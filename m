Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F9CC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2016724619
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2016724619
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48379 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY4Yf-0002Zs-Dy
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 04:12:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hY4Xg-00021r-HP
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hY4Xd-0001bT-VQ
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:11:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hY4Xc-0001Yr-By; Tue, 04 Jun 2019 04:11:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A0AF22389D;
	Tue,  4 Jun 2019 08:11:31 +0000 (UTC)
Received: from [10.36.117.61] (ovpn-117-61.ams2.redhat.com [10.36.117.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6060A6063B;
	Tue,  4 Jun 2019 08:11:28 +0000 (UTC)
To: Stefan Liebler <stli@linux.ibm.com>, qemu-devel@nongnu.org
References: <20190531145608.28183-1-david@redhat.com>
	<20190531145608.28183-3-david@redhat.com>
	<b16f8afd-3458-591c-5b47-e1672e53e64a@linux.ibm.com>
	<dcf1b51b-78c8-7936-092b-439e8a9a3c8b@redhat.com>
	<3bec7cf0-9be1-ea6f-7dbc-cbf95fd08293@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	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
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <14a03703-a0af-1120-dabd-69bfba670f13@redhat.com>
Date: Tue, 4 Jun 2019 10:11:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3bec7cf0-9be1-ea6f-7dbc-cbf95fd08293@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Tue, 04 Jun 2019 08:11:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 2/2] s390x/tcg: Store only the necessary
 amount of doublewords for STFLE
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@de.ibm.com>,
	Andreas Krebbel <Andreas.Krebbel@de.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03.06.19 16:39, Stefan Liebler wrote:
> On 6/3/19 12:45 PM, David Hildenbrand wrote:
>> On 03.06.19 12:38, Stefan Liebler wrote:
>>> On 5/31/19 4:56 PM, David Hildenbrand wrote:
>>>> The PoP (z14, 7-382) says:
>>>>       Doublewords to the right of the doubleword in which the
>>>>       highest-numbered facility bit is assigned for a model
>>>>       may or may not be stored.
>>>>
>>>> However, stack protection in certain binaries can't deal with that.
>>>> "gzip" example code:
>>>>
>>>> f1b4:       a7 08 00 03             lhi     %r0,3
>>>> f1b8:       b2 b0 f0 a0             stfle   160(%r15)
>>>> f1bc:       e3 20 f0 b2 00 90       llgc    %r2,178(%r15)
>>>> f1c2:       c0 2b 00 00 00 01       nilf    %r2,1
>>>> f1c8:       b2 4f 00 10             ear     %r1,%a0
>>>> f1cc:       b9 14 00 22             lgfr    %r2,%r2
>>>> f1d0:       eb 11 00 20 00 0d       sllg    %r1,%r1,32
>>>> f1d6:       b2 4f 00 11             ear     %r1,%a1
>>>> f1da:       d5 07 f0 b8 10 28       clc     184(8,%r15),40(%r1)
>>>> f1e0:       a7 74 00 06             jne     f1ec <file_read@@Base+0x1bc>
>>>> f1e4:       eb ef f1 30 00 04       lmg     %r14,%r15,304(%r15)
>>>> f1ea:       07 fe                   br      %r14
>>>> f1ec:       c0 e5 ff ff 9d 6e       brasl   %r14,2cc8 <__stack_chk_fail@plt>
>>>>
>>>> In QEMU, we currently have:
>>>>       max_bytes = 24
>>>> the code asks for (3 + 1) doublewords == 32 bytes.
>>>>
>>>> If we write 32 bytes instead of only 24, and return "2 + 1" doublewords
>>>> ("one less than the number of doulewords needed to contain all of the
>>>>    facility bits"), the example code detects a stack corruption.
>>>>
>>>> In my opinion, the code is wrong. However, it seems to work fine on
>>>> real machines. So let's limit storing to the minimum of the requested
>>>> and the maximum doublewords.
>>> Hi David,
>>>
>>> Thanks for catching this. I've reported the "gzip" example to Ilya and
>>> indeed, r0 is setup too large. He will fix it in gzip.
>>>
>>> You've mentioned, that this is detected in certain binaries.
>>> Can you please share those occurrences.
>>
>> Hi Stafan,
>>
>> thanks for your reply.
>>
>> I didn't track all occurrences, it *could* be that it was only gzip in
>> the background making other processes fail.
>>
>> For example, the systemd "vitual console setup" unit failed, too, which
>> was fixed by this change.
> At least "objdump -d /usr/lib/systemd/systemd-vconsole-setup" does not 
> contain the stfle instruction, but "ldd 
> /usr/lib/systemd/systemd-vconsole-setup" is showing libz.so which could 
> also contain Ilya's patches with the stfle instruction (I assume there 
> is the same bug as in gzip). But I have no idea if libz is really called.
>>
>> I also remember, seeing segfaults in rpmbuild, for example. They only
>> "changed" with this fix - I m still chasing different errors. :)
> The same applies for rpmbuild.
>>
>> You mentioned "He will fix it in gzip", so I assume this is a gzip issue
>> and not a gcc/glibc/whatever toolchain issue?
>>
> Yes, this is a gzip bug. r0 was initialized with:
> (sizeof(array-on-stack) / 8)
> instead of:
> (sizeof(array-on-stack) / 8) - 1
> 
> Ilya will fix it in gzip and zlib.
> @Ilya: Please correct me if I'm wrong.
> 

Makes sense, thanks for the explanation!

-- 

Thanks,

David / dhildenb

