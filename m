Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FE1C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9953C2072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9953C2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlxd-0000qB-QY
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 08:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jTluJ-0004yc-F9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jTluC-0006xv-2I
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:33:43 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:41588
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frederic.konrad@adacore.com>)
 id 1jTlu9-0006hC-Tl
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:33:35 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id B2F7481343;
 Wed, 29 Apr 2020 14:33:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iTf_XWq1qryu; Wed, 29 Apr 2020 14:33:26 +0200 (CEST)
Received: from localhost.localdomain (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr
 [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id CFBA381368;
 Wed, 29 Apr 2020 14:33:25 +0200 (CEST)
Subject: Re: [PATCH 1/2] softfloat: m68k: infinity is a valid encoding
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
 <1588094279-17913-2-git-send-email-frederic.konrad@adacore.com>
 <55a6feb0-38ba-432f-82cb-06c5694c325a@vivier.eu>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <ecd3ae17-5626-1211-515f-109f69dcb6e5@adacore.com>
Date: Wed, 29 Apr 2020 14:33:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <55a6feb0-38ba-432f-82cb-06c5694c325a@vivier.eu>
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
Cc: philmd@redhat.com, alex.bennee@linaro.org,
 Pierre Muller <pierre@freepascal.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 4/29/20 à 10:42 AM, Laurent Vivier a écrit :
> Le 28/04/2020 à 19:17, KONRAD Frederic a écrit :
>> The MC68881 say about infinities (3.2.4):
>>
>> "*For the extended precision format, the most significant bit of the
>> mantissa (the integer bit) is a don't care."
>>
>> https://www.nxp.com/docs/en/reference-manual/MC68881UM.pdf
> 
> As we use 68040 I refer to:
> 
> https://www.nxp.com/files-static/archives/doc/ref_manual/M68000PRM.pdf
> 

[...]

> 
> This is denormalized numbers and should generate an exception.
> 
> I tried something like that in the past:
> 
> https://patchew.org/QEMU/20170207005930.28327-1-laurent@vivier.eu/20170207005930.28327-3-laurent@vivier.eu/
> 
> Pierre tried recently:
> https://patchew.org/QEMU/1615bbe5-3033-3b76-5cfb-52e343dc4d67@freepascal.org/

Arg, yes that's almost the same!  Sorry Pierre I missed this one :(.

> 
> See "1.6.2 Denormalized Numbers" in M68000 FAMILY PROGRAMMER’S REFERENCE
> MANUAL.
> 
> "Since the extended-precision data format has an explicit integer bit, a
> number can be formatted with a nonzero exponent, less than the maximum
> value, and a zero integer bit. The IEEE 754 standard does not define a
> zero integer bit. Such a number is an unnormalized number. Hardware does
> not directly support denormalized and unnormalized numbers, but
> implicitly supports them by trapping them as unimplemented data types,
> allowing efficient conversion in software."
> 
> But m68k FPU exceptions are not currently implemented in QEMU.

Hmm ok, I don't have any m68k with an FPU at hand for testing.  I just tested
with an other simulator and it seems to trap when I load the value in the
register.  So I'm probably chasing the wrong bug here.

Thanks for the tips Laurent!
Fred

> 
> Thanks,
> Laurent
> 

