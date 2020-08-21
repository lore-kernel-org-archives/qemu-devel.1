Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFD8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 05:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DE320724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 05:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DE320724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8zn1-0004Kn-Ib
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 01:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8zmB-0003ni-OC; Fri, 21 Aug 2020 01:39:43 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:36067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8zm9-0002lT-Ps; Fri, 21 Aug 2020 01:39:43 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.188])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 958CD527B2C5;
 Fri, 21 Aug 2020 07:39:36 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 07:39:35 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002a5916cc3-b1bd-4a26-9c6d-0feec1d6325c,
 75F2C724DC147A8CFF44EDCF727470C0E1FB3540) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2] spapr/xive: Use the xics flag to check for XIVE-only
 IRQ backends
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200820140106.2357228-1-clg@kaod.org>
 <20200820232237.GU271315@yekko.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <83b3dff5-0b6c-699d-cc29-577ee009d038@kaod.org>
Date: Fri, 21 Aug 2020 07:39:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820232237.GU271315@yekko.fritz.box>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 3253c77f-2254-4ca7-babd-dbfa02066781
X-Ovh-Tracer-Id: 6780169243066207200
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudduuddgleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeehnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeelgfejveehieefffduueehvdevfedtleeiudekjeegveeigfeifefhtdfffedtnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:39:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 1:22 AM, David Gibson wrote:
> On Thu, Aug 20, 2020 at 04:01:06PM +0200, Cédric Le Goater wrote:
>> The sPAPR machine has four different IRQ backends, each implementing
>> the XICS or XIVE interrupt mode or both in the case of the 'dual'
>> backend.
>>
>> If a machine is started in P8 compat mode, QEMU should necessarily
>> support the XICS interrupt mode and in that case, the XIVE-only IRQ
>> backend is invalid. Currently, spapr_irq_check() tests the pointer
>> value to the IRQ backend to check for this condition, instead use the
>> 'xics' flag. It's equivalent and it will ease the introduction of new
>> XIVE-only IRQ backends if needed.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> 
> Thanks, applied to ppc-for-5.2.
> 
> I still kind of want to remove the last vestiges of those
> "backends", but I'm unlikely to have time to do so soon.

What did you have in mind ? 

Move the 'xics' and 'xive' flags directly under the spapr machine ? 
It would add state.

C.
 
> 
>> ---
>>  hw/ppc/spapr_irq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 80cf1c3d6bb2..d036c8fef519 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -172,7 +172,7 @@ static int spapr_irq_check(SpaprMachineState *spapr, Error **errp)
>>           * To cover both and not confuse the OS, add an early failure in
>>           * QEMU.
>>           */
>> -        if (spapr->irq == &spapr_irq_xive) {
>> +        if (!spapr->irq->xics) {
>>              error_setg(errp, "XIVE-only machines require a POWER9 CPU");
>>              return -1;
>>          }
> 


