Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F43C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24ECA20714
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKsq8K7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24ECA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY80u-0008PW-8Y
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 07:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iY80E-0007zh-PT
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iY80D-0008Hu-J7
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:25:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25786
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iY80D-0008Hh-F6
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574425533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6HTQs+G0Wi6fMIML/e2nJJ5wBzuYtl9tZu722QDXXUY=;
 b=eKsq8K7qUchtbxVtxdKKplTKthRjGmGTRCCJXtwtBlidX/3FdfCmkzeYd9+w61yIzXGKAT
 WEFgBACzGKCmqwo+vQ5+beRnpx1dCmmSEj9TRjZ5th1/R+3knNoEOW2CectT8JtbOQHJGL
 uPe5J9BAgheDbfNh+4H7/rrSL1EkonY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-Tz-OnkgrNk2yRPj7FxDHZg-1; Fri, 22 Nov 2019 07:25:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2588107ACC5;
 Fri, 22 Nov 2019 12:25:27 +0000 (UTC)
Received: from [10.36.118.121] (unknown [10.36.118.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5946319C70;
 Fri, 22 Nov 2019 12:25:26 +0000 (UTC)
Subject: Re: [PATCH 4/4] s390x: Beautify machine reset
To: Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
References: <20191122075218.23935-1-frankja@linux.ibm.com>
 <20191122075218.23935-5-frankja@linux.ibm.com>
 <d026944f-1a0a-0dbe-6514-d8e4fd293e35@redhat.com>
 <c2459655-f205-3294-23ba-ba5d3280df41@linux.ibm.com>
 <def970f9-6889-c8ed-0f6a-087e4cd3bd87@redhat.com>
 <20191122131035.4f334a99.cohuck@redhat.com>
 <8217f5a5-1700-9371-d642-8520df9df0ed@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <925e1c0e-bf63-a244-df72-2f477d014666@redhat.com>
Date: Fri, 22 Nov 2019 13:25:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <8217f5a5-1700-9371-d642-8520df9df0ed@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Tz-OnkgrNk2yRPj7FxDHZg-1
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, qemu-devel@nongnu.org,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.11.19 13:22, Janosch Frank wrote:
> On 11/22/19 1:10 PM, Cornelia Huck wrote:
>> On Fri, 22 Nov 2019 12:47:44 +0100
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> On 22.11.19 12:46, Janosch Frank wrote:
>>>> On 11/22/19 11:59 AM, David Hildenbrand wrote:
>>>>> On 22.11.19 08:52, Janosch Frank wrote:
>>>>>> * Add comments that tell you which diag308 subcode caused the reset
>>>>>> * Sort by diag308 reset subcode
>>>>>>
>>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>>> ---
>>>>>>     hw/s390x/s390-virtio-ccw.c | 20 ++++++++++----------
>>>>>>     1 file changed, 10 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>>>>> index c1d1440272..88f7758721 100644
>>>>>> --- a/hw/s390x/s390-virtio-ccw.c
>>>>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>>>>> @@ -330,15 +330,7 @@ static void s390_machine_reset(MachineState *ma=
chine)
>>>>>>         s390_cmma_reset();
>>>>>>    =20
>>>>>>         switch (reset_type) {
>>>>>> -    case S390_RESET_EXTERNAL:
>>>>>> -    case S390_RESET_REIPL:
>>>>>> -        qemu_devices_reset();
>>>>>> -        s390_crypto_reset();
>>>>>> -
>>>>>> -        /* configure and start the ipl CPU only */
>>>>>> -        run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
>>>>>> -        break;
>>>>>> -    case S390_RESET_MODIFIED_CLEAR:
>>>>>> +    case S390_RESET_MODIFIED_CLEAR: /* Subcode 0 */
>>>>>
>>>>> IMHO "Subcode X" isn't of much help here. We're out of diag handling.
>>>>>
>>>>> I'd suggest to just document the subcodes along with the definitions,=
 if
>>>>> really needed, and drop this patch, at least I don't quite see the va=
lue
>>>>> of moving code around here... or is the code shuffling of any value o=
n
>>>>> your prot virt patches?
>>>>>  =20
>>>>
>>>> It keeps me from consulting the POP every time I need to change things
>>>> in the machine resets. This is basically a 1:1 mapping of diag 308
>>>> subcodes to machine resets, so why don't we want to make that obvious
>>>> and order them by the subcodes?
>>>>   =20
>>>
>>> Because it is not a 1:1 mapping: S390_RESET_EXTERNAL
>>>
>>
>> Tack the explanation onto the definitions of S390_RESET_, then?
>> Probably still quicker than consulting the POP :)
>>
>=20
> Does it really bother you that much, that I add some explanations to the
> things we're doing. The external reset also gets a comment so Conni
> won't need that much coffee anymore to understand the code :-)
>=20

I'm really sorry, but I fail to see how "Subcode 0" is *any* better than=20
S390_RESET_MODIFIED_CLEAR (and avoids consulting the PoP) and why the=20
order should matter at all here to make it easier to understand.

I don't NACK this, I just find it *completely* useless :)

--=20

Thanks,

David / dhildenb


