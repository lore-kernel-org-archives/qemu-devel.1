Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E129EC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 10:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C2C20830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 10:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C2C20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54107 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNaxp-0000B4-Pm
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 06:35:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hNawx-0008JL-KR
	for qemu-devel@nongnu.org; Mon, 06 May 2019 06:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hNaww-0007OZ-Ec
	for qemu-devel@nongnu.org; Mon, 06 May 2019 06:34:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hNaww-0007OL-76; Mon, 06 May 2019 06:34:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85A103082B15;
	Mon,  6 May 2019 10:34:21 +0000 (UTC)
Received: from gondolin (unknown [10.40.205.81])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 649E71001E85;
	Mon,  6 May 2019 10:34:17 +0000 (UTC)
Date: Mon, 6 May 2019 12:34:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20190506123414.5b33b6f8.cohuck@redhat.com>
In-Reply-To: <98a268ee-17fb-079e-01d1-5dc554a24efd@de.ibm.com>
References: <1556543381-12671-1-git-send-email-jjherne@linux.ibm.com>
	<daad75f0-c8bb-1c9f-5b43-afa828601c42@redhat.com>
	<df6bde4f-9c83-5009-3ca8-32d7a5e088d3@redhat.com>
	<55907be5-61a5-f251-4609-b0336818de17@redhat.com>
	<98a268ee-17fb-079e-01d1-5dc554a24efd@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 06 May 2019 10:34:21 +0000 (UTC)
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
	David Hildenbrand <david@redhat.com>, alifm@linux.ibm.com,
	qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 May 2019 12:18:42 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 06.05.19 12:16, Thomas Huth wrote:
> > On 06/05/2019 12.10, David Hildenbrand wrote:  
> >> On 06.05.19 12:01, David Hildenbrand wrote:  
> >>> On 29.04.19 15:09, Jason J. Herne wrote:  
> >>>> Newer versions of zipl have the ability to write signature entries to the boot
> >>>> script for secure boot. We don't yet support secure boot, but we need to skip
> >>>> over signature entries while reading the boot script in order to maintain our
> >>>> ability to boot guest operating systems that have a secure bootloader.
> >>>>
> >>>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> >>>> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> >>>> ---
> >>>>  pc-bios/s390-ccw/bootmap.c | 19 +++++++++++++++++--
> >>>>  pc-bios/s390-ccw/bootmap.h | 10 ++++++----
> >>>>  2 files changed, 23 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> >>>> index 7aef65a..d13b7cb 100644
> >>>> --- a/pc-bios/s390-ccw/bootmap.c
> >>>> +++ b/pc-bios/s390-ccw/bootmap.c
> >>>> @@ -254,7 +254,14 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
> >>>>      memset(sec, FREE_SPACE_FILLER, sizeof(sec));
> >>>>      read_block(block_nr, sec, "Cannot read Boot Map Script");
> >>>>  
> >>>> -    for (i = 0; bms->entry[i].type == BOOT_SCRIPT_LOAD; i++) {
> >>>> +    for (i = 0; bms->entry[i].type == BOOT_SCRIPT_LOAD ||
> >>>> +                bms->entry[i].type == BOOT_SCRIPT_SIGNATURE; i++) {
> >>>> +
> >>>> +        /* We don't support secure boot yet, so we skip signature entries */
> >>>> +        if (bms->entry[i].type == BOOT_SCRIPT_SIGNATURE) {
> >>>> +            continue;
> >>>> +        }
> >>>> +
> >>>>          address = bms->entry[i].address.load_address;
> >>>>          block_nr = eckd_block_num(&bms->entry[i].blkptr.xeckd.bptr.chs);
> >>>>  
> >>>> @@ -489,7 +496,15 @@ static void zipl_run(ScsiBlockPtr *pte)
> >>>>  
> >>>>      /* Load image(s) into RAM */
> >>>>      entry = (ComponentEntry *)(&header[1]);
> >>>> -    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD) {
> >>>> +    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
> >>>> +           entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> >>>> +
> >>>> +        /* We don't support secure boot yet, so we skip signature entries */
> >>>> +        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> >>>> +            entry++;
> >>>> +            continue;
> >>>> +        }
> >>>> +
> >>>>          zipl_load_segment(entry);
> >>>>  
> >>>>          entry++;
> >>>> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
> >>>> index a085212..94f53a5 100644
> >>>> --- a/pc-bios/s390-ccw/bootmap.h
> >>>> +++ b/pc-bios/s390-ccw/bootmap.h
> >>>> @@ -98,8 +98,9 @@ typedef struct ScsiMbr {
> >>>>  #define ZIPL_COMP_HEADER_IPL    0x00
> >>>>  #define ZIPL_COMP_HEADER_DUMP   0x01
> >>>>  
> >>>> -#define ZIPL_COMP_ENTRY_LOAD    0x02
> >>>> -#define ZIPL_COMP_ENTRY_EXEC    0x01
> >>>> +#define ZIPL_COMP_ENTRY_EXEC      0x01
> >>>> +#define ZIPL_COMP_ENTRY_LOAD      0x02
> >>>> +#define ZIPL_COMP_ENTRY_SIGNATURE 0x03
> >>>>  
> >>>>  typedef struct XEckdMbr {
> >>>>      uint8_t magic[4];   /* == "xIPL"        */
> >>>> @@ -117,8 +118,9 @@ typedef struct BootMapScriptEntry {
> >>>>      BootMapPointer blkptr;
> >>>>      uint8_t pad[7];
> >>>>      uint8_t type;   /* == BOOT_SCRIPT_* */
> >>>> -#define BOOT_SCRIPT_EXEC 0x01
> >>>> -#define BOOT_SCRIPT_LOAD 0x02
> >>>> +#define BOOT_SCRIPT_EXEC      0x01
> >>>> +#define BOOT_SCRIPT_LOAD      0x02
> >>>> +#define BOOT_SCRIPT_SIGNATURE 0x03
> >>>>      union {
> >>>>          uint64_t load_address;
> >>>>          uint64_t load_psw;
> >>>>  
> >>>
> >>> Naive question from me:
> >>>
> >>> Can't we place the signatures somewhere else, and instead associate them
> >>> with entries? This avoids breaking backwards compatibility for the sake
> >>> of signatures we want unmodified zipl loaders to ignore.
> >>>  
> >>
> >>
> >> ... but I guess this is already documented somewhere internally and
> >> other components have been adjusted. IOW, cannot be changed anymore.
> >>
> >> Guess our implementation should have tolerated other entries than
> >> "BOOT_SCRIPT_LOAD" right from the beginning.  
> > 
> > Hmm, now we only tolerate the _LOAD and _SIGNATURE entries, but still
> > nothing else... would it make sense to rewrite the code a little bit to
> > tolerate all other kind of entries, but just act on the well-known _LOAD
> > entries, so that we do not step into this trap in the future anymore?  
> 
> I think we should not. Those entries might have sematic elements that the guest
> wants to enforce. I do not think that this will come, but imagine a boot entry
> that mandates some security wishes (e.g. do only run on non-shared cores).

Can we split the namespace for BOOT_SCRIPT into 'ignore if you don't
know what that is' and 'fail if you don't know what that is'? I'm
completely confused how 'optional' those entries are supposed to be...

