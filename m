Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EF3C31E40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 10:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE97121743
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 10:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE97121743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyD1o-00006x-OE
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 06:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1hyD13-0007zp-Sh
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hyD10-0004SM-UR
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:29:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hyD0x-0004PB-Gb; Thu, 15 Aug 2019 06:29:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C19F3175291;
 Thu, 15 Aug 2019 10:29:50 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-12.ams2.redhat.com [10.36.117.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2FAB83C0E;
 Thu, 15 Aug 2019 10:29:48 +0000 (UTC)
Date: Thu, 15 Aug 2019 12:29:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190815102947.GB7415@linux.fritz.box>
References: <20190326155157.3719-1-kwolf@redhat.com>
 <20190326155157.3719-6-kwolf@redhat.com>
 <fb6063ca-d4c4-7add-adec-5e92c3805ad8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <fb6063ca-d4c4-7add-adec-5e92c3805ad8@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 15 Aug 2019 10:29:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 5/7] file-posix: Support
 BDRV_REQ_NO_FALLBACK for zero writes
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
Cc: nsoffer@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.08.2019 um 04:44 hat Eric Blake geschrieben:
> On 3/26/19 10:51 AM, Kevin Wolf wrote:
> > We know that the kernel implements a slow fallback code path for
> > BLKZEROOUT, so if BDRV_REQ_NO_FALLBACK is given, we shouldn't call it.
> > The other operations we call in the context of .bdrv_co_pwrite_zeroes
> > should usually be quick, so no modification should be needed for them.
> > If we ever notice that there are additional problematic cases, we can
> > still make these conditional as well.
>=20
> Are there cases where fallocate(FALLOC_FL_ZERO_RANGE) falls back to slow
> writes?  It may be fast on some file systems, but when used on a block
> device, that may equally trigger slow fallbacks.  The man page is not
> clear on that fact; I suspect that there may be cases in there that need
> to be made conditional (it would be awesome if the kernel folks would
> give us another FALLOC_ flag when we want to guarantee no fallback).

The NO_FALLBACK changes were based on the Linux code rather than
documentation because no interface is explicitly documented to forbid
fallbacks.

I think for file systems, we can generally assume that we don't get
fallbacks because for file systems, just deallocating blocks is the
easiest way to implement the function anyway. (Hm, or is it when we
don't punch holes...?)

And for block devices, we don't try FALLOC_FL_ZERO_RANGE because it also
involves the same slow fallback as BLKZEROOUT. In other words,
bdrv_co_pwrite_zeroes() with NO_FALLBACK, but without MAY_UNMAP, always
fails on Linux block devices, and we fall back to emulation in user
space.

We would need a kernel interface that calls blkdev_issue_zeroout() with
BLKDEV_ZERO_NOUNMAP | BLKDEV_ZERO_NOFALLBACK, but no such interface
exists.

When I talked to some file system people, they insisted that "efficient"
or "fast" wasn't well-defined enough for them or something, so if we
want to get a kernel change, maybe a new block device ioctl would be the
most realistic thing.

We do use FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE for MAY_UNMAP,
which works for both file systems (I assume - each file system has a
separate implementation) and block devices without slow fallbacks.

qemu-img create sets MAY_UNMAP, so the case we are most interested in is
covered with a fast implementation.

> By the way, is there an easy setup to prove (maybe some qemu-img convert
> command on a specially-prepared source image) whether the no fallback
> flag makes a difference?  I'm about to cross-post a series of patches to
> nbd/qemu/nbdkit/libnbd that adds a new NBD_CMD_FLAG_FAST_ZERO which fits
> the bill of BDRV_REQ_NO_FALLBACK, but would like to include some
> benchmark numbers in my cover letter if I can reproduce a setup where it
> matters.

Hm, the original case came from Nir, maybe he can suggest something.

You'll definitely need a block device that doesn't support
FALLOC_FL_PUNCH_HOLE, otherwise you can't trigger the fallback. My
first though was a loop device, but this actually does support the
operation and passes it through to the underlying file system. So maybe
if you know a file system that doesn't support it. Or if you have an old
hard disk handy.

Or... Actually there is an easily available block device that doesn't
suppport zero writes: The in-kernel NBD client! :-)

And I think I remember now how I tested this back then:

1. qemu-nbd exports an image with very slow throttling enabled
   (throttling affects writes, but not write_zeroes)

2. Attach the NBD device to /dev/nbd0

3. Convert to there (use a second NBD connection to test the fix)

> And this patch has a bug:
>=20
> > +++ b/block/file-posix.c
> > @@ -652,7 +652,7 @@ static int raw_open_common(BlockDriverState *bs, QD=
ict *options,
> >      }
> >  #endif
> > =20
> > -    bs->supported_zero_flags =3D BDRV_REQ_MAY_UNMAP;
> > +    bs->supported_zero_flags =3D BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALL=
BACK;
> >      ret =3D 0;
> >  fail:
> >      if (filename && (bdrv_flags & BDRV_O_TEMPORARY)) {
> > @@ -1500,14 +1500,19 @@ static ssize_t handle_aiocb_write_zeroes_block(=
RawPosixAIOData *aiocb)
> {
>     int ret =3D -ENOTSUP;
>     BDRVRawState *s =3D aiocb->bs->opaque;
>=20
>     if (!s->has_write_zeroes) {
>         return -ENOTSUP;
> >      }
>=20
> At this point, ret is -ENOTSUP.
>=20
> > =20
> >  #ifdef BLKZEROOUT
> > -    do {
> > -        uint64_t range[2] =3D { aiocb->aio_offset, aiocb->aio_nbytes };
> > -        if (ioctl(aiocb->aio_fildes, BLKZEROOUT, range) =3D=3D 0) {
> > -            return 0;
> > -        }
> > -    } while (errno =3D=3D EINTR);
> > +    /* The BLKZEROOUT implementation in the kernel doesn't set
> > +     * BLKDEV_ZERO_NOFALLBACK, so we can't call this if we have to avo=
id slow
> > +     * fallbacks. */
> > +    if (!(aiocb->aio_type & QEMU_AIO_NO_FALLBACK)) {
> > +        do {
> > +            uint64_t range[2] =3D { aiocb->aio_offset, aiocb->aio_nbyt=
es };
> > +            if (ioctl(aiocb->aio_fildes, BLKZEROOUT, range) =3D=3D 0) {
> > +                return 0;
> > +            }
> > +        } while (errno =3D=3D EINTR);
> > =20
> > -    ret =3D translate_err(-errno);
> > +        ret =3D translate_err(-errno);
> > +    }
>=20
> If the very first call to this function is with NO_FALLBACK, then this
> 'if' is skipped,
>=20
> >  #endif
> > =20
> >      if (ret =3D=3D -ENOTSUP) {
>         s->has_write_zeroes =3D false;
>     }
>=20
> and we set s->has_write_zeroes to false, permanently disabling any
> BLKZEROOUT attempts in future calls, even if the future calls no longer
> pass the NO_FALLBACK flag.

Right, this should be moved inside the if (!NO_FALLBACK) block.

Kevin

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdVTQbAAoJEH8JsnLIjy/WOHAP/1+7CkaTd8tHY+U3TSi/dIv1
tsX3qFmqXC6RHH2CRNsI7OltGtYJQY+KtgzxaZjnzCoA6T4/F1MuQGZACMwSh2i5
+zVAOk0Y+m/sy7LnSjBiWFXuSuqsUocA2am8vQN1RPFKcvooRXya5G7242G0Ux+O
FPBD8lFdWCO4rj484p1U+em0PNinoxPS2DKAk4pWui3ieMaLLDPcjXHs33VEb+83
fpy5/qbMkdD027cI87Mhg6ju2bZxK9aQErxA3iQeMKGWeHDOGe7br3Cgh9+dR587
33CDfsZkmih422FxUv14P6gGI+tVzPZRVNwu+5ZtSBPLWawAwgx5xqRuYA7h5F4K
HxUrGMyNTBFzfZNgnpdSaF9h7qdwsaQ7+tVfl7SUK6CQeFWH+hXNOgKTm7gk5203
wTkb+9ZIfGQLcO612VOM9PjU7+fiOBOA9Jb7szeyL6tnFDR533SNvUX6PHUEoqP9
8L6y1Elp/KCZZ0KtzfmqgYYxoe1B23DWd6ev9bJNlpBJEnXY0LjbXrQ/2Y/k91BZ
AiZGr7gnDjBb8lYXsdXkUfrdhidyaP7HF+S0KciyLfcmxjD77yLMdFCbuIs++2vF
QELdAxunYaS/jrDYFZPezBPzfSAORcKRkiTWa9puEziiu5oTfEImlQ2bO1ixvEcs
hRUk0sa9ehm1TFSQDSmY
=NzeB
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--

