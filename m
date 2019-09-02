Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11A0C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 14:33:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21FA20578
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 14:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21FA20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4nOQ-000214-OH
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 10:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i4nNE-0001EA-NK
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 10:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i4nNC-0002Nb-FN
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 10:32:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i4nN8-00028R-Bz; Mon, 02 Sep 2019 10:31:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1035283F3D;
 Mon,  2 Sep 2019 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-189.ams2.redhat.com
 [10.36.116.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4500C5C299;
 Mon,  2 Sep 2019 14:31:55 +0000 (UTC)
Date: Mon, 2 Sep 2019 16:31:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Lieven <pl@kamp.de>
Message-ID: <20190902143153.GJ13140@localhost.localdomain>
References: <20190829133615.29873-1-pl@kamp.de>
 <20190902130701.GE13140@localhost.localdomain>
 <7992af97-086e-b1c1-2b1a-fa72727e04c1@kamp.de>
 <20190902134622.GH13140@localhost.localdomain>
 <644e6e56-828a-120f-35de-1e738327a8bd@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <644e6e56-828a-120f-35de-1e738327a8bd@kamp.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 02 Sep 2019 14:31:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block/vhdx: add check for truncated image
 files
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
Cc: codyprime@gmail.com, Jan-Hendrik Frintrop <jhf@kamp.de>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.09.2019 um 16:17 hat Peter Lieven geschrieben:
> Am 02.09.19 um 15:46 schrieb Kevin Wolf:
> > Am 02.09.2019 um 15:15 hat Peter Lieven geschrieben:
> > > Am 02.09.19 um 15:07 schrieb Kevin Wolf:
> > > > Am 29.08.2019 um 15:36 hat Peter Lieven geschrieben:
> > > > > qemu is currently not able to detect truncated vhdx image files=
.
> > > > > Add a basic check if all allocated blocks are reachable to vhdx=
_co_check.
> > > > >=20
> > > > > Signed-off-by: Jan-Hendrik Frintrop <jhf@kamp.de>
> > > > > Signed-off-by: Peter Lieven <pl@kamp.de>
> > > > > ---
> > > > >    block/vhdx.c | 19 +++++++++++++++++++
> > > > >    1 file changed, 19 insertions(+)
> > > > >=20
> > > > > diff --git a/block/vhdx.c b/block/vhdx.c
> > > > > index 6a09d0a55c..4382b1375d 100644
> > > > > --- a/block/vhdx.c
> > > > > +++ b/block/vhdx.c
> > > > > @@ -2068,10 +2068,29 @@ static int coroutine_fn vhdx_co_check(B=
lockDriverState *bs,
> > > > >                                          BdrvCheckMode fix)
> > > > >    {
> > > > >        BDRVVHDXState *s =3D bs->opaque;
> > > > > +    VHDXSectorInfo sinfo;
> > > > > +    int64_t file_size =3D bdrv_get_allocated_file_size(bs);
> > > > Don't you mean bdrv_getlength()?
> > > >=20
> > > > bdrv_get_allocated_file_size() is only the allocated size, i.e. w=
ithout
> > > > holes. So a higher offset may actually be present.
> > >=20
> > > Isn't bdrv_getlength the virtual disk size? I need to check if a bl=
ock
> > > points to a location after EOF of the underlying physical file.
> > Yes, it would have to be bdrv_getlength(bs->file->bs), i.e. call it o=
n
> > the protocol layer, not on the format layer.
> >=20
> > > > > +    int64_t sector_num;
> > > > >        if (s->log_replayed_on_open) {
> > > > >            result->corruptions_fixed++;
> > > > >        }
> > > > > +
> > > > > +    for (sector_num =3D 0; sector_num < bs->total_sectors;
> > > > > +         sector_num +=3D s->block_size / BDRV_SECTOR_SIZE) {
> > > > > +        int nb_sectors =3D MIN(bs->total_sectors - sector_num,
> > > > > +                             s->block_size / BDRV_SECTOR_SIZE)=
;
> > > > > +        vhdx_block_translate(s, sector_num, nb_sectors, &sinfo=
);
> > > > > +        if ((s->bat[sinfo.bat_idx] & VHDX_BAT_STATE_BIT_MASK) =
=3D=3D
> > > > > +            PAYLOAD_BLOCK_FULLY_PRESENT) {
> > > > > +            if (sinfo.file_offset +
> > > > > +                sinfo.sectors_avail * BDRV_SECTOR_SIZE > file_=
size) {
> > > > Do we need to protect against integer overflows here? I think
> > > > sinfo.file_offset comes directly from the image file and might be
> > > > corrupted.
> > > >=20
> > > > Or has it already been check somewhere?
> > >=20
> > > The headers are being checked in vhdx_open.=A0 sinfo.file_offset +
> > > sinfo.sectors_avail * BDRV_SECTOR_SIZE is exactly what is being pas=
sed
> > > to bdrv_pread when reading from the image file.
> > Fair enough, though if I'm not missing anything, we only check that B=
AT
> > entries don't overlap with other regions, not that they aren't too hi=
gh.
> > And vhdx_block_translate() doesn't seem to check for overflows either
> > before it sets sinfo->sectors_avail.
> >=20
> > So maybe this is actually a bug that should be fixed in
> > vhdx_block_translate() so that normal accesses get the fix, too.
>=20
> Or maybe already or also check in vhdx_open when we already iterate
> over all BAT entries?
>=20
> vhdx_block_translate cannot return an error at the moment.

Hm, makes sense, yes.

However, in vhdx_open(), it means that 'qemu-img check' won't even be
able to open the image, so we don't properly report this as an error,
but just as "can't open".

Of course, this is already true for the existing checks, so I don't want
to require you to fix this now (probably by skipping the checks there
with BDRV_O_CHECK and instead calling them from .bdrv_co_check) when
you're trying to fix something mostly unrelated. But if you'd like to, I
certainly wouldn't mind.

Kevin

