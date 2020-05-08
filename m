Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA67C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 14:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF45224954
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 14:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF45224954
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX3zL-00037W-0t
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 10:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jX3yb-0002Pj-FY
 for qemu-devel@nongnu.org; Fri, 08 May 2020 10:27:45 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:48595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jX3yZ-00010d-6L
 for qemu-devel@nongnu.org; Fri, 08 May 2020 10:27:45 -0400
Received: from player728.ha.ovh.net (unknown [10.110.171.136])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id A0B4D8C1DE
 for <qemu-devel@nongnu.org>; Fri,  8 May 2020 16:27:40 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player728.ha.ovh.net (Postfix) with ESMTPSA id 7F23C12133DD4;
 Fri,  8 May 2020 14:27:33 +0000 (UTC)
Subject: Re: [PATCH v3] aspeed: Add boot stub for smp booting
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
References: <20200504081953.245912-1-joel@jms.id.au>
 <CACPK8XfTg1OucOEeiUE711_+-Pz4daYCrPmKFDTj25keeM8aMQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3e8500ab-929b-a3f0-f8b6-fcf8ea5c1306@kaod.org>
Date: Fri, 8 May 2020 16:27:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XfTg1OucOEeiUE711_+-Pz4daYCrPmKFDTj25keeM8aMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7808115856730393408
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrkeefgdduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedvkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.73.241; envelope-from=clg@kaod.org;
 helo=10.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 10:27:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/20 8:52 AM, Joel Stanley wrote:
> On Mon, 4 May 2020 at 08:20, Joel Stanley <joel@jms.id.au> wrote:
> ...
> 
>> v3: Use WFI instead of WFE
>> v2: test for number of CPUs
> 
>> +static void aspeed_write_smpboot(ARMCPU *cpu,
>> +                                 const struct arm_boot_info *info)
>> +{
>> +    static const uint32_t poll_mailbox_ready[] = {
>> +        /*
>> +         * r2 = per-cpu go sign value
>> +         * r1 = AST_SMP_MBOX_FIELD_ENTRY
>> +         * r0 = AST_SMP_MBOX_FIELD_GOSIGN
>> +         */
>> +        0xee100fb0,  /* mrc     p15, 0, r0, c0, c0, 5 */
>> +        0xe21000ff,  /* ands    r0, r0, #255          */
>> +        0xe59f201c,  /* ldr     r2, [pc, #28]         */
>> +        0xe1822000,  /* orr     r2, r2, r0            */
>> +
>> +        0xe59f1018,  /* ldr     r1, [pc, #24]         */
>> +        0xe59f0018,  /* ldr     r0, [pc, #24]         */
>> +
>> +        0xe320f003,  /* wfi                           */
> 
> I was wrong, wfi does not work in this case. I must have made a
> mistake when testing.
> 
> Cédric, can you please confirm my testing is correct? I was using
> today's linux next, but anything newer than Linux 5.4 should have the
> same result.

Indeed, with OpenBMC kernel v5.4.32-260-g7dc9442bbe7d and wfi (patch v3), 
    
    [    0.045214] smp: Bringing up secondary CPUs ...
    [    1.178127] CPU1: failed to come online
    [    1.187309] smp: Brought up 1 node, 1 CPU
    [    1.187590] SMP: Total of 1 processors activated (2250.00 BogoMIPS).
    [    1.187786] CPU: All CPU(s) started in HYP mode.
    [    1.187850] CPU: Virtualization extensions available.

When using wfe (patch v2),

    [    0.091092] smp: Bringing up secondary CPUs ...
    [    0.096628] smp: Brought up 1 node, 2 CPUs
    [    0.096718] SMP: Total of 2 processors activated (4500.00 BogoMIPS).
    [    0.096768] CPU: All CPU(s) started in HYP mode.
    [    0.096785] CPU: Virtualization extensions available.


Cheers,

C.


