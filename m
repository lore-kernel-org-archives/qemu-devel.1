Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135EBC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D554121852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D554121852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAAOO-0008DR-2F
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAAKx-00059o-2H
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAAKu-0003MT-By
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:03:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAAKt-0003K0-UO
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:03:52 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DF6C88553A
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 10:03:50 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id m14so1108958wru.17
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 03:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3+afwFZpDz4drxhEg51Q+8ZlZcQqE592fqIFd+/NFmM=;
 b=KDQEUEoT+VpCdki5bxqSlov8C9xNPGEWBwwvm9jevuaHkbYd8+lWUzSH2esI+4aqiF
 pSTOu3FPDojE/34TFAdnI+qQIhiykMBawR61W2H1Uq8Y2wOzgyFujA62cfhZIhCVDXKJ
 SRYsOu297HFsEoNaSGwAUpH0VbzRjWhGueZILm+4AFJAKbMcEHwYsB7cUzXiQayJyk5B
 OUbbJkiwEokkyPJNiACR1a0WrEcKmuh/9CNmgJR08uGn5z3PIZ3BrP/OjeICkFgzlS7s
 wjVz6/S7RkKb1+7XB4W7s5rwLU6BWaapPUZk5cf2emJvgOn3r9oREqVhvqOd5U/7ztlA
 4pMg==
X-Gm-Message-State: APjAAAVcxWZ5OXcsw0QPqkaUQ1qFQvwipFHghIvZqgmK/FQGBtEYho+E
 m6qkHUx/tVUOA2ME9mpEV6ULun0LjzqPAHigGqoSGX+AS+PP1/34hDk6oQcq5MebFoKCCLSwzXa
 VmqK5bkzrH/FKgzQ=
X-Received: by 2002:a1c:a8cb:: with SMTP id r194mr2736616wme.156.1568714629384; 
 Tue, 17 Sep 2019 03:03:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyWBHhwZmTJh6SFpuqliFIeD+lO0EJas8rgr5e7IP/fOavk4cyu11TICgjLe3pCFv9Ewzhgow==
X-Received: by 2002:a1c:a8cb:: with SMTP id r194mr2736575wme.156.1568714629145; 
 Tue, 17 Sep 2019 03:03:49 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id r12sm1655754wrq.88.2019.09.17.03.03.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2019 03:03:48 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-4-philmd@redhat.com>
 <c5caa155-19d3-1b22-ea61-d8c17dca39e7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6f9f0932-5420-c67f-b6f7-2a7ceb4e99a4@redhat.com>
Date: Tue, 17 Sep 2019 12:03:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c5caa155-19d3-1b22-ea61-d8c17dca39e7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 03/13] hw: Move MC146818 device from
 hw/timer/ to hw/rtc/ subdirectory
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 7:07 AM, Thomas Huth wrote:
> On 16/09/2019 17.48, Philippe Mathieu-Daud=C3=A9 wrote:
>> The MC146818 is a Real Time Clock, not a timer.
>> Move it under the hw/rtc/ subdirectory.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> [...]
>> diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc=
.h
>> new file mode 100644
>> index 0000000000..888e04f9ab
>> --- /dev/null
>> +++ b/include/hw/rtc/mc146818rtc.h
>> @@ -0,0 +1,38 @@
>> +/*
>> + * QEMU MC146818 RTC emulation
>> + *
>> + * Copyright (c) 2003-2004 Fabrice Bellard
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtain=
ing a copy
>> + * of this software and associated documentation files (the "Software=
"), to deal
>> + * in the Software without restriction, including without limitation =
the rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/=
or sell
>> + * copies of the Software, and to permit persons to whom the Software=
 is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be inc=
luded in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EX=
PRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT =
SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES =
OR OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, AR=
ISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEAL=
INGS IN
>> + * THE SOFTWARE.
>> + */
>=20
> If you run "git blame" on the old header file, it does not seem like
> Fabrice wrote this header, so I'm not sure whether it makes sense to ad=
d
> his (c) statement here?
>=20
> Maybe rather use a one-line "SPDX-License-Identifier: GPL-2.0-or-later"
> here?

It was first added by Fabrice here:

$ git show 80cabfad163
[...]
> diff --git a/hw/mc146818rtc.c b/hw/mc146818rtc.c
new file mode 100644
index 0000000000..cab76cfab2
--- /dev/null
+++ b/hw/mc146818rtc.c
@@ -0,0 +1,203 @@
+/*
+ * QEMU MC146818 RTC emulation
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person
obtaining a copy
+ * of this software and associated documentation files (the
"Software"), to deal
+ * in the Software without restriction, including without limitation
the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be
included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN
+ * THE SOFTWARE.
+ */[...]
diff --git a/vl.h b/vl.h
index 35962d1985..026a5dee5a 100644
--- a/vl.h
+++ b/vl.h
+/* mc146818rtc.c */
+
+typedef struct RTCState {
+    uint8_t cmos_data[128];
+    uint8_t cmos_index;
+    int irq;
+} RTCState;
+
+extern RTCState rtc_state;
+
+void rtc_init(int base, int irq);
+void rtc_timer(void);

Then moved from vl.h to pc.h:

$ git show 87ecb68bdf8
commit 87ecb68bdf8a3e40ef885ddbb7ca1797dca40ebf
Author: pbrook <pbrook@c046a42c-6fe2-441c-8c8c-71466251a162>
Date:   Sat Nov 17 17:14:51 2007 +0000

    Break up vl.h.

Then moved from pc.h to mc146818rtc.h without adding the (c):

$ git show e1460e4707c
commit e1460e4707cd80982add597f5cb421289db84e4e
Author: Isaku Yamahata <yamahata@valinux.co.jp>
Date:   Fri May 14 16:29:16 2010 +0900

    pc: move rtc declarations from pc.h into a dedicated header file.

    Move rtc_xxx declarations from pc.h into mc146818rtc.h.

    Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
    Acked-by: Gerd Hoffmann <kraxel@redhat.com>
    Signed-off-by: Blue Swirl <blauwirbel@gmail.com>

diff --git a/hw/mc146818rtc.h b/hw/mc146818rtc.h
new file mode 100644
index 0000000000..7211dae37e
--- /dev/null
+++ b/hw/mc146818rtc.h
@@ -0,0 +1,10 @@
+#ifndef MC146818RTC_H
+#define MC146818RTC_H
+
+typedef struct RTCState RTCState;
+
+RTCState *rtc_init(int base_year);
+void rtc_set_memory(RTCState *s, int addr, int val);
+void rtc_set_date(RTCState *s, const struct tm *tm);
+
+#endif /* !MC146818RTC_H */
diff --git a/hw/pc.h b/hw/pc.h
index 8cfec6c0dc..e3cc0a58bd 100644
--- a/hw/pc.h
+++ b/hw/pc.h
@@ -5,6 +5,7 @@
 #include "ioport.h"
 #include "isa.h"
 #include "fdc.h"
+#include "mc146818rtc.h"

 /* PC-style peripherals (also used by other machines).  */

@@ -76,14 +77,6 @@ void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_ir=
q,
                    target_phys_addr_t base, ram_addr_t size,
                    target_phys_addr_t mask);

-/* mc146818rtc.c */
-
-typedef struct RTCState RTCState;
-
-RTCState *rtc_init(int base_year);
-void rtc_set_memory(RTCState *s, int addr, int val);
-void rtc_set_date(RTCState *s, const struct tm *tm);

So the (c) looks correct to me. Do you still disagree?

