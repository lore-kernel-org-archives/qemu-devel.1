Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE84C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB7620881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB7620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44574 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTSWG-0005Pg-9V
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 10:47:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1hTRnS-0007Te-OR
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1hTRnM-0001v0-Kf
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:00:43 -0400
Received: from ivanoab6.miniserver.com ([5.153.251.140]:57266
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1hTRnK-0001tF-1h
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:00:39 -0400
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1hTRnG-0004Bo-ET; Wed, 22 May 2019 14:00:34 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.89)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1hTRnE-0004HD-47; Wed, 22 May 2019 15:00:34 +0100
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
	virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
References: <0952696452f5ff4e38d2417029243fc60efa33d6.camel@sipsolutions.net>
	<ddeee710-d546-ff05-5c53-991a7d807067@kot-begemot.co.uk>
	<8b30e5cea2692d62fd7f486fc98effdb589a1412.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <f21ae7ac-ae56-71e6-cebd-f97c8912f5e1@cambridgegreys.com>
Date: Wed, 22 May 2019 15:00:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8b30e5cea2692d62fd7f486fc98effdb589a1412.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.153.251.140
X-Mailman-Approved-At: Wed, 22 May 2019 10:44:51 -0400
Subject: Re: [Qemu-devel] custom virt-io support (in user-mode-linux)
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 22/05/2019 14:46, Johannes Berg wrote:
> Hi Anton,
> 
>>> I'm thinking about adding virt-io support to UML, but the tricky part is
>>> that while I want to use the virt-io basics (because it's a nice
>>> interface from the 'inside'), I don't actually want the stock drivers
>>> that are part of the kernel now (like virtio-net etc.) but rather
>>> something that integrates with wifi (probably building on hwsim).
> 
>> I have looked at using virtio semantics in UML in the past around the
>> point when I wanted to make the recvmmsg/sendmmsg vector drivers common
>> in UML and QEMU. It is certainly possible,
>>
>> I went for the native approach at the end though.
> 
> Hmm. I'm not sure what you mean by either :-)
> 
> Is there any commonality between the vector drivers? 

I was looking purely from a network driver perspective.

I had two options - either do a direct read/write as it does today or 
implement the ring/king semantics and read/write from that.

I decided to not bother with the latter and read/write directly from/to 
skbs.

> I can't see how
> that'd work without a bus abstraction (like virtio) in qemu? I mean, the
> kernel driver just calls uml_vector_sendmmsg(), which I'd say belongs
> more to the 'outside world', but that can't really be done in qemu?
> 
> Ok, I guess then I see what you mean by 'native' though.
> 
> Similarly, of course, I can implement arbitrary virt-io devices - just
> the kernel side doesn't call a function like uml_vector_sendmmsg()
> directly, but instead the virt-io model, and the model calls the
> function, which essentially is the same just with a (convenient)
> abstraction layer.
> 
> But this leaves the fundamental fact the model code ("vector_user.c" or
> a similar "virtio_user.c") is still part of the build.
> 
> I guess what I'm thinking is have something like "virtio_user_rpc.c"
> that uses some appropriate RPC to interact with the real model. IOW,
> rather than having all the model-specific logic actually be here (like
> vector_user.c actually knows how to send network packets over a real
> socket fd), try to call out to some RPC that contains the real model.
> 
> Now that I thought about it further, I guess my question boils down to
> "did anyone ever think about doing RPC for Virt-IO instead of putting
> the entire device model into the hypervisor/emulator/...".

Virtio in general no. UML specifically - yes. I have thought of mapping 
out all key device calls to RPCs for a few applications. The issue is 
that it is fairly difficult to make all of this function cleanly without 
blocking in strange places.

You may probably want to look at the UML UBD driver. That is an example 
of moving out all processing to an external thread and talking to it via 
a request/response API. While it still expects shared memory and needs 
access to UML address space the model should be more amenable to 
replacing various calls with RPCs as you have now left the rest of the 
kernel to run while you are processing the RPC. It also provides you 
with RPC completion interrupts, etc as a side effect.

So you basically have UML -> Thread -> RPCs -> Model?

> 
> johannes
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

