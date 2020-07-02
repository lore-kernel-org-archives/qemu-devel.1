Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A94C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866EA2088E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866EA2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgraf.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqv7f-0003Kq-Rl
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 05:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>)
 id 1jqv6r-0002mx-AC; Thu, 02 Jul 2020 05:02:21 -0400
Received: from mail.csgraf.de ([188.138.100.120]:50802
 helo=zulu616.server4you.de) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <agraf@csgraf.de>)
 id 1jqv6p-0007UZ-6l; Thu, 02 Jul 2020 05:02:20 -0400
Received: from 38f9d3867b82.ant.amazon.com
 (ec2-3-122-114-9.eu-central-1.compute.amazonaws.com [3.122.114.9])
 by csgraf.de (Postfix) with ESMTPSA id 2FB6139002EF;
 Thu,  2 Jul 2020 11:02:16 +0200 (CEST)
Subject: Re: [PATCH] target/arm: Treat unknown SMC calls as NOP
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200701200848.26746-1-agraf@csgraf.de>
 <CAFEAcA9S5v0LHMNc4fu9JGUzecbg8DsogZuCEv_aGNqVxRAcDQ@mail.gmail.com>
 <60440cb5-bd18-2928-afcf-974766222dd7@csgraf.de> <878sg2qrli.fsf@linaro.org>
From: Alexander Graf <agraf@csgraf.de>
Message-ID: <83381dc5-a259-e6d6-11b0-a6b96e850003@csgraf.de>
Date: Thu, 2 Jul 2020 11:02:10 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <878sg2qrli.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=188.138.100.120; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 05:02:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 02.07.20 09:54, Alex Bennée wrote:
> Alexander Graf <agraf@csgraf.de> writes:
>
>> On 01.07.20 22:47, Peter Maydell wrote:
>>> On Wed, 1 Jul 2020 at 21:08, Alexander Graf <agraf@csgraf.de> wrote:
>>>> We currently treat unknown SMC calls as UNDEF. This behavior is different
>>>> from KVM, which treats them as NOP.
>>>>
>>>> Unfortunately, the UNDEF exception breaks running Windows for ARM in QEMU,
>>>> as that probes an OEM SMCCC call on boot, but does not expect to receive
>>>> an UNDEF exception as response.
>>>>
>>>> So instead, let's follow the KVM path and ignore SMC calls that we don't
>>>> handle. This fixes booting the Windows 10 for ARM preview in TCG for me.
>>>>
>>>> Signed-off-by: Alexander Graf <agraf@csgraf.de>
>>>> +    if (cs->exception_index == EXCP_SMC &&
>>>> +        !arm_feature(env, ARM_FEATURE_EL3) &&
>>>> +        cpu->psci_conduit != QEMU_PSCI_CONDUIT_SMC) {
>>> This condition says: "we got an SMC, and this CPU doesn't
>>> have EL3, and we're not imitating real EL3 firmware".
>>
>> I like to think of it as "This CPU exposes an environment that looks
>> like KVM, so it implements HVC calls (EL2) and is responsible for
>> handling SMC calls as well.
> That is a very KVM centric view of the world ;-)
>
> I thought the aim was always to behave as the real processor would.


If we aim to behave like a "real processor", then why do we implement 
PSCI using HVC? A much more likely "real processor" would implement EL3, 
but no EL2 and then have PSCI as SMC calls, no?

My understanding for the rationale on why we do PSCI over HVC by default 
was to make the VM as similar between KVM and TCG as possible.


>
>> The main difference between the two semantics is that in yours, you
>> don't have EL3. In mine, there is an EL3, but it's virtualized by the
>> same layer that implements EL2.
> If you boot up with secure firmware + EL2 aware KVM kernel I assume
> everything behaves as expected?


I would assume so as well, but I don't have a working ATF setup handy. 
I'm also not worried about making it work for me - I have my local debug 
setup now :). I'm worried about a good out of the box experience for 
users who want to run Windows on ARM in TCG.


Alex


