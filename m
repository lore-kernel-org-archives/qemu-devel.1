Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A5FC32771
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 00:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C842467C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 00:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C842467C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwEWN-0003I7-2l
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 19:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iwEVS-0002lC-6F
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 19:13:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iwEVQ-0007Od-Sa
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 19:13:26 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:55143)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iwEVQ-0007NA-K4; Mon, 27 Jan 2020 19:13:24 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MRmo8-1j2Anw39kw-00TDB8; Tue, 28 Jan 2020 01:12:58 +0100
Subject: Re: [PATCH v3 00/14] Fixes for DP8393X SONIC device emulation
To: Finn Thain <fthain@telegraphics.com.au>, Jason Wang
 <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <cover.1579474761.git.fthain@telegraphics.com.au>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <570c20e2-4f39-72cd-555a-10040015c321@vivier.eu>
Date: Tue, 28 Jan 2020 01:12:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <cover.1579474761.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:S1Tx/OCWs3vPZwjpVnJujo/wwddsufphbjL8Z2W1VjfhjPWIHuT
 Nk+M79qMSzILVz0lWbeZBvn2Q5pO0iwkNJxvwiBONJrn3J6eNNAqIPuvUBl3upNijPPo/d/
 KBakdR80ydr1I78vKiNGj4cBgxp7n1EYqgfEE4Mg2Ij8C92fV/486e4GbtzH8ZmiqVn3xk9
 tXv+X2VxCdyvqfzss9a2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EzNMBdNN3nk=:9c0id7t641CplWplVmqxRT
 hGACeuWJ1kEX0dWYxuXbZrq36A2TszAiuMaVHSDs9iUgRrhV8o50xuZ9qXVE3KJcUlYV5ntql
 U/Je2sM5/WIHDM7sJI4Iksgor7agodceo18xHd0jR504RXBw83g7mOeUuYfZYN2klnuvt6JtP
 cSyTi+tbK/Gv3CPJVvHxgGE8xR4aAukYWzgpmY3UY9zuMxPxDnXKH+oO9GOOp1jUQ1bhC6Czn
 CG4YmFJ8uNR8pxlCtaA1LAC/YI9LDvn8aPH8GjRRWwbSMuGtKLZO4BpD6dr0mm4fSoVgmuGCO
 Cial8Hn2sCz7D+tU7vnT1+EWWGHtkQCg/JDdefkTJ2RQdfXeueyuPYJyoTuf0KsZe31gJ5xRw
 Hd1xuGqP6mj1VWxbUmJZLrqYMEvPyAOZFAchvN819ghe+5+mF8Z9WOljfjcY0ZJfPk0qLZEEO
 ubT1gVPLWVbxSd9ThiL8wsLGH+uPaW7AgBVR5EEyejZPcrk+jy4vdspZFknQfFQx0mf+BMF+i
 wr1LsYap/lwXsU2RGX8T5kwKY44pwoif1DrTVtpPe6yMwiuh9HBytrMieIgAQOdgGXIYmASOC
 gRDLTh6EvhDm5UWgTTcZnFMiw7sPiwsJu43bSnKbIfl14BQJNJcmifqL3uRzJ+FV5fQxIj1AF
 p4w3poc8vgAF3ONgFid6nG76Xk7IYuIlUvnQ+YHop3RBJJCda+y0y4VW4Akp4BnpZGSD+bbo3
 k3J7ZjrA18/yNoVwhBTWvfp6Emb4zU8pfdop/lgEKv51U3Z/8SzEVDDwTEcOWYgGnkI9l7bB2
 PA69ZUQQJ4EnrCDossc5EqITejVBUnpA2TJ0LcTXqQ5+AxhW1ThyDNRvlyq/9TFkYW7BTg9
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/01/2020 à 23:59, Finn Thain a écrit :
> Hi All,
> 
> There are bugs in the emulated dp8393x device that can stop packet
> reception in a Linux/m68k guest (q800 machine).
> 
> With a Linux/mips guest (magnum machine), the driver fails to probe
> the dp8393x device.
> 
> With a NetBSD/arc 5.1 guest (magnum machine), the bugs in the device
> can be fatal to the guest kernel.
> 
> Whilst debugging the device, I found that the receiver algorithm
> differs from the one described in the National Semiconductor
> datasheet.
> 
> This patch series resolves these bugs.
> 
> Note that the mainline Linux sonic driver also has bugs.
> I have fixed the bugs that I know of in a series of patches at,
> https://github.com/fthain/linux/commits/mac68k
> ---
> Changed since v1:
>  - Minor revisions as described in commit logs.
>  - Dropped patches 4/10 and 7/10.
>  - Added 5 new patches.
> 
> Changed since v2:
>  - Minor revisions as described in commit logs.
>  - Dropped patch 13/13.
>  - Added 2 new patches.
> 
> 
> Finn Thain (14):
>   dp8393x: Mask EOL bit from descriptor addresses
>   dp8393x: Always use 32-bit accesses
>   dp8393x: Clean up endianness hacks
>   dp8393x: Have dp8393x_receive() return the packet size
>   dp8393x: Update LLFA and CRDA registers from rx descriptor
>   dp8393x: Clear RRRA command register bit only when appropriate
>   dp8393x: Implement packet size limit and RBAE interrupt
>   dp8393x: Don't clobber packet checksum
>   dp8393x: Use long-word-aligned RRA pointers in 32-bit mode
>   dp8393x: Pad frames to word or long word boundary
>   dp8393x: Clear descriptor in_use field to release packet
>   dp8393x: Always update RRA pointers and sequence numbers
>   dp8393x: Don't reset Silicon Revision register
>   dp8393x: Don't stop reception upon RBE interrupt assertion
> 
>  hw/net/dp8393x.c | 205 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 137 insertions(+), 68 deletions(-)
> 

For the series with q800 machine type and kernel 5.5.0:

Tested-by: Laurent Vivier <laurent@vivier.eu>

