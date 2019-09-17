Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69A1C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CF820862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="JvpY+bdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CF820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA98F-0004Ui-Hi
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 04:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1iA95S-0003hB-Ra
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1iA95R-00083Z-Or
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:43:50 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:36490)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1iA95N-00081M-W7; Tue, 17 Sep 2019 04:43:46 -0400
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 8E29E96F50;
 Tue, 17 Sep 2019 08:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1568709823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VHN5ARYEvEd8sow+DO60Ao3ezWbjVE8SpECORQ8v1vA=;
 b=JvpY+bdgRe4LI1iwO2XrZlBHsou4n9SRWNYkciOvgJNCdkMtranxL54I4hSF/LlOc5WnHO
 Pg2Ahg4/MDso3zyrQ1lzu/vaVJpMxKsbHI5ySTIZn6OMu50X1p+9sISyFremsm+hN7m+r2
 UTLHVUlH6koIgLhZm2jmw1zs5FUbLwg=
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190912110103.1417887-1-luc.michel@greensocs.com>
 <CAFEAcA-WO=O5zwRDQoNz2zT4sx61j8Jy5px0uFPiWgF_JUpa+A@mail.gmail.com>
 <204007b1-1c1e-432b-399f-b3784f812710@greensocs.com>
Message-ID: <c3a22836-0435-e09b-6fe0-eff85124c0ca@greensocs.com>
Date: Tue, 17 Sep 2019 10:43:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <204007b1-1c1e-432b-399f-b3784f812710@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1568709823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VHN5ARYEvEd8sow+DO60Ao3ezWbjVE8SpECORQ8v1vA=;
 b=IqJ9OKRqkWQT9kO0mEMLXFLAYBLmGfosY1uxJDD5iXSneQYwPrtuyStqMJpNSGK5Gu7rYK
 DcXJF/jvc8qxJV/hQNR7tVPAeNswCiLLeo2oraDcLG2cVuuB9aiZxctn3mDJOYemIGDYpE
 qE8k7nvaQ5sY93Djz1foKiKjlRRgJRE=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1568709823; a=rsa-sha256; cv=none;
 b=idfTcU/COTYoc5S8ZGy8TdEuqqiAXhgy7NzH4gesSj2xn73+jy0xT8cuq2QjIerTjdRVPT
 nFe9P+a2coyEzVJOLsKVsRQ/R0vptPAXYUZ66LtWS+QVTrxTO7C7QntECjh2sT6kFWmdnc
 10FnJWiEd4AZ4pDX0kHG06XPFS7LYkA=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH] target/arm: fix CBAR register for AArch64
 CPUs
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/19 9:26 AM, Luc Michel wrote:
> Hi Peter,
> 
> On 9/12/19 6:03 PM, Peter Maydell wrote:
>> On Thu, 12 Sep 2019 at 12:01, Luc Michel <luc.michel@greensocs.com> wrote:
>>>
>>> For AArch64 CPUs with a CBAR register, we have two views for it:
>>>   - in AArch64 state, the CBAR_EL1 register (S3_1_C15_C3_0), returns the
>>>     full 64 bits CBAR value
>>>   - in AArch32 state, the CBAR register (cp15, opc1=1, CRn=15, CRm=3, opc2=0)
>>>     returns a 32 bits view such that:
>>>       CBAR = CBAR_EL1[31:18] 0..0 CBAR_EL1[43:32]
>>>
>>> This commit fixes the current implementation where:
>>>   - CBAR_EL1 was returning the 32 bits view instead of the full 64 bits
>>>     value,
>>>   - CBAR was returning a truncated 32 bits version of the full 64 bits
>>>     one, instead of the 32 bits view
>>>   - CBAR was declared as cp15, opc1=4, CRn=15, CRm=0, opc2=0, which is
>>>     the CBAR register found in the ARMv7 Cortex-Ax CPUs, but not in
>>>     ARMv8 CPUs.
>>>
>>> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
>>> ---
>>>  target/arm/helper.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>>> index 507026c915..755aa18a2d 100644
>>> --- a/target/arm/helper.c
>>> +++ b/target/arm/helper.c
>>> @@ -6740,12 +6740,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>>>              ARMCPRegInfo cbar_reginfo[] = {
>>>                  { .name = "CBAR",
>>>                    .type = ARM_CP_CONST,
>>> -                  .cp = 15, .crn = 15, .crm = 0, .opc1 = 4, .opc2 = 0,
>>> -                  .access = PL1_R, .resetvalue = cpu->reset_cbar },
>>> +                  .cp = 15, .crn = 15, .crm = 3, .opc1 = 1, .opc2 = 0,
>>> +                  .access = PL1_R, .resetvalue = cbar32 },
>>
>> This will break the Cortex-A9 &c which use the 15/0/4/0 encoding
>> and the un-rearranged value for this register.
> I don't think so because we are in the "if (arm_feature(env,
> ARM_FEATURE_AARCH64))" branch of the code. The else branch still maps
> 15/0/4/0 for non-AArch64 CPUs.
> 
>>
>> I think we need to check through the TRMs to confirm which CPUs use
>> which format for the CBAR, and have a different feature bit for the
>> newer format/sysreg encoding, so we can provide the right sysregs for
>> the right cores.
> I checked all the AArch64 Cortex's TRMs, for those having a PERIPHBASE
> signal and CBAR register (namely Cortex-A53, 57, 72, 73), they all match
> the mapping I put in this patch, so I think we don't need to split the
> CBAR feature further. I believe more recent Cortex's address the GIC
> using coprocessor registers, and CBAR does not exist in those ones.

Hi Peter,

Do you want me to re-roll this patch with some modifications?
Thanks.

-- 
Luc

