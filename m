Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8F9C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4074820731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4074820731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlmq-0001Ad-DF
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 08:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jTlm7-0000KL-My
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jTlm6-0006x6-Pb
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:25:15 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:40540
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frederic.konrad@adacore.com>)
 id 1jTlm6-0006vF-Ar
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:25:14 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 7585381353;
 Wed, 29 Apr 2020 14:25:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nSeo8Zh8b9L7; Wed, 29 Apr 2020 14:25:12 +0200 (CEST)
Received: from localhost.localdomain (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr
 [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 25B6881343;
 Wed, 29 Apr 2020 14:25:12 +0200 (CEST)
Subject: Re: [PATCH 2/2] target/m68k: fix gdb for m68xxx
To: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
 <1588094279-17913-3-git-send-email-frederic.konrad@adacore.com>
 <d565528d-426f-bf00-5974-5653eaf5cd25@vivier.eu> <877dxyljxg.fsf@linaro.org>
 <d3e2bc6a-2f2a-c1ef-00f2-213c91e1ae9c@vivier.eu>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <408eb029-2ad0-c15a-c6cc-f99b1d17ba38@adacore.com>
Date: Wed, 29 Apr 2020 14:25:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d3e2bc6a-2f2a-c1ef-00f2-213c91e1ae9c@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.98.77.210;
 envelope-from=frederic.konrad@adacore.com; helo=smtp.eu.adacore.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 08:25:12
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Received-From: 194.98.77.210
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 4/29/20 à 11:38 AM, Laurent Vivier a écrit :
> Le 29/04/2020 à 11:28, Alex Bennée a écrit :
>>
>> Laurent Vivier <laurent@vivier.eu> writes:
>>
>>> Le 28/04/2020 à 19:17, KONRAD Frederic a écrit :
>>>> Currently "cf-core.xml" is sent to GDB when using any m68k flavor.  Thing is
>>>> it uses the "org.gnu.gdb.coldfire.core" feature name and gdb 8.3 then expects
>>>> a coldfire FPU instead of the default m68881 FPU.
>>>>
>>>> This is not OK because the m68881 floats registers are 96 bits wide so it
>>>> crashes GDB with the following error message:
>>>>
>>>> (gdb) target remote localhost:7960
>>>> Remote debugging using localhost:7960
>>>> warning: Register "fp0" has an unsupported size (96 bits)
>>>> warning: Register "fp1" has an unsupported size (96 bits)
>>>> ...
>>>> Remote 'g' packet reply is too long (expected 148 bytes, got 180 bytes):    \
>>>>    00000000000[...]0000
>>>>
>>>> With this patch: qemu-system-m68k -M none -cpu m68020 -s -S
>>>>
>>>> (gdb) tar rem :1234
>>>> Remote debugging using :1234
>>>> warning: No executable has been specified and target does not support
>>>> determining executable automatically.  Try using the "file" command.
>>>> 0x00000000 in ?? ()
>>>> (gdb) p $fp0
>>>> $1 = nan(0xffffffffffffffff)
>>>>
>>>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>>>> ---
>>>>   configure             |  2 +-
>>>>   gdb-xml/m68k-core.xml | 29 ++++++++++++++++++++++++++++
>>>>   target/m68k/cpu.c     | 52 ++++++++++++++++++++++++++++++++++++---------------
>>>>   3 files changed, 67 insertions(+), 16 deletions(-)
>>>>   create mode 100644 gdb-xml/m68k-core.xml
>>>
>>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>>
>> Are you going to take this through your tree or do you want me to add it
>> to my small pile of gdbstub fixes?
>>
> 
> Please add it to your pile.
> 
> Thanks,
> Laurent
> 

Thanks!

