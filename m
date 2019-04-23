Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1558C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650232175B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650232175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55165 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIx3P-0001BC-NI
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 11:09:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hIx2W-0000uL-Ud
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hIx2V-00089b-Lp
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:08:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hIx2V-00087W-Cn
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:08:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83FED3098558
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-143.ams2.redhat.com
	[10.36.116.143])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E0B427191;
	Tue, 23 Apr 2019 15:08:47 +0000 (UTC)
Date: Tue, 23 Apr 2019 17:08:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Martin Kletzander <mkletzan@redhat.com>
Message-ID: <20190423150845.GG9041@localhost.localdomain>
References: <20190423113028.GD30014@wheatley>
	<20190423121218.GF9041@localhost.localdomain>
	<20190423142648.GA2967@wheatley>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <20190423142648.GA2967@wheatley>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 23 Apr 2019 15:08:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Possibly incorrect data sparsification by qemu-img
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Richard Jones <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423150845.ADwznPVgr0YXlKJlbm8nhfQA7q5HiaIAp3F5J5jdXRY@z>


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 23.04.2019 um 16:26 hat Martin Kletzander geschrieben:
> On Tue, Apr 23, 2019 at 02:12:18PM +0200, Kevin Wolf wrote:
> > Am 23.04.2019 um 13:30 hat Martin Kletzander geschrieben:
> > > Hi,
> > >=20
> > > I am using qemu-img with nbdkit to transfer a disk image and the upda=
te it with
> > > extra data from newer snapshots.  The end image cannot be transferred=
 because
> > > the snapshots will be created later than the first transfer and we wa=
nt to save
> > > some time up front.  You might think of it as a continuous synchronis=
ation.  It
> > > looks something like this:
> > >=20
> > > I first transfer the whole image:
> > >=20
> > >  qemu-img convert -p $nbd disk.raw
> > >=20
> > > Where `$nbd` is something along the lines of `nbd+unix:///?socket=3Dn=
bdkit.sock`
> > >=20
> > > Then, after the next snapshot is created, I can update it thanks to t=
he `-n`
> > > parameter (the $nbd now points to the newer snapshot with unchanged d=
ata looking
> > > like holes in the file):
> > >=20
> > >  qemu-img convert -p -n $nbd disk.raw
> > >=20
> > > This is fast and efficient as it uses block status nbd extension, so =
it only
> > > transfers new data.
> >=20
> > This is an implementation detail. Don't rely on it. What you're doing is
> > abusing 'qemu-img convert', so problems like what you describe are to be
> > expected.
> >=20
> > > This can be done over and over again to keep the local
> > > `disk.raw` image up to date with the latest remote snapshot.
> > >=20
> > > However, when the guest OS zeroes some of the data and it gets writte=
n into the
> > > snapshot, qemu-img scans for those zeros and does not write them to t=
he
> > > destination image.  Checking the output of `qemu-img map --output=3Dj=
son $nbd`
> > > shows that the zeroed data is properly marked as `data: true`.
> > >=20
> > > Using `-S 0` would write zeros even where the holes are, effectively =
overwriting
> > > the data from the last snapshot even though they should not be change=
d.
> > >=20
> > > Having gone through some workarounds I would like there to be another=
 way.  I
> > > know this is far from the typical usage of qemu-img, but is this real=
ly the
> > > expected behaviour or is this just something nobody really needed bef=
ore?  If it
> > > is the former, would it be possible to have a parameter that would co=
ntrol this
> > > behaviour?  If the latter is the case, can that behaviour be changed =
so that it
> > > properly replicates the data when `-n` parameter is used?
> > >=20
> > > Basically the only thing we need is to either:
> > >=20
> > > 1) write zeros where they actually are or
> > >=20
> > > 2) turn off explicit sparsification without requesting dense image (b=
asically
> > >    sparsify only the par that is reported as hole on the source) or
> > >=20
> > > 3) ideally, just FALLOC_FL_PUNCH_HOLE in places where source did repo=
rt data,
> > >    but qemu-img found they are all zeros (or source reported HOLE+ZER=
O which, I
> > >    believe, is effectively the same)
> > >=20
> > > If you want to try this out, I found the easiest reproducible way is =
using
> > > nbdkit's data plugin, which can simulate whatever source image you li=
ke.
> >=20
> > I think what you _really_ want is a commit block job. The problem is
> > just that you don't have a proper backing file chain, but just a bunch
> > of NBD connections.
> >=20
> > Can't you get an NBD connection that already provides the condensed form
> > of the whole snapshot chain directly at the source? If the NBD server
> > was QEMU, this would actually be easier than providing each snapshot
> > individually.
> >=20
> > If this isn't possible, I think you need to replicate the backing chain
> > on the destination instead of converting into the same image again and
> > again so that qemu-img knows that it must take existing data of the
> > backing file into consideration:
> >=20
> >    qemu-img convert -O qcow2 nbd://... base.qcow2
> >    qemu-img convert -O qcow2 -F qcow2 -B base.qcow2 nbd://... overlay1.=
qcow2
> >    qemu-img convert -O qcow2 -F qcow2 -B overlay1.qcow2 nbd://... overl=
ay2.qcow2
> >    ...
> >=20
>=20
> I thought of this, but (to be honest) I did not know that `-B` would
> work for nbd.

It still depends on the NBD server providing the right block allocation
status, but that's no worse than what you needed for -n. But whether -B
can be used at all depends on the target format, not the source.

> Does it assume that data are to be taken from the base image if and
> only if the source (be it nbd server or just a plain file) says there
> is a hole?  If yes, then it could nicely solve the issue.

I haven't tested it now, but yes, that's what I remember it to do.

Looking at the code, the requirement seems to be that the NBD server
flags the sparse blocks as a HOLE, but not as ZERO.

Kevin

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcvyp9AAoJEH8JsnLIjy/Wag8QALDg7Qvr1EYMmJdn83lNhIG/
J27looFncNGc4BLpQRVD55MYFSkL/kP4Krqhwa/LPsJOLKsjZLD0KB4K1bCHVmud
2RkH7h+oww+l0Jl+Xz6o6kLypWX7uo/9G8rXIfsa3K6SBnrpYhBvjEvOR3hrRSwK
XF9hBY6nsQ6QicI3Q+IKbfXCjuqlkI/WVbne7zveKyAetloWgBVxsrKMdwuts3fA
Kyie/IXgcr0okPF9s+k6jHOl1yYi3tgPsYWGDLjft4IkaM/8DbS9kBdodL1l8RBD
Ax//gQDMDO1ic90P+J8CsVlPNtaogNsdzJcfGK8fc6JsajW+vQEzk3Cpby+TC0ll
6TaUKWYj/MPEqjJGPDywSWH62OMrwMMOgkLEWrJqgl/0loUFuwoOLcRD7VYFxT8Z
/musoCopvt5U3ImKZoMg+zSqDT6Y5Rse5DHjLxwY1vLK/1tWNJkYKjJp/yZeEdbN
56N+kOp/+1a8Cf7v+7DUoSo/0Iu8fG13GOyZGWPOwVwpwKPi4l6jXDSZC9LRkcQA
tFDDO9kHxtz5TSBRQUz/Igwzy/2SwSJBJhzLfH38kvx0eOKjDZN3DrCvz9hfSN2n
z364aMprVMRJUtwMJS/ZAI+1KaESgvJ3JekfqsDazteT5eHUUs+PLyqBbfbDcx3M
SskMp0ZH58G8H5ZEaum/
=g6XU
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--

