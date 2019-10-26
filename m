Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B72CA9EBD
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 13:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67353222D2
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 13:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67353222D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOM1L-0004tm-B0
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 09:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOLzf-0003Dl-8I
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 09:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOLzb-0005EJ-PI
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 09:20:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38846)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOLzb-00059i-Em
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 09:20:31 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B929F59449
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 13:20:26 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id a15so2959770wrr.0
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 06:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3l9obMCJnffoqaUMu8c1foElODV0vWG4czi5gqPWIzI=;
 b=qD9EfHlwKraixf9r/CRIVi9Y3X3UsinrCqaoBkearUTTn5XESLJMbjs46vPAKv82oC
 Ak8MDE9A8FvLc+i6CEN7xHlkDLNEIwi6MHV4Ge+IJWgyQV0xlPP879Qw83hevgpG44Vk
 pafLvUwAz6zpffsfRqvl+KzuDwRT9GjXBc0HsPMgRiqI9R8/FCxJYNLDwNvcS50LbbM6
 YmNdxza5QNJhkT2ZiYKKt4Ic5yYzaG19nBns0TvmBpum9e8ikZjoJGlEe8A+nyPXAI7s
 dpqPzp8G4mDGqPUOD7vERsZUfKrdQmtDgHQX3f7sADl2B0XNv5qAsm6NcWmjCf70U275
 +Muw==
X-Gm-Message-State: APjAAAUFq4FqGEOJRDR01/ZM6rZ0R5x21DZqG5a6pxVQ2jMZ9eTamb/b
 MOqWHYSMgKVfdXl8WA+m0OleaaQ6Hm4wQXYTwhZT4qpRrmu3htRb1NAg7JM9rBJO+dVNR+y5H20
 fFAtZG0AwwZ44loE=
X-Received: by 2002:a1c:7401:: with SMTP id p1mr7510817wmc.144.1572096025019; 
 Sat, 26 Oct 2019 06:20:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyuN0rcFe4OAUy9sEJxx5aOne8IEInZm+NGwlUEbzhPn2nbrQY263F1guxBWxZMCV/6AEp+vw==
X-Received: by 2002:a1c:7401:: with SMTP id p1mr7510806wmc.144.1572096024825; 
 Sat, 26 Oct 2019 06:20:24 -0700 (PDT)
Received: from [192.168.1.33] (62.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.62])
 by smtp.gmail.com with ESMTPSA id s5sm1140300wmj.37.2019.10.26.06.20.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Oct 2019 06:20:24 -0700 (PDT)
Subject: Re: [PULL 00/39] Misc (mostly x86) patches for 2019-10-24
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA-1gWa8qRK85i+MP-UixiPq7NPHw+8kn6KPq6VQMtRt4g@mail.gmail.com>
 <d599e5c5-0963-bf02-df88-0e01ee739c93@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d7fbed89-29f9-7b4f-b894-9fd78dc9ce73@redhat.com>
Date: Sat, 26 Oct 2019 15:20:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d599e5c5-0963-bf02-df88-0e01ee739c93@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/19 1:17 PM, Paolo Bonzini wrote:
> On 25/10/19 12:46, Peter Maydell wrote:
>>
>> x86_register_ferr_irq() is defined in target/i386/fpu_helper.c,
>> which is only built if CONFIG_TCG, but the callers don't
>> seem to be similarly guarded and there's no stub fallback.
> 
> Indeed, thanks.  I'll add an "if (tcg_enabled())" since this feature is
> not supported by accelerators other than TCG.

Paolo, since the "Split timer <-> rtc" series got merged via
the trivial tree, you need to squash this fix to patch #33
("mc146818rtc: Include mc146818rtc_regs.h directly in
  mc146818rtc.c") to avoid build failure:

-- >8 --
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index bbe6783898..9f5dd47fb6 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -42,7 +42,7 @@
  #include "qapi/qapi-events-misc-target.h"
  #include "qapi/visitor.h"
  #include "exec/address-spaces.h"
-#include "hw/timer/mc146818rtc_regs.h"
+#include "hw/rtc/mc146818rtc_regs.h"

  #ifdef TARGET_I386
  #include "hw/i386/apic.h"
---

Regards,

Phil.

