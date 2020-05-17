Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EEFC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 14:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 341962070A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 14:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341962070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaKK1-0007yN-CG
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 10:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jaKJM-0007Yi-Gd
 for qemu-devel@nongnu.org; Sun, 17 May 2020 10:30:40 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:40457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jaKJK-0001xf-MC
 for qemu-devel@nongnu.org; Sun, 17 May 2020 10:30:39 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 38FCB746335;
 Sun, 17 May 2020 16:30:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0FB33746333; Sun, 17 May 2020 16:30:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0E18D746331;
 Sun, 17 May 2020 16:30:27 +0200 (CEST)
Date: Sun, 17 May 2020 16:30:27 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH] ati-vga: Do not allow unaligned access via index register
In-Reply-To: <2aa3e473-4de3-253b-37b6-f61b13969329@amsat.org>
Message-ID: <alpine.BSF.2.22.395.2005171613510.1650@zero.eik.bme.hu>
References: <20200516132352.39E9374594E@zero.eik.bme.hu>
 <20200516144706.zz54mgs7k7anq3cj@mozz.bu.edu>
 <alpine.BSF.2.22.395.2005161730460.69993@zero.eik.bme.hu>
 <16020f02-5fe3-a7d9-ca30-759a2ba69307@amsat.org>
 <2aa3e473-4de3-253b-37b6-f61b13969329@amsat.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-965870377-1589725827=:1650"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-965870377-1589725827=:1650
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 17 May 2020, Philippe Mathieu-Daudé wrote:
> On 5/17/20 12:40 PM, Philippe Mathieu-Daudé wrote:
>> On 5/16/20 5:33 PM, BALATON Zoltan wrote:
>>> On Sat, 16 May 2020, Alexander Bulekov wrote:
>>>> On 200516 1513, BALATON Zoltan wrote:
>> Finally, there is a tag documented for bug fixes:
>> https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message 
>> 
>> If your patch addresses a bug in a public bug tracker, please add a line 
>> with "Buglink: <URL-of-the-bug>" there, too.
>> 
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1878134

Does this reply add that tag already or do I need to submit a v2 with it 
(or the maintainer could add it when merging)?

>> Now, looking at your device implementation, it seems
>> 
>> 1/ The device isn't supposed to have 64-bit accesses
>> 
>> So this might be a more generic fix to Alexander issue:
>> 
>> -- >8 --
>> @@ -879,6 +879,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>>   static const MemoryRegionOps ati_mm_ops = {
>>       .read = ati_mm_read,
>>       .write = ati_mm_write,
>> +    .valid.max_access_size = 4,
>>       .endianness = DEVICE_LITTLE_ENDIAN,
>>   };
>> ---

I've tried that first but it does not work. The reason is that ati_mm_read 
is recursively called for indexed access via MM_DATA which causes the 
problem that happens when MM_INDEX is set to a non-aligned value. No 64 
bit access, just 32 bit with offset of 2 bytes as can be seen from the 
stach trace I've attached to the bug. Fortunately indexed access is 
documented to only support aligned access by not allowing setting low bits 
of MM_INDEX so unless we find a client needing it my patch should do it.

>> 2/ All the registers are 32-bit aligned
>> 
>> So you can simplify the implementation by letting 
>> access_with_adjusted_size() handle the 8/16-bit accesses by using:
>> 
>> @@ -879,6 +879,8 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>>   static const MemoryRegionOps ati_mm_ops = {
>>       .read = ati_mm_read,
>>       .write = ati_mm_write,
>> +    .min.min_access_size = 4,
>
> I meant '.impl.min_access_size'.

I think this would not work either because not all registers are the same, 
some only can be read all 32 bits, some also 16 or 8 bits and clients do 
access these with less than 32 bits and accessing parts of the reg may 
trigger actions so the current way is probably better and necessary to 
correctly support different valid and invalid unaligned accessses.

Regards,
BALATON Zoltan
--3866299591-965870377-1589725827=:1650--

