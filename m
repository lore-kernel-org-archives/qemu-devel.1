Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64597C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E6F22B45
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9g5/u3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E6F22B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2g93-0000Lj-VI
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 15:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patmagauran.j@gmail.com>)
 id 1k2g8R-0008Nf-Sh
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:28:35 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d]:41370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <patmagauran.j@gmail.com>)
 id 1k2g8P-0002vh-Fc
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:28:35 -0400
Received: by mail-qt1-x82d.google.com with SMTP id v22so23203476qtq.8
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 12:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=c6KONIAQWcGJfzRM5rejWz/91HgedpDAiy0hwpiVE/k=;
 b=O9g5/u3XU/+/7LMmLvVRbqwZOjGw0dqmx6I+8z9IWFh5ZGwBlNbZGY/00t+n+HRad1
 qKpeUhk+OgpEovLR2ZMecR1s9Y4k+kQRRr63DSxxWhU2dVdvqd01ODXHiDsZ2Jv+dBrN
 PP9gjYnTKV2EnU2QZXg/vAJ6tyT4YpX1icyDui0Zmw1HNkkEREmdmXISQ0ygDUOWq64R
 cPxbJCADKJJc4ovZhGlWjUEFGM0YA9vDARXpxtHJuGMFgOBf1dRteNtWaYmoso3nlqKH
 OPcPUWYeABzG6uqhihzT7atc1Umu9vPO0frHj8jhkEJmbMT9iJb7uNz16uEzdKRbVze6
 c+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=c6KONIAQWcGJfzRM5rejWz/91HgedpDAiy0hwpiVE/k=;
 b=D2GmIt+G3K3FAbZVI3LZxRzWJdaCalAI6ffqcCGOPDlOSZOCA2lAWKKdE8/sTHFk6B
 8G5AC/OxyRnybZmN2TOj6EJI7W+bPsRr29maVvmwdfjEi3TMbD3ppsi6VrjXU+8+3jLC
 d75ZmHSd9HiS9yi5/z8XMldPWdKMH0iGn61yiEOfQLokM1S4q+FhvAdPPNWZpjLaBEdb
 smMxb6dPJCqE4HJ42PoO+6WO9fsclygXMDAV0IC6M3N9MWkycBdTpXU81faIieM3EgUr
 X8NNRWqwgNZbe1HO00rrsk3hmVH3nCS13EiRmDLBHIo4ug34U1yrrZYxEWX2eSr6ctc4
 Pw7A==
X-Gm-Message-State: AOAM530po5ojm9HpbQ4ex1TP7ugHe3ML+p4xmAPOkqb4OrlNLaiqdkIC
 HgrWiwrS75/SlxQyzOrY8Gc=
X-Google-Smtp-Source: ABdhPJz3xB2IjMFbIkjwYRH4Vsi2nFXAMFtRUSMcYU9XkwPutF3gSMEG5TFaAjzNqDIFHH3LDHupGg==
X-Received: by 2002:ac8:454f:: with SMTP id z15mr17550166qtn.351.1596482910518; 
 Mon, 03 Aug 2020 12:28:30 -0700 (PDT)
Received: from pats-laptop-linux (pool-72-92-80-32.phlapa.fios.verizon.net.
 [72.92.80.32])
 by smtp.gmail.com with ESMTPSA id o2sm19454213qkh.102.2020.08.03.12.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 12:28:29 -0700 (PDT)
Message-ID: <07a76c44306d4bbc699019b2f3fea4ac67c8a1d9.camel@gmail.com>
Subject: Re: [Bug 1889943] Improper TCP/IP packet splitting on e1000e/vmxnet3
From: "Patrick J. Magauran" <patmagauran.j@gmail.com>
To: Yan Vugenfirer <yvugenfi@redhat.com>, Bug 1889943
 <1889943@bugs.launchpad.net>
Date: Mon, 03 Aug 2020 15:28:28 -0400
In-Reply-To: <7C05EECD-F47B-4314-8FB0-D5C9C69A8BB9@redhat.com>
References: <159622949743.5060.8912306868276612545.malonedeb@soybean.canonical.com>
 <159638395025.2765.10598480128444699560.malone@gac.canonical.com>
 <7C05EECD-F47B-4314-8FB0-D5C9C69A8BB9@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=patmagauran.j@gmail.com; helo=mail-qt1-x82d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Andrew Melnichenko <andrew@daynix.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Yan,

I tryed the patches mentioned(the first one was already implemented in
the git master, the second wasn't). It did fix the IPv6 fragmentation
issue. So therefore, the focus needs to be on implementing proper layer
4 segmentation. 

--Patrick
On Mon, 2020-08-03 at 09:37 +0300, Yan Vugenfirer wrote:
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
> > On 2 Aug 2020, at 6:59 PM, Patrick Magauran <
> > 1889943@bugs.launchpad.net> wrote:
> > 
> > Some more clarifications:
> > It appears the QEMU does turn on the vnet_hdr flag of the tap
> > interface in most cases, not just host-only networks. My previous
> > assumption was due to the way the libvirt manages it, only setting
> > it if the virtio interface is used.
> > 
> > Still, for software fragmentation implementations, ip fragmentation
> > should be a last resort.
> > 
> > I have also confirmed a suspicion that the current implementation
> > of sw
> > fragmentation will not work with IPV6. It creates malformed packets
> > as
> > ipv6 requires a different setup of headers to fragment. Thanks to
> > the
> > many redundancies in the network stack, the packets eventually
> > arrive at
> > the host server correctly formed, but we should not rely on this
> > fact.
> > 
> > ** Description changed:
> > 
> > + Update: The sw implementation of fragmentation also creates
> > malformed
> > + IPv6 packets when their size is above the MTU. See comment #3
> > + 
> >  Problem Description:
> > - When using a tap interface and the guest sends a TCP packet that
> > would need to be segmented, it is fragmented using IP
> > fragmentation. The host does not reassemble the IP fragments and
> > forwards them to the next hop. This causes issues on certain ISPs,
> > which seemingly reject IP fragments(Verizon Fios). 
> > - This issue occurs on the e1000e and vmxnet3 NIC models, and
> > possibly others. It does not occur on the virtio(which passes the
> > entire packet through to the host w/o fragmentation or
> > segmentation) or the e1000 model(). 
> > + When using a tap interface and the guest sends a TCP packet that
> > would need to be segmented, it is fragmented using IP
> > fragmentation. The host does not reassemble the IP fragments and
> > forwards them to the next hop. This causes issues on certain ISPs,
> > which seemingly reject IP fragments(Verizon Fios).
> > + This issue occurs on the e1000e and vmxnet3 NIC models, and
> > possibly others. It does not occur on the virtio(which passes the
> > entire packet through to the host w/o fragmentation or
> > segmentation) or the e1000 model().
> > 
> >  Test scenario:
> >  Setup a tap and network bridge using the directions here: 
> > https://gist.github.com/extremecoders-re/e8fd8a67a515fee0c873dcafc81d811c
> >  Boot the machine into any modern guest(a Fedora 31 live iso was
> > used for testing)
> >  Begin a wireshark capture on the host machine
> >  On the host(or another machine on the network) run: npx http-echo-
> > server(See https://github.com/watson/http-echo-server)
> >  On the guest run
> >  Curl -d “Lorem ipsum dolor sit amet, consectetur adipiscing elit.
> > Maecenas venenatis viverra ipsum, ac tincidunt est rhoncus eu.
> > Suspendisse vehicula congue ante, non rhoncus elit tempus vitae.
> > Duis ac leo massa. Donec rutrum condimentum turpis nec ultricies.
> > Duis laoreet elit eu arcu pulvinar, vitae congue neque mattis.
> > Mauris sed ante nunc. Vestibulum vitae urna a tellus maximus
> > sagittis. Vivamus luctus pellentesque neque, vel tempor purus porta
> > ut. Phasellus at quam bibendum, fermentum libero sit amet,
> > ullamcorper mauris. In rutrum sit amet dui id maximus. Ut lectus
> > ligula, hendrerit nec aliquam non, finibus a turpis. Proin
> > scelerisque convallis ante, et pharetra elit. Donec nunc nisl,
> > viverra vitae dui at, posuere rhoncus nibh. Mauris in massa quis
> > neque posuere placerat quis quis massa. Donec quis lacus ligula.
> > Donec mollis vel nisi eget elementum. Nam id magna porta nunc
> > consectetur efficitur ac quis lorem. Cras faucibus vel ex porttitor
> > mattis. Praesent in mattis tortor. In venenatis convallis quam, in
> > posuere nibh. Proin non dignissim massa. Cras at mi ut lorem
> > tristique fringilla. Nulla ac quam condimentum metus tincidunt
> > vulputate ut at leo. Nunc pellentesque, nunc vel rhoncus
> > condimentum, arcu sem molestie augue, in suscipit mauris odio
> > mollis odio. Integer hendrerit lectus a leo facilisis, in accumsan
> > urna maximus. Nam nec odio volutpat, varius est id, tempus libero.
> > Vestibulum lobortis tortor quam, ac scelerisque urna rhoncus in.
> > Etiam tempor, est sit amet vulputate molestie, urna neque sodales
> > leo, sit amet blandit risus felis sed est. Nulla eu eros nec tortor
> > dapibus maximus faucibus ut erat. Ut pharetra tempor massa in
> > bibendum. Interdum et malesuada fames ac ante ipsum primis in
> > faucibus. Etiam mattis molestie felis eu efficitur. Morbi tincidunt
> > consectetur diam tincidunt feugiat. Morbi euismod ut lorem finibus
> > pellentesque. Aliquam eu porta ex. Aliquam cursus, orci sit amet
> > volutpat egestas, est est pulvinar erat, sed luctus nisl ligula
> > eget justo vestibulum.” <ECHOSERVERIP:PORT>
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
> >  TCP Segment to proper size OR pass full size to host and let the
> > host split if necessary.
> > 
> >  Configuration changes that did not work:
> >  Disable host, guest, router firewalls
> >  Different Hosts
> >  Different Physical NICs
> >  Libvirt based NAT/Routed modes
> >  Fedora 32 vs 31
> >  Qemu 4.2.0 vs github commit
> > d74824cf7c8b352f9045e949dc636c7207a41eee
> > 
> >  System Information:
> >  lsb_release -rd
> >  Description:	Fedora release 32 (Thirty Two)
> >  Release:	32
> > 
> >  uname -a
> >  Linux pats-laptop-linux 5.7.10-201.fc32.x86_64 #1 SMP Thu Jul 23
> > 00:58:39 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> > 
> >  I can provide additional logs, debug info, etc. if needed.
> > 
> > -- 
> > You received this bug notification because you are a member of
> > qemu-
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
> >  Update: The sw implementation of fragmentation also creates
> > malformed
> >  IPv6 packets when their size is above the MTU. See comment #3
> > 
> >  Problem Description:
> >  When using a tap interface and the guest sends a TCP packet that
> > would need to be segmented, it is fragmented using IP
> > fragmentation. The host does not reassemble the IP fragments and
> > forwards them to the next hop. This causes issues on certain ISPs,
> > which seemingly reject IP fragments(Verizon Fios).
> >  This issue occurs on the e1000e and vmxnet3 NIC models, and
> > possibly others. It does not occur on the virtio(which passes the
> > entire packet through to the host w/o fragmentation or
> > segmentation) or the e1000 model().
> > 
> >  Test scenario:
> >  Setup a tap and network bridge using the directions here: 
> > https://gist.github.com/extremecoders-re/e8fd8a67a515fee0c873dcafc81d811c
> >  Boot the machine into any modern guest(a Fedora 31 live iso was
> > used for testing)
> >  Begin a wireshark capture on the host machine
> >  On the host(or another machine on the network) run: npx http-echo-
> > server(See https://github.com/watson/http-echo-server)
> >  On the guest run
> >  Curl -d “Lorem ipsum dolor sit amet, consectetur adipiscing elit.
> > Maecenas venenatis viverra ipsum, ac tincidunt est rhoncus eu.
> > Suspendisse vehicula congue ante, non rhoncus elit tempus vitae.
> > Duis ac leo massa. Donec rutrum condimentum turpis nec ultricies.
> > Duis laoreet elit eu arcu pulvinar, vitae congue neque mattis.
> > Mauris sed ante nunc. Vestibulum vitae urna a tellus maximus
> > sagittis. Vivamus luctus pellentesque neque, vel tempor purus porta
> > ut. Phasellus at quam bibendum, fermentum libero sit amet,
> > ullamcorper mauris. In rutrum sit amet dui id maximus. Ut lectus
> > ligula, hendrerit nec aliquam non, finibus a turpis. Proin
> > scelerisque convallis ante, et pharetra elit. Donec nunc nisl,
> > viverra vitae dui at, posuere rhoncus nibh. Mauris in massa quis
> > neque posuere placerat quis quis massa. Donec quis lacus ligula.
> > Donec mollis vel nisi eget elementum. Nam id magna porta nunc
> > consectetur efficitur ac quis lorem. Cras faucibus vel ex porttitor
> > mattis. Praesent in mattis tortor. In venenatis convallis quam, in
> > posuere nibh. Proin non dignissim massa. Cras at mi ut lorem
> > tristique fringilla. Nulla ac quam condimentum metus tincidunt
> > vulputate ut at leo. Nunc pellentesque, nunc vel rhoncus
> > condimentum, arcu sem molestie augue, in suscipit mauris odio
> > mollis odio. Integer hendrerit lectus a leo facilisis, in accumsan
> > urna maximus. Nam nec odio volutpat, varius est id, tempus libero.
> > Vestibulum lobortis tortor quam, ac scelerisque urna rhoncus in.
> > Etiam tempor, est sit amet vulputate molestie, urna neque sodales
> > leo, sit amet blandit risus felis sed est. Nulla eu eros nec tortor
> > dapibus maximus faucibus ut erat. Ut pharetra tempor massa in
> > bibendum. Interdum et malesuada fames ac ante ipsum primis in
> > faucibus. Etiam mattis molestie felis eu efficitur. Morbi tincidunt
> > consectetur diam tincidunt feugiat. Morbi euismod ut lorem finibus
> > pellentesque. Aliquam eu porta ex. Aliquam cursus, orci sit amet
> > volutpat egestas, est est pulvinar erat, sed luctus nisl ligula
> > eget justo vestibulum.” <ECHOSERVERIP:PORT>
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
> >  TCP Segment to proper size OR pass full size to host and let the
> > host split if necessary.
> > 
> >  Configuration changes that did not work:
> >  Disable host, guest, router firewalls
> >  Different Hosts
> >  Different Physical NICs
> >  Libvirt based NAT/Routed modes
> >  Fedora 32 vs 31
> >  Qemu 4.2.0 vs github commit
> > d74824cf7c8b352f9045e949dc636c7207a41eee
> > 
> >  System Information:
> >  lsb_release -rd
> >  Description:	Fedora release 32 (Thirty Two)
> >  Release:	32
> > 
> >  uname -a
> >  Linux pats-laptop-linux 5.7.10-201.fc32.x86_64 #1 SMP Thu Jul 23
> > 00:58:39 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> > 
> >  I can provide additional logs, debug info, etc. if needed.
> > 
> > To manage notifications about this bug go to:
> > https://bugs.launchpad.net/qemu/+bug/1889943/+subscriptions
> > 
> 
> 


