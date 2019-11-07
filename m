Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090CAC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C881821D7E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AjWDaWWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C881821D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSjRH-0004Is-VP
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 10:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lfy@google.com>) id 1iSjQZ-0003nH-Bg
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lfy@google.com>) id 1iSjQX-0005Rd-6H
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:10:27 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:42429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lfy@google.com>) id 1iSjQW-0005R2-UK
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:10:25 -0500
Received: by mail-ot1-x32f.google.com with SMTP id b16so2281873otk.9
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 07:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vrl3FGILhK8DZvEFWhjpJnUUjOla3+p9TtjZCf618Qo=;
 b=AjWDaWWQims5Ny6hLE3iEQNDL0cINH9IYOeNCXmBtek+k5YBNpPbFV4DBpry/+FJtc
 qaZMLRp5OSMYEVgEeBpfp+17W+znvJZ5A0ZO9TrfE8uajt3qRdEJe5BXL1oByGET+5Zz
 Y6A8ScH5nEIw0L+cikso7Oqa/yx5TC1+dMQXsCHi8CWrI+2rvfOz1c/iR585gp3fYwgy
 ASVvs1LBexz6TjgWV3GZxBuCIMzio1LwgCiErnYEk48J4HxF464oHat/gEuK7JwsFKO8
 BSHGcdxuQSopr7EVeAvhdSVf8ovaC9eREgS5L9iJpI28gU5P3w0chDf6H9lVcA9BDnAq
 jXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vrl3FGILhK8DZvEFWhjpJnUUjOla3+p9TtjZCf618Qo=;
 b=JyKxubZlmrr+kYFw2GfgLEM4IdyFDPiq8msIhd+SXGtF5NHEK8/8v9hTwS51RiBuPX
 4O/ZEDbuRUFQVPdahb3GhDYmY9nvwnmgFZa/NO6kvmaYcUGgoOqlR5kNiz88tbrtn/DD
 SYIRN8acMPwnYAKyfmyZ5baHx1N2Cwg8nylWCnxdA6aFP1z/O24QUoizlh8CAl/d+ldZ
 JbD9qUebYDi1CtAYxaY6uvIVcr03SasenTwR7iUcWonAwt7rdvvOiTR6FSXi+ND4xM9z
 mvMgo1z9DjBVYdVxKgF2OeIBSatWKM7N4ySc72Xd3kkXYXZ4PtcyVv1nSYsOxUYBkb4d
 QtRg==
X-Gm-Message-State: APjAAAUMALGM9F1GCrYVsOEiLsMdo2w0Z/r7unIsMc0v9DbXA0d6mwKi
 yS3ObZEpsIKM/I2c8xbCunlBDa+0NmjogBvc6e2PZw==
X-Google-Smtp-Source: APXvYqwNeo9J4ew9BzbV30S7G07Vd1ZK5ZXjNadnIyQVQZrLG91HCFhfLFXjPH/toMhE4waVxe0w0v5Y9/eo1/fW73Q=
X-Received: by 2002:a9d:5f16:: with SMTP id f22mr3267705oti.13.1573139423049; 
 Thu, 07 Nov 2019 07:10:23 -0800 (PST)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
 <CAJSP0QUJBkqtVJq17tfX5O-JuvEGcZQviP0C3tv9qSDy-P-hcg@mail.gmail.com>
 <20191106125023.uhdhtqisybilxasr@sirius.home.kraxel.org>
 <CAJSP0QXG5Z3zCnPL+Y7EQfCeey2Fb9OdPdx531Jz2Ofk63wndg@mail.gmail.com>
In-Reply-To: <CAJSP0QXG5Z3zCnPL+Y7EQfCeey2Fb9OdPdx531Jz2Ofk63wndg@mail.gmail.com>
From: Frank Yang <lfy@google.com>
Date: Thu, 7 Nov 2019 07:10:15 -0800
Message-ID: <CAEkmjvU8or7YT7CCBe7aUx-XQ3yJpUrY4CfBOnqk7pUH9d9RGQ@mail.gmail.com>
Subject: Re: guest / host buffer sharing ...
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, geoff@hostfission.com, 
 virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>, 
 Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>, 
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, 
 David Stevens <stevensd@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, 
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, 
 Dylan Reid <dgreid@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>, 
 Pawel Osciak <posciak@chromium.org>, 
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: multipart/alternative; boundary="0000000000007eb04b0596c310f0"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
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

--0000000000007eb04b0596c310f0
Content-Type: text/plain; charset="UTF-8"

So I'm not really sure why people are having issues sharing buffers that
live on the GPU. Doesn't that show up as some integer ID on the host, and
some $GuestFramework (dmabuf, gralloc) ID on the guest, and it all works
out due to maintaining the correspondence in your particular stack of
virtual devices? For example, if you want to do video decode in hardware on
an Android guest, there should be a gralloc buffer whose handle contains
enough information to reconstruct the GPU buffer ID on the host, because
gralloc is how processes communicate gpu buffer ids to each other on
Android.

BTW, if we have a new device just for this, this should also be more
flexible than being udmabuf on the host. There are other OSes than Linux.
Keep in mind, also, that across different drivers even on Linux, e.g.,
NVIDIA proprietary, dmabuf might not always be available.

As for host CPU memory that is allocated in various ways, I think Android
Emulator has built a very flexible/general solution, esp if we need to
share a host CPU buffer allocated via something thats not completely under
our control, such as Vulkan. We reserve a PCI BAR for that and map memory
directly from the host Vk drier into there, via the address space device.
It's

https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-master-dev/hw/pci/goldfish_address_space.c

https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-master-dev/android/android-emu/android/emulation/address_space_device.cpp#205


Number of copies is also completely under the user's control, unlike
ivshmem. It also is not tied to any particular device such as gpu or codec.
Since the memory is owned by the host and directly mapped to the guest PCI
without any abstraction, it's contiguous, it doesn't carve out guest RAM,
doesn't waste CMA, etc.

On Thu, Nov 7, 2019 at 4:13 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, Nov 6, 2019 at 1:50 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > In the graphics buffer sharing use case, how does the other side
> > > determine how to interpret this data?
> >
> > The idea is to have free form properties (name=value, with value being
> > a string) for that kind of metadata.
> >
> > > Shouldn't there be a VIRTIO
> > > device spec for the messaging so compatible implementations can be
> > > written by others?
> >
> > Adding a list of common properties to the spec certainly makes sense,
> > so everybody uses the same names.  Adding struct-ed properties for
> > common use cases might be useful too.
>
> Why not define VIRTIO devices for wayland and friends?
>
> This new device exposes buffer sharing plus properties - effectively a
> new device model nested inside VIRTIO.  The VIRTIO device model has
> the necessary primitives to solve the buffer sharing problem so I'm
> struggling to see the purpose of this new device.
>
> Custom/niche applications that do not wish to standardize their device
> type can maintain out-of-tree VIRTIO devices.  Both kernel and
> userspace drivers can be written for the device and there is already
> VIRTIO driver code that can be reused.  They have access to the full
> VIRTIO device model, including feature negotiation and configuration
> space.
>
> Stefan
>
>

--0000000000007eb04b0596c310f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">So I&#39;m not really sure why people are having issues sh=
aring buffers that live on the GPU. Doesn&#39;t that show up as some intege=
r ID on the host, and some $GuestFramework (dmabuf, gralloc) ID on the gues=
t, and it all works out due to maintaining the correspondence in your parti=
cular stack of virtual devices? For example, if you want to do video decode=
 in hardware on an Android guest, there should be a gralloc buffer whose ha=
ndle contains enough information to reconstruct the GPU buffer ID on the ho=
st, because gralloc is how processes communicate gpu buffer ids to each oth=
er on Android.<div><br></div><div>BTW, if we have a new device just for thi=
s, this should also be more flexible than being udmabuf on the host. There =
are other OSes than Linux. Keep in mind, also, that across different driver=
s even on Linux, e.g., NVIDIA proprietary, dmabuf might not always be avail=
able.<div><br><div>As for host CPU memory that is allocated in various ways=
, I think Android Emulator has built a very flexible/general solution, esp =
if we need to share a host CPU buffer allocated via something thats not com=
pletely under our control, such as Vulkan. We reserve a PCI BAR for that an=
d map memory directly from the host Vk drier into there, via the address sp=
ace device. It&#39;s=C2=A0</div><div><br></div><div><a href=3D"https://andr=
oid.googlesource.com/platform/external/qemu/+/refs/heads/emu-master-dev/hw/=
pci/goldfish_address_space.c">https://android.googlesource.com/platform/ext=
ernal/qemu/+/refs/heads/emu-master-dev/hw/pci/goldfish_address_space.c</a>=
=C2=A0</div><div><a href=3D"https://android.googlesource.com/platform/exter=
nal/qemu/+/refs/heads/emu-master-dev/android/android-emu/android/emulation/=
address_space_device.cpp#205">https://android.googlesource.com/platform/ext=
ernal/qemu/+/refs/heads/emu-master-dev/android/android-emu/android/emulatio=
n/address_space_device.cpp#205</a>=C2=A0<br></div><div><br></div><div><div>=
Number of copies is also completely under the user&#39;s control, unlike iv=
shmem. It also is not tied to any particular device such as gpu or codec. S=
ince the memory is owned by the host and directly mapped to the guest PCI w=
ithout any abstraction, it&#39;s contiguous, it doesn&#39;t carve out guest=
 RAM, doesn&#39;t waste CMA, etc.</div></div></div></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 7, 201=
9 at 4:13 AM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com">stef=
anha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Wed, Nov 6, 2019 at 1:50 PM Gerd Hoffmann &lt;<a href=3D"m=
ailto:kraxel@redhat.com" target=3D"_blank">kraxel@redhat.com</a>&gt; wrote:=
<br>
&gt; &gt; In the graphics buffer sharing use case, how does the other side<=
br>
&gt; &gt; determine how to interpret this data?<br>
&gt;<br>
&gt; The idea is to have free form properties (name=3Dvalue, with value bei=
ng<br>
&gt; a string) for that kind of metadata.<br>
&gt;<br>
&gt; &gt; Shouldn&#39;t there be a VIRTIO<br>
&gt; &gt; device spec for the messaging so compatible implementations can b=
e<br>
&gt; &gt; written by others?<br>
&gt;<br>
&gt; Adding a list of common properties to the spec certainly makes sense,<=
br>
&gt; so everybody uses the same names.=C2=A0 Adding struct-ed properties fo=
r<br>
&gt; common use cases might be useful too.<br>
<br>
Why not define VIRTIO devices for wayland and friends?<br>
<br>
This new device exposes buffer sharing plus properties - effectively a<br>
new device model nested inside VIRTIO.=C2=A0 The VIRTIO device model has<br=
>
the necessary primitives to solve the buffer sharing problem so I&#39;m<br>
struggling to see the purpose of this new device.<br>
<br>
Custom/niche applications that do not wish to standardize their device<br>
type can maintain out-of-tree VIRTIO devices.=C2=A0 Both kernel and<br>
userspace drivers can be written for the device and there is already<br>
VIRTIO driver code that can be reused.=C2=A0 They have access to the full<b=
r>
VIRTIO device model, including feature negotiation and configuration<br>
space.<br>
<br>
Stefan<br>
<br>
</blockquote></div>

--0000000000007eb04b0596c310f0--

