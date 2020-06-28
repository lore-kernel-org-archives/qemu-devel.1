Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FCBC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 18:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA37206C0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 18:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA37206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpc9Z-0007uk-0Z
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 14:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpc8t-0007Eq-43; Sun, 28 Jun 2020 14:35:03 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:28674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpc8r-0007b2-FK; Sun, 28 Jun 2020 14:35:02 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id BCF2A74632C;
 Sun, 28 Jun 2020 20:34:57 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A0C6A745712; Sun, 28 Jun 2020 20:34:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9F6587456F8;
 Sun, 28 Jun 2020 20:34:57 +0200 (CEST)
Date: Sun, 28 Jun 2020 20:34:57 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v5 00/11] Mac Old World ROM experiment
In-Reply-To: <7e7de183-e453-0907-71ca-c1c8126e5543@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2006282032040.88507@zero.eik.bme.hu>
References: <cover.1592315226.git.balaton@eik.bme.hu>
 <alpine.BSF.2.22.395.2006261218180.94870@zero.eik.bme.hu>
 <7e7de183-e453-0907-71ca-c1c8126e5543@ilande.co.uk>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 14:20:01
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020, Mark Cave-Ayland wrote:
> On 26/06/2020 11:21, BALATON Zoltan wrote:
>> What about these patches? At least those that are finished (up to patch 9) could be
>> merged. I've seen you sent a pull request but not including any of these. Will this
>> need another rebase after your patches? If I rebase them will you consider merging
>> them? (Otherwise I won't spend time with it.)
>
> Ah sorry I missed the latest version of these. I'll take a quick look now.

In case you missed that I've just sent the latest v6 version of the series 
with changes you've suggested and I made since.

> (BTW it seems the patches in your patchset have started appearing in a random order
> when sent to the list again?)

I've noticed this too but don't know why that happens or what to do to 
prevent it. I submit these in one batch to my mail server which then seems 
to send it off simultaneously and may end up out of order. I've tried 
adding a 1 sec delay now but apparently that did not solve it. Sorry for 
the inconvenience.

Regards,
BALATON Zoltan

