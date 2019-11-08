Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A72BC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44CCF214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jHveOhHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CCF214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5QK-0005EQ-8N
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nevilad@yahoo.com>) id 1iT5Ke-0006nL-6B
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nevilad@yahoo.com>) id 1iT5KZ-0004zZ-Pv
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:33:47 -0500
Received: from sonic306-47.consmr.mail.ir2.yahoo.com ([77.238.176.233]:38085)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nevilad@yahoo.com>) id 1iT5KZ-0004z9-Aa
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1573223620; bh=baYfIi9A6dMF+sYwP6ZzKExyZf9a8z+bpNkyKLdXtjI=;
 h=Date:From:To:Cc:Subject:References:From:Subject;
 b=jHveOhHlxNuVkq1QshUqYryM7ZPKrokeJJ0ewg/Z9FN4/Qmc+v9Bl5rRrCA9lsTselvCWb9IQP3xooLpvIpw1zdMKPcL9rvkOTxBu/3kdukCTu9g31dQIkI+noO4FyJuJzaOkShFKlcV0yQkH6R5IUPDHHsnJ6w01U/RkrLaFl4U5AOsXCC/DzHWUDT7lHU3uUQonUxI65nG4Apur/zqDnt2+TaelepPZFgeVMhjpGjHuOMPu04y/7v+ppEtu0Kqj0hE7bGyKJSUIZwYERtwN0uyHxfPPsCupP90hpWbKaXh7JauILHrcCYzgb/gzoD8Omm82CoqZLeIlFx15ZLCPA==
X-YMail-OSG: lCxido4VM1ngfUiF6_TPnH9Oh6bTKTcYTYg0MsZj3fWd8BMR5HrVusrg1vvLOk6
 sbdPF3G6PndWQbelbx1ik1u2tux.D0ssOHGduH.HxU1t7.R95Gh0fftVXREgkEULm8nbM1pBwOoA
 2Tl6O15GDhJt0OiFikXZ8.G4tCfKzqaQDmFJCMhjSOO21N5obpzdthPBnCcpTNvKrt_tDB7rMQFq
 tN1hyMy4Prud0jZFrVnSMiRGEpDRVgUWlOzsdxILEWX5s106yU409dAPkh_IC2OGS3fZR_lPmPUa
 5h9bkxy91isQPn473PENPr4VjxQv_xQGBUd1R38hoID8m5KXO5XXPNpp8H3ddIYEmmyOO0wMDNNx
 ppmCclIg0RmCpD0iII3GAi2UwbutKkvuLz6TQZ5JCdrdLaenl_xoIsrXrwdlCJiyd4USe.zfTdcJ
 apxPd6ri5feAp7uBuXX1rCuLgzLADfyMnW4nw7Trd.a6IXuJyQLz6YJEpCmrZWuNjuFqSReYvCTd
 8OnlXPV8Utn_l1beYsxDuKfELJRpa_ubPF6G42loYQYTGVLWW.O3V.PwwZ9_cIkEVvRBFPbF5gxL
 7NeEqxYH2T6zzS41Bp1dwEvlGNuBJY2YNJ1PC45aW2fipg1pM_yGAOGpCvY_EZqczHjd..H741Wy
 MnGiSu0ZolUU77ybqfBXkBH3CUSxr3XVF0raZLL40YJXdk5mWyBtIv0GUC3iLGJbIU1s9LpyNAC4
 vnYm91MSspuHn4hZPjt1yma974.pOex3Av5puCJDiZl0d9mn6LrMR0x9QcL8rG70WY2PcQvX9Gaq
 Xp1B7ZjYCU153nblVfs1chIImJ4g3yJaP_s_Zzu6Prw0HipvroMxPJbGoGb5Kourxeb2J6XYHdK0
 vIV9AK97.QUK3d9hoEafXm.OgOsrzKcHJ5yPHp927ShSMr5BDXbCZi01AhwQIu08GT.GZccGSx4E
 9nmmYq6V_DewZmWJSHzxRb4HL6iHdqsFwYwi6LQYcT7HHE5Y0sXRjdVr69XHQPmxoQCWjxT2Q98z
 BIGBF_5yE_xvzJUqagNcZv8SLm5p7KyGH50JVfZ2VT94R.o5ebGbpE2.Dlnih1I9YP2zqtQXVrgi
 2q7.SXwIg0SBxUPbVXiLBmyikTu0ZG6tmdfMyyn25zY9LddXQjuCp1H1r0egYjCA.5G_Z965CtdP
 _4aD7pZTcHpbRXx3ZKJhQKzZ8CXtFIlqERo1scXgo1EJwsUsXXC0S2ecJCppkR5qQaKQu2rrT9q1
 PmAAgJj0dmz14ZAibkgjERpT8dB3a9FCJJuBbaG8Ceip_QbEIaoQy.OaUuaFUcAsFW9zFsmxgZC_
 JUsCHwnYAyb.A6k15ObHBj53SowJWNBCyaG2O
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.ir2.yahoo.com with HTTP; Fri, 8 Nov 2019 14:33:40 +0000
Date: Fri, 8 Nov 2019 14:31:33 +0000 (UTC)
From: - - <nevilad@yahoo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>
Message-ID: <694638341.1321046.1573223493407@mail.yahoo.com>
Subject: [PATCH] Bug #1829242 correction
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <694638341.1321046.1573223493407.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14680 YMailNorrin Mozilla/5.0 (Windows NT 6.1)
 AppleWebKit/537.36 (KHTML,
 like Gecko) Chrome/76.0.3809.132 Safari/537.36 OPR/63.0.3368.94
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 77.238.176.233
X-Mailman-Approved-At: Fri, 08 Nov 2019 09:34:18 -0500
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bug #1829242 correction. Added type conversions to ram_addr_t
before all left shifts of page indexes to TARGET_PAGE_BITS, to correct
overflows when the page address was 4Gb and more.

Signed-off-by: Alexey Romko <nevilad@yahoo.com>
---
=C2=A0migration/ram.c | 22 +++++++++++-----------
=C2=A01 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5078f94490..90a09de620 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1730,7 +1730,7 @@ static inline bool migration_bitmap_clear_dirty(RAMSt=
ate *rs,
=C2=A0 =C2=A0 =C2=A0if (rb->clear_bmap && clear_bmap_test_and_clear(rb, pag=
e)) {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t shift =3D rb->clear_bmap_shift;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr size =3D 1ULL << (TARGET_PAGE_BITS=
 + shift);
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr start =3D (page << TARGET_PAGE_BITS) & =
(-size);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr start =3D (((ram_addr_t)page) << TARGET=
_PAGE_BITS) & (-size);
=C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * CLEAR_BITMAP_SHIFT_MIN should always g=
uarantee this... this
@@ -1967,7 +1967,7 @@ static void ram_release_pages(const char *rbname, uin=
t64_t offset, int pages)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
=C2=A0 =C2=A0 =C2=A0}
=C2=A0
-=C2=A0 =C2=A0 ram_discard_range(rbname, offset, pages << TARGET_PAGE_BITS)=
;
+=C2=A0 =C2=A0 ram_discard_range(rbname, offset, ((ram_addr_t)pages) << TAR=
GET_PAGE_BITS);
=C2=A0}
=C2=A0
=C2=A0/*
@@ -2055,7 +2055,7 @@ static int ram_save_page(RAMState *rs, PageSearchStat=
us *pss, bool last_stage)
=C2=A0 =C2=A0 =C2=A0uint8_t *p;
=C2=A0 =C2=A0 =C2=A0bool send_async =3D true;
=C2=A0 =C2=A0 =C2=A0RAMBlock *block =3D pss->block;
-=C2=A0 =C2=A0 ram_addr_t offset =3D pss->page << TARGET_PAGE_BITS;
+=C2=A0 =C2=A0 ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE=
_BITS;
=C2=A0 =C2=A0 =C2=A0ram_addr_t current_addr =3D block->offset + offset;
=C2=A0
=C2=A0 =C2=A0 =C2=A0p =3D block->host + offset;
@@ -2242,7 +2242,7 @@ static bool find_dirty_block(RAMState *rs, PageSearch=
Status *pss, bool *again)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*again =3D false;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;
=C2=A0 =C2=A0 =C2=A0}
-=C2=A0 =C2=A0 if ((pss->page << TARGET_PAGE_BITS) >=3D pss->block->used_le=
ngth) {
+=C2=A0 =C2=A0 if ((((ram_addr_t)pss->page) << TARGET_PAGE_BITS) >=3D pss->=
block->used_length) {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Didn't find anything in this RAM Block=
 */
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pss->page =3D 0;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pss->block =3D QLIST_NEXT_RCU(pss->block,=
 next);
@@ -2536,7 +2536,7 @@ static int ram_save_target_page(RAMState *rs, PageSea=
rchStatus *pss,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool last_stage)
=C2=A0{
=C2=A0 =C2=A0 =C2=A0RAMBlock *block =3D pss->block;
-=C2=A0 =C2=A0 ram_addr_t offset =3D pss->page << TARGET_PAGE_BITS;
+=C2=A0 =C2=A0 ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE=
_BITS;
=C2=A0 =C2=A0 =C2=A0int res;
=C2=A0
=C2=A0 =C2=A0 =C2=A0if (control_save_page(rs, block, offset, &res)) {
@@ -2617,7 +2617,7 @@ static int ram_save_host_page(RAMState *rs, PageSearc=
hStatus *pss,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pages +=3D tmppages;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pss->page++;
=C2=A0 =C2=A0 =C2=A0} while ((pss->page & (pagesize_bits - 1)) &&
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset_in_ramblock(pss->bl=
ock, pss->page << TARGET_PAGE_BITS));
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset_in_ramblock(pss->bl=
ock, ((ram_addr_t)pss->page) << TARGET_PAGE_BITS));
=C2=A0
=C2=A0 =C2=A0 =C2=A0/* The offset we leave with is the last one we looked a=
t */
=C2=A0 =C2=A0 =C2=A0pss->page--;
@@ -2834,8 +2834,8 @@ void ram_postcopy_migrated_memory_release(MigrationSt=
ate *ms)
=C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (run_start < range) {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long run_end =3D f=
ind_next_bit(bitmap, range, run_start + 1);
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_discard_range(block->idstr, =
run_start << TARGET_PAGE_BITS,
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (run_end - run_start) << TARGET_PAGE_BITS);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_discard_range(block->idstr, =
((ram_addr_t)run_start) << TARGET_PAGE_BITS,
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((ram_addr_t)(run_end - run_start)) << TARG=
ET_PAGE_BITS);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run_start =3D find_next_zer=
o_bit(bitmap, range, run_end + 1);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
=C2=A0 =C2=A0 =C2=A0}
@@ -4201,13 +4201,13 @@ static void colo_flush_ram_cache(void)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (block) {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D migration_bitmap=
_find_dirty(ram_state, block, offset);
=C2=A0
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (offset << TARGET_PAGE_BITS >=
=3D block->used_length) {
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (((ram_addr_t)offset) << TARG=
ET_PAGE_BITS >=3D block->used_length) {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D 0;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block =3D QLI=
ST_NEXT_RCU(block, next);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0migration_bit=
map_clear_dirty(ram_state, block, offset);
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dst_host =3D block=
->host + (offset << TARGET_PAGE_BITS);
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 src_host =3D block=
->colo_cache + (offset << TARGET_PAGE_BITS);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dst_host =3D block=
->host + (((ram_addr_t)offset) << TARGET_PAGE_BITS);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 src_host =3D block=
->colo_cache + (((ram_addr_t)offset) << TARGET_PAGE_BITS);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(dst_ho=
st, src_host, TARGET_PAGE_SIZE);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
--=C2=A0
2.15.0.windows.1


