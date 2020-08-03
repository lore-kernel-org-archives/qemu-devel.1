Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9C6C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0AA206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="pTr1zXyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0AA206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Vlx-0002wV-2d
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 04:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1k2VlI-0002UM-L2
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 04:24:00 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:39522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1k2VlF-0004Xc-C2
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 04:24:00 -0400
Received: by mail-pf1-x42b.google.com with SMTP id z188so9902291pfc.6
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 01:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EqaxmxBa1+wbc/oUnjvRQSyr6PgkiXP0hS23vAzFBMk=;
 b=pTr1zXyJDhazifdd8Q6MTLDd1B21xMny8vs/Era84DeM6pnRjO6vUo1fwXUicGJHpA
 9WvcFLlXXLYOwzWrowC24hD1EcqrRuJvomqMV/+XpEkPmemHviiC68AjsBly5A2aahPV
 dOT9jpxbGXLhT7dAPeZ7Iao26JYva+uh3qm3XCBRYebBTJSG3TeoN1iptMepzythNCt0
 qGd/3FJn+WMrJNF5m0cIndXwqQpQq6gUmo2699FK4xy+87zgrFa8eC+Lv++gSxzk7b2y
 84esqkwLP/CW6En2Y5vYQzUL2Z858jLB+jyrGsGzfbmWnRbVdpd0PclGuwyokEMiJLc6
 P3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EqaxmxBa1+wbc/oUnjvRQSyr6PgkiXP0hS23vAzFBMk=;
 b=mUuo6hw6SRdd/aazVDABDN0hLIbsZnLkMo2uoPwhxRKzllrRYGb2VRf0ScaA8jiKav
 86NJ8vOWYxOPIGEDUF8czheYvU35bFBly7Q6NWedwQerN1DOdyqf2qAM3LrxBAh0L4O5
 +ZNgn0alQ4xnfNZXgPbxBQTFx53k6crneyLoyT45BQThtoEOfZyDW9iymszlU29t+cem
 3wHjESk9qGc8rIwKp+7FgojKJjr14EYd0L2ODV8+7d1BFwHsW6sSzNlyoURY4hNR0dWu
 2NOnDgAnlk77hN9wBYp2riSrrt72F4ZLPJ3ag3xdEtQv0uy4iSB8KFkexleBj28BWVyw
 /Fig==
X-Gm-Message-State: AOAM531cDQdtPAt5RIosEjprr0fuockgde22gh8STWScIFMHryycZxV7
 zUxzDCxuB+djBRLQArngcjBqguX0KoKTn41+X5u9og==
X-Google-Smtp-Source: ABdhPJxYnHodf5h65Jr5oC/LuFAfv7tbXYBsR+Fj2oq9TBnD0iBCQNj1N0ONDvxAkZmoxQ7NoKNApzOJbj6c8dNRfoI=
X-Received: by 2002:a62:5297:: with SMTP id g145mr14807230pfb.28.1596443034767; 
 Mon, 03 Aug 2020 01:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <159622949743.5060.8912306868276612545.malonedeb@soybean.canonical.com>
 <159638395025.2765.10598480128444699560.malone@gac.canonical.com>
 <7C05EECD-F47B-4314-8FB0-D5C9C69A8BB9@redhat.com>
In-Reply-To: <7C05EECD-F47B-4314-8FB0-D5C9C69A8BB9@redhat.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Mon, 3 Aug 2020 11:53:24 +0300
Message-ID: <CABcq3pEzBOfhVzvZ52MBedT2eMmkDotgbxk+6zYduYDNMQLPUg@mail.gmail.com>
Subject: Re: [Bug 1889943] Improper TCP/IP packet splitting on e1000e/vmxnet3
To: Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fdebf005abf4db1a"
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=andrew@daynix.com; helo=mail-pf1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Bug 1889943 <1889943@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fdebf005abf4db1a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Also, as far as I can tell, qemu doesn't support segmentation(if there is
no vheader) - performs fragmentation.
And also check
https://www.mail-archive.com/qemu-devel@nongnu.org/msg717496.html - there
was an issue with IPv6 CSO.
Those patches provide basic IPv6 fragmentation, for now, qemu requires
proper work with IPv6 extensions.

On Mon, Aug 3, 2020 at 9:37 AM Yan Vugenfirer <yvugenfi@redhat.com> wrote:

> Hello Patrick,
>
> If you are using  QEMU version 4.2, then it is missing recent patches
> fixing IPv6 and TSO behaviour:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg723411.html
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg723412.html
>
> Can you check that the above patches solve your issues?
>
>
> Best regards,
> Yan.
>
> > On 2 Aug 2020, at 6:59 PM, Patrick Magauran <1889943@bugs.launchpad.net=
>
> wrote:
> >
> > Some more clarifications:
> > It appears the QEMU does turn on the vnet_hdr flag of the tap interface
> in most cases, not just host-only networks. My previous assumption was du=
e
> to the way the libvirt manages it, only setting it if the virtio interfac=
e
> is used.
> >
> > Still, for software fragmentation implementations, ip fragmentation
> > should be a last resort.
> >
> > I have also confirmed a suspicion that the current implementation of sw
> > fragmentation will not work with IPV6. It creates malformed packets as
> > ipv6 requires a different setup of headers to fragment. Thanks to the
> > many redundancies in the network stack, the packets eventually arrive a=
t
> > the host server correctly formed, but we should not rely on this fact.
> >
> > ** Description changed:
> >
> > + Update: The sw implementation of fragmentation also creates malformed
> > + IPv6 packets when their size is above the MTU. See comment #3
> > +
> >  Problem Description:
> > - When using a tap interface and the guest sends a TCP packet that woul=
d
> need to be segmented, it is fragmented using IP fragmentation. The host
> does not reassemble the IP fragments and forwards them to the next hop.
> This causes issues on certain ISPs, which seemingly reject IP
> fragments(Verizon Fios).
> > - This issue occurs on the e1000e and vmxnet3 NIC models, and possibly
> others. It does not occur on the virtio(which passes the entire packet
> through to the host w/o fragmentation or segmentation) or the e1000
> model().
> > + When using a tap interface and the guest sends a TCP packet that woul=
d
> need to be segmented, it is fragmented using IP fragmentation. The host
> does not reassemble the IP fragments and forwards them to the next hop.
> This causes issues on certain ISPs, which seemingly reject IP
> fragments(Verizon Fios).
> > + This issue occurs on the e1000e and vmxnet3 NIC models, and possibly
> others. It does not occur on the virtio(which passes the entire packet
> through to the host w/o fragmentation or segmentation) or the e1000 model=
().
> >
> >  Test scenario:
> >  Setup a tap and network bridge using the directions here:
> https://gist.github.com/extremecoders-re/e8fd8a67a515fee0c873dcafc81d811c
> >  Boot the machine into any modern guest(a Fedora 31 live iso was used
> for testing)
> >  Begin a wireshark capture on the host machine
> >  On the host(or another machine on the network) run: npx
> http-echo-server(See https://github.com/watson/http-echo-server)
> >  On the guest run
> >  Curl -d =E2=80=9CLorem ipsum dolor sit amet, consectetur adipiscing el=
it.
> Maecenas venenatis viverra ipsum, ac tincidunt est rhoncus eu. Suspendiss=
e
> vehicula congue ante, non rhoncus elit tempus vitae. Duis ac leo massa.
> Donec rutrum condimentum turpis nec ultricies. Duis laoreet elit eu arcu
> pulvinar, vitae congue neque mattis. Mauris sed ante nunc. Vestibulum vit=
ae
> urna a tellus maximus sagittis. Vivamus luctus pellentesque neque, vel
> tempor purus porta ut. Phasellus at quam bibendum, fermentum libero sit
> amet, ullamcorper mauris. In rutrum sit amet dui id maximus. Ut lectus
> ligula, hendrerit nec aliquam non, finibus a turpis. Proin scelerisque
> convallis ante, et pharetra elit. Donec nunc nisl, viverra vitae dui at,
> posuere rhoncus nibh. Mauris in massa quis neque posuere placerat quis qu=
is
> massa. Donec quis lacus ligula. Donec mollis vel nisi eget elementum. Nam
> id magna porta nunc consectetur efficitur ac quis lorem. Cras faucibus ve=
l
> ex porttitor mattis. Praesent in mattis tortor. In venenatis convallis
> quam, in posuere nibh. Proin non dignissim massa. Cras at mi ut lorem
> tristique fringilla. Nulla ac quam condimentum metus tincidunt vulputate =
ut
> at leo. Nunc pellentesque, nunc vel rhoncus condimentum, arcu sem molesti=
e
> augue, in suscipit mauris odio mollis odio. Integer hendrerit lectus a le=
o
> facilisis, in accumsan urna maximus. Nam nec odio volutpat, varius est id=
,
> tempus libero. Vestibulum lobortis tortor quam, ac scelerisque urna rhonc=
us
> in. Etiam tempor, est sit amet vulputate molestie, urna neque sodales leo=
,
> sit amet blandit risus felis sed est. Nulla eu eros nec tortor dapibus
> maximus faucibus ut erat. Ut pharetra tempor massa in bibendum. Interdum =
et
> malesuada fames ac ante ipsum primis in faucibus. Etiam mattis molestie
> felis eu efficitur. Morbi tincidunt consectetur diam tincidunt feugiat.
> Morbi euismod ut lorem finibus pellentesque. Aliquam eu porta ex. Aliquam
> cursus, orci sit amet volutpat egestas, est est pulvinar erat, sed luctus
> nisl ligula eget justo vestibulum.=E2=80=9D <ECHOSERVERIP:PORT>
> >
> >  2000 bytes of Lorem Ipsum taken from https://www.lipsum.com/
> >
> >  Compare results from an e1000, a virtio, and a e1000e card:
> >  +--------+-----------+---------+------------+
> >  | Model  | Fragment  | Segment | Wire Size  |
> >  +--------+-----------+---------+------------+
> >  | e1000e | Yes       | NO      | 1484 + 621 |
> >  +--------+-----------+---------+------------+
> >  | e1000  | No        | Yes     | 1516 + 620 |
> >  +--------+-----------+---------+------------+
> >  | Virtio | NO        | NO      | 2068       |
> >  +--------+-----------+---------+------------+
> >
> >  Expected Results:
> >  TCP Segment to proper size OR pass full size to host and let the host
> split if necessary.
> >
> >  Configuration changes that did not work:
> >  Disable host, guest, router firewalls
> >  Different Hosts
> >  Different Physical NICs
> >  Libvirt based NAT/Routed modes
> >  Fedora 32 vs 31
> >  Qemu 4.2.0 vs github commit d74824cf7c8b352f9045e949dc636c7207a41eee
> >
> >  System Information:
> >  lsb_release -rd
> >  Description: Fedora release 32 (Thirty Two)
> >  Release:     32
> >
> >  uname -a
> >  Linux pats-laptop-linux 5.7.10-201.fc32.x86_64 #1 SMP Thu Jul 23
> 00:58:39 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> >
> >  I can provide additional logs, debug info, etc. if needed.
> >
> > --
> > You received this bug notification because you are a member of qemu-
> > devel-ml, which is subscribed to QEMU.
> > https://bugs.launchpad.net/bugs/1889943
> >
> > Title:
> >  Improper TCP/IP packet splitting on e1000e/vmxnet3
> >
> > Status in QEMU:
> >  New
> >
> > Bug description:
> >  Update: The sw implementation of fragmentation also creates malformed
> >  IPv6 packets when their size is above the MTU. See comment #3
> >
> >  Problem Description:
> >  When using a tap interface and the guest sends a TCP packet that would
> need to be segmented, it is fragmented using IP fragmentation. The host
> does not reassemble the IP fragments and forwards them to the next hop.
> This causes issues on certain ISPs, which seemingly reject IP
> fragments(Verizon Fios).
> >  This issue occurs on the e1000e and vmxnet3 NIC models, and possibly
> others. It does not occur on the virtio(which passes the entire packet
> through to the host w/o fragmentation or segmentation) or the e1000 model=
().
> >
> >  Test scenario:
> >  Setup a tap and network bridge using the directions here:
> https://gist.github.com/extremecoders-re/e8fd8a67a515fee0c873dcafc81d811c
> >  Boot the machine into any modern guest(a Fedora 31 live iso was used
> for testing)
> >  Begin a wireshark capture on the host machine
> >  On the host(or another machine on the network) run: npx
> http-echo-server(See https://github.com/watson/http-echo-server)
> >  On the guest run
> >  Curl -d =E2=80=9CLorem ipsum dolor sit amet, consectetur adipiscing el=
it.
> Maecenas venenatis viverra ipsum, ac tincidunt est rhoncus eu. Suspendiss=
e
> vehicula congue ante, non rhoncus elit tempus vitae. Duis ac leo massa.
> Donec rutrum condimentum turpis nec ultricies. Duis laoreet elit eu arcu
> pulvinar, vitae congue neque mattis. Mauris sed ante nunc. Vestibulum vit=
ae
> urna a tellus maximus sagittis. Vivamus luctus pellentesque neque, vel
> tempor purus porta ut. Phasellus at quam bibendum, fermentum libero sit
> amet, ullamcorper mauris. In rutrum sit amet dui id maximus. Ut lectus
> ligula, hendrerit nec aliquam non, finibus a turpis. Proin scelerisque
> convallis ante, et pharetra elit. Donec nunc nisl, viverra vitae dui at,
> posuere rhoncus nibh. Mauris in massa quis neque posuere placerat quis qu=
is
> massa. Donec quis lacus ligula. Donec mollis vel nisi eget elementum. Nam
> id magna porta nunc consectetur efficitur ac quis lorem. Cras faucibus ve=
l
> ex porttitor mattis. Praesent in mattis tortor. In venenatis convallis
> quam, in posuere nibh. Proin non dignissim massa. Cras at mi ut lorem
> tristique fringilla. Nulla ac quam condimentum metus tincidunt vulputate =
ut
> at leo. Nunc pellentesque, nunc vel rhoncus condimentum, arcu sem molesti=
e
> augue, in suscipit mauris odio mollis odio. Integer hendrerit lectus a le=
o
> facilisis, in accumsan urna maximus. Nam nec odio volutpat, varius est id=
,
> tempus libero. Vestibulum lobortis tortor quam, ac scelerisque urna rhonc=
us
> in. Etiam tempor, est sit amet vulputate molestie, urna neque sodales leo=
,
> sit amet blandit risus felis sed est. Nulla eu eros nec tortor dapibus
> maximus faucibus ut erat. Ut pharetra tempor massa in bibendum. Interdum =
et
> malesuada fames ac ante ipsum primis in faucibus. Etiam mattis molestie
> felis eu efficitur. Morbi tincidunt consectetur diam tincidunt feugiat.
> Morbi euismod ut lorem finibus pellentesque. Aliquam eu porta ex. Aliquam
> cursus, orci sit amet volutpat egestas, est est pulvinar erat, sed luctus
> nisl ligula eget justo vestibulum.=E2=80=9D <ECHOSERVERIP:PORT>
> >
> >  2000 bytes of Lorem Ipsum taken from https://www.lipsum.com/
> >
> >  Compare results from an e1000, a virtio, and a e1000e card:
> >  +--------+-----------+---------+------------+
> >  | Model  | Fragment  | Segment | Wire Size  |
> >  +--------+-----------+---------+------------+
> >  | e1000e | Yes       | NO      | 1484 + 621 |
> >  +--------+-----------+---------+------------+
> >  | e1000  | No        | Yes     | 1516 + 620 |
> >  +--------+-----------+---------+------------+
> >  | Virtio | NO        | NO      | 2068       |
> >  +--------+-----------+---------+------------+
> >
> >  Expected Results:
> >  TCP Segment to proper size OR pass full size to host and let the host
> split if necessary.
> >
> >  Configuration changes that did not work:
> >  Disable host, guest, router firewalls
> >  Different Hosts
> >  Different Physical NICs
> >  Libvirt based NAT/Routed modes
> >  Fedora 32 vs 31
> >  Qemu 4.2.0 vs github commit d74824cf7c8b352f9045e949dc636c7207a41eee
> >
> >  System Information:
> >  lsb_release -rd
> >  Description: Fedora release 32 (Thirty Two)
> >  Release:     32
> >
> >  uname -a
> >  Linux pats-laptop-linux 5.7.10-201.fc32.x86_64 #1 SMP Thu Jul 23
> 00:58:39 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> >
> >  I can provide additional logs, debug info, etc. if needed.
> >
> > To manage notifications about this bug go to:
> > https://bugs.launchpad.net/qemu/+bug/1889943/+subscriptions
> >
>
>

--000000000000fdebf005abf4db1a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br></div><div>Also, as far as I can tell, qemu do=
esn&#39;t support segmentation(if there is no vheader) - performs fragmenta=
tion.</div><div>And also check <a href=3D"https://www.mail-archive.com/qemu=
-devel@nongnu.org/msg717496.html">https://www.mail-archive.com/qemu-devel@n=
ongnu.org/msg717496.html</a> - there was an issue with IPv6 CSO.</div><div>=
Those patches provide basic IPv6 fragmentation, for now, qemu requires prop=
er work with IPv6 extensions.<br></div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 3, 2020 at 9:37 AM Yan V=
ugenfirer &lt;<a href=3D"mailto:yvugenfi@redhat.com">yvugenfi@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hel=
lo Patrick,<br>
<br>
If you are using=C2=A0 QEMU version 4.2, then it is missing recent patches =
fixing IPv6 and TSO behaviour:<br>
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg723411.htm=
l" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qemu-d=
evel@nongnu.org/msg723411.html</a><br>
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg723412.htm=
l" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qemu-d=
evel@nongnu.org/msg723412.html</a><br>
<br>
Can you check that the above patches solve your issues?<br>
<br>
<br>
Best regards,<br>
Yan.<br>
<br>
&gt; On 2 Aug 2020, at 6:59 PM, Patrick Magauran &lt;<a href=3D"mailto:1889=
943@bugs.launchpad.net" target=3D"_blank">1889943@bugs.launchpad.net</a>&gt=
; wrote:<br>
&gt; <br>
&gt; Some more clarifications:<br>
&gt; It appears the QEMU does turn on the vnet_hdr flag of the tap interfac=
e in most cases, not just host-only networks. My previous assumption was du=
e to the way the libvirt manages it, only setting it if the virtio interfac=
e is used.<br>
&gt; <br>
&gt; Still, for software fragmentation implementations, ip fragmentation<br=
>
&gt; should be a last resort.<br>
&gt; <br>
&gt; I have also confirmed a suspicion that the current implementation of s=
w<br>
&gt; fragmentation will not work with IPV6. It creates malformed packets as=
<br>
&gt; ipv6 requires a different setup of headers to fragment. Thanks to the<=
br>
&gt; many redundancies in the network stack, the packets eventually arrive =
at<br>
&gt; the host server correctly formed, but we should not rely on this fact.=
<br>
&gt; <br>
&gt; ** Description changed:<br>
&gt; <br>
&gt; + Update: The sw implementation of fragmentation also creates malforme=
d<br>
&gt; + IPv6 packets when their size is above the MTU. See comment #3<br>
&gt; + <br>
&gt;=C2=A0 Problem Description:<br>
&gt; - When using a tap interface and the guest sends a TCP packet that wou=
ld need to be segmented, it is fragmented using IP fragmentation. The host =
does not reassemble the IP fragments and forwards them to the next hop. Thi=
s causes issues on certain ISPs, which seemingly reject IP fragments(Verizo=
n Fios). <br>
&gt; - This issue occurs on the e1000e and vmxnet3 NIC models, and possibly=
 others. It does not occur on the virtio(which passes the entire packet thr=
ough to the host w/o fragmentation or segmentation) or the e1000 model(). <=
br>
&gt; + When using a tap interface and the guest sends a TCP packet that wou=
ld need to be segmented, it is fragmented using IP fragmentation. The host =
does not reassemble the IP fragments and forwards them to the next hop. Thi=
s causes issues on certain ISPs, which seemingly reject IP fragments(Verizo=
n Fios).<br>
&gt; + This issue occurs on the e1000e and vmxnet3 NIC models, and possibly=
 others. It does not occur on the virtio(which passes the entire packet thr=
ough to the host w/o fragmentation or segmentation) or the e1000 model().<b=
r>
&gt; <br>
&gt;=C2=A0 Test scenario:<br>
&gt;=C2=A0 Setup a tap and network bridge using the directions here: <a hre=
f=3D"https://gist.github.com/extremecoders-re/e8fd8a67a515fee0c873dcafc81d8=
11c" rel=3D"noreferrer" target=3D"_blank">https://gist.github.com/extremeco=
ders-re/e8fd8a67a515fee0c873dcafc81d811c</a><br>
&gt;=C2=A0 Boot the machine into any modern guest(a Fedora 31 live iso was =
used for testing)<br>
&gt;=C2=A0 Begin a wireshark capture on the host machine<br>
&gt;=C2=A0 On the host(or another machine on the network) run: npx http-ech=
o-server(See <a href=3D"https://github.com/watson/http-echo-server" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/watson/http-echo-server</a=
>)<br>
&gt;=C2=A0 On the guest run<br>
&gt;=C2=A0 Curl -d =E2=80=9CLorem ipsum dolor sit amet, consectetur adipisc=
ing elit. Maecenas venenatis viverra ipsum, ac tincidunt est rhoncus eu. Su=
spendisse vehicula congue ante, non rhoncus elit tempus vitae. Duis ac leo =
massa. Donec rutrum condimentum turpis nec ultricies. Duis laoreet elit eu =
arcu pulvinar, vitae congue neque mattis. Mauris sed ante nunc. Vestibulum =
vitae urna a tellus maximus sagittis. Vivamus luctus pellentesque neque, ve=
l tempor purus porta ut. Phasellus at quam bibendum, fermentum libero sit a=
met, ullamcorper mauris. In rutrum sit amet dui id maximus. Ut lectus ligul=
a, hendrerit nec aliquam non, finibus a turpis. Proin scelerisque convallis=
 ante, et pharetra elit. Donec nunc nisl, viverra vitae dui at, posuere rho=
ncus nibh. Mauris in massa quis neque posuere placerat quis quis massa. Don=
ec quis lacus ligula. Donec mollis vel nisi eget elementum. Nam id magna po=
rta nunc consectetur efficitur ac quis lorem. Cras faucibus vel ex porttito=
r mattis. Praesent in mattis tortor. In venenatis convallis quam, in posuer=
e nibh. Proin non dignissim massa. Cras at mi ut lorem tristique fringilla.=
 Nulla ac quam condimentum metus tincidunt vulputate ut at leo. Nunc pellen=
tesque, nunc vel rhoncus condimentum, arcu sem molestie augue, in suscipit =
mauris odio mollis odio. Integer hendrerit lectus a leo facilisis, in accum=
san urna maximus. Nam nec odio volutpat, varius est id, tempus libero. Vest=
ibulum lobortis tortor quam, ac scelerisque urna rhoncus in. Etiam tempor, =
est sit amet vulputate molestie, urna neque sodales leo, sit amet blandit r=
isus felis sed est. Nulla eu eros nec tortor dapibus maximus faucibus ut er=
at. Ut pharetra tempor massa in bibendum. Interdum et malesuada fames ac an=
te ipsum primis in faucibus. Etiam mattis molestie felis eu efficitur. Morb=
i tincidunt consectetur diam tincidunt feugiat. Morbi euismod ut lorem fini=
bus pellentesque. Aliquam eu porta ex. Aliquam cursus, orci sit amet volutp=
at egestas, est est pulvinar erat, sed luctus nisl ligula eget justo vestib=
ulum.=E2=80=9D &lt;ECHOSERVERIP:PORT&gt;<br>
&gt; <br>
&gt;=C2=A0 2000 bytes of Lorem Ipsum taken from <a href=3D"https://www.lips=
um.com/" rel=3D"noreferrer" target=3D"_blank">https://www.lipsum.com/</a><b=
r>
&gt; <br>
&gt;=C2=A0 Compare results from an e1000, a virtio, and a e1000e card:<br>
&gt;=C2=A0 +--------+-----------+---------+------------+<br>
&gt;=C2=A0 | Model=C2=A0 | Fragment=C2=A0 | Segment | Wire Size=C2=A0 |<br>
&gt;=C2=A0 +--------+-----------+---------+------------+<br>
&gt;=C2=A0 | e1000e | Yes=C2=A0 =C2=A0 =C2=A0 =C2=A0| NO=C2=A0 =C2=A0 =C2=
=A0 | 1484 + 621 |<br>
&gt;=C2=A0 +--------+-----------+---------+------------+<br>
&gt;=C2=A0 | e1000=C2=A0 | No=C2=A0 =C2=A0 =C2=A0 =C2=A0 | Yes=C2=A0 =C2=A0=
 =C2=A0| 1516 + 620 |<br>
&gt;=C2=A0 +--------+-----------+---------+------------+<br>
&gt;=C2=A0 | Virtio | NO=C2=A0 =C2=A0 =C2=A0 =C2=A0 | NO=C2=A0 =C2=A0 =C2=
=A0 | 2068=C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 +--------+-----------+---------+------------+<br>
&gt; <br>
&gt;=C2=A0 Expected Results:<br>
&gt;=C2=A0 TCP Segment to proper size OR pass full size to host and let the=
 host split if necessary.<br>
&gt; <br>
&gt;=C2=A0 Configuration changes that did not work:<br>
&gt;=C2=A0 Disable host, guest, router firewalls<br>
&gt;=C2=A0 Different Hosts<br>
&gt;=C2=A0 Different Physical NICs<br>
&gt;=C2=A0 Libvirt based NAT/Routed modes<br>
&gt;=C2=A0 Fedora 32 vs 31<br>
&gt;=C2=A0 Qemu 4.2.0 vs github commit d74824cf7c8b352f9045e949dc636c7207a4=
1eee<br>
&gt; <br>
&gt;=C2=A0 System Information:<br>
&gt;=C2=A0 lsb_release -rd<br>
&gt;=C2=A0 Description: Fedora release 32 (Thirty Two)<br>
&gt;=C2=A0 Release:=C2=A0 =C2=A0 =C2=A032<br>
&gt; <br>
&gt;=C2=A0 uname -a<br>
&gt;=C2=A0 Linux pats-laptop-linux 5.7.10-201.fc32.x86_64 #1 SMP Thu Jul 23=
 00:58:39 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux<br>
&gt; <br>
&gt;=C2=A0 I can provide additional logs, debug info, etc. if needed.<br>
&gt; <br>
&gt; -- <br>
&gt; You received this bug notification because you are a member of qemu-<b=
r>
&gt; devel-ml, which is subscribed to QEMU.<br>
&gt; <a href=3D"https://bugs.launchpad.net/bugs/1889943" rel=3D"noreferrer"=
 target=3D"_blank">https://bugs.launchpad.net/bugs/1889943</a><br>
&gt; <br>
&gt; Title:<br>
&gt;=C2=A0 Improper TCP/IP packet splitting on e1000e/vmxnet3<br>
&gt; <br>
&gt; Status in QEMU:<br>
&gt;=C2=A0 New<br>
&gt; <br>
&gt; Bug description:<br>
&gt;=C2=A0 Update: The sw implementation of fragmentation also creates malf=
ormed<br>
&gt;=C2=A0 IPv6 packets when their size is above the MTU. See comment #3<br=
>
&gt; <br>
&gt;=C2=A0 Problem Description:<br>
&gt;=C2=A0 When using a tap interface and the guest sends a TCP packet that=
 would need to be segmented, it is fragmented using IP fragmentation. The h=
ost does not reassemble the IP fragments and forwards them to the next hop.=
 This causes issues on certain ISPs, which seemingly reject IP fragments(Ve=
rizon Fios).<br>
&gt;=C2=A0 This issue occurs on the e1000e and vmxnet3 NIC models, and poss=
ibly others. It does not occur on the virtio(which passes the entire packet=
 through to the host w/o fragmentation or segmentation) or the e1000 model(=
).<br>
&gt; <br>
&gt;=C2=A0 Test scenario:<br>
&gt;=C2=A0 Setup a tap and network bridge using the directions here: <a hre=
f=3D"https://gist.github.com/extremecoders-re/e8fd8a67a515fee0c873dcafc81d8=
11c" rel=3D"noreferrer" target=3D"_blank">https://gist.github.com/extremeco=
ders-re/e8fd8a67a515fee0c873dcafc81d811c</a><br>
&gt;=C2=A0 Boot the machine into any modern guest(a Fedora 31 live iso was =
used for testing)<br>
&gt;=C2=A0 Begin a wireshark capture on the host machine<br>
&gt;=C2=A0 On the host(or another machine on the network) run: npx http-ech=
o-server(See <a href=3D"https://github.com/watson/http-echo-server" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/watson/http-echo-server</a=
>)<br>
&gt;=C2=A0 On the guest run<br>
&gt;=C2=A0 Curl -d =E2=80=9CLorem ipsum dolor sit amet, consectetur adipisc=
ing elit. Maecenas venenatis viverra ipsum, ac tincidunt est rhoncus eu. Su=
spendisse vehicula congue ante, non rhoncus elit tempus vitae. Duis ac leo =
massa. Donec rutrum condimentum turpis nec ultricies. Duis laoreet elit eu =
arcu pulvinar, vitae congue neque mattis. Mauris sed ante nunc. Vestibulum =
vitae urna a tellus maximus sagittis. Vivamus luctus pellentesque neque, ve=
l tempor purus porta ut. Phasellus at quam bibendum, fermentum libero sit a=
met, ullamcorper mauris. In rutrum sit amet dui id maximus. Ut lectus ligul=
a, hendrerit nec aliquam non, finibus a turpis. Proin scelerisque convallis=
 ante, et pharetra elit. Donec nunc nisl, viverra vitae dui at, posuere rho=
ncus nibh. Mauris in massa quis neque posuere placerat quis quis massa. Don=
ec quis lacus ligula. Donec mollis vel nisi eget elementum. Nam id magna po=
rta nunc consectetur efficitur ac quis lorem. Cras faucibus vel ex porttito=
r mattis. Praesent in mattis tortor. In venenatis convallis quam, in posuer=
e nibh. Proin non dignissim massa. Cras at mi ut lorem tristique fringilla.=
 Nulla ac quam condimentum metus tincidunt vulputate ut at leo. Nunc pellen=
tesque, nunc vel rhoncus condimentum, arcu sem molestie augue, in suscipit =
mauris odio mollis odio. Integer hendrerit lectus a leo facilisis, in accum=
san urna maximus. Nam nec odio volutpat, varius est id, tempus libero. Vest=
ibulum lobortis tortor quam, ac scelerisque urna rhoncus in. Etiam tempor, =
est sit amet vulputate molestie, urna neque sodales leo, sit amet blandit r=
isus felis sed est. Nulla eu eros nec tortor dapibus maximus faucibus ut er=
at. Ut pharetra tempor massa in bibendum. Interdum et malesuada fames ac an=
te ipsum primis in faucibus. Etiam mattis molestie felis eu efficitur. Morb=
i tincidunt consectetur diam tincidunt feugiat. Morbi euismod ut lorem fini=
bus pellentesque. Aliquam eu porta ex. Aliquam cursus, orci sit amet volutp=
at egestas, est est pulvinar erat, sed luctus nisl ligula eget justo vestib=
ulum.=E2=80=9D &lt;ECHOSERVERIP:PORT&gt;<br>
&gt; <br>
&gt;=C2=A0 2000 bytes of Lorem Ipsum taken from <a href=3D"https://www.lips=
um.com/" rel=3D"noreferrer" target=3D"_blank">https://www.lipsum.com/</a><b=
r>
&gt; <br>
&gt;=C2=A0 Compare results from an e1000, a virtio, and a e1000e card:<br>
&gt;=C2=A0 +--------+-----------+---------+------------+<br>
&gt;=C2=A0 | Model=C2=A0 | Fragment=C2=A0 | Segment | Wire Size=C2=A0 |<br>
&gt;=C2=A0 +--------+-----------+---------+------------+<br>
&gt;=C2=A0 | e1000e | Yes=C2=A0 =C2=A0 =C2=A0 =C2=A0| NO=C2=A0 =C2=A0 =C2=
=A0 | 1484 + 621 |<br>
&gt;=C2=A0 +--------+-----------+---------+------------+<br>
&gt;=C2=A0 | e1000=C2=A0 | No=C2=A0 =C2=A0 =C2=A0 =C2=A0 | Yes=C2=A0 =C2=A0=
 =C2=A0| 1516 + 620 |<br>
&gt;=C2=A0 +--------+-----------+---------+------------+<br>
&gt;=C2=A0 | Virtio | NO=C2=A0 =C2=A0 =C2=A0 =C2=A0 | NO=C2=A0 =C2=A0 =C2=
=A0 | 2068=C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 +--------+-----------+---------+------------+<br>
&gt; <br>
&gt;=C2=A0 Expected Results:<br>
&gt;=C2=A0 TCP Segment to proper size OR pass full size to host and let the=
 host split if necessary.<br>
&gt; <br>
&gt;=C2=A0 Configuration changes that did not work:<br>
&gt;=C2=A0 Disable host, guest, router firewalls<br>
&gt;=C2=A0 Different Hosts<br>
&gt;=C2=A0 Different Physical NICs<br>
&gt;=C2=A0 Libvirt based NAT/Routed modes<br>
&gt;=C2=A0 Fedora 32 vs 31<br>
&gt;=C2=A0 Qemu 4.2.0 vs github commit d74824cf7c8b352f9045e949dc636c7207a4=
1eee<br>
&gt; <br>
&gt;=C2=A0 System Information:<br>
&gt;=C2=A0 lsb_release -rd<br>
&gt;=C2=A0 Description: Fedora release 32 (Thirty Two)<br>
&gt;=C2=A0 Release:=C2=A0 =C2=A0 =C2=A032<br>
&gt; <br>
&gt;=C2=A0 uname -a<br>
&gt;=C2=A0 Linux pats-laptop-linux 5.7.10-201.fc32.x86_64 #1 SMP Thu Jul 23=
 00:58:39 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux<br>
&gt; <br>
&gt;=C2=A0 I can provide additional logs, debug info, etc. if needed.<br>
&gt; <br>
&gt; To manage notifications about this bug go to:<br>
&gt; <a href=3D"https://bugs.launchpad.net/qemu/+bug/1889943/+subscriptions=
" rel=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.net/qemu/+bug=
/1889943/+subscriptions</a><br>
&gt; <br>
<br>
</blockquote></div>

--000000000000fdebf005abf4db1a--

