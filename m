Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38B2C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A9920B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A9920B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50609 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVuzK-0000q5-QO
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 05:35:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVuyJ-0000QE-Jz
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVuyI-0000gi-JL
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:34:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hVuyI-0000gA-EX
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:34:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so1084229wmi.0
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 02:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=1ZW6Bqh0iZdaiBhb5YnemBuazfDKbfooOOm0jlLBHHM=;
	b=MiAf0tfBPssZ3aLaEhaD0sbxhiDNss/yLYoIZ57EpluWtgXBO7bOFOdpChKsGxhTUx
	olfO0b0Wc39FGRCkhlriJgeNmC4rlf4Qj+mENMAhSUfBGan9y39XRnfkRPZOvFYC4IIA
	uUPz1NN26KcKl13YDSNLlzBDVP90rpIfVMipmeWRDxpK9Yywr1wUBHWkAsvbIis2zQZO
	0b4nkBKk3kipVsz70sVizpdNt59nXdeUDb0bVTXzSx9JuPGRayXU33IhuIroSmPu8lR1
	bclYmCmGndXuBJbKzhQK1exasL8Gl/SwAgOyfLXHi7mKOP/2VL0qekrqUeM1ehyqEOoL
	j8Qg==
X-Gm-Message-State: APjAAAXSJf3mkvlqyGlHiQZHJV/u+hMLcKH6/mMwOriylajz8Fx5TJ7s
	SHJ9yX1nT9GrsdwEtsYD96uyNg==
X-Google-Smtp-Source: APXvYqxECDu4Gfrv0VvghZQt0+dJCb2Rn8YzUp6InvbTyxPYWX5i6cRTFXhQge9NnRdXglJZQaz/Kw==
X-Received: by 2002:a1c:2907:: with SMTP id p7mr6139025wmp.100.1559122448967; 
	Wed, 29 May 2019 02:34:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c92d:f9e8:f150:3553?
	([2001:b07:6468:f312:c92d:f9e8:f150:3553])
	by smtp.gmail.com with ESMTPSA id
	g16sm16722405wrm.96.2019.05.29.02.34.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 02:34:08 -0700 (PDT)
To: Michal Privoznik <mprivozn@redhat.com>, Jie Wang <wangjie88@huawei.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1559048796-57016-1-git-send-email-wangjie88@huawei.com>
	<cac8ed16-7846-ca22-2463-c3c738066d61@redhat.com>
	<f165741a-2ffd-62fd-b121-49bf1a3597f1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca74a7bf-dd68-d4c3-2c25-8e43db52678c@redhat.com>
Date: Wed, 29 May 2019 11:34:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f165741a-2ffd-62fd-b121-49bf1a3597f1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] pr-manager-helper: fix pr
 process been killed when reconectting
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: eric.fangyi@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/05/19 09:33, Michal Privoznik wrote:
> On 5/28/19 7:45 PM, Paolo Bonzini wrote:
>> On 28/05/19 15:06, Jie Wang wrote:
>>> if pr-helper been killed and qemu send disconnect event to libvirt
>>> and libvirt started a new pr-helper process, the new pr-heleper
>>> been killed again when qemu is connectting to the new pr-helper,
>>> qemu will never send disconnect to libvirt, and libvirt will never
>>> receive connected event.
>>
>> I think this would let a guest "spam" events just by sending a lot PR
>> commands.  Also, as you said, in this case QEMU has never sent a
>> "connected" event, so I'm not sure why it should send a disconnection
>> event.
> 
> So pr manager is initialized on the first PR command and not when qemu
> is starting?

It is initialized when QEMU is started, but if it dies, that's not
detected until the first PR command.  The command is retried for 5
seconds, which should give libvirt ample time to restart the PR manager
(and it's an exceptional situation anyway).

> If a user inside the guest could somehow kill pr-helper process in the
> host then yes, they could spam libvirt/qemu. But if a user from inside a
> guest can kill a process in the host that is much bigger problem than
> spaming libvirt.

This is true.

>> Does libvirt monitor at all the pr-helper to check if it dies?  Or does
>> it rely exclusively on QEMU's events?
> 
> Libvirt relies solely on QEMU's events. Just like with qemu process
> itself, libvirt can't rely on SIGCHILD because the daemon might be
> restarted which would reparent all qemu and pr-helper processes
> rendering libvirt wait for SIGCHILD useless.
> 
> But there is an exception to this: when libvirt is spawning pr-helper it
> does so by following these steps:
> 
> 1) Try to acquire (lock) pidfile
> 2) unlink(socket)
> 3) spawn pr-helper process (this yields child's PID)
> 4) wait some time until socket is created
> 5) some follow up work (move child's PID into same cgroup as qemu's main
> thread, relabel the socket so that qemu can access it)
> 
> If any of these steps fails then child is killed. However, the PID is
> not recorded anywhere and thus is forgotten once control jumps out of
> the function.

Note that qemu-pr-helper supports the systemd socket activation
protocol.  Would it help if libvirt used it?

Paolo

