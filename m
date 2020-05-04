Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31309C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 19:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34C320658
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 19:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAPZIwhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34C320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVh0T-0004ZF-4n
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 15:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVgzm-00042D-2j; Mon, 04 May 2020 15:43:18 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVgzl-0006wt-Ed; Mon, 04 May 2020 15:43:17 -0400
Received: by mail-wm1-x342.google.com with SMTP id v4so778096wme.1;
 Mon, 04 May 2020 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KtlccjpCc3cTSA86pPoexRbefD9KvD3tNDzKPg80V/4=;
 b=CAPZIwhF9qSuFvyBuABfwRDczNcLtY/nbHdWF0/dgAMMRlRxWd78K34FbnfaOLg0ke
 d1RFlq8M8pbsmAEbdvjp/eelXUHBY4T825uYTT4Hk1jKRfVBOT0yEGI6zrWXeFMWd8vz
 FG1JbmxT6c6sF2/N3a513LHwHWqTikqNygpRvxY4eIHWdn8yOxBkIz6pC3L6/HSjY96u
 JHIqMRoVF5qzrwKFHgKCOWw5pDrteTRmsrJ9cbjgIVC8jdCQEPdrgL/Z1czswz/JcbQ+
 57rTNLcdWl/Q4p1Zn88+gBcXf58eU0At0NQ5lQrlY5izEqh64LQaQXg2940IcAyoI9n1
 /OoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KtlccjpCc3cTSA86pPoexRbefD9KvD3tNDzKPg80V/4=;
 b=p9puTdwrziMfCdizEClWftwZxQnwuQpx5nHkp+MPNEw/TBjL2z915/AAwP6SIdODWd
 GBamrlQJi3Eunv0rbjCOQ0jgvhRZeiFBupe2JKSsU5Zlht1x3/qwuu6eRYeuH3SVUD9U
 1lyzM+pdRAtEfU3qeJePMHzUyQIgAZoE0tY0tKdYJWH8elwZ60KmJQodIcFkTekqVg4p
 pfjlLUEslEJRXOiYaNa4b/VCabdTu2L89FIngFuP9Ty48Ka0/PAnyO+DFU5zjs8Xc7+0
 5gjXo1IPIjImiHFjyq/8F+4awpgFT/8cgDR/hwxbg6uMYFCRyKGnHftHTDdb6bwF+C7p
 TdGg==
X-Gm-Message-State: AGi0PuYQP9PFhkHAGR/N7ccfm1n8frWFuxWe1eI814iDUMhqnf0BaQsc
 L4IveH92gWo5sKojJdlMwLw=
X-Google-Smtp-Source: APiQypLNWMEjCWzpTTqRlNQ5fM43DasBthqPDNGNs3dvQ9EgTcvJOMNXBfjnILMttnezy+7yq4bt+g==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr15993457wmc.59.1588621395641; 
 Mon, 04 May 2020 12:43:15 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id y11sm19530695wrh.59.2020.05.04.12.43.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 12:43:14 -0700 (PDT)
Subject: Re: [PATCH 2/3] io/task: Move 'qom/object.h' header to source
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200504084615.27642-1-f4bug@amsat.org>
 <20200504084615.27642-3-f4bug@amsat.org>
 <799fe603-906c-c00b-07ce-0e7619c444f5@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c28f6af0-4a41-3f01-6bac-db87f40fd5fc@amsat.org>
Date: Mon, 4 May 2020 21:43:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <799fe603-906c-c00b-07ce-0e7619c444f5@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 7:42 PM, Richard Henderson wrote:
> On 5/4/20 1:46 AM, Philippe Mathieu-Daudé wrote:
>> We need "qom/object.h" to call object_ref()/object_unref().
> 
> This description doesn't seem to match
> 
>> +++ b/include/io/task.h
>> @@ -21,8 +21,6 @@
>>   #ifndef QIO_TASK_H
>>   #define QIO_TASK_H
>>   
>> -#include "qom/object.h"
>> -
>>   typedef struct QIOTask QIOTask;
>>   
>>   typedef void (*QIOTaskFunc)(QIOTask *task,
>> diff --git a/io/task.c b/io/task.c
>> index 1ae7b86488..53c0bed686 100644
>> --- a/io/task.c
>> +++ b/io/task.c
>> @@ -22,6 +22,7 @@
>>   #include "io/task.h"
>>   #include "qapi/error.h"
>>   #include "qemu/thread.h"
>> +#include "qom/object.h"
> 
> the change.  Since io/task.c includes io/tash.h, what are you actually doing?

Sorry to not document clearly on the cover.

The original goal was to stop using $SRC_PATH as include directory, but 
as it is huge I believe it will never get fully accepted, so I simply 
kept the few maybe worthwhile patches...

The final patch is:

-- >8 --
--- a/configure
+++ b/configure
@@ -601,7 +601,7 @@ QEMU_CFLAGS="-fno-strict-aliasing -fno-common 
-fwrapv -std=gnu99 $QEMU_CFLAGS"
  QEMU_CFLAGS="-Wall -Wundef -Wwrite-strings -Wmissing-prototypes 
$QEMU_CFLAGS"
  QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
  QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE 
$QEMU_CFLAGS"
-QEMU_INCLUDES="-iquote . -iquote \$(SRC_PATH) -iquote 
\$(SRC_PATH)/accel/tcg -iquote \$(SRC_PATH)/include"
+QEMU_INCLUDES="-iquote . -iquote \$(SRC_PATH)/accel/tcg -iquote 
\$(SRC_PATH)/include"
  QEMU_INCLUDES="$QEMU_INCLUDES -iquote \$(SRC_PATH)/disas/libvixl"
  if test "$debug_info" = "yes"; then
      CFLAGS="-g $CFLAGS"
---

