Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B12C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993A32080D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993A32080D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwDg-0007Vy-Dx
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kRwC8-0006rp-7U; Mon, 12 Oct 2020 07:40:48 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:27714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kRwC4-0007n0-T3; Mon, 12 Oct 2020 07:40:47 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id B40F7745953;
 Mon, 12 Oct 2020 13:40:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4091F745712; Mon, 12 Oct 2020 13:40:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3F2CB745702;
 Mon, 12 Oct 2020 13:40:33 +0200 (CEST)
Date: Mon, 12 Oct 2020 13:40:33 +0200 (CEST)
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v9] spapr: Implement Open Firmware client
 interface
In-Reply-To: <35aeefc4-bdfc-65c5-afe5-1cd2579db3e4@ozlabs.ru>
Message-ID: <3a81d5-9553-9a9a-ec4a-5c47607f54c0@eik.bme.hu>
References: <20200513035826.14205-1-aik@ozlabs.ru>
 <e5ddf04a-0d68-3cb8-2b84-47a43e234a59@ozlabs.ru>
 <f7e9ff41-de7a-c0d5-f004-51a2046ce0a0@ozlabs.ru>
 <434cdf49-5b80-5620-2635-079ee4b4ebad@ozlabs.ru>
 <86e79b6a-0032-56da-a066-9f02df361298@ozlabs.ru>
 <20200716132249.GB5607@umbus.fritz.box>
 <24e83a34-6788-d9ee-ca07-6833778d81df@ozlabs.ru>
 <35aeefc4-bdfc-65c5-afe5-1cd2579db3e4@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-387189231-1602502833=:51921"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 07:40:34
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-387189231-1602502833=:51921
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 12 Oct 2020, Alexey Kardashevskiy wrote:
> On 29/09/2020 20:35, Alexey Kardashevskiy wrote:
>> 
>> On 16/07/2020 23:22, David Gibson wrote:
>>> On Thu, Jul 16, 2020 at 07:04:56PM +1000, Alexey Kardashevskiy wrote:
>>>> Ping? I kinda realize it is not going to replace SLOF any time soon but
>>>> still...
>>> 
>>> Yeah, I know.   I just haven't had time to consider it.  Priority
>>> starvation.
>> 
>> 
>> Still? :)
>
> Ping?

+1, I'd like to see this merged and experiment with it to emulate firmware 
for pegasos2 but I'd rather use the final version than something off-tree 
which may end up different when gets upstream. Is there a way I could help 
with this?

Regards,
BALATON Zoltan
--3866299591-387189231-1602502833=:51921--

