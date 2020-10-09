Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URI_HEX,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5215CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 05:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3A22222F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 05:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3A22222F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQlQJ-0000NK-JB
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 01:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kQlPQ-0008Gw-O4; Fri, 09 Oct 2020 01:57:40 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:33515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kQlPO-0004RE-DA; Fri, 09 Oct 2020 01:57:40 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.183])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 7B944639CCCD;
 Fri,  9 Oct 2020 07:57:34 +0200 (CEST)
Received: from kaod.org (37.59.142.101) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 9 Oct 2020
 07:57:33 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004902c1cdd-ce21-4095-9d70-f6137da1ba87,
 9C17108FFE341ECC283EB15F3EE0608ADCC107E7) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 0/6] spapr/xive: Activate StoreEOI in P10 compat guests
To: David Gibson <david@gibson.dropbear.id.au>
References: <20201005165147.526426-1-clg@kaod.org>
 <20201009002326.GB1025389@yekko.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5a3af480-8e84-ddb8-e40e-e3050f6c2978@kaod.org>
Date: Fri, 9 Oct 2020 07:57:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201009002326.GB1025389@yekko.fritz.box>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 1a5e483e-5edf-4857-9f96-0f1fc1d4ac1b
X-Ovh-Tracer-Id: 18144439951582727075
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrhedtgddutdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeehnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepteekffethfdvueetvddujeffgfelvdethfeghfeuheekvdfgieegveeuveetjeetnecuffhomhgrihhnpehpphhophhsrdhnvghtpdgurhhophgsvggrrhdrihgurdgruhdpphhphhhoshhtvggurdgtohhmnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehgrhhouhhgsehkrghougdrohhrgh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 01:57:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.214,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URI_HEX=0.1 autolearn=ham autolearn_force=no
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
Cc: Gustavo Romero <gromero@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 2:23 AM, David Gibson wrote:
> On Mon, Oct 05, 2020 at 06:51:41PM +0200, Cédric Le Goater wrote:
>> Hello,
>>
>> When an interrupt has been handled, the OS notifies the interrupt
>> controller with an EOI sequence. On the XIVE interrupt controller
>> (POWER9 and POWER10), this can be done with a load or a store
>> operation on the ESB interrupt management page of the interrupt. The
>> StoreEOI operation has less latency and improves interrupt handling
>> performance but it was deactivated during the POWER9 DD2.0 time-frame
>> because of ordering issues. POWER9 systems use the LoadEOI instead.
>> POWER10 has fixed the issue with a special load command which enforces
>> Load-after-Store ordering and StoreEOI can be safely used.
> 
> Do you mean that ordering is *always* enforced on P10?  Or it's a
> special form of load that has the ordering?

It's a special form of load that has the ordering, only on available 
on P10. It's a no-op on P9. 

Linux commit b1f9be9392f0 ("powerpc/xive: Enforce load-after-store  
ordering when StoreEOI is active") introduced the Load-after-Store 
ordering offset and P10 support was added in the same 5.8 release.

This is why StoreEOI should be advertised on P10 compat kernels only. 
I would have preferred to introduce some extra CAS bits. that would 
have been cleaner than mix the two.


The basic requirement is to advertise StoreEOI when the CPU compat
allows it. I have used the capabilities to toggle the feature on/off.
It seemed a clean way to cover all the extra needs : 

 - switch it off on P10 if needed
 - switch it on on P9 for tests

 
> Also, weirdly, despite the series being addressed to me, only some of
> the patches ended up in my inbox, rather than the list folder :/.


Yes. I have received a few ot these : 
 
The original message was received at Mon, 5 Oct 2020 12:51:56 -0400
from m0098419.ppops.net [127.0.0.1]

   ----- The following addresses had permanent fatal errors -----
<david@gibson.dropbear.id.au>

   ----- Transcript of session follows -----
<david@gibson.dropbear.id.au>... Deferred: Name server: gibson.dropbear.id.au.: host name lookup failure
Message could not be delivered for 1 day
Message will be deleted from queue


Reporting-MTA: dns; mx0b-001b2d01.pphosted.com
Arrival-Date: Mon, 5 Oct 2020 12:51:56 -0400

Final-Recipient: RFC822; david@gibson.dropbear.id.au
Action: failed
Status: 4.4.7
Remote-MTA: DNS; gibson.dropbear.id.au
Last-Attempt-Date: Tue, 6 Oct 2020 13:06:28 -0400


>> These changes add a new StoreEOI capability which activate StoreEOI
>> support in the flags returned by the hcall H_INT_GET_SOURCE_INFO. When
>> the machine is using an emulated interrupt controller, TCG or without
>> kernel IRQ chip, there are no limitations and activating StoreEOI is
>> not an issue. However, when running with a kernel IRQ chip, some
>> verification needs to be done on the host. This is done through the
>> DT, which tells us that firmware has configured the HW for StoreEOI,
>> but a new KVM capability would be cleaner.
>>
>> The last patch introduces a new 'cas' value to the capability which
>> lets the hypervisor decide at CAS time if StoreEOI should be
>> advertised to the guest OS. P10 compat kernel are considered safe
>> because the OS enforces load-after-store ordering but not with P9.
>>
>> The StoreEOI capability is a global setting and does not take into
>> account the characteristics of a single source. It could be an issue
>> if StoreEOI is not supported on a specific source, of a passthrough
>> device for instance. In that case, we could either introduce a new KVM
>> ioctl to query the characteristics of the source at the HW level (like
>> in v1) or deactivate StoreEOI on the machine.
>>
>> We are using these patches today on P10 and P9 (with a custom FW
>> activating StoreEOI) systems to benchmark interrupt performance on
>> large guests but there's no hurry to take them. Let's discuss this new
>> approach.
>>
>> Thanks,
>>
>> C.
>>
>> Changes in v2:
>>
>>  - completely approach using a capability
>>
>> Cédric Le Goater (6):
>>   spapr/xive: Introduce a StoreEOI capability
>>   spapr/xive: Add a warning when StoreEOI is activated on POWER8 CPUs
>>   spapr/xive: Add a warning when StoreEOI is activated on POWER9 CPUs
>>   spapr/xive: Enforce load-after-store ordering
>>   spapr/xive: Activate StoreEOI at the source level
>>   spapr/xive: Introduce a new CAS value for the StoreEOI capability
>>
>>  include/hw/ppc/spapr.h      |  5 +++-
>>  include/hw/ppc/spapr_xive.h |  1 +
>>  include/hw/ppc/xive.h       |  8 +++++
>>  target/ppc/kvm_ppc.h        |  6 ++++
>>  hw/intc/spapr_xive.c        | 10 +++++++
>>  hw/intc/spapr_xive_kvm.c    | 12 ++++++++
>>  hw/intc/xive.c              |  6 ++++
>>  hw/ppc/spapr.c              |  1 +
>>  hw/ppc/spapr_caps.c         | 60 +++++++++++++++++++++++++++++++++++++
>>  hw/ppc/spapr_hcall.c        |  7 +++++
>>  hw/ppc/spapr_irq.c          |  6 ++++
>>  target/ppc/kvm.c            | 18 +++++++++++
>>  12 files changed, 139 insertions(+), 1 deletion(-)
>>
> 


