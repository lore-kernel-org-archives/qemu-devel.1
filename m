Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34198C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8022065D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="YVzTF3ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8022065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7KX-000407-Tw
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kc7Ig-0003MO-9w
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:33:38 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kc7Ib-0006sb-Fr
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:33:37 -0500
Received: by mail-ot1-x341.google.com with SMTP id a15so7170643otf.5
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 05:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oen1tC/PVeTokH21emTzofz9Az7mCNl3PDfLGo5nNGA=;
 b=YVzTF3kaWEuHNxzpNmsKFVe8yEPq2bRnbhvhyNJSWPMp3w2l5M6AAO5Sv+XWoIG1DL
 5ql4flYYk++WxWJ2PgBcG+6wnFffSPawQ6UP4uzrZyycZFaeI0hm5pdgkwsx+x8K3d4o
 uqf3aBGCx0Ux042WtCR1JN3KwCKmqvDjwMT0Unxs0D7IOE8Ue4B3flJ9BOit/qnAfPN3
 rxAQJluFmNUttyxroElpmzNRUpFLOluCiVw71AbykZpm859nVtDIraO+I6ZhxpfuF5KR
 hxOc2NrGlMvC8rN7llnPrPBFafckivyyXqaTKPKDUZeOx5/Y/Jr7bKPlATbPcWF5VBt/
 16AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oen1tC/PVeTokH21emTzofz9Az7mCNl3PDfLGo5nNGA=;
 b=lGR0XchmSfIpW01lWaHNLKDhCSGWG/DGyzIZdoBx8TUQG9OZAqAdgnEENFRXBnYAGb
 RbISx+D6QSshhfoIVSE50MTRAWOf9jyH/ELJseUMvR404+7JYRzloWTTG7S72JdFiRbJ
 PFlIE/UxWHQCKddBR1hcD4b1gj4sH+YvVnHlfr77vd9T6ETflpkI4qVTXrx4z2Y3z4Bc
 aDYvc2GBzE7PLRAHHzjt+jO6R3J5Wpy0r5xvxqi2IbqH3s7DJLQ6otmaj/HifNmMpNeK
 +xzXQKLN4+NdZboM5eDgyooab3oxjEqMjXHfDQKGcSCzq1Y6xOnfhOXGMGzQtJcWnelL
 BrRw==
X-Gm-Message-State: AOAM532PcifY4tI3QYqnSXcanb7GPShVfQa8FDkVfssWBu3cT30RTzJv
 neDinsjdD5MtTSx3pceYTMeS4V5cVwm4tQ+FkayR1g==
X-Google-Smtp-Source: ABdhPJzirIJyiHApWU7tCaLxs3xmYTSHCCTEJ47gUH432OxuBZezmeT7JB0EOShOdF+lUn9BmXZPQoo2kc7uOF0QRU0=
X-Received: by 2002:a9d:61:: with SMTP id 88mr9708773ota.109.1604928811621;
 Mon, 09 Nov 2020 05:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20201102185115.7425-1-andrew@daynix.com>
 <0164a42f-4542-6f3e-bd71-3319dfaae190@redhat.com>
 <CAOEp5Oe3btwgPcOA6v=kK9s2to=x2Hg6Qw2iCFXOOWZs49s=-Q@mail.gmail.com>
 <caa38709-88f1-bd6d-3ff9-61e64c3aa51f@redhat.com>
 <20201104093155.GB565323@redhat.com>
 <cc53c09c-9b3c-63e1-6df3-b5fc949e626c@redhat.com>
 <20201105100109.GE630142@redhat.com>
 <20201105131938.GK630142@redhat.com>
 <CAOEp5Oe-Ct-ed5D3UjLZN=iP2W81ta=rTqMjiQ-8vVajag=GfA@mail.gmail.com>
 <16bfe468-b0f8-396a-08e9-8917423909e5@redhat.com>
In-Reply-To: <16bfe468-b0f8-396a-08e9-8917423909e5@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 9 Nov 2020 15:33:20 +0200
Message-ID: <CAOEp5Ofb7zK6A+zwbubVtitCrVTe_zLtZDYc0uExvgb+F_p9Zg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] eBPF RSS support for virtio-net
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b4f47e05b3ac9b0b"
Received-SPF: none client-ip=2607:f8b0:4864:20::341;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-ot1-x341.google.com
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
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b4f47e05b3ac9b0b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2020 at 4:14 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/11/5 =E4=B8=8B=E5=8D=8811:13, Yuri Benditovich wrote:
> > First of all, thank you for all your feedbacks
> >
> > Please help me to summarize and let us understand better what we do in
> v2:
> > Major questions are:
> > 1. Building eBPF from source during qemu build vs. regenerating it on
> > demand and keeping in the repository
> > Solution 1a (~ as in v1): keep instructions or ELF in H file, generate
> > it out of qemu build. In general we'll need to have BE and LE binaries.
> > Solution 1b: build ELF or instructions during QEMU build if llvm +
> > clang exist. Then we will have only one (BE or LE, depending on
> > current QEMU build)
> > We agree with any solution - I believe you know the requirements better=
.
>
>
> I think we can go with 1a. (See Danial's comment)
>
>
> >
> > 2. Use libbpf or not
> > In general we do not see any advantage of using libbpf. It works with
> > object files (does ELF parsing at time of loading), but it does not do
> > any magic.
> > Solution 2a. Switch to libbpf, generate object files (LE and BE) from
> > source, keep them inside QEMU (~8k each) or aside
>
>
> Can we simply use dynamic linking here?
>
>
Can you please explain, where exactly you suggest to use dynamic linking?


>
> > Solution 2b. (as in v1) Use python script to parse object ->
> > instructions (~2k each)
> > We'd prefer not to use libbpf at the moment.
> > If due to some unknown reason we'll find it useful in future, we can
> > switch to it, this does not create any incompatibility. Then this will
> > create a dependency on libbpf.so
>
>
> I think we need to care about compatibility. E.g we need to enable BTF
> so I don't know how hard if we add BTF support in the current design. It
> would be probably OK it's not a lot of effort.
>
>
As far as we understand BTF helps in BPF debugging and libbpf supports it
as is.
Without libbpf we in v1 load the BPF instructions only.
If you think the BTF is mandatory (BTW, why?) I think it is better to
switch to libbpf and keep the entire ELF in the qemu data.


> >
> > 3. Keep instructions or ELF inside QEMU or as separate external file
> > Solution 3a (~as in v1): Built-in array of instructions or ELF. If we
> > generate them out of QEMU build - keep 2 arrays or instructions or ELF
> > (BE and LE),
> > Solution 3b: Install them as separate files (/usr/share/qemu).
> > We'd prefer 3a:
> >  Then there is a guarantee that the eBPF is built with exactly the
> > same config structures as QEMU (qemu creates a mapping of its
> > structures, eBPF uses them).
> >  No need to take care on scenarios like 'file not found', 'file is not
> > suitable' etc
>
>
> Yes, let's go 3a for upstream.
>
>
> >
> > 4. Is there some real request to have the eBPF for big-endian?
> > If no, we can enable eBPF only for LE builds
>
>
> We can go with LE first.
>
> Thanks
>
>
> >
> > Jason, Daniel, Michael
> > Can you please let us know what you think and why?
> >
> > On Thu, Nov 5, 2020 at 3:19 PM Daniel P. Berrang=C3=A9 <berrange@redhat=
.com
> > <mailto:berrange@redhat.com>> wrote:
> >
> >     On Thu, Nov 05, 2020 at 10:01:09AM +0000, Daniel P. Berrang=C3=A9 w=
rote:
> >     > On Thu, Nov 05, 2020 at 11:46:18AM +0800, Jason Wang wrote:
> >     > >
> >     > > On 2020/11/4 =E4=B8=8B=E5=8D=885:31, Daniel P. Berrang=C3=A9 wr=
ote:
> >     > > > On Wed, Nov 04, 2020 at 10:07:52AM +0800, Jason Wang wrote:
> >     > > > > On 2020/11/3 =E4=B8=8B=E5=8D=886:32, Yuri Benditovich wrote=
:
> >     > > > > >
> >     > > > > > On Tue, Nov 3, 2020 at 11:02 AM Jason Wang
> >     <jasowang@redhat.com <mailto:jasowang@redhat.com>
> >     > > > > > <mailto:jasowang@redhat.com
> >     <mailto:jasowang@redhat.com>>> wrote:
> >     > > > > >
> >     > > > > >
> >     > > > > >      On 2020/11/3 =E4=B8=8A=E5=8D=882:51, Andrew Melnyche=
nko wrote:
> >     > > > > >      > Basic idea is to use eBPF to calculate and steer
> >     packets in TAP.
> >     > > > > >      > RSS(Receive Side Scaling) is used to distribute
> >     network packets
> >     > > > > >      to guest virtqueues
> >     > > > > >      > by calculating packet hash.
> >     > > > > >      > eBPF RSS allows us to use RSS with vhost TAP.
> >     > > > > >      >
> >     > > > > >      > This set of patches introduces the usage of eBPF
> >     for packet steering
> >     > > > > >      > and RSS hash calculation:
> >     > > > > >      > * RSS(Receive Side Scaling) is used to distribute
> >     network packets to
> >     > > > > >      > guest virtqueues by calculating packet hash
> >     > > > > >      > * eBPF RSS suppose to be faster than already
> >     existing 'software'
> >     > > > > >      > implementation in QEMU
> >     > > > > >      > * Additionally adding support for the usage of
> >     RSS with vhost
> >     > > > > >      >
> >     > > > > >      > Supported kernels: 5.8+
> >     > > > > >      >
> >     > > > > >      > Implementation notes:
> >     > > > > >      > Linux TAP TUNSETSTEERINGEBPF ioctl was used to
> >     set the eBPF program.
> >     > > > > >      > Added eBPF support to qemu directly through a
> >     system call, see the
> >     > > > > >      > bpf(2) for details.
> >     > > > > >      > The eBPF program is part of the qemu and
> >     presented as an array
> >     > > > > >      of bpf
> >     > > > > >      > instructions.
> >     > > > > >      > The program can be recompiled by provided
> >     Makefile.ebpf(need to
> >     > > > > >      adjust
> >     > > > > >      > 'linuxhdrs'),
> >     > > > > >      > although it's not required to build QEMU with
> >     eBPF support.
> >     > > > > >      > Added changes to virtio-net and vhost, primary
> >     eBPF RSS is used.
> >     > > > > >      > 'Software' RSS used in the case of hash
> >     population and as a
> >     > > > > >      fallback option.
> >     > > > > >      > For vhost, the hash population feature is not
> >     reported to the guest.
> >     > > > > >      >
> >     > > > > >      > Please also see the documentation in PATCH 6/6.
> >     > > > > >      >
> >     > > > > >      > I am sending those patches as RFC to initiate the
> >     discussions
> >     > > > > >      and get
> >     > > > > >      > feedback on the following points:
> >     > > > > >      > * Fallback when eBPF is not supported by the kerne=
l
> >     > > > > >
> >     > > > > >
> >     > > > > >      Yes, and it could also a lacking of CAP_BPF.
> >     > > > > >
> >     > > > > >
> >     > > > > >      > * Live migration to the kernel that doesn't have
> >     eBPF support
> >     > > > > >
> >     > > > > >
> >     > > > > >      Is there anything that we needs special treatment
> here?
> >     > > > > >
> >     > > > > > Possible case: rss=3Don, vhost=3Don, source system with
> >     kernel 5.8
> >     > > > > > (everything works) -> dest. system 5.6 (bpf does not
> >     work), the adapter
> >     > > > > > functions, but all the steering does not use proper queue=
s.
> >     > > > >
> >     > > > > Right, I think we need to disable vhost on dest.
> >     > > > >
> >     > > > >
> >     > > > > >
> >     > > > > >
> >     > > > > >      > * Integration with current QEMU build
> >     > > > > >
> >     > > > > >
> >     > > > > >      Yes, a question here:
> >     > > > > >
> >     > > > > >      1) Any reason for not using libbpf, e.g it has been
> >     shipped with some
> >     > > > > >      distros
> >     > > > > >
> >     > > > > >
> >     > > > > > We intentionally do not use libbpf, as it present only
> >     on some distros.
> >     > > > > > We can switch to libbpf, but this will disable bpf if
> >     libbpf is not
> >     > > > > > installed
> >     > > > >
> >     > > > > That's better I think.
> >     > > > >
> >     > > > >
> >     > > > > >      2) It would be better if we can avoid shipping
> >     bytecodes
> >     > > > > >
> >     > > > > >
> >     > > > > >
> >     > > > > > This creates new dependencies: llvm + clang + ...
> >     > > > > > We would prefer byte code and ability to generate it if
> >     prerequisites
> >     > > > > > are installed.
> >     > > > >
> >     > > > > It's probably ok if we treat the bytecode as a kind of
> >     firmware.
> >     > > > That is explicitly *not* OK for inclusion in Fedora. They
> >     require that
> >     > > > BPF is compiled from source, and rejected my suggestion that
> >     it could
> >     > > > be considered a kind of firmware and thus have an exception
> >     from building
> >     > > > from source.
> >     > >
> >     > >
> >     > > Please refer what it was done in DPDK:
> >     > >
> >     > > http://git.dpdk.org/dpdk/tree/doc/guides/nics/tap.rst#n235
> >     > >
> >     > > I don't think what proposed here makes anything different.
> >     >
> >     > I'm not convinced that what DPDK does is acceptable to Fedora
> either
> >     > based on the responses I've received when asking about BPF handli=
ng
> >     > during build.  I wouldn't suprise me, however, if this was simply
> >     > missed by reviewers when accepting DPDK into Fedora, because it i=
s
> >     > not entirely obvious unless you are looking closely.
> >
> >     FWIW, I'm pushing back against the idea that we have to compile the
> >     BPF code from master source, as I think it is reasonable to have th=
e
> >     program embedded as a static array in the source code similar to wh=
at
> >     DPDK does.  It doesn't feel much different from other places where
> >     apps
> >     use generated sources, and don't build them from the original sourc=
e
> >     every time. eg "configure" is never re-generated from
> >     "configure.ac <http://configure.ac>"
> >     by Fedora packagers, they just use the generated "configure" script
> >     as-is.
> >
> >     Regards,
> >     Daniel
> >     --
> >     |: https://berrange.com     -o-
> >     https://www.flickr.com/photos/dberrange :|
> >     |: https://libvirt.org        -o- https://fstop138.berrange.com :|
> >     |: https://entangle-photo.org   -o-
> >     https://www.instagram.com/dberrange :|
> >
>
>

--000000000000b4f47e05b3ac9b0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 9, 2020 at 4:14 AM Jason =
Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/11/5 =E4=B8=8B=E5=8D=8811:13, Yuri Benditovich wrote:<br>
&gt; First of all, thank you for all your feedbacks<br>
&gt;<br>
&gt; Please help me to summarize and let us understand better what we do in=
 v2:<br>
&gt; Major questions are:<br>
&gt; 1. Building eBPF from source during qemu build vs. regenerating it on =
<br>
&gt; demand and keeping in the repository<br>
&gt; Solution 1a (~ as in v1): keep instructions or ELF in H file, generate=
 <br>
&gt; it out of qemu build. In general we&#39;ll need to have BE and LE bina=
ries.<br>
&gt; Solution 1b: build ELF or instructions during QEMU build if llvm=C2=A0=
+ <br>
&gt; clang exist. Then we will have only one (BE or LE, depending on <br>
&gt; current QEMU build)<br>
&gt; We agree with any solution - I believe you know the requirements bette=
r.<br>
<br>
<br>
I think we can go with 1a. (See Danial&#39;s comment)<br>
<br>
<br>
&gt;<br>
&gt; 2. Use libbpf or not<br>
&gt; In general we do not see any advantage of using libbpf. It works with =
<br>
&gt; object files=C2=A0(does ELF parsing at time of loading), but it does n=
ot=C2=A0do <br>
&gt; any magic.<br>
&gt; Solution 2a. Switch to libbpf, generate object files (LE and BE) from =
<br>
&gt; source, keep them inside QEMU (~8k each) or aside<br>
<br>
<br>
Can we simply use dynamic linking here?<br>
<br></blockquote><div><br></div><div>Can you please explain, where exactly =
you suggest to use dynamic linking?<br></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
&gt; Solution 2b. (as in v1) Use python script to parse object -&gt; <br>
&gt; instructions (~2k each)<br>
&gt; We&#39;d prefer not to use libbpf at the moment.<br>
&gt; If due to some unknown reason we&#39;ll find it useful in future, we c=
an <br>
&gt; switch to it, this does not create any incompatibility. Then this will=
 <br>
&gt; create a dependency on libbpf.so<br>
<br>
<br>
I think we need to care about compatibility. E.g we need to enable BTF <br>
so I don&#39;t know how hard if we add BTF support in the current design. I=
t <br>
would be probably OK it&#39;s not a lot of effort.<br>
<br></blockquote><div><br></div><div>As far as we understand BTF helps in B=
PF debugging and libbpf supports it as is.<br></div><div>Without libbpf we =
in v1 load the BPF instructions only.</div><div>If you think the BTF is man=
datory (BTW, why?) I think it is better to switch to libbpf and keep the en=
tire ELF in the qemu data.</div><div><br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
&gt;<br>
&gt; 3. Keep instructions or ELF inside QEMU or as separate external file<b=
r>
&gt; Solution 3a (~as in v1): Built-in array of instructions or ELF. If we =
<br>
&gt; generate them out of QEMU build - keep 2 arrays or instructions or ELF=
 <br>
&gt; (BE and LE),<br>
&gt; Solution 3b: Install them as separate files (/usr/share/qemu).<br>
&gt; We&#39;d prefer 3a:<br>
&gt; =C2=A0Then there is a guarantee that the eBPF is built with exactly th=
e <br>
&gt; same config structures as QEMU (qemu creates a mapping of its <br>
&gt; structures, eBPF uses them).<br>
&gt; =C2=A0No need to take care on scenarios like &#39;file not found&#39;,=
 &#39;file is not <br>
&gt; suitable&#39; etc<br>
<br>
<br>
Yes, let&#39;s go 3a for upstream.<br>
<br>
<br>
&gt;<br>
&gt; 4. Is there some real request to have the eBPF for big-endian?<br>
&gt; If no, we can enable eBPF only for LE builds<br>
<br>
<br>
We can go with LE first.<br>
<br>
Thanks<br>
<br>
<br>
&gt;<br>
&gt; Jason, Daniel, Michael<br>
&gt; Can you please let us know what you think and why?<br>
&gt;<br>
&gt; On Thu, Nov 5, 2020 at 3:19 PM Daniel P. Berrang=C3=A9 &lt;<a href=3D"=
mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:berrange@redhat.com" target=3D"_blank">be=
rrange@redhat.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On Thu, Nov 05, 2020 at 10:01:09AM +0000, Daniel P.=
 Berrang=C3=A9 wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On Thu, Nov 05, 2020 at 11:46:18AM +0800, Jaso=
n Wang wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; On 2020/11/4 =E4=B8=8B=E5=8D=885:31, Dani=
el P. Berrang=C3=A9 wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; On Wed, Nov 04, 2020 at 10:07:52AM +=
0800, Jason Wang wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; On 2020/11/3 =E4=B8=8B=E5=8D=88=
6:32, Yuri Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; On Tue, Nov 3, 2020 at 11:=
02 AM Jason Wang<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:jasowang@redhat.com" target=
=3D"_blank">jasowang@redhat.com</a> &lt;mailto:<a href=3D"mailto:jasowang@r=
edhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &lt;mailto:<a href=3D"mail=
to:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:jasowang@redhat.com" t=
arget=3D"_blank">jasowang@redhat.com</a>&gt;&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 On 202=
0/11/3 =E4=B8=8A=E5=8D=882:51, Andrew Melnychenko wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; B=
asic idea is to use eBPF to calculate and steer<br>
&gt;=C2=A0 =C2=A0 =C2=A0packets in TAP.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; R=
SS(Receive Side Scaling) is used to distribute<br>
&gt;=C2=A0 =C2=A0 =C2=A0network packets<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 to gue=
st virtqueues<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; b=
y calculating packet hash.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; e=
BPF RSS allows us to use RSS with vhost TAP.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; T=
his set of patches introduces the usage of eBPF<br>
&gt;=C2=A0 =C2=A0 =C2=A0for packet steering<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; a=
nd RSS hash calculation:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; *=
 RSS(Receive Side Scaling) is used to distribute<br>
&gt;=C2=A0 =C2=A0 =C2=A0network packets to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; g=
uest virtqueues by calculating packet hash<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; *=
 eBPF RSS suppose to be faster than already<br>
&gt;=C2=A0 =C2=A0 =C2=A0existing &#39;software&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; i=
mplementation in QEMU<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; *=
 Additionally adding support for the usage of<br>
&gt;=C2=A0 =C2=A0 =C2=A0RSS with vhost<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; S=
upported kernels: 5.8+<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; I=
mplementation notes:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; L=
inux TAP TUNSETSTEERINGEBPF ioctl was used to<br>
&gt;=C2=A0 =C2=A0 =C2=A0set the eBPF program.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; A=
dded eBPF support to qemu directly through a<br>
&gt;=C2=A0 =C2=A0 =C2=A0system call, see the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; b=
pf(2) for details.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; T=
he eBPF program is part of the qemu and<br>
&gt;=C2=A0 =C2=A0 =C2=A0presented as an array<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 of bpf=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; i=
nstructions.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; T=
he program can be recompiled by provided<br>
&gt;=C2=A0 =C2=A0 =C2=A0Makefile.ebpf(need to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 adjust=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; &=
#39;linuxhdrs&#39;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; a=
lthough it&#39;s not required to build QEMU with<br>
&gt;=C2=A0 =C2=A0 =C2=A0eBPF support.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; A=
dded changes to virtio-net and vhost, primary<br>
&gt;=C2=A0 =C2=A0 =C2=A0eBPF RSS is used.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; &=
#39;Software&#39; RSS used in the case of hash<br>
&gt;=C2=A0 =C2=A0 =C2=A0population and as a<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 fallba=
ck option.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; F=
or vhost, the hash population feature is not<br>
&gt;=C2=A0 =C2=A0 =C2=A0reported to the guest.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; P=
lease also see the documentation in PATCH 6/6.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; I=
 am sending those patches as RFC to initiate the<br>
&gt;=C2=A0 =C2=A0 =C2=A0discussions<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 and ge=
t<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; f=
eedback on the following points:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; *=
 Fallback when eBPF is not supported by the kernel<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 Yes, a=
nd it could also a lacking of CAP_BPF.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; *=
 Live migration to the kernel that doesn&#39;t have<br>
&gt;=C2=A0 =C2=A0 =C2=A0eBPF support<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 Is the=
re anything that we needs special treatment here?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; Possible case: rss=3Don, v=
host=3Don, source system with<br>
&gt;=C2=A0 =C2=A0 =C2=A0kernel 5.8<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; (everything works) -&gt; d=
est. system 5.6 (bpf does not<br>
&gt;=C2=A0 =C2=A0 =C2=A0work), the adapter<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; functions, but all the ste=
ering does not use proper queues.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; Right, I think we need to disab=
le vhost on dest.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; *=
 Integration with current QEMU build<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 Yes, a=
 question here:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 1) Any=
 reason for not using libbpf, e.g it has been<br>
&gt;=C2=A0 =C2=A0 =C2=A0shipped with some<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 distro=
s<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; We intentionally do not us=
e libbpf, as it present only<br>
&gt;=C2=A0 =C2=A0 =C2=A0on some distros.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; We can switch to libbpf, b=
ut this will disable bpf if<br>
&gt;=C2=A0 =C2=A0 =C2=A0libbpf is not<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; installed<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; That&#39;s better I think.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 2) It =
would be better if we can avoid shipping<br>
&gt;=C2=A0 =C2=A0 =C2=A0bytecodes<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; This creates new dependenc=
ies: llvm=C2=A0+ clang=C2=A0+ ...<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; We would prefer byte code =
and ability to generate it if<br>
&gt;=C2=A0 =C2=A0 =C2=A0prerequisites<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; are installed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; It&#39;s probably ok if we trea=
t the bytecode as a kind of<br>
&gt;=C2=A0 =C2=A0 =C2=A0firmware.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; That is explicitly *not* OK for incl=
usion in Fedora. They<br>
&gt;=C2=A0 =C2=A0 =C2=A0require that<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; BPF is compiled from source, and rej=
ected my suggestion that<br>
&gt;=C2=A0 =C2=A0 =C2=A0it could<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; be considered a kind of firmware and=
 thus have an exception<br>
&gt;=C2=A0 =C2=A0 =C2=A0from building<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; from source.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Please refer what it was done in DPDK:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; <a href=3D"http://git.dpdk.org/dpdk/tree/=
doc/guides/nics/tap.rst#n235" rel=3D"noreferrer" target=3D"_blank">http://g=
it.dpdk.org/dpdk/tree/doc/guides/nics/tap.rst#n235</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; I don&#39;t think what proposed here make=
s anything different.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I&#39;m not convinced that what DPDK does is a=
cceptable to Fedora either<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; based on the responses I&#39;ve received when =
asking about BPF handling<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; during build.=C2=A0 I wouldn&#39;t suprise me,=
 however, if this was simply<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; missed by reviewers when accepting DPDK into F=
edora, because it is<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; not entirely obvious unless you are looking cl=
osely.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0FWIW, I&#39;m pushing back against the idea that we=
 have to compile the<br>
&gt;=C2=A0 =C2=A0 =C2=A0BPF code from master source, as I think it is reaso=
nable to have the<br>
&gt;=C2=A0 =C2=A0 =C2=A0program embedded as a static array in the source co=
de similar to what<br>
&gt;=C2=A0 =C2=A0 =C2=A0DPDK does.=C2=A0 It doesn&#39;t feel much different=
 from other places where<br>
&gt;=C2=A0 =C2=A0 =C2=A0apps<br>
&gt;=C2=A0 =C2=A0 =C2=A0use generated sources, and don&#39;t build them fro=
m the original source<br>
&gt;=C2=A0 =C2=A0 =C2=A0every time. eg &quot;configure&quot; is never re-ge=
nerated from<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;<a href=3D"http://configure.ac" rel=3D"norefe=
rrer" target=3D"_blank">configure.ac</a> &lt;<a href=3D"http://configure.ac=
" rel=3D"noreferrer" target=3D"_blank">http://configure.ac</a>&gt;&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0by Fedora packagers, they just use the generated &q=
uot;configure&quot; script<br>
&gt;=C2=A0 =C2=A0 =C2=A0as-is.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Daniel<br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A0|: <a href=3D"https://berrange.com" rel=3D"noreferr=
er" target=3D"_blank">https://berrange.com</a> =C2=A0 =C2=A0 -o-<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://www.flickr.com/photos/dberrange"=
 rel=3D"noreferrer" target=3D"_blank">https://www.flickr.com/photos/dberran=
ge</a> :|<br>
&gt;=C2=A0 =C2=A0 =C2=A0|: <a href=3D"https://libvirt.org" rel=3D"noreferre=
r" target=3D"_blank">https://libvirt.org</a> =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=
 <a href=3D"https://fstop138.berrange.com" rel=3D"noreferrer" target=3D"_bl=
ank">https://fstop138.berrange.com</a> :|<br>
&gt;=C2=A0 =C2=A0 =C2=A0|: <a href=3D"https://entangle-photo.org" rel=3D"no=
referrer" target=3D"_blank">https://entangle-photo.org</a> =C2=A0 -o-<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://www.instagram.com/dberrange" rel=
=3D"noreferrer" target=3D"_blank">https://www.instagram.com/dberrange</a> :=
|<br>
&gt;<br>
<br>
</blockquote></div></div>

--000000000000b4f47e05b3ac9b0b--

