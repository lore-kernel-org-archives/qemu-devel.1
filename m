Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B5CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 07:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2AD207D5
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 07:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFFrJq1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2AD207D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjHv4-0001Cc-SD
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 03:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjHtz-0000bw-NF; Thu, 11 Jun 2020 03:45:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40484)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjHty-00083P-MM; Thu, 11 Jun 2020 03:45:31 -0400
Received: by mail-wr1-x444.google.com with SMTP id h5so5059904wrc.7;
 Thu, 11 Jun 2020 00:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Z9mLbMQ1a+zqqEsWA9XtDeFrJ9tENxl+wPySvmF067E=;
 b=ZFFrJq1BQzB3XLTox7M3Lm4wAcFw2nKL9VFZtT2qGzC+EJDXNye8rfcxABLkGcVGyT
 vQ4/FTZtL5MTm8iNILzxzaO/BVBCS1iKoXCbVN7omRMeZal/aLux+buHwgZoZ2LwVETV
 Zc8a8U+ODNhNLzYAKdJVDGll7SyN/nY79EZMj3Ec/YmEJQQiQRzDf4nU+DvbopnbWNbX
 r14B/uMuu0XKmdux48oz+hFlMMiVKBrqqftI8oJVBOjhM7WG7kCKqggRrqmBx7opJPOh
 xvxG2iMlKWWd5FU3zSkbZhylhst2HPAJnAtMBbCiXx45AswdPeo98PBbPaqbPfXTnSW7
 IloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z9mLbMQ1a+zqqEsWA9XtDeFrJ9tENxl+wPySvmF067E=;
 b=LK9zkggeRDcoPEJDFhTojL9o9egC3eXDOCVd53fAnQ+BJF9JR1+/DxjkBsaOPPd+N8
 bwvOpIMS73znP2xtHSi+O9wGvBufZPYWeWApKOyPcBEeMo4B+TniqmARniGzOMPIXFw2
 8eK/ucatrAf8DGobHeqkhh5GGEG9dHqtiO1JOtb2xXwc0KRGBFDumVYFBPwi3qTMqSkD
 8WQcx5efDj+14IjrHaetWRfUg3el+F0HpYnln/1/qd5nJ9DPvucaMre8kAew2M69k/0l
 vsz+KTZYIc5+OBrfa8fiaXcHQmtE4y9QA96zag/pueHP7iFQHn9q1HJ7xRskx/U9LdKR
 XIzQ==
X-Gm-Message-State: AOAM532u5zbQDOeIyXus5SX6kNVKbI91MneTeF9DYxML4y0EGhfouOb6
 7m2hhd9zxYSolQL6JvsXEZw=
X-Google-Smtp-Source: ABdhPJxGW5fiPqQSH6hsX0HNo7IoXzXrPQ83vbvuTtOZAbtwrktrv41loqpF0acXNSuUOVcCwah1Pw==
X-Received: by 2002:a5d:5492:: with SMTP id h18mr7806170wrv.330.1591861517945; 
 Thu, 11 Jun 2020 00:45:17 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id u9sm3053898wme.16.2020.06.11.00.45.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 00:45:17 -0700 (PDT)
Subject: Re: [PATCH v3 05/11] MAINTAINERS: Add an entry for common Renesas
 peripherals
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200610220853.8558-1-f4bug@amsat.org>
 <20200610220853.8558-6-f4bug@amsat.org>
 <03112dec-ca30-2fa2-02a7-7a7402721783@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b5b87280-6bdb-6f4a-4922-9e7916eeadea@amsat.org>
Date: Thu, 11 Jun 2020 09:45:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <03112dec-ca30-2fa2-02a7-7a7402721783@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 9:38 AM, Thomas Huth wrote:
> On 11/06/2020 00.08, Philippe Mathieu-Daudé wrote:
>> Renesas peripherals are common to SH4/RX based MCUs. Their
>> datasheets share common sections. It makes sense to maintain
>> them altogether. The current names are misleading (see the
>> 'sh' prefix). This will be fixed later when RX peripherals
>> will be added.
>>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  MAINTAINERS | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 653fca1da8..0398634179 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1254,8 +1254,6 @@ M: Magnus Damm <magnus.damm@gmail.com>
>>  S: Odd Fixes
>>  F: hw/sh4/r2d.c
>>  F: hw/intc/sh_intc.c
>> -F: hw/timer/sh_timer.c
>> -F: include/hw/sh4/sh_intc.h
> 
> You've added the line for sh_intc.h in the previous patch, just to
> remove it here again? ... I guess you only wanted to remove sh_timer.c
> here instead?

Yes, you are right, too many rework trying to split in a way that
would satisfy Aleksander requirements, but he eventually implicitly
Nacked this series (not replying on the cover however, and not
answering my questions, so this is not clear neither...):
https://www.mail-archive.com/qemu-devel@nongnu.org/msg711260.html
Aleksander said Yoshinori will arrange the sections in his own
ways. While I'm not certain Yoshinori is interested/willing to do
the cleanup, I don't think any more reviewer should spend time
reviewing this. Thanks for caring anyway, very appreciated!

> 
>  Thomas
> 
>>  Shix
>>  S: Orphan
>> @@ -1954,6 +1952,13 @@ F: hw/*/*xive*
>>  F: include/hw/*/*xive*
>>  F: docs/*/*xive*
>>  
>> +Renesas peripherals
>> +M: Magnus Damm <magnus.damm@gmail.com>
>> +S: Odd Fixes
>> +F: hw/char/sh_serial.c
>> +F: hw/timer/sh_timer.c
>> +F: include/hw/sh4/sh.h
>> +
>>  Subsystems
>>  ----------
>>  Audio
>>
> 

