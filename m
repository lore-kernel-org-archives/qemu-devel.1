Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6556BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 23:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761092087D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 23:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arrikto-com.20150623.gappssmtp.com header.i=@arrikto-com.20150623.gappssmtp.com header.b="w3nkbets"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761092087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arrikto.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS73F-000815-BW
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 19:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ndragazis@arrikto.com>)
 id 1kS722-0007PX-SZ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 19:15:06 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ndragazis@arrikto.com>)
 id 1kS720-0004Ul-0U
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 19:15:06 -0400
Received: by mail-wm1-x343.google.com with SMTP id p15so18903912wmi.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 16:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrikto-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=vMyn8d6s7xE0WQaXGH16P6bLeJgzPYtpK8gxdV/GiII=;
 b=w3nkbetsfmRs/XoJ46zqOZ/ijesJsmzwgUstamDTtEFbAMP8wmYwXDx6nvjVfd3i1G
 MSDAMvScF+aUEVQhagmBmIFWA3h818oPlT17g/t3Kx8A6TarENPBJU5o/Qd8MdR+ZbHX
 bpcYyfRNfVR4UqPmnLlKZLgJfe0iSmxd8VI+fcFlFm/UO2OGDtXIPPG5maNICoXGNHaS
 eLBwJHCfBS74AqOfKqYU792J8q9Y21aoJ27jfWesQbWhcnlwsEWIL+ji5EVAjmHY1nZ9
 987HksjccqaQ5+7E+NDiS27j2c+BkEhmSWkHFgw9duSGTmFoCsr9vaMICcKzW59/cX5h
 btKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=vMyn8d6s7xE0WQaXGH16P6bLeJgzPYtpK8gxdV/GiII=;
 b=pffHP0lbMTqA0QA5Zp4kZbxpz4f17EUhA3lAw6aQecDtzg/Sr6qvC5+yH/OUc/9xa3
 nUrzaSc35H2u8xsE7IG0Q1d4B53MUNcbluqj8A24C2usG9p1lKgp52h3DiNyUn/vCqji
 zDL59EaeOjgfH1i/Q6SI2soCseG5Z/XLmbCIvG288/mPdDV62ikB+A2WDFO8fFv3NyPj
 KX/gy8JCpVsvecEWAMFeAJ42FASYA5WIogREqdJjRCRuMrD0IwXqX4b5WVBRYY1FcIwz
 u1CwjZhP7qBCXaTEHD7UoNf/F+/nzs3uaIonYnCGRwWM896ueNCE0NVZk9ppg7L1jzvK
 QVOA==
X-Gm-Message-State: AOAM5332oJyRn6VqYgxxuFAKk4pdoA9+eyYmmSePleT+MngmCWi176Wh
 vULPXGpvP1ZNNX/2SlZdO8PE1Q==
X-Google-Smtp-Source: ABdhPJxNH9bPaFV/Re5EmkRebZLG+Q1xAF0lIJdJdS66ZgQ8Lng/xfMrFy/qRayQf1I9VqJ1USVrxA==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr4856503wmh.26.1602544500464; 
 Mon, 12 Oct 2020 16:15:00 -0700 (PDT)
Received: from ?IPv6:2a02:587:b20c:c900:713d:859a:cfca:8a17?
 ([2a02:587:b20c:c900:713d:859a:cfca:8a17])
 by smtp.gmail.com with ESMTPSA id h16sm28072823wre.87.2020.10.12.16.14.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 16:14:59 -0700 (PDT)
Subject: Re: Using virtio-vhost-user or vhost-pci
To: Cosmin Chenaru <cosmin.chenaru@gmail.com>
References: <CADx_CBPzAstC0o9X6CrnyFqYYAtPbw5-XHWxmXTt6+LyYb-U3g@mail.gmail.com>
From: Nikos Dragazis <ndragazis@arrikto.com>
Message-ID: <9287d0a2-a3ed-6517-3fa2-07ba75f6414c@arrikto.com>
Date: Tue, 13 Oct 2020 02:14:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CADx_CBPzAstC0o9X6CrnyFqYYAtPbw5-XHWxmXTt6+LyYb-U3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=ndragazis@arrikto.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/20 10:22 μ.μ., Cosmin Chenaru wrote:

> Hi,
>
> Could you please tell me if there has been any more work on virtio-vhost-user or vhost-pci? The last messages that I could find were from January 2018, from this thread [1], and from what I see the latest Qemu code does not have that included.

Hi Cosmin,

The thread that you are pointing to is Stefan's initial work on this
subject, but it is not the last update. Since 2018, a lot of things have
happened. I have personally put a lot of effort on pushing this further
and with the help of the community we are trying to get this merged into
QEMU eventually. You can find an overview of the up-to-date state here
[1]. Note also that, recently, we had a discussion on various on-going
inter-VM device emulation interfaces (have a look at this [2]).

In brief, the current step/goal is to get the device spec merged into the
VIRTIO spec (have a look at these [3][4]).

For more details, please just do a simple search on the spdk, dpdk,
qemu-devel and virtio-dev mailing lists. You will find a lot of threads
on this subject. If anything doesn't make sense or is not clear enough,
feel free to ask.

Nikos

[1] https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg03356.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04934.html
[3] https://lists.oasis-open.org/archives/virtio-dev/202008/msg00083.html
[4] https://lists.oasis-open.org/archives/virtio-dev/202005/msg00132.html

>
> I am currently running multiple VMs, connected in between by the DPDK vhost-switch. A VM can start, reboot, shutdown, so much of this is dynamic and the vhost-switch handles all of these. So these VMs are some sort of "endpoints" (I could not find a better naming).
>
> The code which runs on the VM endpoints is somehow tied to the vhost-switch code, and if I change something on the VM which breaks the compatibility, I need to recompile the vhost-switch and restart. The problem is that most of the time I forget to update the vhost-switch, and I run into other problems.
>
> If I could use a VM as a vhost-switch instead of the DPDK app, then I hope that in my endpoint code which runs on the VM, I can add functionality to make it also run as a switch, and forward the packets between the other VMs like the current DPDK switch does. Doing so would allow me to catch this out-of-sync between the VM endpoint code and the switch code at compile time, since they will be part of the same app.
>
> This would be a two-phase process. First to run the DPDK vhost-switch inside a guest VM, and then to move the tx-rx part into my app.
>
> Both Qemu and the DPDK app use "vhost-user". I was happy to see that I can start Qemu in vhost-user server mode:
>
>     <interface type='vhostuser'>
>       <mac address='52:54:00:9c:3a:e3'/>
>       <source type='unix' path='/home/cosmin/vsocket.server' mode='server'/>
>       <model type='virtio'/>
>       <driver queues='2'>
>         <host mrg_rxbuf='on'/>
>       </driver>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x04' function='0x0'/>
>     </interface>
>
> This would translate to these Qemu arguments:
>
> -chardev socket,id=charnet1,path=/home/cosmin/vsocket.server,server -netdev type=vhost-user,id=hostnet1,chardev=charnet1,queues=2 -device virtio-net-pci,mrg_rxbuf=on,mq=on,vectors=6,netdev=hostnet1,id=net1,mac=52:54:00:9c:3a:e3,bus=pci.0,addr=0x4
>
> But at this point Qemu will not boot the VM until there is a vhost-user client connecting to Qemu. I even tried adding the "nowait" argument, but Qemu still waits. This will not work in my case, as the endpoint VMs could start and stop at any time, and I don't even know how many network interfaces the endpoint VMs will have.
>
> I then found the virtio-vhost-user transport protocol [2], and was thinking that I could at least start the packet-switching VM, and then let the DPDK app inside it do the forwarding of the packets. But from what I understand, this creates a single network interface inside the VM on which the DPDK app can bind. The limitation here is that if another VM wants to connect to the packet-switching VM, I need to manually add another virtio-vhost-user-pci device (and a new vhost-user.sock) before this packet-switching VM starts, so this is not dynamic.
>
> The second approach for me would be to use vhost-pci [3], which I could not fully understand how it works, but I think it presents a network interface to the guest kernel after another VM connects to the first one.
>
> I realize I made a big story and probably don't make too much sense, but one more thing. The ideal solution for me would be a combination of the vhost-user socket and the vhost-pci socket. The Qemu will start the VM and the socket will wait in the background for vhost-user connections. When a new connection is established, Qemu should create a hot-plugable PCI network card and either the guest kernel or the DPDK app inside to handle the vhost-user messages.
>
> Any feedback will be welcome, and I really appreciate all your work :)
>
> Cosmin.
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg04806.html
> [2] https://wiki.qemu.org/Features/VirtioVhostUser
> [3] https://github.com/wei-w-wang/vhost-pci
>

