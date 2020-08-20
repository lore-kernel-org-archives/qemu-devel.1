Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48496C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 06:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D7D120738
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 06:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7D120738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8eYG-0000JD-Di
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 02:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8eXV-0008D9-KK; Thu, 20 Aug 2020 02:59:09 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:57953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8eXR-00024o-1q; Thu, 20 Aug 2020 02:59:09 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.51])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 2E5565227D46;
 Thu, 20 Aug 2020 08:59:01 +0200 (CEST)
Received: from kaod.org (37.59.142.97) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 20 Aug
 2020 08:59:00 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0015eb00571-523a-4c00-a404-995241fc8298,
 02C359FD435C2C4122574921AFFD4D91C9CEEBEA) smtp.auth=clg@kaod.org
Subject: Re: [PATCH 3/8] spapr/xive: Query the characteristics of a source in
 KVM
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200819130843.2230799-1-clg@kaod.org>
 <20200819130843.2230799-4-clg@kaod.org>
 <20200820013333.GG271315@yekko.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <674e94bf-ce24-e45d-e29c-5debb44b3298@kaod.org>
Date: Thu, 20 Aug 2020 08:58:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820013333.GG271315@yekko.fritz.box>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 6e103211-276f-41e9-9476-d91da0dcae6d
X-Ovh-Tracer-Id: 2248703589571988387
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddtledgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeehnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeelgfejveehieefffduueehvdevfedtleeiudekjeegveeigfeifefhtdfffedtnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepghhrohhugheskhgrohgurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 02:45:31
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/20 3:33 AM, David Gibson wrote:
> On Wed, Aug 19, 2020 at 03:08:38PM +0200, Cédric Le Goater wrote:
>> When running a guest with a kernel IRQ chip enabled, the XIVE
>> characteristics of the interrupts are advertised to the guest in the
>> H_INT_GET_SOURCE_INFO hcall. These characteristics depend on the
>> underlying HW interrupts but today, QEMU simply advertises its own
>> without checking what the host supports. It is not a problem for the
>> moment, but POWER10 will (re)add support for StoreEOI and we need a
>> way to in sync with the host.
>>
>> The KVM_DEV_XIVE_GRP_SOURCE_INFO command lets QEMU query the XIVE
>> characteristics of the underlying HW interrupts and override any
>> previous setting done by QEMU. This allows the fallback mode, when the
>> XIVE device is emulated by QEMU, to use its own custom settings on the
>> sources but makes sure that we don't let a guest run with features
>> incompatible with KVM.
>>
>> It only applies to the StoreEOI feature for the moment.
> 
> Urgh.  This means that the source characteristics can change across a
> migration, that's kind of a problem.

yes.

The official plan is : 

  * P9 compat : no StoreEOI 
  * P10 : StoreEOI 

and the obvious solution I started with was to change the global source 
flags at CAS time. 

But, we have experimental P9 firmwares in which StoreEOI is activated
and migration of a P9 compat guest from a P10 host to another P10 host 
should work. I am looking for a smarter solution.

Forbidding StoreEOI on P9 compat guests is ok, since this is already 
the default, but an option to change it would be nice to have. 

As for P10, all HW sources and IC sources now have StoreEOI but we
might want to disable it for some reason. This is already in place 
at the firmware and PowerNV level, QEMU is the next layer to address.

Thanks,

C. 




> 
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr_xive.h |  2 ++
>>  hw/intc/spapr_xive.c        | 20 ++++++++++++++++++++
>>  hw/intc/spapr_xive_kvm.c    | 26 ++++++++++++++++++++++++++
>>  3 files changed, 48 insertions(+)
>>
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index 1dddcbcb9cdd..3f325723ea74 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -84,6 +84,8 @@ void kvmppc_xive_disconnect(SpaprInterruptController *intc);
>>  void kvmppc_xive_reset(SpaprXive *xive, Error **errp);
>>  int kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS *eas,
>>                                    Error **errp);
>> +int kvmppc_xive_get_source_info(SpaprXive *xive, uint32_t lisn, uint64_t *flags,
>> +                                 Error **errp);
>>  void kvmppc_xive_sync_source(SpaprXive *xive, uint32_t lisn, Error **errp);
>>  uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t offset,
>>                              uint64_t data, bool write);
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index 1fa09f287ac0..943b9958a68b 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -932,6 +932,26 @@ static target_ulong h_int_get_source_info(PowerPCCPU *cpu,
>>          args[0] |= SPAPR_XIVE_SRC_STORE_EOI;
>>      }
>>  
>> +    if (kvm_irqchip_in_kernel()) {
>> +        Error *local_err = NULL;
>> +        uint64_t flags = 0;
>> +
>> +        kvmppc_xive_get_source_info(xive, lisn, &flags, &local_err);
>> +        if (local_err) {
>> +            error_report_err(local_err);
>> +            return H_HARDWARE;
>> +        }
>> +
>> +        /*
>> +         * Override QEMU settings with KVM values
>> +         */
>> +        if (flags & XIVE_SRC_STORE_EOI) {
>> +            args[0] |= SPAPR_XIVE_SRC_STORE_EOI;
>> +        } else {
>> +            args[0] &= ~SPAPR_XIVE_SRC_STORE_EOI;
>> +        }
>> +    }
>> +
>>      /*
>>       * Force the use of the H_INT_ESB hcall in case of an LSI
>>       * interrupt. This is necessary under KVM to re-trigger the
>> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
>> index e8667ce5f621..90f4509e6959 100644
>> --- a/hw/intc/spapr_xive_kvm.c
>> +++ b/hw/intc/spapr_xive_kvm.c
>> @@ -217,6 +217,32 @@ int kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS *eas,
>>                               &kvm_src, true, errp);
>>  }
>>  
>> +int kvmppc_xive_get_source_info(SpaprXive *xive, uint32_t lisn, uint64_t *flags,
>> +                                 Error **errp)
>> +{
>> +    struct kvm_ppc_xive_src kvm_src = { 0 };
>> +    int ret;
>> +
>> +    /*
>> +     * Check that KVM supports the new attribute to query source
>> +     * characteristics.
>> +     */
>> +    if (!kvm_device_check_attr(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_INFO, 0)) {
>> +        return 0;
>> +    }
>> +
>> +    ret = kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_INFO, lisn,
>> +                            &kvm_src, false, errp);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    if (kvm_src.flags & KVM_XIVE_SOURCE_FLAG_STORE_EOI) {
>> +        *flags |= XIVE_SRC_STORE_EOI;
>> +    }
>> +    return 0;
>> +}
>> +
>>  void kvmppc_xive_sync_source(SpaprXive *xive, uint32_t lisn, Error **errp)
>>  {
>>      kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_SYNC, lisn,
> 


