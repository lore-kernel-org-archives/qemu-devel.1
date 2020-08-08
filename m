Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43700C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 10:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1129020723
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 10:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1129020723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4MR6-00049v-CD
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 06:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k4MQI-0003YD-Kq; Sat, 08 Aug 2020 06:49:58 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:38457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k4MQG-0002p4-5D; Sat, 08 Aug 2020 06:49:58 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.124])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id CD1D3550C641;
 Sat,  8 Aug 2020 12:49:43 +0200 (CEST)
Received: from kaod.org (37.59.142.95) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 8 Aug 2020
 12:49:43 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001c55ddfdc-dd91-47a1-b2ff-4f6206f45a05,
 C8A1FAB73906E5665C3B6F042B66887CBAB5505C) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v3 for-5.2 2/3] ppc/xive: Introduce dedicated
 kvm_irqchip_in_kernel() wrappers
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <159679991916.876294.8967140647442842745.stgit@bahia.lan>
 <159679993438.876294.7285654331498605426.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e718da5f-c5f3-db74-be94-938700384ce7@kaod.org>
Date: Sat, 8 Aug 2020 12:49:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159679993438.876294.7285654331498605426.stgit@bahia.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 2f793697-0b2b-47e7-a790-9354654c4917
X-Ovh-Tracer-Id: 9459529542488001443
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkeeggddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegvdeijeefvdfhudfhffeuveehledufffhvdekheelgedttddthfeigeevgefhffenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehgrhhouhhgsehkrghougdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/08 06:49:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some more comments, because I still think there are some shortcuts.

My feeling is that all the kvmppc_xive* could be part of a QOM interface
defining how to use a kernel device backend. When the kernel IRQ device 
is not available, under TCG or under an hypervisor not advertising 
support at the KVM level, the QOM interface kernel device backend 
would be a no-op, else it would implement what the kvmppc_xive_* do
today. So, it's something we would change like ->intc after an interrupt 
mode has been negotiated. 

It's an intuition regarding POWER10/XIVE2 and nested support which 
could need a different interface of the KVM XIVE device in the future. 
I don't think we need today but it would clarify some of the shortcuts. 
  
> +/*
> + * kvm_irqchip_in_kernel() will cause the compiler to turn this
> + * info a nop if CONFIG_KVM isn't defined.
> + */
> +#define spapr_xive_in_kernel(xive) \
> +    (kvm_irqchip_in_kernel() && (xive)->fd != -1)
> +

Here, we have a shortcut. kvm_irqchip_in_kernel() is a compilation 
trick but the real handler :

	{
		return SPAPR_XIVE(xrtr)->fd != -1;
	}

is a shortcut. We are using ->fd to know if QEMU is connected with 
a KVM device or not.


>  void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon)
>  {
>      XiveSource *xsrc = &xive->source;
>      int i;
>  
> -    if (kvm_irqchip_in_kernel()) {
> +    if (spapr_xive_in_kernel(xive)) {
>          Error *local_err = NULL;
>  
>          kvmppc_xive_synchronize_state(xive, &local_err);

With a QOM interface for a kernel device backend, this would become :

	XIVE_BACKEND_GET_CLASS(xive->backend)->synchronize_state(xive);

and we could drop all the 'if' statement.



Makes sense ? I think XICS behaves the same.

Thanks,

C. 


