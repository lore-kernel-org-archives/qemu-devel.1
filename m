Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08818ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 18:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85E320659
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 18:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85E320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLAN4-0005J5-W3
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 14:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLALs-0004Mz-KK
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLALp-0005fW-L7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:18:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLALp-0005fE-Dn
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:18:17 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 67F7D793F4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 18:18:16 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id s19so1406806wmj.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lpaVTB+bx8+jb/25p56LYk1n43CdvhdtwjXOqCPtJIU=;
 b=I9NWtKZkdBUAPQIQNt+/c7rPuz1eh+fRVZxE5Ecbt4NuSUY8Odz5RR2bDX7+nKq24R
 D2OYO5PiHgAPcwr3x14LiwpMb5tgAWY0spdxK1XswBeuF9qXEHpsM7MLMuB84VqvNp1y
 MxhxjcqvJT4S1Rzu2GIm81+UgYmnp+nfoNewQuXs+lZ4L2NhkRseTNR8y1qVVALlRf4/
 Vy9H8h4TAbphrKx907TgtVNB/92058vOIVMYfFdHtf9EpSxdwDAHL11lXLrHPpoNjWU2
 gJzqL52j6VzVdTKaK4+/KbbGr+32kV3Iq8YnLufHUGTM7w5lAbDkvUfHdKt5y4DF22rl
 OtJg==
X-Gm-Message-State: APjAAAU7JMZ+Xa2ld0J16VySqt3iMX69Y/rdYsaCzFxhtESXEcz5qRX6
 85Yj4GtLR3eSuSkX0Cio5xM81BMdVTiC75kt33vPawkClWpXsI/SmwZ2+BzxYxBHKe2s2no7/aa
 BeJpNxk050P89WOQ=
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr4258998wrv.5.1571336294638;
 Thu, 17 Oct 2019 11:18:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzmzo7VJ1Hp4a9B97yebAfvbgQbOJlzNcARidQ+450EHvCXnOthVkd4+Nv5hyVGUsuFbQxXMQ==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr4258980wrv.5.1571336294341;
 Thu, 17 Oct 2019 11:18:14 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id j1sm3967644wrg.24.2019.10.17.11.18.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 11:18:13 -0700 (PDT)
Subject: Re: [PATCH] hw/s390x: Emit a warning if user tried to enable USB
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20191017142123.1236-1-thuth@redhat.com>
 <20191017163402.43437191.cohuck@redhat.com>
 <2e689f2b-9bed-e40e-c761-6f38efaae635@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <181d44b3-3333-91a3-0003-d312e8ab4805@redhat.com>
Date: Thu, 17 Oct 2019 20:18:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2e689f2b-9bed-e40e-c761-6f38efaae635@redhat.com>
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 4:40 PM, Thomas Huth wrote:
> On 17/10/2019 16.34, Cornelia Huck wrote:
>> On Thu, 17 Oct 2019 16:21:23 +0200
>> Thomas Huth <thuth@redhat.com> wrote:
>>
>>> There is no USB on s390x, so running qemu-system-s390x with
>>> "-machine ...,usb=on" is certainly wrong. Emit a warning to make
>>> the users aware of their misconfiguration.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   After a year or two, we could finally turn this into a hard error,
>>>   but I think we should give the users some time to fix their command
>>>   lines first, so I'm initially only emitting a warning here.
>>>
>>>   hw/s390x/s390-virtio-ccw.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>> index d3edeef0ad..af8c4c0daf 100644
>>> --- a/hw/s390x/s390-virtio-ccw.c
>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>> @@ -243,6 +243,10 @@ static void ccw_init(MachineState *machine)
>>>       VirtualCssBus *css_bus;
>>>       DeviceState *dev;
>>>   
>>> +    if (machine->usb) {
>>> +        warn_report("This machine does not support USB");
>>
>> I'm wondering if this is the only machine type not supporting usb...
>> if not, how are others handling it?
> 
> I think most machines are silently ignoring it, like we did on s390x
> until now, too.
> 
>> The usb parsing code in machine.c does not care if usb is even
>> configured (CONFIG_USB).
> 
> machine.c is common code, so you can not use CONFIG_USB there.

We already have:

bool target_words_bigendian(void)
{
#if defined(TARGET_WORDS_BIGENDIAN)
     return true;
#else
     return false;
#endif
}

What about something such:

-- >8 --
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1689ad3bf8..0c45ab042b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -986,7 +986,7 @@ static void machine_finalize(Object *obj)

  bool machine_usb(MachineState *machine)
  {
-    return machine->usb;
+    return machine_has_usb() && machine->usb;
  }

  bool machine_kernel_irqchip_allowed(MachineState *machine)
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 303ac084a0..ac545cdd2e 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -1,6 +1,7 @@
  # usb subsystem core
  common-obj-y += core.o combined-packet.o bus.o libhw.o
  common-obj-$(CONFIG_USB) += desc.o desc-msos.o
+obj-y += machine.o

  # usb host adapters
  common-obj-$(CONFIG_USB_UHCI) += hcd-uhci.o
diff --git a/hw/usb/machine.c b/hw/usb/machine.c
new file mode 100644
index 0000000000..5381928479
--- /dev/null
+++ b/hw/usb/machine.c
@@ -0,0 +1,12 @@
+#include "qemu/osdep.h"
+#include "hw/boards.h"
+#include "config-devices.h"
+
+bool machine_has_usb(void)
+{
+#if defined(CONFIG_USB)
+    return true;
+#else
+    return false;
+#endif
+}
diff --git a/include/hw/boards.h b/include/hw/boards.h
index be18a5c032..e4518b73b1 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -63,6 +63,7 @@ extern MachineState *current_machine;

  void machine_run_board_init(MachineState *machine);
  bool machine_usb(MachineState *machine);
+bool machine_has_usb(void); /* or target_has_usb()? */
  bool machine_kernel_irqchip_allowed(MachineState *machine);
  bool machine_kernel_irqchip_required(MachineState *machine);
  bool machine_kernel_irqchip_split(MachineState *machine);

---

