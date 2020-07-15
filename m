Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B50C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22B220663
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3QRbmde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22B220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvdZv-00071p-8V
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 05:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jvdZL-0006YU-Td
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:19:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32242
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jvdZK-0006kM-5U
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594804753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OL5Gvbbqd2+SXQoCwR5+SUC04vNCts6iErDBnsNXxhU=;
 b=W3QRbmdeXlUZsVXPsdlmyvXt5FkJtAB98D3kxocmLoqnjpu/SjBtQX2AIEfkz8ATxjeVjs
 825Z/qUrLC66Ee9MJHj9ELYOqZ+smvusqIPIRYpKk4aiS2tpDuJvg2USi7UaDeshEc9G8x
 O/4C7XGEyQ1pR2RoWp8aPW71dxMaiU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-RkoVEQOwO6yzIEOMVowXtQ-1; Wed, 15 Jul 2020 05:19:11 -0400
X-MC-Unique: RkoVEQOwO6yzIEOMVowXtQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1D3F8015FB;
 Wed, 15 Jul 2020 09:19:09 +0000 (UTC)
Received: from [10.36.115.47] (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 301BF5D9C5;
 Wed, 15 Jul 2020 09:19:04 +0000 (UTC)
Subject: Re: [PATCH RFCv2 3/6] s390x/diag: implement diag260
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20200710151239.39370-1-david@redhat.com>
 <20200710151239.39370-4-david@redhat.com> <20200714121718.45f9f3ed@ibm-vm>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <ab4b68ac-b143-c9cb-9e02-af5ba89c23d7@redhat.com>
Date: Wed, 15 Jul 2020 11:19:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200714121718.45f9f3ed@ibm-vm>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14.07.20 12:17, Claudio Imbrenda wrote:
> On Fri, 10 Jul 2020 17:12:36 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Let's implement diag260 - "Access Certain Virtual Machine
>> Information", used under z/VM to expose the storage configuration
>> (especially, layout of storage extends and thereby holes). For now,
>> the returned information is completely redundant to the information
>> exposed via SCLP.
>>
>> We want to reuse diag260 in QEMU to implement memory devices - to
>> have a mechanism to indicate to the guest OS that the initial ram
>> size and the maximum possible physical address differ.
>>
>> The Linux kernel supports diag260 (0x10) to query the available memory
>> since v4.20. Ancient Linux versions used diag 260 (0xc), but stopped
>> doing so a while ago.
>>
>> Let's unconditionally implement the new diag, without any migration
>> checks (e.g., compatibility machine, CPU model). Although a guest OS
>> could observe this when migrating between QEMU evrsions, it's somewhat
>> unlikely to ever trigger due to the way diag260 is used within a guest
>> OS - called only once or twice during boot.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/diag.c        | 51
>> ++++++++++++++++++++++++++++++++++++++ target/s390x/internal.h    |
>> 2 ++ target/s390x/kvm.c         | 11 ++++++++
>>  target/s390x/misc_helper.c |  6 +++++
>>  target/s390x/translate.c   |  7 ++++++
>>  5 files changed, 77 insertions(+)
>>
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index be70aecd72..5378fcf582 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -23,6 +23,57 @@
>>  #include "hw/s390x/pv.h"
>>  #include "kvm_s390x.h"
>>  
>> +void handle_diag_260(CPUS390XState *env, uint64_t r1, uint64_t r3,
>> uintptr_t ra) +{
>> +    MachineState *ms = MACHINE(qdev_get_machine());
>> +    const ram_addr_t initial_ram_size = ms->ram_size;
>> +    const uint64_t subcode = env->regs[r3];
>> +
>> +    switch (subcode) {
>> +    case 0xc:
>> +        /* The first storage extent maps to our initial ram. */
>> +        env->regs[r1] = initial_ram_size - 1;
>> +        /* The highest addressable byte maps to the initial ram size
>> for now. */
>> +        env->regs[r3] = initial_ram_size - 1;
>> +        break;
>> +    case 0x10: {
>> +        ram_addr_t addr, length;
>> +        uint64_t tmp;
>> +
>> +        if (r1 & 1) {
>> +            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>> +            return;
>> +        }
>> +
>> +        addr = env->regs[r1];
>> +        length = env->regs[r1 + 1];
>> +        if (!QEMU_IS_ALIGNED(addr, 16) || !QEMU_IS_ALIGNED(length,
>> 16) ||
>> +            !length) {
>> +            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>> +            return;
>> +        }
>> +        if (!address_space_access_valid(&address_space_memory, addr,
>> length,
>> +                                        true,
>> MEMTXATTRS_UNSPECIFIED)) {
>> +            s390_program_interrupt(env, PGM_ADDRESSING, ra);
>> +            return;
>> +        }
>> +
>> +        /* Indicate our initial memory ([0 .. ram_size - 1]) */
>> +        tmp = cpu_to_be64(0);
>> +        cpu_physical_memory_write(addr, &tmp, sizeof(tmp));
>> +        tmp = cpu_to_be64(initial_ram_size - 1);
>> +        cpu_physical_memory_write(addr + sizeof(tmp), &tmp,
>> sizeof(tmp)); +
>> +        /* Exactly one entry was stored, it always fits into the
>> area. */
> 
> maybe I missed something, but I have the impression that your
> implementation of DIAG 260 always only returns the first extent?

We only indicate boot memory (e.g., -m 2G), never any memory part of the
device memory address space, because such memory has different semantics.

> 
> shouldn't it return all the hotplugged areas once hotplugging is
> enabled?

No, that would be dangerous and wrong. Memory ranges part of memory
devices never must be indicated as part of hw/firmware interfaces to
indicate valid boot memory. Memory provided via memory devices
(virtio-mem, virtio-pmem, ...) has different semantics than ordinary
hotplugged memory, and unmodified OSs (esp., older Linux versions)
should not silently try to make use of any such memory. It's not just
some hotplugged memory a guest OS should detect+use during boot as
system ram. Thanks!

-- 
Thanks,

David / dhildenb


