Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E34AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8D424655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yq3QPzhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8D424655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuDLF-0007Lz-GZ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 05:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuDKW-0006sX-27
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuDKU-0007Zo-Sr
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:33:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25663
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuDKU-0007Zb-Pe
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579689226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=3/8yPemxHC6JRS37fD2zl9msSgWkWK9ptGjPXYFd5/8=;
 b=Yq3QPzhBxvdLcJEjRpMbVJAqEDuv5Ifz5t6uYqAh2fePZrnV7bK27UzrPAZ1+EuLemPQjU
 khWFdmeIgE+FFIh1gwIma5b7vh85rumyeEBmj/j4BhLDFD/+2cKINyzkXiy/+XiBpxdDfN
 ho84kRYkNoWtFePb2a9IdmY5l2rDep8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-QW1s1Q5tPs-jrYs9LL_sFA-1; Wed, 22 Jan 2020 05:33:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1871C8010D6;
 Wed, 22 Jan 2020 10:33:41 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12FBC86430;
 Wed, 22 Jan 2020 10:33:36 +0000 (UTC)
Subject: Re: [PATCH v5] target/s390x/kvm: Enable adapter interruption
 suppression again
To: Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20200122101437.5069-1-thuth@redhat.com>
 <20200122112910.5b8f74c9.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f4e87ccf-5484-c305-aff1-13feccd5dabb@redhat.com>
Date: Wed, 22 Jan 2020 11:33:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200122112910.5b8f74c9.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: QW1s1Q5tPs-jrYs9LL_sFA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/01/2020 11.29, Cornelia Huck wrote:
> On Wed, 22 Jan 2020 11:14:37 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> The AIS feature has been disabled late in the v2.10 development cycle since
>> there were some issues with migration (see commit 3f2d07b3b01ea61126b -
>> "s390x/ais: for 2.10 stable: disable ais facility"). We originally wanted
>> to enable it again for newer machine types, but apparently we forgot to do
>> this so far. Let's do it now for the machines that support proper CPU models.
>>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v5: Use cpu_model_allowed() as suggested by David. Seems to work as far
>>      as I can test it without PCI cards, but ping-pong migration with
>>      "-cpu host" from/to an older version of QEMU is now not working
>>      anymore - but I think that's kind of expected since "-cpu host"
>>      is not migration-safe anyway.
> 
> Ok, so I'll wait for test results with pci cards before queuing this :)

Ok, Matthew, could you please test one more time?

>>  target/s390x/kvm.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 15260aeb9a..30112e529c 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -365,10 +365,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>      /*
>>       * The migration interface for ais was introduced with kernel 4.13
>>       * but the capability itself had been active since 4.12. As migration
>> -     * support is considered necessary let's disable ais in the 2.10
>> -     * machine.
>> +     * support is considered necessary, we only try to enable this for
>> +     * newer machine types if KVM_CAP_S390_AIS_MIGRATION is available.
>>       */
>> -    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
>> +    if (cpu_model_allowed() && kvm_kernel_irqchip_allowed() &&
>> +        kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {
>> +        kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
>> +    }
>>  
>>      kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
>>      return 0;
> 
> Side note: as you do not add a new _allowed() function, you don't add
> the clarifying comment anymore -- any value in doing so as a separate
> patch? And maybe stating as well that new features of that type should
> rely on the cpu model?

Yes, I'm planning to send a patch once this one here got accepted.

 Thomas


