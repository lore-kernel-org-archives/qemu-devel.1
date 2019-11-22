Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AEAC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA792068E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8j4K5Ez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA792068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY7Td-0001qt-JP
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iY7Pm-0006EJ-FF
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:47:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iY7Pl-0002vT-AG
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:47:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24764
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iY7Pl-0002uf-4A
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574423270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jc19GHwoov/psI2gg+4nMgqBq1LLwRQsb8kEa0rE78M=;
 b=D8j4K5EztVhA1OAQMW/5dOTmIDFJV67AUCsbvZs+Y8GCGVIFEw36CUfHkZH/VmhGEW55LT
 8QHHPfK9Nr1BySGsb3mrzKuEtdeAA76wYLvi8oGMTxIQus6D/EHja2pbCLVOyL+GAbECzg
 f1IFIhazYVOudGswhX/5peMDSOdvp0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-H2-cjAmwOeCJWUSV-3LfIQ-1; Fri, 22 Nov 2019 06:47:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33BBC18B9FC2;
 Fri, 22 Nov 2019 11:47:47 +0000 (UTC)
Received: from [10.36.118.121] (unknown [10.36.118.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D39876FF3;
 Fri, 22 Nov 2019 11:47:45 +0000 (UTC)
Subject: Re: [PATCH 4/4] s390x: Beautify machine reset
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191122075218.23935-1-frankja@linux.ibm.com>
 <20191122075218.23935-5-frankja@linux.ibm.com>
 <d026944f-1a0a-0dbe-6514-d8e4fd293e35@redhat.com>
 <c2459655-f205-3294-23ba-ba5d3280df41@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <def970f9-6889-c8ed-0f6a-087e4cd3bd87@redhat.com>
Date: Fri, 22 Nov 2019 12:47:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c2459655-f205-3294-23ba-ba5d3280df41@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: H2-cjAmwOeCJWUSV-3LfIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.11.19 12:46, Janosch Frank wrote:
> On 11/22/19 11:59 AM, David Hildenbrand wrote:
>> On 22.11.19 08:52, Janosch Frank wrote:
>>> * Add comments that tell you which diag308 subcode caused the reset
>>> * Sort by diag308 reset subcode
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>    hw/s390x/s390-virtio-ccw.c | 20 ++++++++++----------
>>>    1 file changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>> index c1d1440272..88f7758721 100644
>>> --- a/hw/s390x/s390-virtio-ccw.c
>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>> @@ -330,15 +330,7 @@ static void s390_machine_reset(MachineState *machi=
ne)
>>>        s390_cmma_reset();
>>>   =20
>>>        switch (reset_type) {
>>> -    case S390_RESET_EXTERNAL:
>>> -    case S390_RESET_REIPL:
>>> -        qemu_devices_reset();
>>> -        s390_crypto_reset();
>>> -
>>> -        /* configure and start the ipl CPU only */
>>> -        run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
>>> -        break;
>>> -    case S390_RESET_MODIFIED_CLEAR:
>>> +    case S390_RESET_MODIFIED_CLEAR: /* Subcode 0 */
>>
>> IMHO "Subcode X" isn't of much help here. We're out of diag handling.
>>
>> I'd suggest to just document the subcodes along with the definitions, if
>> really needed, and drop this patch, at least I don't quite see the value
>> of moving code around here... or is the code shuffling of any value on
>> your prot virt patches?
>>
>=20
> It keeps me from consulting the POP every time I need to change things
> in the machine resets. This is basically a 1:1 mapping of diag 308
> subcodes to machine resets, so why don't we want to make that obvious
> and order them by the subcodes?
>=20

Because it is not a 1:1 mapping: S390_RESET_EXTERNAL

--=20

Thanks,

David / dhildenb


