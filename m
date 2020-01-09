Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01333C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CACA720721
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACA720721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZsM-0002Es-OU
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <like.xu@linux.intel.com>) id 1ipZft-000237-IR
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:24:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <like.xu@linux.intel.com>) id 1ipZfs-0005mM-86
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:24:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:1926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
 id 1ipZfr-0005KE-V5
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:24:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jan 2020 07:24:34 -0800
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; d="scan'208";a="216331222"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.255.28.158])
 ([10.255.28.158])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 09 Jan 2020 07:24:32 -0800
Subject: Re: Difference between 'current_machine' vs
 MACHINE(qdev_get_machine())
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
References: <a88f7647-c061-bf3f-a272-72700078ef26@redhat.com>
 <e6a7197d-1647-4667-dae8-10c8dba1737f@redhat.com>
From: Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <a6d997f6-40b3-4a68-a911-7b9d7ebf9514@linux.intel.com>
Date: Thu, 9 Jan 2020 23:24:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <e6a7197d-1647-4667-dae8-10c8dba1737f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/1/9 20:01, Paolo Bonzini wrote:
> On 09/01/20 12:23, Philippe Mathieu-Daudé wrote:
>>
>>
>>      current_machine =
>> MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
>>      object_property_add_child(object_get_root(), "machine",
>>                                OBJECT(current_machine), &error_abort);
>>
>> The bigger user of 'current_machine' is the accel/KVM code.
>>
>> Recently in a0628599f..cc7d44c2e0 "Replace global smp variables with
>> machine smp properties" we started to use MACHINE(qdev_get_machine()).
>>
>> qdev_get_machine() resolves the machine in the QOM composition tree.
>> I am confused by this comment:
>>
>>    /* qdev_get_machine() can return something that's not TYPE_MACHINE
>>     * if this is one of the user-only emulators; in that case there's
>>     * no need to check the ignore_memory_transaction_failures board flag.
>>     */
>>
>> Following a0628599f..cc7d44c2e0, a5e0b33119 use 'current_machine' again.
>>
>> What are the differences between both form, when should we use one or
>> another (or can we use a single one?). Can this break user-only mode?
> 
> I would always use MACHINE(qdev_get_machine()), espeecially outside
> vl.c.  Ideally, current_machine would be static within vl.c or even
> unused outside the object_property_add_child() that you quote above.
> 
> Most of the times, I noticed from a quick grep, we actually want to
> access the accelerator, not the machine, so we could add a
> qemu_get_accelerator() wrapper that does
> MACHINE(qdev_get_machine())->accelerator.
> 
> Paolo
> 

I prefer to use MACHINE(qdev_get_machine()) wherever possible.

However, the qdev_get_machine() would return non TYPE_MACHINE object if:
- call qdev_get_machine() before we do 
"object_property_add_child(object_get_root(), "machine", 
OBJECT(current_machine), &error_abort);" in vl.c;
- or in the context with '#ifdef CONFIG_USER_ONLY';

Thanks,
Like Xu


