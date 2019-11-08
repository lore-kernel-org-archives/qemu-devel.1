Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6AAFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F982178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTcwAs/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F982178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT69j-000504-55
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:26:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iT60M-0003Eg-Ot
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:16:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iT60K-0002sa-V1
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:16:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53538
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iT60K-0002pB-9Z
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573226210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BN+c6gvZddWxIeD0ZTinF47GD6FR2Oe7c252ysnSyYU=;
 b=XTcwAs/atDoxvq2qONm36Q91+wPMCiLEPxgOMl8cRRTpwKK6JulRztSkONE9KgSHvpNH+k
 eGORhIKp0u6t9ymJ/g2GFypHdhf94JCxkkkulkHrpTrn1bW4usRFomNx00eSaiRWYuHGfZ
 N/p7XDEWB4nte2ytidHEaPR3jUDcgaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-cCrEvohhOT-bN0rN3bA4gA-1; Fri, 08 Nov 2019 10:16:46 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEFEC8017DD;
 Fri,  8 Nov 2019 15:16:45 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA33F27BDC;
 Fri,  8 Nov 2019 15:16:44 +0000 (UTC)
Date: Fri, 8 Nov 2019 15:16:42 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: - - <nevilad@yahoo.com>, quintela@redhat.com, peterx@redhat.com
Subject: Re: [PATCH] Bug #1829242 correction
Message-ID: <20191108151642.GC2877@work-vm>
References: <694638341.1321046.1573223493407.ref@mail.yahoo.com>
 <694638341.1321046.1573223493407@mail.yahoo.com>
MIME-Version: 1.0
In-Reply-To: <694638341.1321046.1573223493407@mail.yahoo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: cCrEvohhOT-bN0rN3bA4gA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* - - (nevilad@yahoo.com) wrote:
> Bug #1829242 correction. Added type conversions to ram_addr_t
> before all left shifts of page indexes to TARGET_PAGE_BITS, to correct
> overflows when the page address was 4Gb and more.
>=20
> Signed-off-by: Alexey Romko <nevilad@yahoo.com>

Hi Alexey,
  (Your git settings are a bit odd, your name isn't on the mail header,
but that's minor since you have the signed-off ok).

Thanks for this, this is probably a fix for Juan's a935e30
which started using 'page' rather than 'offset' in the PageSearchStatus,
and I guess on windows 'long' isn't long enough.

I think this is fine, (with perhaps a better Subject, that Juan can
add);

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

I think in the long term we probably need to stop using 'long' for
offsets.

Dave

> ---
> =A0migration/ram.c | 22 +++++++++++-----------
> =A01 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index 5078f94490..90a09de620 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1730,7 +1730,7 @@ static inline bool migration_bitmap_clear_dirty(RAM=
State *rs,
> =A0 =A0 =A0if (rb->clear_bmap && clear_bmap_test_and_clear(rb, page)) {
> =A0 =A0 =A0 =A0 =A0uint8_t shift =3D rb->clear_bmap_shift;
> =A0 =A0 =A0 =A0 =A0hwaddr size =3D 1ULL << (TARGET_PAGE_BITS + shift);
> -=A0 =A0 =A0 =A0 hwaddr start =3D (page << TARGET_PAGE_BITS) & (-size);
> +=A0 =A0 =A0 =A0 hwaddr start =3D (((ram_addr_t)page) << TARGET_PAGE_BITS=
) & (-size);
> =A0
> =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 * CLEAR_BITMAP_SHIFT_MIN should always guarantee this=
... this
> @@ -1967,7 +1967,7 @@ static void ram_release_pages(const char *rbname, u=
int64_t offset, int pages)
> =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0}
> =A0
> -=A0 =A0 ram_discard_range(rbname, offset, pages << TARGET_PAGE_BITS);
> +=A0 =A0 ram_discard_range(rbname, offset, ((ram_addr_t)pages) << TARGET_=
PAGE_BITS);
> =A0}
> =A0
> =A0/*
> @@ -2055,7 +2055,7 @@ static int ram_save_page(RAMState *rs, PageSearchSt=
atus *pss, bool last_stage)
> =A0 =A0 =A0uint8_t *p;
> =A0 =A0 =A0bool send_async =3D true;
> =A0 =A0 =A0RAMBlock *block =3D pss->block;
> -=A0 =A0 ram_addr_t offset =3D pss->page << TARGET_PAGE_BITS;
> +=A0 =A0 ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BIT=
S;
> =A0 =A0 =A0ram_addr_t current_addr =3D block->offset + offset;
> =A0
> =A0 =A0 =A0p =3D block->host + offset;
> @@ -2242,7 +2242,7 @@ static bool find_dirty_block(RAMState *rs, PageSear=
chStatus *pss, bool *again)
> =A0 =A0 =A0 =A0 =A0*again =3D false;
> =A0 =A0 =A0 =A0 =A0return false;
> =A0 =A0 =A0}
> -=A0 =A0 if ((pss->page << TARGET_PAGE_BITS) >=3D pss->block->used_length=
) {
> +=A0 =A0 if ((((ram_addr_t)pss->page) << TARGET_PAGE_BITS) >=3D pss->bloc=
k->used_length) {
> =A0 =A0 =A0 =A0 =A0/* Didn't find anything in this RAM Block */
> =A0 =A0 =A0 =A0 =A0pss->page =3D 0;
> =A0 =A0 =A0 =A0 =A0pss->block =3D QLIST_NEXT_RCU(pss->block, next);
> @@ -2536,7 +2536,7 @@ static int ram_save_target_page(RAMState *rs, PageS=
earchStatus *pss,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bool l=
ast_stage)
> =A0{
> =A0 =A0 =A0RAMBlock *block =3D pss->block;
> -=A0 =A0 ram_addr_t offset =3D pss->page << TARGET_PAGE_BITS;
> +=A0 =A0 ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BIT=
S;
> =A0 =A0 =A0int res;
> =A0
> =A0 =A0 =A0if (control_save_page(rs, block, offset, &res)) {
> @@ -2617,7 +2617,7 @@ static int ram_save_host_page(RAMState *rs, PageSea=
rchStatus *pss,
> =A0 =A0 =A0 =A0 =A0pages +=3D tmppages;
> =A0 =A0 =A0 =A0 =A0pss->page++;
> =A0 =A0 =A0} while ((pss->page & (pagesize_bits - 1)) &&
> -=A0 =A0 =A0 =A0 =A0 =A0 =A0offset_in_ramblock(pss->block, pss->page << T=
ARGET_PAGE_BITS));
> +=A0 =A0 =A0 =A0 =A0 =A0 =A0offset_in_ramblock(pss->block, ((ram_addr_t)p=
ss->page) << TARGET_PAGE_BITS));
> =A0
> =A0 =A0 =A0/* The offset we leave with is the last one we looked at */
> =A0 =A0 =A0pss->page--;
> @@ -2834,8 +2834,8 @@ void ram_postcopy_migrated_memory_release(Migration=
State *ms)
> =A0
> =A0 =A0 =A0 =A0 =A0while (run_start < range) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long run_end =3D find_next_bit(bitmap=
, range, run_start + 1);
> -=A0 =A0 =A0 =A0 =A0 =A0 ram_discard_range(block->idstr, run_start << TAR=
GET_PAGE_BITS,
> -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (run_end - r=
un_start) << TARGET_PAGE_BITS);
> +=A0 =A0 =A0 =A0 =A0 =A0 ram_discard_range(block->idstr, ((ram_addr_t)run=
_start) << TARGET_PAGE_BITS,
> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((ram_addr_t=
)(run_end - run_start)) << TARGET_PAGE_BITS);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0run_start =3D find_next_zero_bit(bitmap, range=
, run_end + 1);
> =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0}
> @@ -4201,13 +4201,13 @@ static void colo_flush_ram_cache(void)
> =A0 =A0 =A0 =A0 =A0while (block) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0offset =3D migration_bitmap_find_dirty(ram_sta=
te, block, offset);
> =A0
> -=A0 =A0 =A0 =A0 =A0 =A0 if (offset << TARGET_PAGE_BITS >=3D block->used_=
length) {
> +=A0 =A0 =A0 =A0 =A0 =A0 if (((ram_addr_t)offset) << TARGET_PAGE_BITS >=
=3D block->used_length) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0offset =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0block =3D QLIST_NEXT_RCU(block, next);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0migration_bitmap_clear_dirty(ram_state=
, block, offset);
> -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dst_host =3D block->host + (offset << TA=
RGET_PAGE_BITS);
> -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 src_host =3D block->colo_cache + (offset=
 << TARGET_PAGE_BITS);
> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dst_host =3D block->host + (((ram_addr_t=
)offset) << TARGET_PAGE_BITS);
> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 src_host =3D block->colo_cache + (((ram_=
addr_t)offset) << TARGET_PAGE_BITS);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memcpy(dst_host, src_host, TARGET_PAGE=
_SIZE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0}
> --=A0
> 2.15.0.windows.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


