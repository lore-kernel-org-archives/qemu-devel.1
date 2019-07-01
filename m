Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A93C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 06:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91471208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 06:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91471208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhpZW-0004KI-Kb
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 02:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41251)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hhpYy-0003kL-W2
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 02:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hhpYx-0005GM-Pl
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 02:13:16 -0400
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:44601)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hhpYx-0005F6-KM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 02:13:15 -0400
Received: from player168.ha.ovh.net (unknown [10.108.54.156])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 9BF286025D
 for <qemu-devel@nongnu.org>; Mon,  1 Jul 2019 08:13:12 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player168.ha.ovh.net (Postfix) with ESMTPSA id 8944F74FEBC7;
 Mon,  1 Jul 2019 06:13:07 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
References: <156070574343.343123.16772707632470400458.stgit@bahia.lan>
 <20190619093617.GC22560@umbus.BigPond>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a2d8e209-4431-ec77-b5a6-8f755731e433@kaod.org>
Date: Mon, 1 Jul 2019 08:13:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190619093617.GC22560@umbus.BigPond>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11851222422328019776
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvdehgddutdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.50.107
Subject: Re: [Qemu-devel] [PATCH] spapr/xive: Add proper rollback to
 kvmppc_xive_connect()
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/06/2019 11:36, David Gibson wrote:
> On Sun, Jun 16, 2019 at 07:22:23PM +0200, Greg Kurz wrote:
>> Make kvmppc_xive_disconnect() able to undo the changes of a partial
>> execution of kvmppc_xive_connect() and use it to perform rollback.
>>
>> Based-on: <20190614165920.12670-2-clg@kaod.org>
>> Signed-off-by: Greg Kurz <groug@kaod.org>
> 
> I'm afraid this doesn't apply clean on my current ppc-for-4.1.

With the patch you have taken, this one should now apply.

Thanks,

C.

> 
>> ---
>>  hw/intc/spapr_xive_kvm.c |   48 ++++++++++++++++++++++++++++------------------
>>  1 file changed, 29 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
>> index 5559f8bce5ef..3bf8e7a20e14 100644
>> --- a/hw/intc/spapr_xive_kvm.c
>> +++ b/hw/intc/spapr_xive_kvm.c
>> @@ -724,8 +724,7 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
>>      xsrc->esb_mmap = kvmppc_xive_mmap(xive, KVM_XIVE_ESB_PAGE_OFFSET, esb_len,
>>                                        &local_err);
>>      if (local_err) {
>> -        error_propagate(errp, local_err);
>> -        return;
>> +        goto fail;
>>      }
>>  
>>      memory_region_init_ram_device_ptr(&xsrc->esb_mmio_kvm, OBJECT(xsrc),
>> @@ -743,8 +742,7 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
>>      xive->tm_mmap = kvmppc_xive_mmap(xive, KVM_XIVE_TIMA_PAGE_OFFSET, tima_len,
>>                                       &local_err);
>>      if (local_err) {
>> -        error_propagate(errp, local_err);
>> -        return;
>> +        goto fail;
>>      }
>>      memory_region_init_ram_device_ptr(&xive->tm_mmio_kvm, OBJECT(xive),
>>                                        "xive.tima", tima_len, xive->tm_mmap);
>> @@ -760,21 +758,24 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
>>  
>>          kvmppc_xive_cpu_connect(spapr_cpu_state(cpu)->tctx, &local_err);
>>          if (local_err) {
>> -            error_propagate(errp, local_err);
>> -            return;
>> +            goto fail;
>>          }
>>      }
>>  
>>      /* Update the KVM sources */
>>      kvmppc_xive_source_reset(xsrc, &local_err);
>>      if (local_err) {
>> -            error_propagate(errp, local_err);
>> -            return;
>> +        goto fail;
>>      }
>>  
>>      kvm_kernel_irqchip = true;
>>      kvm_msi_via_irqfd_allowed = true;
>>      kvm_gsi_direct_mapping = true;
>> +    return;
>> +
>> +fail:
>> +    error_propagate(errp, local_err);
>> +    kvmppc_xive_disconnect(xive, NULL);
>>  }
>>  
>>  void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp)
>> @@ -796,23 +797,29 @@ void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp)
>>      xsrc = &xive->source;
>>      esb_len = (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
>>  
>> -    memory_region_del_subregion(&xsrc->esb_mmio, &xsrc->esb_mmio_kvm);
>> -    object_unparent(OBJECT(&xsrc->esb_mmio_kvm));
>> -    munmap(xsrc->esb_mmap, esb_len);
>> -    xsrc->esb_mmap = NULL;
>> +    if (xsrc->esb_mmap) {
>> +        memory_region_del_subregion(&xsrc->esb_mmio, &xsrc->esb_mmio_kvm);
>> +        object_unparent(OBJECT(&xsrc->esb_mmio_kvm));
>> +        munmap(xsrc->esb_mmap, esb_len);
>> +        xsrc->esb_mmap = NULL;
>> +    }
>>  
>> -    memory_region_del_subregion(&xive->tm_mmio, &xive->tm_mmio_kvm);
>> -    object_unparent(OBJECT(&xive->tm_mmio_kvm));
>> -    munmap(xive->tm_mmap, 4ull << TM_SHIFT);
>> -    xive->tm_mmap = NULL;
>> +    if (xive->tm_mmap) {
>> +        memory_region_del_subregion(&xive->tm_mmio, &xive->tm_mmio_kvm);
>> +        object_unparent(OBJECT(&xive->tm_mmio_kvm));
>> +        munmap(xive->tm_mmap, 4ull << TM_SHIFT);
>> +        xive->tm_mmap = NULL;
>> +    }
>>  
>>      /*
>>       * When the KVM device fd is closed, the KVM device is destroyed
>>       * and removed from the list of devices of the VM. The VCPU
>>       * presenters are also detached from the device.
>>       */
>> -    close(xive->fd);
>> -    xive->fd = -1;
>> +    if (xive->fd != -1) {
>> +        close(xive->fd);
>> +        xive->fd = -1;
>> +    }
>>  
>>      kvm_kernel_irqchip = false;
>>      kvm_msi_via_irqfd_allowed = false;
>> @@ -822,5 +829,8 @@ void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp)
>>      kvm_cpu_disable_all();
>>  
>>      /* VM Change state handler is not needed anymore */
>> -    qemu_del_vm_change_state_handler(xive->change);
>> +    if (xive->change) {
>> +        qemu_del_vm_change_state_handler(xive->change);
>> +        xive->change = NULL;
>> +    }
>>  }
>>
> 


