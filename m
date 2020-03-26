Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DBEC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 06:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB8C20719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 06:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB8C20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHLvY-0006BH-Cz
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 02:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jHLus-0005l0-GO
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 02:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jHLur-0001lH-Eg
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 02:22:58 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35945)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jHLur-0001iY-6Q; Thu, 26 Mar 2020 02:22:57 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N5n81-1jKULY2DFr-017BP2; Thu, 26 Mar 2020 07:22:51 +0100
Subject: Re: [PATCH v9 3/4] linux-user: Support futex_time64
To: Alistair Francis <alistair23@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <cover.1584571250.git.alistair.francis@wdc.com>
 <d9390e368a9a1fd32d52aa771815e6e3d40cb1d4.1584571250.git.alistair.francis@wdc.com>
 <CAKmqyKNTpfDvWx85eAK2YNRgzxHRMA8NBvJJf081X3O76B=ekQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9d1ce19f-86ba-3247-c3fc-0ba8d0bc7760@vivier.eu>
Date: Thu, 26 Mar 2020 07:22:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNTpfDvWx85eAK2YNRgzxHRMA8NBvJJf081X3O76B=ekQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:adBpIiLGRW6NGSzBYEeIj7Rmc5uEMauKCsOpPajuxXHVUuUfXvb
 r4/YpFbM1sSK61NssSL/djAYoznbQV/TJR1O9wS/1BUd6q2XfQM82LcfYWz1RCvcHDV9Vsf
 noubRnxklUi+yTQ9eg4vrYebVIvPEv9tLX66gKmq23akmOQKR1quGmg+VKEslBVdemjrouT
 FaEaDHTrN4QTHaVlHaX1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fqopX+e9Dww=:37GjQL9u+XLN7eUiPxkdOG
 7ZfQ/cUmoUXf37KisO/wuIqe9Z5JSsq8B462G5SWlueXOAGmgcnKgT97PcGm8F9Zp9nMzNiwR
 Dgi5xzO1p5p7rzbgR4vx0Aqdt1ea+VOyV8O+98XMF3TM9mYYQ+Ys1KttXoUNmR49U+yEp/cIr
 mVAyGfEsOzzJV7NXrZjwaf7W/QRUp3h+yJj1CLxyuHiJEfLfgbXryOffrfhjUGmj1QNA8PSTt
 m1CV+TDsgI1jvb0tseD0L/pq/bzig1crqoMR51K+soFRs/gWvCChXiKsY30qSmKB4U4kSXent
 iM1RabEzl3o4wksfcqIvKgNQE4dBOfsar2OeaTXHM1NJW6rvQsfbqodYo9rcvwaUmZeTfpq9X
 Rcw0RCjBvfM2VkFPFGHAQuYL8YnVNzjFAUFjYRisp3CCxbj2jrlvA0kv2tFGpzsuQSq9YImA0
 I8g4oR6RkHCyY3W6eNwzf44pITPSLoJiAJoQUnzyxFhnORiqBOhHnizeBSix4HvuLBu93DMJs
 KdwyVZHjDSeA9WN1G2WJE3PdmowvIwuhNh6kjqCnS1MvNqSBo0IwfeZdciTypj15aJoa5sFcS
 PohHKXpfVMaWUYhRAImIuZDwUKR5viE7uvim3DKVKDeZlf/u3P/GBbkBviS1ffCQxZ7NHs34G
 m3RZGU3WC7RwN38vWJF4wO+PGgCYAWj+wOwloDjKN3GkeB0AXmZes878vpJxSW+UiosDdn22B
 mKB7rNV0qahyVL43+XrAJo5X/FOUSfvYqD9d1Z3WdJyEuh4aXUgbq5fiFoXWn93BOde7scEJr
 Yu7SuMo+Xe0RUA3KxV2OicRKbD9cOcK4VV8OXVItC2ddTFb1aV8n0VbvBHbyuzWlV5FnVAN
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/03/2020 à 18:41, Alistair Francis a écrit :
> On Wed, Mar 18, 2020 at 3:54 PM Alistair Francis
> <alistair.francis@wdc.com> wrote:
>>
>> Add support for host and target futex_time64. If futex_time64 exists on
>> the host we try that first before falling back to the standard futux
>> syscall.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> 
> @Laurent did you see this?
> 
> I guess it's a little late for 5.0 but it would be nice to support.

Yes, I've seen your patch.

I think it can go into 5.0 RC because it's a bug fix and it is really
needed because the 32bit futex will be broken if host timespec uses
64bit field.

But I need to review and test before.

Thanks,
Laurent

