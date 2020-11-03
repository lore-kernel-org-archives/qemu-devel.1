Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005DAC83021
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5C021D40
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="ocfqP55E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5C021D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZtdY-0008Uh-24
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 05:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kZtcY-0007a5-EX
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:32:58 -0500
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:38771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kZtcV-0003Uo-Qd
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:32:58 -0500
Received: by mail-oo1-xc44.google.com with SMTP id v123so4081401ooa.5
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 02:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L290EPl8tQbky1bFcmhMro84pvf8QEfq1wCcZYdxks8=;
 b=ocfqP55EkKLNaN9zd8pX15wlEzhyOTOnKUW4OAYH02tXRNcDIozGa6H2D5sL/QLO/h
 l4/qkn1IBnz3jlg4qrTqXzTy3W0q0z3l0ABWnTjDwu7JSr7CuxmqfYoYFjw1csTqv75A
 UYWYaNvcaCjmU12hq9K9y3HJMvMshSL29QLYqdqwRKue0DBeK+cRi+m70OokW7KNfvSx
 DuCsL7emZVn/nDCOVDXRiAldWSGCBZzijLjrBANvY2Yh2Zv27W4OmUAbsQ7gTDqPckxZ
 zUxFquPV/1YlvtTcXGTLFJGDVqZXft97agiP7Ay5SguEXRqhGnbk9a9Hsfn5GzZYOQiV
 92gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L290EPl8tQbky1bFcmhMro84pvf8QEfq1wCcZYdxks8=;
 b=CWvhEyEEY2Xj+ERr/0kq5jfyEqiRGdPVlURV3Unk1xdJjcOgro+ymINtSXGibA1/ug
 QkOYZLcbEiSLXP8GUjH/BljeC9xmnwwiUrqe/mGiQKG0LHZymerG5SSvhaMN17vZ8s0N
 BypfezPA7gBVpkpgvhh44Ii31AOzB6Fk3a4EODsMDI3B1XFQ/DQ+uCkqzXsXaK3OwqUJ
 /b+woZZIITqI2IvOiSF5g4z5y537gIdfb/MwWy6NzZ/r1YCq4YwfGYIFUDPYTf9u7EIs
 wR0lKxX9JMTu9uOz+Cb4SIo+2YDJ0PcRo0m7ZHF+buQnr8oJ1o/hs5R6S7NE3JcMQETo
 FnGQ==
X-Gm-Message-State: AOAM530MICbW+OTCtrXArK/x41GmC6WTgZWv/UP5ikli4XoG4ksGyRgj
 sd6b9OTou8sfLZouuYJES/tytFwKCXwuv6m/UfWc+w==
X-Google-Smtp-Source: ABdhPJxA7RATnN+rHMfe/tTU6PRFVmfVOOg1+WYEypls0qh7ExFuVVNf96ZBtpKcvYgThMnn4XDgKA6U0j/6oSvr0+Y=
X-Received: by 2002:a4a:d0a4:: with SMTP id t4mr14901973oor.21.1604399574173; 
 Tue, 03 Nov 2020 02:32:54 -0800 (PST)
MIME-Version: 1.0
References: <20201102185115.7425-1-andrew@daynix.com>
 <0164a42f-4542-6f3e-bd71-3319dfaae190@redhat.com>
In-Reply-To: <0164a42f-4542-6f3e-bd71-3319dfaae190@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 3 Nov 2020 12:32:43 +0200
Message-ID: <CAOEp5Oe3btwgPcOA6v=kK9s2to=x2Hg6Qw2iCFXOOWZs49s=-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] eBPF RSS support for virtio-net
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b25f6505b33162dd"
Received-SPF: none client-ip=2607:f8b0:4864:20::c44;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-oo1-xc44.google.com
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

--000000000000b25f6505b33162dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2020 at 11:02 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/11/3 =E4=B8=8A=E5=8D=882:51, Andrew Melnychenko wrote:
> > Basic idea is to use eBPF to calculate and steer packets in TAP.
> > RSS(Receive Side Scaling) is used to distribute network packets to gues=
t
> virtqueues
> > by calculating packet hash.
> > eBPF RSS allows us to use RSS with vhost TAP.
> >
> > This set of patches introduces the usage of eBPF for packet steering
> > and RSS hash calculation:
> > * RSS(Receive Side Scaling) is used to distribute network packets to
> > guest virtqueues by calculating packet hash
> > * eBPF RSS suppose to be faster than already existing 'software'
> > implementation in QEMU
> > * Additionally adding support for the usage of RSS with vhost
> >
> > Supported kernels: 5.8+
> >
> > Implementation notes:
> > Linux TAP TUNSETSTEERINGEBPF ioctl was used to set the eBPF program.
> > Added eBPF support to qemu directly through a system call, see the
> > bpf(2) for details.
> > The eBPF program is part of the qemu and presented as an array of bpf
> > instructions.
> > The program can be recompiled by provided Makefile.ebpf(need to adjust
> > 'linuxhdrs'),
> > although it's not required to build QEMU with eBPF support.
> > Added changes to virtio-net and vhost, primary eBPF RSS is used.
> > 'Software' RSS used in the case of hash population and as a fallback
> option.
> > For vhost, the hash population feature is not reported to the guest.
> >
> > Please also see the documentation in PATCH 6/6.
> >
> > I am sending those patches as RFC to initiate the discussions and get
> > feedback on the following points:
> > * Fallback when eBPF is not supported by the kernel
>
>
> Yes, and it could also a lacking of CAP_BPF.
>
>
> > * Live migration to the kernel that doesn't have eBPF support
>
>
> Is there anything that we needs special treatment here?
>
> Possible case: rss=3Don, vhost=3Don, source system with kernel 5.8 (every=
thing
works) -> dest. system 5.6 (bpf does not work), the adapter functions, but
all the steering does not use proper queues.




>
> > * Integration with current QEMU build
>
>
> Yes, a question here:
>
> 1) Any reason for not using libbpf, e.g it has been shipped with some
> distros
>

We intentionally do not use libbpf, as it present only on some distros.
We can switch to libbpf, but this will disable bpf if libbpf is not
installed


> 2) It would be better if we can avoid shipping bytecodes
>


This creates new dependencies: llvm + clang + ...
We would prefer byte code and ability to generate it if prerequisites are
installed.


>
>
> > * Additional usage for eBPF for packet filtering
>
>
> Another interesting topics in to implement mac/vlan filters. And in the
> future, I plan to add mac based steering. All of these could be done via
> eBPF.
>
>
No problem, we can cooperate if needed


>
> >
> > Know issues:
> > * hash population not supported by eBPF RSS: 'software' RSS used
>
>
> Is this because there's not way to write to vnet header in STERRING BPF?
>
> Yes. We plan to submit changes for kernel to cooperate with BPF and
populate the hash, this work is in progress


>
> > as a fallback, also, hash population feature is not reported to guests
> > with vhost.
> > * big-endian BPF support: for now, eBPF is disabled for big-endian
> systems.
>
>
> Are there any blocker for this?
>

No, can be added in v2


>
> Just some quick questions after a glance of the codes. Will go through
> them tomorrow.
>
> Thanks
>
>
> >
> > Andrew (6):
> >    Added SetSteeringEBPF method for NetClientState.
> >    ebpf: Added basic eBPF API.
> >    ebpf: Added eBPF RSS program.
> >    ebpf: Added eBPF RSS loader.
> >    virtio-net: Added eBPF RSS to virtio-net.
> >    docs: Added eBPF documentation.
> >
> >   MAINTAINERS                    |   6 +
> >   configure                      |  36 +++
> >   docs/ebpf.rst                  |  29 ++
> >   docs/ebpf_rss.rst              | 129 ++++++++
> >   ebpf/EbpfElf_to_C.py           |  67 ++++
> >   ebpf/Makefile.ebpf             |  38 +++
> >   ebpf/ebpf-stub.c               |  28 ++
> >   ebpf/ebpf.c                    | 107 +++++++
> >   ebpf/ebpf.h                    |  35 +++
> >   ebpf/ebpf_rss.c                | 178 +++++++++++
> >   ebpf/ebpf_rss.h                |  30 ++
> >   ebpf/meson.build               |   1 +
> >   ebpf/rss.bpf.c                 | 470 ++++++++++++++++++++++++++++
> >   ebpf/trace-events              |   4 +
> >   ebpf/trace.h                   |   2 +
> >   ebpf/tun_rss_steering.h        | 556 ++++++++++++++++++++++++++++++++=
+
> >   hw/net/vhost_net.c             |   2 +
> >   hw/net/virtio-net.c            | 120 ++++++-
> >   include/hw/virtio/virtio-net.h |   4 +
> >   include/net/net.h              |   2 +
> >   meson.build                    |   3 +
> >   net/tap-bsd.c                  |   5 +
> >   net/tap-linux.c                |  19 ++
> >   net/tap-solaris.c              |   5 +
> >   net/tap-stub.c                 |   5 +
> >   net/tap.c                      |   9 +
> >   net/tap_int.h                  |   1 +
> >   net/vhost-vdpa.c               |   2 +
> >   28 files changed, 1889 insertions(+), 4 deletions(-)
> >   create mode 100644 docs/ebpf.rst
> >   create mode 100644 docs/ebpf_rss.rst
> >   create mode 100644 ebpf/EbpfElf_to_C.py
> >   create mode 100755 ebpf/Makefile.ebpf
> >   create mode 100644 ebpf/ebpf-stub.c
> >   create mode 100644 ebpf/ebpf.c
> >   create mode 100644 ebpf/ebpf.h
> >   create mode 100644 ebpf/ebpf_rss.c
> >   create mode 100644 ebpf/ebpf_rss.h
> >   create mode 100644 ebpf/meson.build
> >   create mode 100644 ebpf/rss.bpf.c
> >   create mode 100644 ebpf/trace-events
> >   create mode 100644 ebpf/trace.h
> >   create mode 100644 ebpf/tun_rss_steering.h
> >
>
>

--000000000000b25f6505b33162dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 3, 2020 at 11:02 AM Jason=
 Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/11/3 =E4=B8=8A=E5=8D=882:51, Andrew Melnychenko wrote:<br>
&gt; Basic idea is to use eBPF to calculate and steer packets in TAP.<br>
&gt; RSS(Receive Side Scaling) is used to distribute network packets to gue=
st virtqueues<br>
&gt; by calculating packet hash.<br>
&gt; eBPF RSS allows us to use RSS with vhost TAP.<br>
&gt;<br>
&gt; This set of patches introduces the usage of eBPF for packet steering<b=
r>
&gt; and RSS hash calculation:<br>
&gt; * RSS(Receive Side Scaling) is used to distribute network packets to<b=
r>
&gt; guest virtqueues by calculating packet hash<br>
&gt; * eBPF RSS suppose to be faster than already existing &#39;software&#3=
9;<br>
&gt; implementation in QEMU<br>
&gt; * Additionally adding support for the usage of RSS with vhost<br>
&gt;<br>
&gt; Supported kernels: 5.8+<br>
&gt;<br>
&gt; Implementation notes:<br>
&gt; Linux TAP TUNSETSTEERINGEBPF ioctl was used to set the eBPF program.<b=
r>
&gt; Added eBPF support to qemu directly through a system call, see the<br>
&gt; bpf(2) for details.<br>
&gt; The eBPF program is part of the qemu and presented as an array of bpf<=
br>
&gt; instructions.<br>
&gt; The program can be recompiled by provided Makefile.ebpf(need to adjust=
<br>
&gt; &#39;linuxhdrs&#39;),<br>
&gt; although it&#39;s not required to build QEMU with eBPF support.<br>
&gt; Added changes to virtio-net and vhost, primary eBPF RSS is used.<br>
&gt; &#39;Software&#39; RSS used in the case of hash population and as a fa=
llback option.<br>
&gt; For vhost, the hash population feature is not reported to the guest.<b=
r>
&gt;<br>
&gt; Please also see the documentation in PATCH 6/6.<br>
&gt;<br>
&gt; I am sending those patches as RFC to initiate the discussions and get<=
br>
&gt; feedback on the following points:<br>
&gt; * Fallback when eBPF is not supported by the kernel<br>
<br>
<br>
Yes, and it could also a lacking of CAP_BPF.<br>
<br>
<br>
&gt; * Live migration to the kernel that doesn&#39;t have eBPF support<br>
<br>
<br>
Is there anything that we needs special treatment here?<br>
<br></blockquote><div>Possible case: rss=3Don, vhost=3Don, source system wi=
th kernel 5.8 (everything works) -&gt; dest. system 5.6 (bpf does not work)=
, the adapter functions, but all the steering does not use proper queues.=
=C2=A0=C2=A0</div><div><br></div><div><br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
&gt; * Integration with current QEMU build<br>
<br>
<br>
Yes, a question here:<br>
<br>
1) Any reason for not using libbpf, e.g it has been shipped with some <br>
distros=C2=A0<br></blockquote><div><br></div><div>We intentionally do not u=
se libbpf, as it present only on some distros.</div><div>We can switch to l=
ibbpf, but this will disable bpf if libbpf is not installed=C2=A0</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
2) It would be better if we can avoid shipping bytecodes<br>
</blockquote><div><br></div><div><br></div><div>This creates new dependenci=
es: llvm=C2=A0+ clang=C2=A0+ ...</div><div>We would prefer byte code and ab=
ility to generate it if prerequisites are installed.=C2=A0<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"></blockquote>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
&gt; * Additional usage for eBPF for packet filtering<br>
<br>
<br>
Another interesting topics in to implement mac/vlan filters. And in the <br=
>
future, I plan to add mac based steering. All of these could be done via <b=
r>
eBPF.<br>
<br></blockquote><div><br></div><div>No problem, we can cooperate if needed=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Know issues:<br>
&gt; * hash population not supported by eBPF RSS: &#39;software&#39; RSS us=
ed<br>
<br>
<br>
Is this because there&#39;s not way to write to vnet header in STERRING BPF=
?<br>
<br></blockquote><div>Yes. We plan to submit changes for kernel to cooperat=
e with BPF and populate the hash, this work is in progress</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; as a fallback, also, hash population feature is not reported to guests=
<br>
&gt; with vhost.<br>
&gt; * big-endian BPF support: for now, eBPF is disabled for big-endian sys=
tems.<br>
<br>
<br>
Are there any blocker for this?<br></blockquote><div><br></div><div>No, can=
 be added in v2</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
Just some quick questions after a glance of the codes. Will go through <br>
them tomorrow.<br>
<br>
Thanks<br>
<br>
<br>
&gt;<br>
&gt; Andrew (6):<br>
&gt;=C2=A0 =C2=A0 Added SetSteeringEBPF method for NetClientState.<br>
&gt;=C2=A0 =C2=A0 ebpf: Added basic eBPF API.<br>
&gt;=C2=A0 =C2=A0 ebpf: Added eBPF RSS program.<br>
&gt;=C2=A0 =C2=A0 ebpf: Added eBPF RSS loader.<br>
&gt;=C2=A0 =C2=A0 virtio-net: Added eBPF RSS to virtio-net.<br>
&gt;=C2=A0 =C2=A0 docs: Added eBPF documentation.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +<br>
&gt;=C2=A0 =C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 36 +++<br>
&gt;=C2=A0 =C2=A0docs/ebpf.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 29 ++<br>
&gt;=C2=A0 =C2=A0docs/ebpf_rss.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 129 ++++++++<br>
&gt;=C2=A0 =C2=A0ebpf/EbpfElf_to_C.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 67 ++++<br>
&gt;=C2=A0 =C2=A0ebpf/Makefile.ebpf=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 38 +++<br>
&gt;=C2=A0 =C2=A0ebpf/ebpf-stub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 28 ++<br>
&gt;=C2=A0 =C2=A0ebpf/ebpf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 107 +++++++<br>
&gt;=C2=A0 =C2=A0ebpf/ebpf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 35 +++<br>
&gt;=C2=A0 =C2=A0ebpf/ebpf_rss.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 178 +++++++++++<br>
&gt;=C2=A0 =C2=A0ebpf/ebpf_rss.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 30 ++<br>
&gt;=C2=A0 =C2=A0ebpf/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0ebpf/rss.bpf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 470 ++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0ebpf/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0ebpf/trace.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0ebpf/tun_rss_steering.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 556 +=
++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/net/vhost_net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 120 ++++++-<br>
&gt;=C2=A0 =C2=A0include/hw/virtio/virtio-net.h |=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0include/net/net.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0net/tap-bsd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0net/tap-linux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 19 ++<br>
&gt;=C2=A0 =C2=A0net/tap-solaris.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0net/tap-stub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0net/tap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +<br>
&gt;=C2=A0 =C2=A0net/tap_int.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0net/vhost-vdpa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A028 files changed, 1889 insertions(+), 4 deletions(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/ebpf.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/ebpf_rss.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 ebpf/EbpfElf_to_C.py<br>
&gt;=C2=A0 =C2=A0create mode 100755 ebpf/Makefile.ebpf<br>
&gt;=C2=A0 =C2=A0create mode 100644 ebpf/ebpf-stub.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 ebpf/ebpf.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 ebpf/ebpf.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 ebpf/ebpf_rss.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 ebpf/ebpf_rss.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 ebpf/meson.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 ebpf/rss.bpf.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 ebpf/trace-events<br>
&gt;=C2=A0 =C2=A0create mode 100644 ebpf/trace.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 ebpf/tun_rss_steering.h<br>
&gt;<br>
<br>
</blockquote></div></div>

--000000000000b25f6505b33162dd--

