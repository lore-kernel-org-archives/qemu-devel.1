Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DA1C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 07:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B6422CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 07:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B6422CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0h9v-0000Jr-SX
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 03:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ndevos@redhat.com>) id 1i0h89-0007lg-1Q
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 03:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ndevos@redhat.com>) id 1i0h87-0000CN-Kg
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 03:03:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ndevos@redhat.com>)
 id 1i0h83-0008Qf-Da; Thu, 22 Aug 2019 03:03:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BE274A2FC49;
 Thu, 22 Aug 2019 07:03:25 +0000 (UTC)
Received: from localhost (ovpn-116-76.ams2.redhat.com [10.36.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C59D6B49C;
 Thu, 22 Aug 2019 07:03:25 +0000 (UTC)
Date: Thu, 22 Aug 2019 09:03:23 +0200
From: Niels de Vos <ndevos@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190822070323.GE25371@ndevos-x270>
References: <20190817212111.13265-1-nsoffer@redhat.com>
 <9b59c887-ff97-ff0a-fa18-ef9a19c1ad6e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b59c887-ff97-ff0a-fa18-ef9a19c1ad6e@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Thu, 22 Aug 2019 07:03:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block: gluster: Probe alignment limits
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
Cc: Kevin Wolf <kwolf@redhat.com>, integration@gluster.org,
 Nir Soffer <nirsof@gmail.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 21, 2019 at 07:04:17PM +0200, Max Reitz wrote:
> On 17.08.19 23:21, Nir Soffer wrote:
> > Implement alignment probing similar to file-posix, by reading from th=
e
> > first 4k of the image.
> >=20
> > Before this change, provisioning a VM on storage with sector size of
> > 4096 bytes would fail when the installer try to create filesystems. H=
ere
> > is an example command that reproduces this issue:
> >=20
> >     $ qemu-system-x86_64 -accel kvm -m 2048 -smp 2 \
> >         -drive file=3Dgluster://gluster1/gv0/fedora29.raw,format=3Dra=
w,cache=3Dnone \
> >         -cdrom Fedora-Server-dvd-x86_64-29-1.2.iso
> >=20
> > The installer fails in few seconds when trying to create filesystem o=
n
> > /dev/mapper/fedora-root. In error report we can see that it failed wi=
th
> > EINVAL (I could not extract the error from guest).
> >=20
> > Copying disk fails with EINVAL:
> >=20
> >     $ qemu-img convert -p -f raw -O raw -t none -T none \
> >         gluster://gluster1/gv0/fedora29.raw \
> >         gluster://gluster1/gv0/fedora29-clone.raw
> >     qemu-img: error while writing sector 4190208: Invalid argument
> >=20
> > This is a fix to same issue fixed in commit a6b257a08e3d (file-posix:
> > Handle undetectable alignment) for gluster:// images.
> >=20
> > This fix has the same limit, that the first block of the image should=
 be
> > allocated, otherwise we cannot detect the alignment and fallback to a
> > safe value (4096) even when using storage with sector size of 512 byt=
es.
> >=20
> > Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> > ---
> >  block/gluster.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >=20
> > diff --git a/block/gluster.c b/block/gluster.c
> > index f64dc5b01e..d936240b72 100644
> > --- a/block/gluster.c
> > +++ b/block/gluster.c
> > @@ -52,6 +52,9 @@
> > =20
> >  #define GERR_INDEX_HINT "hint: check in 'server' array index '%d'\n"
> > =20
> > +/* The value is known only on the server side. */
> > +#define MAX_ALIGN 4096
> > +
> >  typedef struct GlusterAIOCB {
> >      int64_t size;
> >      int ret;
> > @@ -902,8 +905,52 @@ out:
> >      return ret;
> >  }
> > =20
> > +/*
> > + * Check if read is allowed with given memory buffer and length.
> > + *
> > + * This function is used to check O_DIRECT request alignment.
> > + */
> > +static bool gluster_is_io_aligned(struct glfs_fd *fd, void *buf, siz=
e_t len)
> > +{
> > +    ssize_t ret =3D glfs_pread(fd, buf, len, 0, 0, NULL);
> > +    return ret >=3D 0 || errno !=3D EINVAL;
>=20
> Is glfs_pread() guaranteed to return EINVAL on invalid alignment?
> file-posix says this is only the case on Linux (for normal files).  Now
> I also don=E2=80=99t know whether the gluster driver works on anything =
but Linux
> anyway.

The behaviour depends on the filesystem used by the Gluster backend. XFS
is the recommendation, but in the end it is up to the users. The Gluster
server is known to work on Linux, NetBSD and FreeBSD, the vast majority
of users runs it on Linux.

I do not think there is a strong guarantee EINVAL is always correct. How
about only checking 'ret > 0'?

>=20
> > +}
> > +
> > +static void gluster_probe_alignment(BlockDriverState *bs, struct glf=
s_fd *fd,
> > +                                    Error **errp)
> > +{
> > +    char *buf;
> > +    size_t alignments[] =3D {1, 512, 1024, 2048, 4096};
> > +    size_t align;
> > +    int i;
> > +
> > +    buf =3D qemu_memalign(MAX_ALIGN, MAX_ALIGN);
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(alignments); i++) {
> > +        align =3D alignments[i];
> > +        if (gluster_is_io_aligned(fd, buf, align)) {
> > +            /* Fallback to safe value. */
> > +            bs->bl.request_alignment =3D (align !=3D 1) ? align : MA=
X_ALIGN;
> > +            break;
> > +        }
> > +    }
>=20
> I don=E2=80=99t like the fact that the last element of alignments[] sho=
uld be
> the same as MAX_ALIGN, without that ever having been made explicit anyw=
here.
>=20
> It=E2=80=99s a bit worse in the file-posix patch, because if getpagesiz=
e() is
> greater than 4k, max_align will be greater than 4k.  But MAX_BLOCKSIZE
> is 4k, too, so I suppose we wouldn=E2=80=99t support any block size bey=
ond that
> anyway, which makes the error message appropriate still.
>=20
> > +
> > +    qemu_vfree(buf);
> > +
> > +    if (!bs->bl.request_alignment) {
> > +        error_setg(errp, "Could not find working O_DIRECT alignment"=
);
> > +        error_append_hint(errp, "Try cache.direct=3Doff\n");
> > +    }
> > +}
> > +
> >  static void qemu_gluster_refresh_limits(BlockDriverState *bs, Error =
**errp)
> >  {
> > +    BDRVGlusterState *s =3D bs->opaque;
> > +
> > +    gluster_probe_alignment(bs, s->fd, errp);
> > +
> > +    bs->bl.min_mem_alignment =3D bs->bl.request_alignment;
>=20
> Well, I=E2=80=99ll just trust you that there is no weird system where t=
he memory
> alignment is greater than the request alignment.
>=20
> > +    bs->bl.opt_mem_alignment =3D MAX(bs->bl.request_alignment, MAX_A=
LIGN);
>=20
> Isn=E2=80=99t request_alignment guaranteed to not exceed MAX_ALIGN, i.e=
. isn=E2=80=99t
> this always MAX_ALIGN?
>=20
> >      bs->bl.max_transfer =3D GLUSTER_MAX_TRANSFER;
> >  }
>=20
> file-posix has a check in raw_reopen_prepare() whether we can find a
> working alignment for the new FD.  Shouldn=E2=80=99t we do the same in
> qemu_gluster_reopen_prepare()?

Yes, I think that makes sense too.

Niels

