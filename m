Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92311C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 10:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582222082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 10:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582222082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53921 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNagI-0003NS-IM
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 06:17:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNafM-0002wp-BI
	for qemu-devel@nongnu.org; Mon, 06 May 2019 06:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNafL-0003xX-9g
	for qemu-devel@nongnu.org; Mon, 06 May 2019 06:16:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hNafL-0003xK-1P; Mon, 06 May 2019 06:16:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23915307D861;
	Mon,  6 May 2019 10:16:10 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-74.ams2.redhat.com [10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2F0D9611C0;
	Mon,  6 May 2019 10:16:06 +0000 (UTC)
To: David Hildenbrand <david@redhat.com>,
	"Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org,
	qemu-s390x@nongnu.org, cohuck@redhat.com, alifm@linux.ibm.com,
	borntraeger@de.ibm.com
References: <1556543381-12671-1-git-send-email-jjherne@linux.ibm.com>
	<daad75f0-c8bb-1c9f-5b43-afa828601c42@redhat.com>
	<df6bde4f-9c83-5009-3ca8-32d7a5e088d3@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
	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
Organization: Red Hat
Message-ID: <55907be5-61a5-f251-4609-b0336818de17@redhat.com>
Date: Mon, 6 May 2019 12:16:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <df6bde4f-9c83-5009-3ca8-32d7a5e088d3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 06 May 2019 10:16:10 +0000 (UTC)
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

On 06/05/2019 12.10, David Hildenbrand wrote:
> On 06.05.19 12:01, David Hildenbrand wrote:
>> On 29.04.19 15:09, Jason J. Herne wrote:
>>> Newer versions of zipl have the ability to write signature entries to the boot
>>> script for secure boot. We don't yet support secure boot, but we need to skip
>>> over signature entries while reading the boot script in order to maintain our
>>> ability to boot guest operating systems that have a secure bootloader.
>>>
>>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>>> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
>>> ---
>>>  pc-bios/s390-ccw/bootmap.c | 19 +++++++++++++++++--
>>>  pc-bios/s390-ccw/bootmap.h | 10 ++++++----
>>>  2 files changed, 23 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>>> index 7aef65a..d13b7cb 100644
>>> --- a/pc-bios/s390-ccw/bootmap.c
>>> +++ b/pc-bios/s390-ccw/bootmap.c
>>> @@ -254,7 +254,14 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
>>>      memset(sec, FREE_SPACE_FILLER, sizeof(sec));
>>>      read_block(block_nr, sec, "Cannot read Boot Map Script");
>>>  
>>> -    for (i = 0; bms->entry[i].type == BOOT_SCRIPT_LOAD; i++) {
>>> +    for (i = 0; bms->entry[i].type == BOOT_SCRIPT_LOAD ||
>>> +                bms->entry[i].type == BOOT_SCRIPT_SIGNATURE; i++) {
>>> +
>>> +        /* We don't support secure boot yet, so we skip signature entries */
>>> +        if (bms->entry[i].type == BOOT_SCRIPT_SIGNATURE) {
>>> +            continue;
>>> +        }
>>> +
>>>          address = bms->entry[i].address.load_address;
>>>          block_nr = eckd_block_num(&bms->entry[i].blkptr.xeckd.bptr.chs);
>>>  
>>> @@ -489,7 +496,15 @@ static void zipl_run(ScsiBlockPtr *pte)
>>>  
>>>      /* Load image(s) into RAM */
>>>      entry = (ComponentEntry *)(&header[1]);
>>> -    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD) {
>>> +    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
>>> +           entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
>>> +
>>> +        /* We don't support secure boot yet, so we skip signature entries */
>>> +        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
>>> +            entry++;
>>> +            continue;
>>> +        }
>>> +
>>>          zipl_load_segment(entry);
>>>  
>>>          entry++;
>>> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
>>> index a085212..94f53a5 100644
>>> --- a/pc-bios/s390-ccw/bootmap.h
>>> +++ b/pc-bios/s390-ccw/bootmap.h
>>> @@ -98,8 +98,9 @@ typedef struct ScsiMbr {
>>>  #define ZIPL_COMP_HEADER_IPL    0x00
>>>  #define ZIPL_COMP_HEADER_DUMP   0x01
>>>  
>>> -#define ZIPL_COMP_ENTRY_LOAD    0x02
>>> -#define ZIPL_COMP_ENTRY_EXEC    0x01
>>> +#define ZIPL_COMP_ENTRY_EXEC      0x01
>>> +#define ZIPL_COMP_ENTRY_LOAD      0x02
>>> +#define ZIPL_COMP_ENTRY_SIGNATURE 0x03
>>>  
>>>  typedef struct XEckdMbr {
>>>      uint8_t magic[4];   /* == "xIPL"        */
>>> @@ -117,8 +118,9 @@ typedef struct BootMapScriptEntry {
>>>      BootMapPointer blkptr;
>>>      uint8_t pad[7];
>>>      uint8_t type;   /* == BOOT_SCRIPT_* */
>>> -#define BOOT_SCRIPT_EXEC 0x01
>>> -#define BOOT_SCRIPT_LOAD 0x02
>>> +#define BOOT_SCRIPT_EXEC      0x01
>>> +#define BOOT_SCRIPT_LOAD      0x02
>>> +#define BOOT_SCRIPT_SIGNATURE 0x03
>>>      union {
>>>          uint64_t load_address;
>>>          uint64_t load_psw;
>>>
>>
>> Naive question from me:
>>
>> Can't we place the signatures somewhere else, and instead associate them
>> with entries? This avoids breaking backwards compatibility for the sake
>> of signatures we want unmodified zipl loaders to ignore.
>>
> 
> 
> ... but I guess this is already documented somewhere internally and
> other components have been adjusted. IOW, cannot be changed anymore.
> 
> Guess our implementation should have tolerated other entries than
> "BOOT_SCRIPT_LOAD" right from the beginning.

Hmm, now we only tolerate the _LOAD and _SIGNATURE entries, but still
nothing else... would it make sense to rewrite the code a little bit to
tolerate all other kind of entries, but just act on the well-known _LOAD
entries, so that we do not step into this trap in the future anymore?

 Thomas

