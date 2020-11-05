Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE2CC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA23206D9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="UtQN7q3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA23206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kagyi-0003Xx-3C
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 10:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kagxE-0002jP-QS
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:13:36 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kagxA-0003ND-FG
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:13:36 -0500
Received: by mail-ot1-x343.google.com with SMTP id i18so1738108ots.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 07:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jyKyrno91PU1LnLtdRxbjSIsy8OZZh3GH5zI5cejod4=;
 b=UtQN7q3omjY0ab8U6s1NKTuZTvdCDuyrKbtPTSege/rzuSEgcgjlGhA+5hLGmLSEzI
 vE37X5EZ1LqyTOrcw2zhM1+Aki7Lo80KJmhdQMoCGhpRrYT2snNHEN56Mbguxfvx7Xs2
 BNsNDaDNzfLhrdd5mBIqDLXfJ5ajuyvRx/MWW5D6vUE004FDjFO90K3KgeOeUZU87kmq
 FzCrEdrqE1G89nfhhqL7k125zFlJGCMp+V+EWEQCuB3ctwuIj+HYavof2NO38rKvmWfN
 /9YHmLijyj6NivujwzvBmFC1/e7VTNBMwL6iBxqX+UXSmjH8ekfDMRhdikrLSZ8RA4xm
 Tw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jyKyrno91PU1LnLtdRxbjSIsy8OZZh3GH5zI5cejod4=;
 b=OCag7TLSFOFAghcolzk9JlUuzWXY7OTSpdQgjNZhsvefi2R2N2WIlo2RVNrCawHPhF
 j3/NxIzlHfYVgoPkIrRQo4r8aJxttm+MMm0XaIwaIXZJgKSCJZFAyHhjMuWHg3FgJmi1
 oGELFc+EL06HVHfSCXUCvmapru8srhxX+zKUYzPnWnEAqTFqoostA6TmloDuDcZD8gJO
 78vWtUmOkIi8btjK0d9eD87QXwiAewi/Cr2Fxo0u2yuufxQtEHXNRlhmwExCej6hqCo0
 pxk0yOwYj4E2EOuRjBWVqDxKvQ2fV9KnpTo/+U7X6WtR2pd+Y6ULHCAzwLbHp2f0MN8O
 67FA==
X-Gm-Message-State: AOAM530z2cHyxnUbXocY8YyQ2d/f9+NpwttioeMVHFWrkWMzNbDMfJl5
 V5HlX1DwgrO2gasvbeozSZxP+P5ECTk+7ZDj1ptTfA==
X-Google-Smtp-Source: ABdhPJzEXV+te4myNOJzPBEfHHrQfzaUaz5NHg0Cc2lDWduyoQYir0syeir4rvoynLlLJpVz9J0Oqx+VUdDm9otWQBQ=
X-Received: by 2002:a9d:61:: with SMTP id 88mr1871491ota.109.1604589210410;
 Thu, 05 Nov 2020 07:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20201102185115.7425-1-andrew@daynix.com>
 <0164a42f-4542-6f3e-bd71-3319dfaae190@redhat.com>
 <CAOEp5Oe3btwgPcOA6v=kK9s2to=x2Hg6Qw2iCFXOOWZs49s=-Q@mail.gmail.com>
 <caa38709-88f1-bd6d-3ff9-61e64c3aa51f@redhat.com>
 <20201104093155.GB565323@redhat.com>
 <cc53c09c-9b3c-63e1-6df3-b5fc949e626c@redhat.com>
 <20201105100109.GE630142@redhat.com>
 <20201105131938.GK630142@redhat.com>
In-Reply-To: <20201105131938.GK630142@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 5 Nov 2020 17:13:18 +0200
Message-ID: <CAOEp5Oe-Ct-ed5D3UjLZN=iP2W81ta=rTqMjiQ-8vVajag=GfA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] eBPF RSS support for virtio-net
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e5f73405b35d8939"
Received-SPF: none client-ip=2607:f8b0:4864:20::343;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-ot1-x343.google.com
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Andrew Melnychenko <andrew@daynix.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e5f73405b35d8939
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

First of all, thank you for all your feedbacks

Please help me to summarize and let us understand better what we do in v2:
Major questions are:
1. Building eBPF from source during qemu build vs. regenerating it on
demand and keeping in the repository
Solution 1a (~ as in v1): keep instructions or ELF in H file, generate it
out of qemu build. In general we'll need to have BE and LE binaries.
Solution 1b: build ELF or instructions during QEMU build if llvm + clang
exist. Then we will have only one (BE or LE, depending on current QEMU
build)
We agree with any solution - I believe you know the requirements better.

2. Use libbpf or not
In general we do not see any advantage of using libbpf. It works with
object files (does ELF parsing at time of loading), but it does not do any
magic.
Solution 2a. Switch to libbpf, generate object files (LE and BE) from
source, keep them inside QEMU (~8k each) or aside
Solution 2b. (as in v1) Use python script to parse object -> instructions
(~2k each)
We'd prefer not to use libbpf at the moment.
If due to some unknown reason we'll find it useful in future, we can switch
to it, this does not create any incompatibility. Then this will create a
dependency on libbpf.so

3. Keep instructions or ELF inside QEMU or as separate external file
Solution 3a (~as in v1): Built-in array of instructions or ELF. If we
generate them out of QEMU build - keep 2 arrays or instructions or ELF (BE
and LE),
Solution 3b: Install them as separate files (/usr/share/qemu).
We'd prefer 3a:
 Then there is a guarantee that the eBPF is built with exactly the same
config structures as QEMU (qemu creates a mapping of its structures, eBPF
uses them).
 No need to take care on scenarios like 'file not found', 'file is not
suitable' etc

4. Is there some real request to have the eBPF for big-endian?
If no, we can enable eBPF only for LE builds

Jason, Daniel, Michael
Can you please let us know what you think and why?

On Thu, Nov 5, 2020 at 3:19 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:

> On Thu, Nov 05, 2020 at 10:01:09AM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Nov 05, 2020 at 11:46:18AM +0800, Jason Wang wrote:
> > >
> > > On 2020/11/4 =E4=B8=8B=E5=8D=885:31, Daniel P. Berrang=C3=A9 wrote:
> > > > On Wed, Nov 04, 2020 at 10:07:52AM +0800, Jason Wang wrote:
> > > > > On 2020/11/3 =E4=B8=8B=E5=8D=886:32, Yuri Benditovich wrote:
> > > > > >
> > > > > > On Tue, Nov 3, 2020 at 11:02 AM Jason Wang <jasowang@redhat.com
> > > > > > <mailto:jasowang@redhat.com>> wrote:
> > > > > >
> > > > > >
> > > > > >      On 2020/11/3 =E4=B8=8A=E5=8D=882:51, Andrew Melnychenko wr=
ote:
> > > > > >      > Basic idea is to use eBPF to calculate and steer packets
> in TAP.
> > > > > >      > RSS(Receive Side Scaling) is used to distribute network
> packets
> > > > > >      to guest virtqueues
> > > > > >      > by calculating packet hash.
> > > > > >      > eBPF RSS allows us to use RSS with vhost TAP.
> > > > > >      >
> > > > > >      > This set of patches introduces the usage of eBPF for
> packet steering
> > > > > >      > and RSS hash calculation:
> > > > > >      > * RSS(Receive Side Scaling) is used to distribute networ=
k
> packets to
> > > > > >      > guest virtqueues by calculating packet hash
> > > > > >      > * eBPF RSS suppose to be faster than already existing
> 'software'
> > > > > >      > implementation in QEMU
> > > > > >      > * Additionally adding support for the usage of RSS with
> vhost
> > > > > >      >
> > > > > >      > Supported kernels: 5.8+
> > > > > >      >
> > > > > >      > Implementation notes:
> > > > > >      > Linux TAP TUNSETSTEERINGEBPF ioctl was used to set the
> eBPF program.
> > > > > >      > Added eBPF support to qemu directly through a system
> call, see the
> > > > > >      > bpf(2) for details.
> > > > > >      > The eBPF program is part of the qemu and presented as an
> array
> > > > > >      of bpf
> > > > > >      > instructions.
> > > > > >      > The program can be recompiled by provided
> Makefile.ebpf(need to
> > > > > >      adjust
> > > > > >      > 'linuxhdrs'),
> > > > > >      > although it's not required to build QEMU with eBPF
> support.
> > > > > >      > Added changes to virtio-net and vhost, primary eBPF RSS
> is used.
> > > > > >      > 'Software' RSS used in the case of hash population and a=
s
> a
> > > > > >      fallback option.
> > > > > >      > For vhost, the hash population feature is not reported t=
o
> the guest.
> > > > > >      >
> > > > > >      > Please also see the documentation in PATCH 6/6.
> > > > > >      >
> > > > > >      > I am sending those patches as RFC to initiate the
> discussions
> > > > > >      and get
> > > > > >      > feedback on the following points:
> > > > > >      > * Fallback when eBPF is not supported by the kernel
> > > > > >
> > > > > >
> > > > > >      Yes, and it could also a lacking of CAP_BPF.
> > > > > >
> > > > > >
> > > > > >      > * Live migration to the kernel that doesn't have eBPF
> support
> > > > > >
> > > > > >
> > > > > >      Is there anything that we needs special treatment here?
> > > > > >
> > > > > > Possible case: rss=3Don, vhost=3Don, source system with kernel =
5.8
> > > > > > (everything works) -> dest. system 5.6 (bpf does not work), the
> adapter
> > > > > > functions, but all the steering does not use proper queues.
> > > > >
> > > > > Right, I think we need to disable vhost on dest.
> > > > >
> > > > >
> > > > > >
> > > > > >
> > > > > >      > * Integration with current QEMU build
> > > > > >
> > > > > >
> > > > > >      Yes, a question here:
> > > > > >
> > > > > >      1) Any reason for not using libbpf, e.g it has been shippe=
d
> with some
> > > > > >      distros
> > > > > >
> > > > > >
> > > > > > We intentionally do not use libbpf, as it present only on some
> distros.
> > > > > > We can switch to libbpf, but this will disable bpf if libbpf is
> not
> > > > > > installed
> > > > >
> > > > > That's better I think.
> > > > >
> > > > >
> > > > > >      2) It would be better if we can avoid shipping bytecodes
> > > > > >
> > > > > >
> > > > > >
> > > > > > This creates new dependencies: llvm + clang + ...
> > > > > > We would prefer byte code and ability to generate it if
> prerequisites
> > > > > > are installed.
> > > > >
> > > > > It's probably ok if we treat the bytecode as a kind of firmware.
> > > > That is explicitly *not* OK for inclusion in Fedora. They require
> that
> > > > BPF is compiled from source, and rejected my suggestion that it cou=
ld
> > > > be considered a kind of firmware and thus have an exception from
> building
> > > > from source.
> > >
> > >
> > > Please refer what it was done in DPDK:
> > >
> > > http://git.dpdk.org/dpdk/tree/doc/guides/nics/tap.rst#n235
> > >
> > > I don't think what proposed here makes anything different.
> >
> > I'm not convinced that what DPDK does is acceptable to Fedora either
> > based on the responses I've received when asking about BPF handling
> > during build.  I wouldn't suprise me, however, if this was simply
> > missed by reviewers when accepting DPDK into Fedora, because it is
> > not entirely obvious unless you are looking closely.
>
> FWIW, I'm pushing back against the idea that we have to compile the
> BPF code from master source, as I think it is reasonable to have the
> program embedded as a static array in the source code similar to what
> DPDK does.  It doesn't feel much different from other places where apps
> use generated sources, and don't build them from the original source
> every time. eg "configure" is never re-generated from "configure.ac"
> by Fedora packagers, they just use the generated "configure" script
> as-is.
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000e5f73405b35d8939
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">First of all, thank you for all your feedbacks<div><br></d=
iv><div>Please help me to summarize and let us understand better what we do=
 in v2:</div><div>Major questions are:=C2=A0</div><div>1. Building eBPF fro=
m source during qemu build vs. regenerating it on demand and keeping in the=
 repository</div><div>Solution 1a (~ as in v1): keep instructions or ELF in=
 H file, generate it out of qemu build. In general we&#39;ll need to have B=
E and LE binaries.</div><div>Solution 1b: build ELF or instructions during =
QEMU build if llvm=C2=A0+ clang exist. Then we will have only one (BE or LE=
, depending on current QEMU build)</div><div>We agree with any solution - I=
 believe you know the requirements better.=C2=A0</div><div><br></div><div>2=
. Use libbpf or not</div><div>In general we do not see any advantage of usi=
ng libbpf. It works with object files=C2=A0(does ELF parsing at time of loa=
ding), but it does not=C2=A0do any magic.</div><div>Solution 2a. Switch to =
libbpf, generate object files (LE and BE) from source, keep them inside QEM=
U (~8k each) or aside<br></div><div>Solution 2b. (as in v1) Use python scri=
pt to parse object -&gt; instructions (~2k each)</div><div>We&#39;d prefer =
not to use libbpf at the moment.</div><div>If due to some unknown reason we=
&#39;ll find it useful in future, we can switch to it, this does not create=
 any incompatibility. Then this will create a dependency on libbpf.so=C2=A0=
=C2=A0</div><div><br></div><div>3. Keep instructions or ELF inside QEMU or =
as separate external file</div><div>Solution 3a (~as in v1): Built-in array=
 of instructions or ELF. If we generate them out of QEMU build - keep 2 arr=
ays or instructions or ELF (BE and LE),=C2=A0</div><div>Solution 3b: Instal=
l them as separate files (/usr/share/qemu).</div><div>We&#39;d prefer 3a:</=
div><div>=C2=A0Then there is a guarantee that the eBPF is built with exactl=
y the same config structures as QEMU (qemu creates a mapping of its structu=
res, eBPF uses them).</div><div>=C2=A0No need to take care on scenarios lik=
e &#39;file not found&#39;, &#39;file is not suitable&#39; etc</div><div><b=
r></div><div>4. Is there some real request to have the eBPF for big-endian?=
<br></div><div>If no, we can enable eBPF only for LE builds</div><div><br><=
/div><div>Jason, Daniel, Michael</div><div>Can you please let us know what =
you think and why?</div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Nov 5, 2020 at 3:19 PM Daniel P. Berrang=C3=
=A9 &lt;<a href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Thu, Nov 05, 2020 at 10:01:09AM +0000, Daniel P. Berrang=C3=
=A9 wrote:<br>
&gt; On Thu, Nov 05, 2020 at 11:46:18AM +0800, Jason Wang wrote:<br>
&gt; &gt; <br>
&gt; &gt; On 2020/11/4 =E4=B8=8B=E5=8D=885:31, Daniel P. Berrang=C3=A9 wrot=
e:<br>
&gt; &gt; &gt; On Wed, Nov 04, 2020 at 10:07:52AM +0800, Jason Wang wrote:<=
br>
&gt; &gt; &gt; &gt; On 2020/11/3 =E4=B8=8B=E5=8D=886:32, Yuri Benditovich w=
rote:<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; On Tue, Nov 3, 2020 at 11:02 AM Jason Wang &lt;<a =
href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</=
a><br>
&gt; &gt; &gt; &gt; &gt; &lt;mailto:<a href=3D"mailto:jasowang@redhat.com" =
target=3D"_blank">jasowang@redhat.com</a>&gt;&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 On 2020/11/3 =E4=B8=8A=E5=8D=
=882:51, Andrew Melnychenko wrote:<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Basic idea is to use eBPF=
 to calculate and steer packets in TAP.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; RSS(Receive Side Scaling)=
 is used to distribute network packets<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 to guest virtqueues<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; by calculating packet has=
h.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; eBPF RSS allows us to use=
 RSS with vhost TAP.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; This set of patches intro=
duces the usage of eBPF for packet steering<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; and RSS hash calculation:=
<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; * RSS(Receive Side Scalin=
g) is used to distribute network packets to<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; guest virtqueues by calcu=
lating packet hash<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; * eBPF RSS suppose to be =
faster than already existing &#39;software&#39;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; implementation in QEMU<br=
>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; * Additionally adding sup=
port for the usage of RSS with vhost<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Supported kernels: 5.8+<b=
r>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Implementation notes:<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Linux TAP TUNSETSTEERINGE=
BPF ioctl was used to set the eBPF program.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Added eBPF support to qem=
u directly through a system call, see the<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; bpf(2) for details.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; The eBPF program is part =
of the qemu and presented as an array<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 of bpf<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; instructions.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; The program can be recomp=
iled by provided Makefile.ebpf(need to<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 adjust<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; &#39;linuxhdrs&#39;),<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; although it&#39;s not req=
uired to build QEMU with eBPF support.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Added changes to virtio-n=
et and vhost, primary eBPF RSS is used.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; &#39;Software&#39; RSS us=
ed in the case of hash population and as a<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 fallback option.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; For vhost, the hash popul=
ation feature is not reported to the guest.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Please also see the docum=
entation in PATCH 6/6.<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; I am sending those patche=
s as RFC to initiate the discussions<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 and get<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; feedback on the following=
 points:<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; * Fallback when eBPF is n=
ot supported by the kernel<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 Yes, and it could also a lacki=
ng of CAP_BPF.<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; * Live migration to the k=
ernel that doesn&#39;t have eBPF support<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 Is there anything that we need=
s special treatment here?<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; Possible case: rss=3Don, vhost=3Don, source system=
 with kernel 5.8<br>
&gt; &gt; &gt; &gt; &gt; (everything works) -&gt; dest. system 5.6 (bpf doe=
s not work), the adapter<br>
&gt; &gt; &gt; &gt; &gt; functions, but all the steering does not use prope=
r queues.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Right, I think we need to disable vhost on dest.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; * Integration with curren=
t QEMU build<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 Yes, a question here:<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 1) Any reason for not using li=
bbpf, e.g it has been shipped with some<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 distros<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; We intentionally do not use libbpf, as it present =
only on some distros.<br>
&gt; &gt; &gt; &gt; &gt; We can switch to libbpf, but this will disable bpf=
 if libbpf is not<br>
&gt; &gt; &gt; &gt; &gt; installed<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; That&#39;s better I think.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 2) It would be better if we ca=
n avoid shipping bytecodes<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; This creates new dependencies: llvm=C2=A0+ clang=
=C2=A0+ ...<br>
&gt; &gt; &gt; &gt; &gt; We would prefer byte code and ability to generate =
it if prerequisites<br>
&gt; &gt; &gt; &gt; &gt; are installed.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; It&#39;s probably ok if we treat the bytecode as a kind=
 of firmware.<br>
&gt; &gt; &gt; That is explicitly *not* OK for inclusion in Fedora. They re=
quire that<br>
&gt; &gt; &gt; BPF is compiled from source, and rejected my suggestion that=
 it could<br>
&gt; &gt; &gt; be considered a kind of firmware and thus have an exception =
from building<br>
&gt; &gt; &gt; from source.<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; Please refer what it was done in DPDK:<br>
&gt; &gt; <br>
&gt; &gt; <a href=3D"http://git.dpdk.org/dpdk/tree/doc/guides/nics/tap.rst#=
n235" rel=3D"noreferrer" target=3D"_blank">http://git.dpdk.org/dpdk/tree/do=
c/guides/nics/tap.rst#n235</a><br>
&gt; &gt; <br>
&gt; &gt; I don&#39;t think what proposed here makes anything different.<br=
>
&gt; <br>
&gt; I&#39;m not convinced that what DPDK does is acceptable to Fedora eith=
er<br>
&gt; based on the responses I&#39;ve received when asking about BPF handlin=
g<br>
&gt; during build.=C2=A0 I wouldn&#39;t suprise me, however, if this was si=
mply<br>
&gt; missed by reviewers when accepting DPDK into Fedora, because it is<br>
&gt; not entirely obvious unless you are looking closely.<br>
<br>
FWIW, I&#39;m pushing back against the idea that we have to compile the<br>
BPF code from master source, as I think it is reasonable to have the<br>
program embedded as a static array in the source code similar to what<br>
DPDK does.=C2=A0 It doesn&#39;t feel much different from other places where=
 apps<br>
use generated sources, and don&#39;t build them from the original source<br=
>
every time. eg &quot;configure&quot; is never re-generated from &quot;<a hr=
ef=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">configure.a=
c</a>&quot;<br>
by Fedora packagers, they just use the generated &quot;configure&quot; scri=
pt<br>
as-is.<br>
<br>
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div>

--000000000000e5f73405b35d8939--

