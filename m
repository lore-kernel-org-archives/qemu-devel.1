Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4F4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5BD20721
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnfyh9n6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5BD20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcYd-00005q-Ir
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdcXh-0007k3-M2; Tue, 26 May 2020 12:35:05 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:46670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdcXf-0005vA-RS; Tue, 26 May 2020 12:35:04 -0400
Received: by mail-ed1-x543.google.com with SMTP id m21so1652153eds.13;
 Tue, 26 May 2020 09:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CwD+5/sJjrX1n3x46dk05WNppGiKdaTTjs5dbKTiJVc=;
 b=lnfyh9n6eqnG/z0US/t7N/P9z2EQVGQfTP6tqD0uCwDD4OkAN2hy4ZLTBrUN4xTowO
 tZx7976Deo69SBr/m4NjeSG/7wFyf0v9jAPJDcYRes1MLgCqkiNtE47Sa2BXitOgcRQd
 ez3z6j8umiXknGIKbmeedlj2ZXcNDY0BDwn281ScyAYyJ4gEtdrzE2HpaJ2GP+IKFwd2
 4+K1VoiYy97G11In6WJF6DAtSIBG4kj7OoJUQRRLQSM/rUTvy/HPo/IQnUiNCFrMP9f7
 aD3E/AMjYafQnrnP3s4G1oXTmw6TLUnTfmo+Aof7P/+VGdvA4dM/gUqVJaVOaEIt18zx
 TC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CwD+5/sJjrX1n3x46dk05WNppGiKdaTTjs5dbKTiJVc=;
 b=NaPdtrpwIhB8BVNdUdmjaB/I1Lp0a9Sjt/BwFyXSySKUTN/kRH6ow8IHaFKCs3iW8x
 NXIHdeelKo+LlKsvrHPAXrG1fDD0D/jKbQWm9TOqC94OoYqeC86noQJFVHejUtVBNLme
 WKNIzil24R9g6BeNgV1kTDD8FKl9EB1ydgK5A8qrZ5wwcj/ZI2cffYUTr5/USE1e6WPX
 XCFKVEbnNBZAS+WBJkN41Vuc9InN284m8LsRxgtzk2bjleFCqiVy0QWMQkhnfVEwagoz
 2YtAH2FGCiNTTjlZW51c+ecmmKuqKPnJ/IlDDLITGirb0MGQas80CwpeA82hMiREyupX
 T0oQ==
X-Gm-Message-State: AOAM533gJ8AyCdrQuI4uA3xk8TWvQ46nyNMEZfPKZOYW09at6fPphO6Y
 wg/xl5OGUbu3UOrCTNJ8PV0lnjTMKJ8=
X-Google-Smtp-Source: ABdhPJzNl8p2EGcucUZK8OPqtAO7QmDhJbWwx645fAHiMoCwWbxqLr6eS+qgNPp4C4xliChqP2/opA==
X-Received: by 2002:a05:6402:2035:: with SMTP id
 ay21mr19837725edb.279.1590510901278; 
 Tue, 26 May 2020 09:35:01 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id nj6sm302535ejb.99.2020.05.26.09.34.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 09:35:00 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] hw/m68k/mcf52xx: Replace hw_error() by
 qemu_log_mask()
To: Thomas Huth <huth@tuxfamily.org>
References: <20200526094052.1723-1-f4bug@amsat.org>
 <20200526094052.1723-3-f4bug@amsat.org> <20200526180416.4f151f81@thl530>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d2171c12-ae7f-30aa-2361-30b8e58906c5@amsat.org>
Date: Tue, 26 May 2020 18:34:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200526180416.4f151f81@thl530>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 6:04 PM, Thomas Huth wrote:
> Am Tue, 26 May 2020 11:40:52 +0200
> schrieb Philippe Mathieu-Daudé <f4bug@amsat.org>:
> 
>> hw_error() calls exit(). This a bit overkill when we can log
>> the accesses as unimplemented or guest error.
>>
>> When fuzzing the devices, we don't want the whole process to
>> exit. Replace some hw_error() calls by qemu_log_mask().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> [...]
>> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
>> index b84c152ce3..108623b4ad 100644
>> --- a/hw/m68k/mcf5208.c
>> +++ b/hw/m68k/mcf5208.c
>> @@ -9,10 +9,10 @@
>>  #include "qemu/osdep.h"
>>  #include "qemu/units.h"
>>  #include "qemu/error-report.h"
>> +#include "qemu/log.h"
>>  #include "qapi/error.h"
>>  #include "qemu-common.h"
>>  #include "cpu.h"
>> -#include "hw/hw.h"
>>  #include "hw/irq.h"
>>  #include "hw/m68k/mcf.h"
>>  #include "hw/m68k/mcf_fec.h"
>> @@ -111,8 +111,9 @@ static void m5208_timer_write(void *opaque,
>> hwaddr offset, case 4:
>>          break;
>>      default:
>> -        hw_error("m5208_timer_write: Bad offset 0x%x\n",
>> (int)offset);
>> -        break;
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" PRIx64
>> "\n",
> 
> That likely should be HWADDR_PRIX, too? ... could be fixed up while
> applying the patch.

Oops yes. Thanks a lot!

> 
> With that:
> Reviewed-by: Thomas Huth <huth@tuxfamily.org>
> 
> 
>> +                      __func__, offset);
>> +        return;
>>      }
>>      m5208_timer_update(s);
>>  }
>> @@ -136,7 +137,8 @@ static uint64_t m5208_timer_read(void *opaque,
>> hwaddr addr, case 4:
>>          return ptimer_get_count(s->timer);
>>      default:
>> -        hw_error("m5208_timer_read: Bad offset 0x%x\n", (int)addr);
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"
>> HWADDR_PRIX "\n",
>> +                      __func__, addr);
>>          return 0;
>>      }
>>  }
>> @@ -164,7 +166,8 @@ static uint64_t m5208_sys_read(void *opaque,
>> hwaddr addr, return 0;
>>  
>>      default:
>> -        hw_error("m5208_sys_read: Bad offset 0x%x\n", (int)addr);
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"
>> HWADDR_PRIX "\n",
>> +                      __func__, addr);
>>          return 0;
>>      }
>>  }
>> @@ -172,7 +175,8 @@ static uint64_t m5208_sys_read(void *opaque,
>> hwaddr addr, static void m5208_sys_write(void *opaque, hwaddr addr,
>>                              uint64_t value, unsigned size)
>>  {
>> -    hw_error("m5208_sys_write: Bad offset 0x%x\n", (int)addr);
>> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX
>> "\n",
>> +                  __func__, addr);
>>  }
> 

