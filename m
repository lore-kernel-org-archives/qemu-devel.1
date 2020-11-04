Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D00C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C31292071A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="IISCcF9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31292071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaHIe-0003FE-PK
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kaHI0-0002pA-K6
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:49:20 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kaHHy-0004Jo-00
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:49:20 -0500
Received: by mail-oi1-x241.google.com with SMTP id c80so10363378oib.2
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 03:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2+0jnG8LK0hnNd7Jf5NvXaKrqMHrCVDgHd8a0tXzWfo=;
 b=IISCcF9Q2s9P/lOBkvFISxf/ZWyOW3ZmuzTnJKhG/qf1WFot9uJRFfk39H47td0yix
 ZAeWjrLeMRxCXPnXe9QQ7R/OJ/ic1sH8hYcMQDWrnhEdee9O5MBoQ+THNMqycxVoKg4P
 Q5s8NxisewoQj3LNRFfRUl7UEk7Xm+av1nx9KOIkipDsGeVGbI2gjG078gQvA0PH3psd
 vZWlo9EQCOPBskcCVY1/epsplkx1z9lNXp3zpqEsrtu16gMmLjWJmUoHiv43ViJ6WJyP
 /do6croJcNPKjoOKvcIH3rcXOOkXcqq2VujYGcsj8YYWR1b5sjODSIK9hfBMN9tqhDju
 z3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2+0jnG8LK0hnNd7Jf5NvXaKrqMHrCVDgHd8a0tXzWfo=;
 b=XYUV9F4wQodgRElpOLZR9yYem5NQwYwXDvlWCKf4nazOs2kpptw4LeolLFTWcAxBYA
 hF1Zf3ZLzkcilR2XwiO4oMtEHqjj1bbtfddkpd5Xq0ulgoKxQDg+tZP2sYnXqCB+/QOv
 XaPQX6RoZDPiS0DCjHLK73aYGa8STaQvowNdKe0VIYRHVJ9cvLfNb5twSHo/mshp9GxG
 yfmXrugO96eP9lBD23FMJbgUmorRr4s1HR936DZcSYx6X0nUQwFOv5dRR2DJTCqV05Fw
 6eAZnpQb1illAC0D7MFbV7z/THvd3HXMWAkVZv5rlCVowA2PgIg6vKdovitnOOnPZI0/
 AUOg==
X-Gm-Message-State: AOAM530PNpAlrq1GllbUFtAH7QkJ9OgF1ZgtaDv4CooQW9BGY7aY480q
 T63J/bXo9dcmXyXXwYj/TqzXghZWWLwPKwWxlqg5iQ==
X-Google-Smtp-Source: ABdhPJz6h/+FC3GBmon6BXHd4na2gDuiMCug8jC5RKuJJQo4w7bEk2jlUJqpmhnsW0hmgsgXmfO2EipI2F9d5Ql3jrE=
X-Received: by 2002:aca:8c1:: with SMTP id 184mr2423586oii.137.1604490556480; 
 Wed, 04 Nov 2020 03:49:16 -0800 (PST)
MIME-Version: 1.0
References: <20201102185115.7425-1-andrew@daynix.com>
 <0164a42f-4542-6f3e-bd71-3319dfaae190@redhat.com>
 <CAOEp5Oe3btwgPcOA6v=kK9s2to=x2Hg6Qw2iCFXOOWZs49s=-Q@mail.gmail.com>
 <caa38709-88f1-bd6d-3ff9-61e64c3aa51f@redhat.com>
In-Reply-To: <caa38709-88f1-bd6d-3ff9-61e64c3aa51f@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 4 Nov 2020 13:49:05 +0200
Message-ID: <CAOEp5OciCLsKtnZ=mYavaFbePBwh7VWVg9NyFrns6zy18YKC=w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] eBPF RSS support for virtio-net
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000aa3b3805b3469196"
Received-SPF: none client-ip=2607:f8b0:4864:20::241;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Yan Vugenfirer <yan@daynix.com>, Andrew Melnychenko <andrew@daynix.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000aa3b3805b3469196
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2020 at 4:08 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/11/3 =E4=B8=8B=E5=8D=886:32, Yuri Benditovich wrote:
> >
> >
> > On Tue, Nov 3, 2020 at 11:02 AM Jason Wang <jasowang@redhat.com
> > <mailto:jasowang@redhat.com>> wrote:
> >
> >
> >     On 2020/11/3 =E4=B8=8A=E5=8D=882:51, Andrew Melnychenko wrote:
> >     > Basic idea is to use eBPF to calculate and steer packets in TAP.
> >     > RSS(Receive Side Scaling) is used to distribute network packets
> >     to guest virtqueues
> >     > by calculating packet hash.
> >     > eBPF RSS allows us to use RSS with vhost TAP.
> >     >
> >     > This set of patches introduces the usage of eBPF for packet
> steering
> >     > and RSS hash calculation:
> >     > * RSS(Receive Side Scaling) is used to distribute network packets
> to
> >     > guest virtqueues by calculating packet hash
> >     > * eBPF RSS suppose to be faster than already existing 'software'
> >     > implementation in QEMU
> >     > * Additionally adding support for the usage of RSS with vhost
> >     >
> >     > Supported kernels: 5.8+
> >     >
> >     > Implementation notes:
> >     > Linux TAP TUNSETSTEERINGEBPF ioctl was used to set the eBPF
> program.
> >     > Added eBPF support to qemu directly through a system call, see th=
e
> >     > bpf(2) for details.
> >     > The eBPF program is part of the qemu and presented as an array
> >     of bpf
> >     > instructions.
> >     > The program can be recompiled by provided Makefile.ebpf(need to
> >     adjust
> >     > 'linuxhdrs'),
> >     > although it's not required to build QEMU with eBPF support.
> >     > Added changes to virtio-net and vhost, primary eBPF RSS is used.
> >     > 'Software' RSS used in the case of hash population and as a
> >     fallback option.
> >     > For vhost, the hash population feature is not reported to the
> guest.
> >     >
> >     > Please also see the documentation in PATCH 6/6.
> >     >
> >     > I am sending those patches as RFC to initiate the discussions
> >     and get
> >     > feedback on the following points:
> >     > * Fallback when eBPF is not supported by the kernel
> >
> >
> >     Yes, and it could also a lacking of CAP_BPF.
> >
> >
> >     > * Live migration to the kernel that doesn't have eBPF support
> >
> >
> >     Is there anything that we needs special treatment here?
> >
> > Possible case: rss=3Don, vhost=3Don, source system with kernel 5.8
> > (everything works) -> dest. system 5.6 (bpf does not work), the
> > adapter functions, but all the steering does not use proper queues.
>
>
> Right, I think we need to disable vhost on dest.
>
>
Is this acceptable to disable vhost at time of migration?


> >
> >
> >
> >     > * Integration with current QEMU build
> >
> >
> >     Yes, a question here:
> >
> >     1) Any reason for not using libbpf, e.g it has been shipped with so=
me
> >     distros
> >
> >
> > We intentionally do not use libbpf, as it present only on some distros.
> > We can switch to libbpf, but this will disable bpf if libbpf is not
> > installed
>
>
> That's better I think.
>

We think the preferred way is to have an eBPF code built-in in QEMU (not
distribute it as a separate file).

Our initial idea was to not use the libbpf because it:
1. Does not create additional dependency during build time and during
run-time
2. Gives us smaller footprint of loadable eBPF blob inside qemu
3. Do not add too much code to QEMU

We can switch to libbpf, in this case:
1. Presence of dynamic library is not guaranteed on the target system
2. Static library is large
3. libbpf uses eBPF ELF which is significantly bigger than just the array
or instructions (May be we succeed to reduce the ELF to some suitable size
and still have it built-in)

Please let us know whether you still think libbpf is better and why.

Thanks


>
> >     2) It would be better if we can avoid shipping bytecodes
> >
> >
> >
> > This creates new dependencies: llvm + clang + ...
> > We would prefer byte code and ability to generate it if prerequisites
> > are installed.
>
>
> It's probably ok if we treat the bytecode as a kind of firmware.
>
> But in the long run, it's still worthwhile consider the qemu source is
> used for development and llvm/clang should be a common requirement for
> generating eBPF bytecode for host.
>
>
> >
> >
> >     > * Additional usage for eBPF for packet filtering
> >
> >
> >     Another interesting topics in to implement mac/vlan filters. And
> >     in the
> >     future, I plan to add mac based steering. All of these could be
> >     done via
> >     eBPF.
> >
> >
> > No problem, we can cooperate if needed
> >
> >
> >     >
> >     > Know issues:
> >     > * hash population not supported by eBPF RSS: 'software' RSS used
> >
> >
> >     Is this because there's not way to write to vnet header in
> >     STERRING BPF?
> >
> > Yes. We plan to submit changes for kernel to cooperate with BPF and
> > populate the hash, this work is in progress
>
>
> That would require a new type of eBPF program and may need some work on
> verifier.
>
>
May be need to allow loading of an additional type in tun.c, not only
socket filter (to use bpf_set_hash)
Also vhost and tun in kernel need to be aware of header extension for hash
population.


> Btw, macvtap is still lacking even steering ebpf program. Would you want
> to post a patch to support that?
>
>
Probably after we have full functioning BPF with TAP/TUN


>
> >
> >     > as a fallback, also, hash population feature is not reported to
> >     guests
> >     > with vhost.
> >     > * big-endian BPF support: for now, eBPF is disabled for
> >     big-endian systems.
> >
> >
> >     Are there any blocker for this?
> >
> >
> > No, can be added in v2
>
>
> Cool.
>
> Thanks
>
>
> >
> >     Just some quick questions after a glance of the codes. Will go
> >     through
> >     them tomorrow.
> >
> >     Thanks
> >
> >
> >     >
> >     > Andrew (6):
> >     >    Added SetSteeringEBPF method for NetClientState.
> >     >    ebpf: Added basic eBPF API.
> >     >    ebpf: Added eBPF RSS program.
> >     >    ebpf: Added eBPF RSS loader.
> >     >    virtio-net: Added eBPF RSS to virtio-net.
> >     >    docs: Added eBPF documentation.
> >     >
> >     >   MAINTAINERS                    |   6 +
> >     >   configure                      |  36 +++
> >     >   docs/ebpf.rst                  |  29 ++
> >     >   docs/ebpf_rss.rst              | 129 ++++++++
> >     >   ebpf/EbpfElf_to_C.py           |  67 ++++
> >     >   ebpf/Makefile.ebpf             |  38 +++
> >     >   ebpf/ebpf-stub.c               |  28 ++
> >     >   ebpf/ebpf.c                    | 107 +++++++
> >     >   ebpf/ebpf.h                    |  35 +++
> >     >   ebpf/ebpf_rss.c                | 178 +++++++++++
> >     >   ebpf/ebpf_rss.h                |  30 ++
> >     >   ebpf/meson.build               |   1 +
> >     >   ebpf/rss.bpf.c                 | 470 ++++++++++++++++++++++++++=
++
> >     >   ebpf/trace-events              |   4 +
> >     >   ebpf/trace.h                   |   2 +
> >     >   ebpf/tun_rss_steering.h        | 556
> >     +++++++++++++++++++++++++++++++++
> >     >   hw/net/vhost_net.c             |   2 +
> >     >   hw/net/virtio-net.c            | 120 ++++++-
> >     >   include/hw/virtio/virtio-net.h |   4 +
> >     >   include/net/net.h              |   2 +
> >     >   meson.build                    |   3 +
> >     >   net/tap-bsd.c                  |   5 +
> >     >   net/tap-linux.c                |  19 ++
> >     >   net/tap-solaris.c              |   5 +
> >     >   net/tap-stub.c                 |   5 +
> >     >   net/tap.c                      |   9 +
> >     >   net/tap_int.h                  |   1 +
> >     >   net/vhost-vdpa.c               |   2 +
> >     >   28 files changed, 1889 insertions(+), 4 deletions(-)
> >     >   create mode 100644 docs/ebpf.rst
> >     >   create mode 100644 docs/ebpf_rss.rst
> >     >   create mode 100644 ebpf/EbpfElf_to_C.py
> >     >   create mode 100755 ebpf/Makefile.ebpf
> >     >   create mode 100644 ebpf/ebpf-stub.c
> >     >   create mode 100644 ebpf/ebpf.c
> >     >   create mode 100644 ebpf/ebpf.h
> >     >   create mode 100644 ebpf/ebpf_rss.c
> >     >   create mode 100644 ebpf/ebpf_rss.h
> >     >   create mode 100644 ebpf/meson.build
> >     >   create mode 100644 ebpf/rss.bpf.c
> >     >   create mode 100644 ebpf/trace-events
> >     >   create mode 100644 ebpf/trace.h
> >     >   create mode 100644 ebpf/tun_rss_steering.h
> >     >
> >
>
>

--000000000000aa3b3805b3469196
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 4, 2020 at 4:08 AM Jason =
Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/11/3 =E4=B8=8B=E5=8D=886:32, Yuri Benditovich wrote:<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Nov 3, 2020 at 11:02 AM Jason Wang &lt;<a href=3D"mailto:jasow=
ang@redhat.com" target=3D"_blank">jasowang@redhat.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">ja=
sowang@redhat.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2020/11/3 =E4=B8=8A=E5=8D=882:51, Andrew Melnych=
enko wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Basic idea is to use eBPF to calculate and ste=
er packets in TAP.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; RSS(Receive Side Scaling) is used to distribut=
e network packets<br>
&gt;=C2=A0 =C2=A0 =C2=A0to guest virtqueues<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; by calculating packet hash.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; eBPF RSS allows us to use RSS with vhost TAP.<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; This set of patches introduces the usage of eB=
PF for packet steering<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; and RSS hash calculation:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; * RSS(Receive Side Scaling) is used to distrib=
ute network packets to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; guest virtqueues by calculating packet hash<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; * eBPF RSS suppose to be faster than already e=
xisting &#39;software&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; implementation in QEMU<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; * Additionally adding support for the usage of=
 RSS with vhost<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Supported kernels: 5.8+<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Implementation notes:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Linux TAP TUNSETSTEERINGEBPF ioctl was used to=
 set the eBPF program.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Added eBPF support to qemu directly through a =
system call, see the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; bpf(2) for details.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; The eBPF program is part of the qemu and prese=
nted as an array<br>
&gt;=C2=A0 =C2=A0 =C2=A0of bpf<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; instructions.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; The program can be recompiled by provided Make=
file.ebpf(need to<br>
&gt;=C2=A0 =C2=A0 =C2=A0adjust<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &#39;linuxhdrs&#39;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; although it&#39;s not required to build QEMU w=
ith eBPF support.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Added changes to virtio-net and vhost, primary=
 eBPF RSS is used.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &#39;Software&#39; RSS used in the case of has=
h population and as a<br>
&gt;=C2=A0 =C2=A0 =C2=A0fallback option.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; For vhost, the hash population feature is not =
reported to the guest.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Please also see the documentation in PATCH 6/6=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I am sending those patches as RFC to initiate =
the discussions<br>
&gt;=C2=A0 =C2=A0 =C2=A0and get<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; feedback on the following points:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; * Fallback when eBPF is not supported by the k=
ernel<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Yes, and it could also a lacking of CAP_BPF.<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; * Live migration to the kernel that doesn&#39;=
t have eBPF support<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Is there anything that we needs special treatment h=
ere?<br>
&gt;<br>
&gt; Possible case: rss=3Don, vhost=3Don, source system with kernel 5.8 <br=
>
&gt; (everything works) -&gt; dest. system 5.6 (bpf does not work), the <br=
>
&gt; adapter functions, but all the steering does not use proper queues.<br=
>
<br>
<br>
Right, I think we need to disable vhost on dest.<br><br></blockquote><div><=
br></div><div>Is this acceptable to disable vhost at time of migration?=C2=
=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; * Integration with current QEMU build<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Yes, a question here:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A01) Any reason for not using libbpf, e.g it has been=
 shipped with some<br>
&gt;=C2=A0 =C2=A0 =C2=A0distros<br>
&gt;<br>
&gt;<br>
&gt; We intentionally do not use libbpf, as it present only on some distros=
.<br>
&gt; We can switch to libbpf, but this will disable bpf if libbpf is not <b=
r>
&gt; installed<br>
<br>
<br>
That&#39;s better I think.<br></blockquote><div><br></div><div>We think the=
 preferred way is to have an eBPF code built-in in QEMU (not distribute it =
as a separate=C2=A0file).</div><div><br></div><div>Our initial idea was to =
not use the=C2=A0libbpf because it:</div><div>1. Does not create additional=
 dependency during build time and during run-time</div><div>2. Gives us sma=
ller footprint=C2=A0of loadable eBPF blob inside qemu</div><div>3. Do not a=
dd too much code to QEMU</div><div><br></div><div>We can switch to libbpf, =
in this case:</div><div>1. Presence of dynamic library is not guaranteed on=
 the target system</div><div>2. Static library is large</div><div>3. libbpf=
 uses eBPF ELF which is significantly bigger than just the array or instruc=
tions (May be we succeed to reduce the ELF to some suitable size and still =
have it built-in)</div><div></div><div><br></div><div>Please let us know wh=
ether you still think libbpf is better and why.=C2=A0</div><div><br></div><=
div>Thanks</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A02) It would be better if we can avoid shipping byte=
codes<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; This creates new dependencies: llvm=C2=A0+ clang=C2=A0+ ...<br>
&gt; We would prefer byte code and ability to generate it if prerequisites =
<br>
&gt; are installed.<br>
<br>
<br>
It&#39;s probably ok if we treat the bytecode as a kind of firmware.<br>
<br>
But in the long run, it&#39;s still worthwhile consider the qemu source is =
<br>
used for development and llvm/clang should be a common requirement for <br>
generating eBPF bytecode for host.<br>
<br>
<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; * Additional usage for eBPF for packet filteri=
ng<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Another interesting topics in to implement mac/vlan=
 filters. And<br>
&gt;=C2=A0 =C2=A0 =C2=A0in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0future, I plan to add mac based steering. All of th=
ese could be<br>
&gt;=C2=A0 =C2=A0 =C2=A0done via<br>
&gt;=C2=A0 =C2=A0 =C2=A0eBPF.<br>
&gt;<br>
&gt;<br>
&gt; No problem, we can cooperate if needed<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Know issues:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; * hash population not supported by eBPF RSS: &=
#39;software&#39; RSS used<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Is this because there&#39;s not way to write to vne=
t header in<br>
&gt;=C2=A0 =C2=A0 =C2=A0STERRING BPF?<br>
&gt;<br>
&gt; Yes. We plan to submit changes for kernel to cooperate with BPF and <b=
r>
&gt; populate the hash, this work is in progress<br>
<br>
<br>
That would require a new type of eBPF program and may need some work on <br=
>
verifier.<br>
<br></blockquote><div><br></div><div>May be need to allow loading of an add=
itional type in tun.c, not only socket filter (to use bpf_set_hash)</div><d=
iv>Also vhost and tun in kernel need to be aware of header extension for ha=
sh population.<br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
Btw, macvtap is still lacking even steering ebpf program. Would you want <b=
r>
to post a patch to support that?<br>
<br></blockquote><div><br></div><div>Probably after we have full functionin=
g BPF with TAP/TUN</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; as a fallback, also, hash population feature i=
s not reported to<br>
&gt;=C2=A0 =C2=A0 =C2=A0guests<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; with vhost.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; * big-endian BPF support: for now, eBPF is dis=
abled for<br>
&gt;=C2=A0 =C2=A0 =C2=A0big-endian systems.<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Are there any blocker for this?<br>
&gt;<br>
&gt;<br>
&gt; No, can be added in v2<br>
<br>
<br>
Cool.<br>
<br>
Thanks<br>
<br>
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Just some quick questions after a glance of the cod=
es. Will go<br>
&gt;=C2=A0 =C2=A0 =C2=A0through<br>
&gt;=C2=A0 =C2=A0 =C2=A0them tomorrow.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Andrew (6):<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 Added SetSteeringEBPF method for =
NetClientState.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 ebpf: Added basic eBPF API.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 ebpf: Added eBPF RSS program.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 ebpf: Added eBPF RSS loader.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 virtio-net: Added eBPF RSS to vir=
tio-net.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 docs: Added eBPF documentation.<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 36 +++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0docs/ebpf.rst=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 29 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0docs/ebpf_rss.rst=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 129 ++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0ebpf/EbpfElf_to_C.py=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 67 ++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0ebpf/Makefile.ebpf=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 38 +++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0ebpf/ebpf-stub.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 28 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0ebpf/ebpf.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 107 +++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0ebpf/ebpf.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 35 +++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0ebpf/ebpf_rss.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 178 +++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0ebpf/ebpf_rss.h=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 30 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0ebpf/meson.build=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0ebpf/rss.bpf.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 470 +++++++++++++++++++++++++++=
+<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0ebpf/trace-events=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0ebpf/trace.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0ebpf/tun_rss_steering.h=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 556<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0hw/net/vhost_net.c=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0hw/net/virtio-net.c=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 120 ++++++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0include/hw/virtio/virtio-net.h |=
=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0include/net/net.h=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0net/tap-bsd.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0net/tap-linux.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 19 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0net/tap-solaris.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0net/tap-stub.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0net/tap.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0net/tap_int.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0net/vhost-vdpa.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A028 files changed, 1889 insertions(=
+), 4 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0create mode 100644 docs/ebpf.rst<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0create mode 100644 docs/ebpf_rss.r=
st<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0create mode 100644 ebpf/EbpfElf_to=
_C.py<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0create mode 100755 ebpf/Makefile.e=
bpf<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0create mode 100644 ebpf/ebpf-stub.=
c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0create mode 100644 ebpf/ebpf.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0create mode 100644 ebpf/ebpf.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0create mode 100644 ebpf/ebpf_rss.c=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0create mode 100644 ebpf/ebpf_rss.h=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0create mode 100644 ebpf/meson.buil=
d<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0create mode 100644 ebpf/rss.bpf.c<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0create mode 100644 ebpf/trace-even=
ts<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0create mode 100644 ebpf/trace.h<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0create mode 100644 ebpf/tun_rss_st=
eering.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;<br>
<br>
</blockquote></div></div>

--000000000000aa3b3805b3469196--

