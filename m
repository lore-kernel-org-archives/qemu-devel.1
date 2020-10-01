Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF933C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E772137B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E772137B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNzBj-0002RT-27
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kNzAn-0001ab-No
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:03:05 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:56382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kNzAk-00056h-ET
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:03:04 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 5B66B747F1E;
 Thu,  1 Oct 2020 16:02:50 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3FCD7747F19; Thu,  1 Oct 2020 16:02:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3E4B6747F18;
 Thu,  1 Oct 2020 16:02:50 +0200 (CEST)
Date: Thu, 1 Oct 2020 16:02:50 +0200 (CEST)
To: Eric Blake <eblake@redhat.com>
Subject: Re: Use of "?" for help has been deprecated for 8 years, can we drop
 it?
In-Reply-To: <54b77382-78c8-e6bf-45d4-616595baa87f@redhat.com>
Message-ID: <b2ac33d8-6358-7e19-9ced-1febbf191dfd@eik.bme.hu>
References: <87k0wa1bf8.fsf@dusky.pond.sub.org>
 <54b77382-78c8-e6bf-45d4-616595baa87f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Thu, 1 Oct 2020, Eric Blake wrote:
> On 10/1/20 5:35 AM, Markus Armbruster wrote:
>> We deprecated "?" more than eight years ago.  We didn't have a
>> deprecation process back then, but we did purge "?" from the
>> documentation and from help texts.  Can we finally drop it?
>>
>> I'm asking because there is a patch on the list that bypasses
>> is_help_option() to not add deprecated "?" to a new place: "[PATCH v2
>> 1/4] keyval: Parse help options".
>>
>
> Did we ever issue a warning when it was used?  It's easier to argue that
> it can be dropped if users had notice of some form or another.  That
> said, I'm not heartbroken if we yank it immediately instead of letting
> it live for 2 more releases.

How about keeping it as a convenience? I find it easier to type ? than 
help and often use it instead. It's sufficiently hidden to not cause any 
confusion for those who don't know and convenient for those who know. I 
agree with Peter that it should not be something that causes that much 
trouble that it would need to be removed immediately (or even in the 
future).

Regrads,
BALATON Zoltan

