Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD7FC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7FE20644
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7FE20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxVLC-0006P9-G7
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 07:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45980)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hxVKm-0005wM-UO
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hxVKl-0005Zi-CX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:51:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hxVKh-0005Xq-V0; Tue, 13 Aug 2019 07:51:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C652E3082E44;
 Tue, 13 Aug 2019 11:51:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-18.ams2.redhat.com
 [10.36.117.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C77D7FB7C;
 Tue, 13 Aug 2019 11:51:17 +0000 (UTC)
Date: Tue, 13 Aug 2019 13:51:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190813115115.GG4663@localhost.localdomain>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
 <e53a0399-f051-52bd-49e8-4ac4dbf2596f@redhat.com>
 <3d5fcc5b-cdb0-f028-1ea2-af85850db20e@virtuozzo.com>
 <15cf7372-826a-0684-d6ad-90deea36959e@virtuozzo.com>
 <43fb7754-6f94-00f6-6172-70cbb53e787c@virtuozzo.com>
 <94ccf129-cc7e-2778-7688-fd718f8df249@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94ccf129-cc7e-2778-7688-fd718f8df249@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 13 Aug 2019 11:51:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] deal with BDRV_BLOCK_RAW
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.08.2019 um 13:14 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 13.08.2019 12:33, Vladimir Sementsov-Ogievskiy wrote:
> > 13.08.2019 12:01, Vladimir Sementsov-Ogievskiy wrote:
> >> 13.08.2019 11:39, Vladimir Sementsov-Ogievskiy wrote:
> >>> 12.08.2019 22:50, Max Reitz wrote:
> >>>> On 12.08.19 21:46, Max Reitz wrote:
> >>>>> On 12.08.19 20:11, Vladimir Sementsov-Ogievskiy wrote:
> >>>>>> Hi all!
> >>>>>>
> >>>>>> I'm not sure, is it a bug or a feature, but using qcow2 under ra=
w is
> >>>>>> broken. It should be either fixed like I propose (by Max's sugge=
stion)
> >>>>>> or somehow forbidden (just forbid backing-file supporting node t=
o be
> >>>>>> file child of raw-format node).
> >>>>>
> >>>>> I agree, I think only filters should return BDRV_BLOCK_RAW.
> >>>>>
> >>>>> (And not even them, they should just be handled transparently by
> >>>>> bdrv_co_block_status().=C2=A0 But that=E2=80=99s something for la=
ter.)
> >>>>>
> >>>>>> Vladimir Sementsov-Ogievskiy (2):
> >>>>>> =C2=A0=C2=A0 block/raw-format: switch to BDRV_BLOCK_DATA with BD=
RV_BLOCK_RECURSE
> >>>>>> =C2=A0=C2=A0 iotests: test mirroring qcow2 under raw format
> >>>>>>
> >>>>>> =C2=A0 block/raw-format.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +-
> >>>>>> =C2=A0 tests/qemu-iotests/263=C2=A0=C2=A0=C2=A0=C2=A0 | 46 +++++=
+++++++++++++++++++++++++++++++++
> >>>>>> =C2=A0 tests/qemu-iotests/263.out | 12 ++++++++++
> >>>>>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0 1 +
> >>>>>> =C2=A0 4 files changed, 60 insertions(+), 1 deletion(-)
> >>>>>> =C2=A0 create mode 100755 tests/qemu-iotests/263
> >>>>>> =C2=A0 create mode 100644 tests/qemu-iotests/263.out
> >>>>>
> >>>>> Thanks, applied to my block-next branch:
> >>>>>
> >>>>> https://git.xanclic.moe/XanClic/qemu/commits/branch/block-next
> >>>>
> >>>> Oops, maybe not.=C2=A0 221 needs to be adjusted.
> >>>>
> >>>
> >>>
> >>> Hmm yes, I forget to run tests.. Areas which were zero becomes data=
|zero, it
> >>> don't look good.
> >>>
> >>> So, it's not quite right to report DATA | RECURSE, we actually shou=
ld report
> >>> DATA_OR_ZERO | RECURSE, which is actually ALLOCATED | RECURSE, as o=
therwise
> >>> DATA will be set in final result (generic layer must not drop it, o=
bviously).
> >>>
> >>> ALLOCATED never returned by drivers but seems it should be. I'll th=
ink a bit and
> >>> resend something new.
> >>>
> >>>
> >>
> >>
> >> Hmmm.. So, we have raw node, and assume backing chain under it. who =
should loop through it,
> >> generic code or raw driver?
> >>
> >> Now it all looks like generic code is responsible for looping throug=
h filtered chain (backing files
> >> and filters) and driver is responsible for all it's children except =
for filtered child.
> >>
> >> Or, driver may return something that says to generic child to handle=
 the whole backing chain of returned
> >> file at once, as it's another backing chain. And seems even RECURSE =
don't work correctly as it doesn't handle
> >> the backing chain in this recursion. Why it works better than RAW - =
just because we return it together
> >> with DATA flags and this DATA flag is kept anyway, independently of =
finding zeros or not.
> >>
> >>
> >=20
> >=20
> > Hmm, so, is it correct that we return DATA | RECURSE, if we are not r=
eally sure that it is data?
> >=20
> > If we see at
> >=20
> >  =C2=A0* BDRV_BLOCK_DATA: allocation for data at offset is tied to th=
is layer
> >=20
> > seems like we should report DATA only if there is allocation..
> >=20
> >  =C2=A0* DATA ZERO OFFSET_VALID
> >  =C2=A0*=C2=A0 t=C2=A0=C2=A0=C2=A0 t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sectors read as zero, ret=
urned file is zero at offset
> >  =C2=A0*=C2=A0 t=C2=A0=C2=A0=C2=A0 f=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sectors read as valid fro=
m file at offset
> >  =C2=A0*=C2=A0 f=C2=A0=C2=A0=C2=A0 t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sectors preallocated, rea=
d as zero, returned file not
> >=20
> > so, ZERO alone doesn't guarantee that we may safely read?
> >=20
> > So, for qcow2 metadata-preallocated images, what about zero-init? We =
report DATA, and probably get ZERO from
> > file and have finally DAYA | ZERO which guarantees that read will ret=
urn zeros, but is it true?
> >=20
> > Finally, what "DATA" mean? That space is allocated and occupies disk =
space? Or it only=C2=A0 means only ALLOCATED i.e.
> > "read from this layer, not from backing" otherwise, and adds addition=
al meaning to ZERO when used together, that
> > read will return zeros for sure?

I think DATA means that the data for this block is provided by *file. I
wouldn't necessarily understand it to mean that the data actually takes
up physical disk space there.

> Continue self-discussion.
>=20
> Consider closer the following case:
>  >   * DATA ZERO OFFSET_VALID
>  >   *  f    t        t       sectors preallocated, read as zero, retur=
ned file not
>=20
> It actually means that we must not read, as read will return wrong
> data, when clusters are actually zero for guest.

It means that you need to read from bs itself to get the correct data
(which will be zero). Even though OFFSET_VALID is set, reading from
*file (typically bs->file->bs) at the returned offset might not give the
right result.

> It's OK, when for ex. qcow2 returns this combination and link to its
> file child: it means that if you read from qcow2 node, you'll see
> correct zeros, as qcow2 has special metadata which shows that these
> clusters are zero. But if you read from file directly at returned
> offset you'll see garbage, so don't do it.

Correct.

> But what if some node returns this combination with file =3D=3D itself?=
 It
> actually means that you must not read, but you should call
> block-status to understand that there are zeros. So, if some format
> can return this combination with file =3D=3D itself it means that you m=
ust
> not read it directly, but only after checking block status.

This doesn't make sense to me. Reading from a node is always correct.

But you're right that DATA seems to mean something slightly different at
the protocol level because *file cannot have a meaningful value for the
lower layer there. In this case, DATA still seems to mean that the data
is fetched from the lower layer (i.e. the block device on which the file
system resides). For holes, this is not the case.

> And file-posix is example of such driver. But file-posix holes are guar=
anteed to read as zero, so we can report DATA | ZERO.
> But this will break user expirience which assumes that DATA means occup=
ation of real disk space.

With the above explanation, DATA shouldn't be set for holes.

But it's still kind of inconsistent because OFFSET_VALID and the offset
refer to bs itself and not to the lower layer.

> ...
> me go and re-read what we've documented in NBD protocol about block ste=
us...
>=20
> "DATA" turns into NBD_STATE_HOLE, which formally means nothing, and jus=
t notes that probably there is no disk space occupation
> for this region.. So it's about disk space allocation and nothing about=
 correctness of read.
> and NBD_STATE_ZERO guarantees that region read as all zeroes.
>=20
> Look at code in nbd/server.c.. Aha, it calls block_status_above and tur=
ns !ALLOCATED into HOLE. Which means that it will never
> return HOLE for file-posix..

Hm... This is a mess. :-)

Kevin

