Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A74C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 10:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCDEB2082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 10:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDEB2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53837 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNabc-0000Zr-TJ
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 06:12:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hNaaA-0008Ev-Lr
	for qemu-devel@nongnu.org; Mon, 06 May 2019 06:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hNaa9-00016e-Bz
	for qemu-devel@nongnu.org; Mon, 06 May 2019 06:10:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hNaa9-00013C-1H; Mon, 06 May 2019 06:10:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13C8D3082E56;
	Mon,  6 May 2019 10:10:47 +0000 (UTC)
Received: from [10.36.116.76] (ovpn-116-76.ams2.redhat.com [10.36.116.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C5F331852E;
	Mon,  6 May 2019 10:10:43 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org,
	qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com,
	alifm@linux.ibm.com, borntraeger@de.ibm.com
References: <1556543381-12671-1-git-send-email-jjherne@linux.ibm.com>
	<daad75f0-c8bb-1c9f-5b43-afa828601c42@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
	dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
	QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
	XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
	Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
	PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
	WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
	UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
	jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
	B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
	ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwX4EEwECACgFAljj9eoCGwMFCQlmAYAGCwkI
	BwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEE3eEPcA/4Na5IIP/3T/FIQMxIfNzZshIq687qgG
	8UbspuE/YSUDdv7r5szYTK6KPTlqN8NAcSfheywbuYD9A4ZeSBWD3/NAVUdrCaRP2IvFyELj
	xoMvfJccbq45BxzgEspg/bVahNbyuBpLBVjVWwRtFCUEXkyazksSv8pdTMAs9IucChvFmmq3
	jJ2vlaz9lYt/lxN246fIVceckPMiUveimngvXZw21VOAhfQ+/sofXF8JCFv2mFcBDoa7eYob
	s0FLpmqFaeNRHAlzMWgSsP80qx5nWWEvRLdKWi533N2vC/EyunN3HcBwVrXH4hxRBMco3jvM
	m8VKLKao9wKj82qSivUnkPIwsAGNPdFoPbgghCQiBjBe6A75Z2xHFrzo7t1jg7nQfIyNC7ez
	MZBJ59sqA9EDMEJPlLNIeJmqslXPjmMFnE7Mby/+335WJYDulsRybN+W5rLT5aMvhC6x6POK
	z55fMNKrMASCzBJum2Fwjf/VnuGRYkhKCqqZ8gJ3OvmR50tInDV2jZ1DQgc3i550T5JDpToh
	dPBxZocIhzg+MBSRDXcJmHOx/7nQm3iQ6iLuwmXsRC6f5FbFefk9EjuTKcLMvBsEx+2DEx0E
	UnmJ4hVg7u1PQ+2Oy+Lh/opK/BDiqlQ8Pz2jiXv5xkECvr/3Sv59hlOCZMOaiLTTjtOIU7Tq
	7ut6OL64oAq+zsFNBFXLn5EBEADn1959INH2cwYJv0tsxf5MUCghCj/CA/lc/LMthqQ773ga
	uB9mN+F1rE9cyyXb6jyOGn+GUjMbnq1o121Vm0+neKHUCBtHyseBfDXHA6m4B3mUTWo13nid
	0e4AM71r0DS8+KYh6zvweLX/LL5kQS9GQeT+QNroXcC1NzWbitts6TZ+IrPOwT1hfB4WNC+X
	2n4AzDqp3+ILiVST2DT4VBc11Gz6jijpC/KI5Al8ZDhRwG47LUiuQmt3yqrmN63V9wzaPhC+
	xbwIsNZlLUvuRnmBPkTJwwrFRZvwu5GPHNndBjVpAfaSTOfppyKBTccu2AXJXWAE1Xjh6GOC
	8mlFjZwLxWFqdPHR1n2aPVgoiTLk34LR/bXO+e0GpzFXT7enwyvFFFyAS0Nk1q/7EChPcbRb
	hJqEBpRNZemxmg55zC3GLvgLKd5A09MOM2BrMea+l0FUR+PuTenh2YmnmLRTro6eZ/qYwWkC
	u8FFIw4pT0OUDMyLgi+GI1aMpVogTZJ70FgV0pUAlpmrzk/bLbRkF3TwgucpyPtcpmQtTkWS
	gDS50QG9DR/1As3LLLcNkwJBZzBG6PWbvcOyrwMQUF1nl4SSPV0LLH63+BrrHasfJzxKXzqg
	rW28CTAE2x8qi7e/6M/+XXhrsMYG+uaViM7n2je3qKe7ofum3s4vq7oFCPsOgwARAQABwsFl
	BBgBAgAPBQJVy5+RAhsMBQkJZgGAAAoJEE3eEPcA/4NagOsP/jPoIBb/iXVbM+fmSHOjEshl
	KMwEl/m5iLj3iHnHPVLBUWrXPdS7iQijJA/VLxjnFknhaS60hkUNWexDMxVVP/6lbOrs4bDZ
	NEWDMktAeqJaFtxackPszlcpRVkAs6Msn9tu8hlvB517pyUgvuD7ZS9gGOMmYwFQDyytpepo
	YApVV00P0u3AaE0Cj/o71STqGJKZxcVhPaZ+LR+UCBZOyKfEyq+ZN311VpOJZ1IvTExf+S/5
	lqnciDtbO3I4Wq0ArLX1gs1q1XlXLaVaA3yVqeC8E7kOchDNinD3hJS4OX0e1gdsx/e6COvy
	qNg5aL5n0Kl4fcVqM0LdIhsubVs4eiNCa5XMSYpXmVi3HAuFyg9dN+x8thSwI836FoMASwOl
	C7tHsTjnSGufB+D7F7ZBT61BffNBBIm1KdMxcxqLUVXpBQHHlGkbwI+3Ye+nE6HmZH7IwLwV
	W+Ajl7oYF+jeKaH4DZFtgLYGLtZ1LDwKPjX7VAsa4Yx7S5+EBAaZGxK510MjIx6SGrZWBrrV
	TEvdV00F2MnQoeXKzD7O4WFbL55hhyGgfWTHwZ457iN9SgYi1JLPqWkZB0JRXIEtjd4JEQcx
	+8Umfre0Xt4713VxMygW0PnQt5aSQdMD58jHFxTk092mU+yIHj5LeYgvwSgZN4airXk5yRXl
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <df6bde4f-9c83-5009-3ca8-32d7a5e088d3@redhat.com>
Date: Mon, 6 May 2019 12:10:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <daad75f0-c8bb-1c9f-5b43-afa828601c42@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 06 May 2019 10:10:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390-bios: Skip bootmap
 signature entries
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06.05.19 12:01, David Hildenbrand wrote:
> On 29.04.19 15:09, Jason J. Herne wrote:
>> Newer versions of zipl have the ability to write signature entries to the boot
>> script for secure boot. We don't yet support secure boot, but we need to skip
>> over signature entries while reading the boot script in order to maintain our
>> ability to boot guest operating systems that have a secure bootloader.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>  pc-bios/s390-ccw/bootmap.c | 19 +++++++++++++++++--
>>  pc-bios/s390-ccw/bootmap.h | 10 ++++++----
>>  2 files changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>> index 7aef65a..d13b7cb 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -254,7 +254,14 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
>>      memset(sec, FREE_SPACE_FILLER, sizeof(sec));
>>      read_block(block_nr, sec, "Cannot read Boot Map Script");
>>  
>> -    for (i = 0; bms->entry[i].type == BOOT_SCRIPT_LOAD; i++) {
>> +    for (i = 0; bms->entry[i].type == BOOT_SCRIPT_LOAD ||
>> +                bms->entry[i].type == BOOT_SCRIPT_SIGNATURE; i++) {
>> +
>> +        /* We don't support secure boot yet, so we skip signature entries */
>> +        if (bms->entry[i].type == BOOT_SCRIPT_SIGNATURE) {
>> +            continue;
>> +        }
>> +
>>          address = bms->entry[i].address.load_address;
>>          block_nr = eckd_block_num(&bms->entry[i].blkptr.xeckd.bptr.chs);
>>  
>> @@ -489,7 +496,15 @@ static void zipl_run(ScsiBlockPtr *pte)
>>  
>>      /* Load image(s) into RAM */
>>      entry = (ComponentEntry *)(&header[1]);
>> -    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD) {
>> +    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
>> +           entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
>> +
>> +        /* We don't support secure boot yet, so we skip signature entries */
>> +        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
>> +            entry++;
>> +            continue;
>> +        }
>> +
>>          zipl_load_segment(entry);
>>  
>>          entry++;
>> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
>> index a085212..94f53a5 100644
>> --- a/pc-bios/s390-ccw/bootmap.h
>> +++ b/pc-bios/s390-ccw/bootmap.h
>> @@ -98,8 +98,9 @@ typedef struct ScsiMbr {
>>  #define ZIPL_COMP_HEADER_IPL    0x00
>>  #define ZIPL_COMP_HEADER_DUMP   0x01
>>  
>> -#define ZIPL_COMP_ENTRY_LOAD    0x02
>> -#define ZIPL_COMP_ENTRY_EXEC    0x01
>> +#define ZIPL_COMP_ENTRY_EXEC      0x01
>> +#define ZIPL_COMP_ENTRY_LOAD      0x02
>> +#define ZIPL_COMP_ENTRY_SIGNATURE 0x03
>>  
>>  typedef struct XEckdMbr {
>>      uint8_t magic[4];   /* == "xIPL"        */
>> @@ -117,8 +118,9 @@ typedef struct BootMapScriptEntry {
>>      BootMapPointer blkptr;
>>      uint8_t pad[7];
>>      uint8_t type;   /* == BOOT_SCRIPT_* */
>> -#define BOOT_SCRIPT_EXEC 0x01
>> -#define BOOT_SCRIPT_LOAD 0x02
>> +#define BOOT_SCRIPT_EXEC      0x01
>> +#define BOOT_SCRIPT_LOAD      0x02
>> +#define BOOT_SCRIPT_SIGNATURE 0x03
>>      union {
>>          uint64_t load_address;
>>          uint64_t load_psw;
>>
> 
> Naive question from me:
> 
> Can't we place the signatures somewhere else, and instead associate them
> with entries? This avoids breaking backwards compatibility for the sake
> of signatures we want unmodified zipl loaders to ignore.
> 


... but I guess this is already documented somewhere internally and
other components have been adjusted. IOW, cannot be changed anymore.

Guess our implementation should have tolerated other entries than
"BOOT_SCRIPT_LOAD" right from the beginning.

-- 

Thanks,

David / dhildenb

