Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDBCC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 19:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F457233FD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 19:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F457233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0sQ7-0003T8-Ib
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 15:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1i0sPN-0002pa-Pq
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 15:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1i0sPL-0000vI-SR
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 15:06:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1i0sPL-0000u9-K3
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 15:06:03 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A18963B77
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 19:06:02 +0000 (UTC)
Received: by mail-ot1-f71.google.com with SMTP id 88so3606746otc.19
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 12:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CYAGuwUT3TWNLQi05s8Kdt+5Kk+u5v+Qg+ik5a6uph8=;
 b=LKE3NjPg136+Qu0oG67E+39dWXJ7zI5CfYHbyNBDAhOq9rFK+HpTeEssle1QL96XLS
 bBKEeiAk7CywMSwf/6jMMi2GtfLsSCTpmohKK0p4jTe39rJbl46AzB1a8sl1MvmHl975
 bgO4D1JcNhud0jv4vy4Tp7AAqu1Wk5bOvnrt/Kki8tn3MxizFvUbdj/hrxtNvY+6H75m
 OCLlHhnCa3rDaPd0bGuUWNCmFPCteXi81lH2gTL5CXquwr/s9hH9CuewvorkVhkKNLZ/
 sc35GXCcFDRGJjLOW5OvwMHsAGqJVoXOfyqocgWllYMGB2aG2g59jhJzsihY8EBp/BHl
 IIyQ==
X-Gm-Message-State: APjAAAUBtT1fc90UN6u09r+mjsC2/xtjU+OeCVmaTgNmfxd6sWj3K7em
 pguZ5b7NS/OfGoMSZIyUJPXFDTrxTVB3hibr00yNnAnTmGRSpAV6jNsKiYIR5g0QPLne/vlvduY
 UWWg5nNTR4i3Jo2+BAEe6b/al0qV0FUo=
X-Received: by 2002:aca:1714:: with SMTP id j20mr433483oii.135.1566500762039; 
 Thu, 22 Aug 2019 12:06:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxh4C9Sg56mltCJAMbMJkPAp9I6x3Y61u4VUR1HcBv2Mrkwcx6gf6d5mqSIEy0KBtABZCo9oGxH/Brphc3Vo6c=
X-Received: by 2002:aca:1714:: with SMTP id j20mr433464oii.135.1566500761727; 
 Thu, 22 Aug 2019 12:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190817212111.13265-1-nsoffer@redhat.com>
 <9b59c887-ff97-ff0a-fa18-ef9a19c1ad6e@redhat.com>
 <20190822070323.GE25371@ndevos-x270>
In-Reply-To: <20190822070323.GE25371@ndevos-x270>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 22 Aug 2019 22:05:50 +0300
Message-ID: <CAMRbyyvprqDs+SvM96LDLJiJ7tAk2AsPBJ6MPY-tMWC+7y1dTQ@mail.gmail.com>
To: Niels de Vos <ndevos@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
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
 Nir Soffer <nirsof@gmail.com>, qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 22, 2019 at 10:03 AM Niels de Vos <ndevos@redhat.com> wrote:

> On Wed, Aug 21, 2019 at 07:04:17PM +0200, Max Reitz wrote:
> > On 17.08.19 23:21, Nir Soffer wrote:
> > > Implement alignment probing similar to file-posix, by reading from th=
e
> > > first 4k of the image.
> > >
> > > Before this change, provisioning a VM on storage with sector size of
> > > 4096 bytes would fail when the installer try to create filesystems.
> Here
> > > is an example command that reproduces this issue:
> > >
> > >     $ qemu-system-x86_64 -accel kvm -m 2048 -smp 2 \
> > >         -drive
> file=3Dgluster://gluster1/gv0/fedora29.raw,format=3Draw,cache=3Dnone \
> > >         -cdrom Fedora-Server-dvd-x86_64-29-1.2.iso
> > >
> > > The installer fails in few seconds when trying to create filesystem o=
n
> > > /dev/mapper/fedora-root. In error report we can see that it failed wi=
th
> > > EINVAL (I could not extract the error from guest).
> > >
> > > Copying disk fails with EINVAL:
> > >
> > >     $ qemu-img convert -p -f raw -O raw -t none -T none \
> > >         gluster://gluster1/gv0/fedora29.raw \
> > >         gluster://gluster1/gv0/fedora29-clone.raw
> > >     qemu-img: error while writing sector 4190208: Invalid argument
> > >
> > > This is a fix to same issue fixed in commit a6b257a08e3d (file-posix:
> > > Handle undetectable alignment) for gluster:// images.
> > >
> > > This fix has the same limit, that the first block of the image should
> be
> > > allocated, otherwise we cannot detect the alignment and fallback to a
> > > safe value (4096) even when using storage with sector size of 512
> bytes.
> > >
> > > Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> > > ---
> > >  block/gluster.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 47 insertions(+)
> > >
> > > diff --git a/block/gluster.c b/block/gluster.c
> > > index f64dc5b01e..d936240b72 100644
> > > --- a/block/gluster.c
> > > +++ b/block/gluster.c
> > > @@ -52,6 +52,9 @@
> > >
> > >  #define GERR_INDEX_HINT "hint: check in 'server' array index '%d'\n"
> > >
> > > +/* The value is known only on the server side. */
> > > +#define MAX_ALIGN 4096
> > > +
> > >  typedef struct GlusterAIOCB {
> > >      int64_t size;
> > >      int ret;
> > > @@ -902,8 +905,52 @@ out:
> > >      return ret;
> > >  }
> > >
> > > +/*
> > > + * Check if read is allowed with given memory buffer and length.
> > > + *
> > > + * This function is used to check O_DIRECT request alignment.
> > > + */
> > > +static bool gluster_is_io_aligned(struct glfs_fd *fd, void *buf,
> size_t len)
> > > +{
> > > +    ssize_t ret =3D glfs_pread(fd, buf, len, 0, 0, NULL);
> > > +    return ret >=3D 0 || errno !=3D EINVAL;
> >
> > Is glfs_pread() guaranteed to return EINVAL on invalid alignment?
> > file-posix says this is only the case on Linux (for normal files).  Now
> > I also don=E2=80=99t know whether the gluster driver works on anything =
but Linux
> > anyway.
>
> The behaviour depends on the filesystem used by the Gluster backend. XFS
> is the recommendation, but in the end it is up to the users. The Gluster
> server is known to work on Linux, NetBSD and FreeBSD, the vast majority
> of users runs it on Linux.
>
> I do not think there is a strong guarantee EINVAL is always correct. How
> about only checking 'ret > 0'?
>

Looks like we don't have a choice.

>
> > > +}
> > > +
> > > +static void gluster_probe_alignment(BlockDriverState *bs, struct
> glfs_fd *fd,
> > > +                                    Error **errp)
> > > +{
> > > +    char *buf;
> > > +    size_t alignments[] =3D {1, 512, 1024, 2048, 4096};
> > > +    size_t align;
> > > +    int i;
> > > +
> > > +    buf =3D qemu_memalign(MAX_ALIGN, MAX_ALIGN);
> > > +
> > > +    for (i =3D 0; i < ARRAY_SIZE(alignments); i++) {
> > > +        align =3D alignments[i];
> > > +        if (gluster_is_io_aligned(fd, buf, align)) {
> > > +            /* Fallback to safe value. */
> > > +            bs->bl.request_alignment =3D (align !=3D 1) ? align :
> MAX_ALIGN;
> > > +            break;
> > > +        }
> > > +    }
> >
> > I don=E2=80=99t like the fact that the last element of alignments[] sho=
uld be
> > the same as MAX_ALIGN, without that ever having been made explicit
> anywhere.
> >
> > It=E2=80=99s a bit worse in the file-posix patch, because if getpagesiz=
e() is
> > greater than 4k, max_align will be greater than 4k.  But MAX_BLOCKSIZE
> > is 4k, too, so I suppose we wouldn=E2=80=99t support any block size bey=
ond that
> > anyway, which makes the error message appropriate still.
> >
> > > +
> > > +    qemu_vfree(buf);
> > > +
> > > +    if (!bs->bl.request_alignment) {
> > > +        error_setg(errp, "Could not find working O_DIRECT alignment"=
);
> > > +        error_append_hint(errp, "Try cache.direct=3Doff\n");
> > > +    }
> > > +}
> > > +
> > >  static void qemu_gluster_refresh_limits(BlockDriverState *bs, Error
> **errp)
> > >  {
> > > +    BDRVGlusterState *s =3D bs->opaque;
> > > +
> > > +    gluster_probe_alignment(bs, s->fd, errp);
> > > +
> > > +    bs->bl.min_mem_alignment =3D bs->bl.request_alignment;
> >
> > Well, I=E2=80=99ll just trust you that there is no weird system where t=
he memory
> > alignment is greater than the request alignment.
> >
> > > +    bs->bl.opt_mem_alignment =3D MAX(bs->bl.request_alignment,
> MAX_ALIGN);
> >
> > Isn=E2=80=99t request_alignment guaranteed to not exceed MAX_ALIGN, i.e=
. isn=E2=80=99t
> > this always MAX_ALIGN?
> >
> > >      bs->bl.max_transfer =3D GLUSTER_MAX_TRANSFER;
> > >  }
> >
> > file-posix has a check in raw_reopen_prepare() whether we can find a
> > working alignment for the new FD.  Shouldn=E2=80=99t we do the same in
> > qemu_gluster_reopen_prepare()?
>
> Yes, I think that makes sense too.
>

I'l add it in v2.

Thanks for reviewing.

Nir
