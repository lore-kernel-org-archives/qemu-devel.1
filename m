Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A85C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EF82082D
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="HyzdQVmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EF82082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia3Lj-0001on-Hd
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 14:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jakub.kicinski@netronome.com>) id 1ia3Jh-00011Z-2K
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:49:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jakub.kicinski@netronome.com>) id 1ia3Je-0003Mq-TC
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:49:36 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:37803)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jakub.kicinski@netronome.com>)
 id 1ia3Je-0003IL-95
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:49:34 -0500
Received: by mail-lf1-x143.google.com with SMTP id b20so18143521lfp.4
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 11:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netronome-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :organization:mime-version:content-transfer-encoding;
 bh=tpa6qsgsffF6MZ2hAroMhBII3NVwR7/Y88cSdiliNf0=;
 b=HyzdQVmo2vsOZyvKTv/HixleVW+fE/oq7v6M/t9xSKYG/a1OT34vVXcp5W3hNJy1zP
 mB75uz9wyD1j/1SGSqhE57PHS5G23SWJpr2Uj8ojzcXEQj4dG4HZYvtr/XAQY7QYe1+M
 9p1r2GJ8BRVNhwtH8IsnohsSkt7IdYgL+GgwzqZ15Af1HRQWQJRlbrlJ54p/MElxPUw3
 q4jG/caVgnm2ZOko1agVFfd9raXvqkuNsBCBB1v35QlfzkZp7mVGVY+qZiCf+5XyTciZ
 W3yfw0segLv00PbeIPWCzrQKnilNCrs28T2ucr53EdN6MBs+nzbnoUf4Gikmcpnq1f+m
 mCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=tpa6qsgsffF6MZ2hAroMhBII3NVwR7/Y88cSdiliNf0=;
 b=U98dVK+dcto57LmKHAWyKjZI2XG4ufZtQ7yLKhBeSM8CTmouw07eDECKVP9JAm9xOh
 e0qEmolGEH9zuRa5HwzAXGg7EFYfRSlHYDpfHtTSp0/VeaoGfuWUu4oOXnhS0ASrMb/s
 mbjxP2wIuItzO9RaojBJe1HQuGDL69+Imb1QN0fz3YvN1XkYmxaT0/Ou/rbn5f+CX/i9
 FC7PixkbTGzY3AGdhFsTVrGceBy61qx+64FdvoukbWJtf/AkcflLOLxwFrbN89d+Iwan
 xFJAWqVZyCkQxXU34GGBWJTGkujN+6fv0YUN+S0yDMPZh4CMS2diW7IpOgvJwHJZSvMX
 j9aQ==
X-Gm-Message-State: APjAAAW1YKg6dLp7uAHFI82SVc8PwA97/TX6r/EJJbV/CUsmtH/lb5hp
 kLDPbWkNWsyS0V+7Wwc3OGh4Gg==
X-Google-Smtp-Source: APXvYqybDtB2Ovw/ENr4nkvummmpv5ttVbYMaxRqCU1q3wmSBePOoBmSZRFDwa9J2xUg1ekUya/ruA==
X-Received: by 2002:a19:8104:: with SMTP id c4mr24228921lfd.191.1574884172084; 
 Wed, 27 Nov 2019 11:49:32 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
 by smtp.gmail.com with ESMTPSA id o15sm7741773ljc.28.2019.11.27.11.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 11:49:31 -0800 (PST)
Date: Wed, 27 Nov 2019 11:49:13 -0800
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC net-next 00/18] virtio_net XDP offload
Message-ID: <20191127114913.0363a0e8@cakuba.netronome.com>
In-Reply-To: <48cec928-871f-3f50-e99f-c6a6d124cf4c@redhat.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
 <20191126123514.3bdf6d6f@cakuba.netronome.com>
 <48cec928-871f-3f50-e99f-c6a6d124cf4c@redhat.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: Song Liu <songliubraving@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 qemu-devel@nongnu.org, Alexei Starovoitov <ast@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Prashant Bhole <prashantbhole.linux@gmail.com>, kvm@vger.kernel.org,
 Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
 Martin KaFai Lau <kafai@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 27 Nov 2019 10:59:37 +0800, Jason Wang wrote:
> On 2019/11/27 =E4=B8=8A=E5=8D=884:35, Jakub Kicinski wrote:
> > On Tue, 26 Nov 2019 19:07:26 +0900, Prashant Bhole wrote: =20
> >> Note: This RFC has been sent to netdev as well as qemu-devel lists
> >>
> >> This series introduces XDP offloading from virtio_net. It is based on
> >> the following work by Jason Wang:
> >> https://netdevconf.info/0x13/session.html?xdp-offload-with-virtio-net
> >>
> >> Current XDP performance in virtio-net is far from what we can achieve
> >> on host. Several major factors cause the difference:
> >> - Cost of virtualization
> >> - Cost of virtio (populating virtqueue and context switching)
> >> - Cost of vhost, it needs more optimization
> >> - Cost of data copy
> >> Because of above reasons there is a need of offloading XDP program to
> >> host. This set is an attempt to implement XDP offload from the guest. =
=20
> > This turns the guest kernel into a uAPI proxy.
> >
> > BPF uAPI calls related to the "offloaded" BPF objects are forwarded
> > to the hypervisor, they pop up in QEMU which makes the requested call
> > to the hypervisor kernel. Today it's the Linux kernel tomorrow it may
> > be someone's proprietary "SmartNIC" implementation.
> >
> > Why can't those calls be forwarded at the higher layer? Why do they
> > have to go through the guest kernel? =20
>=20
>=20
> I think doing forwarding at higher layer have the following issues:
>=20
> - Need a dedicated library (probably libbpf) but application may choose=20
>   to do eBPF syscall directly
> - Depends on guest agent to work

This can be said about any user space functionality.

> - Can't work for virtio-net hardware, since it still requires a hardware=
=20
> interface for carrying=C2=A0 offloading information

The HW virtio-net presumably still has a PF and hopefully reprs for
VFs, so why can't it attach the program there?

> - Implement at the level of kernel may help for future extension like=20
>   BPF object pinning and eBPF helper etc.

No idea what you mean by this.

> Basically, this series is trying to have an implementation of=20
> transporting eBPF through virtio, so it's not necessarily a guest to=20
> host but driver and device. For device, it could be either a virtual one=
=20
> (as done in qemu) or a real hardware.

SmartNIC with a multi-core 64bit ARM CPUs is as much of a host as=20
is the x86 hypervisor side. This set turns the kernel into a uAPI
forwarder.

3 years ago my answer to this proposal would have been very different.
Today after all the CPU bugs it seems like the SmartNICs (which are=20
just another CPU running proprietary code) may just take off..

> > If kernel performs no significant work (or "adds value", pardon the
> > expression), and problem can easily be solved otherwise we shouldn't
> > do the work of maintaining the mechanism. =20
>=20
> My understanding is that it should not be much difference compared to=20
> other offloading technology.

I presume you mean TC offloads? In virtualization there is inherently a
hypervisor which will receive the request, be it an IO hub/SmartNIC or
the traditional hypervisor on the same CPU.

The ACL/routing offloads differ significantly, because it's either the=20
driver that does all the HW register poking directly or the complexity
of programming a rule into a HW table is quite low.

Same is true for the NFP BPF offload, BTW, the driver does all the
heavy lifting and compiles the final machine code image.

You can't say verifying and JITing BPF code into machine code entirely
in the hypervisor is similarly simple.

So no, there is a huge difference.

> > The approach of kernel generating actual machine code which is then
> > loaded into a sandbox on the hypervisor/SmartNIC is another story. =20
>=20
> We've considered such way, but actual machine code is not as portable as=
=20
> eBPF bytecode consider we may want:
>=20
> - Support migration
> - Further offload the program to smart NIC (e.g through macvtap=20
>   passthrough mode etc).

You can re-JIT or JIT for SmartNIC..? Having the BPF bytecode does not
guarantee migration either, if the environment is expected to be
running different version of HW and SW. But yes, JITing in the guest
kernel when you don't know what to JIT for may be hard, I was just
saying that I don't mean to discourage people from implementing
sandboxes which run JITed code on SmartNICs. My criticism is (as
always?) against turning the kernel into a one-to-one uAPI forwarder
into unknown platform code.

For cloud use cases I believe the higher layer should solve this.

