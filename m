Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1312BC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D0621E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D0621E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMo2-0004Fj-4q
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38591)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvMnc-0003mP-CT
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvMna-0007Yz-Ui
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:20:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42619)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvMna-0007Yc-O5
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:20:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so41680106wrr.9
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 07:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7zCKhnfIci6BG9SXoz6/fSN5BXrZhQg3pRdUFUWOWQg=;
 b=bCFITXZAQa8gIJrKL8EOYPi/jF9Y4fVu6hTI5lpTJLu+UeRfxyNjRLDvjZPisBAmFr
 qD84OCGDxpLuPGBog/+SFBGXeHwmb6l+xNK9oSWTBcsBiBSAPVmN5dMvv5qQ6VbzwPQy
 EhazK4Kb66E4prBV1kDwYO5T8vdqRxQCd5Na0F9gFW2k1rsOBux0JCmerJR+HLFQutV/
 QKDUMeN8VN3xCy9cknlw6iaeokStyNwZU3Eu/S+o5OK6ZUm/N//ZRsr/CfpxqKfd8L7l
 j8ClniCT+CvvwiRn6SA34W2EBO+6sc49+/GV6PmC77FQT3YYy2ZhZKRSQTb41fBYX3n9
 XVsw==
X-Gm-Message-State: APjAAAXr+SzCwwnI0NmKwydoNKrBzsHdThSkkVcGhlvREQDpclwxcHUI
 tvCs0mIs4DL0EpOr+NkAHeGyNrfIRDU=
X-Google-Smtp-Source: APXvYqxnD8Av8BSECwBZnkuo2uRoA12+GXfhxbMjJo3Fz61dqx8sbk7NgfrN9T40S2UDPYaP+lpmLw==
X-Received: by 2002:adf:f104:: with SMTP id r4mr11809946wro.140.1565187617095; 
 Wed, 07 Aug 2019 07:20:17 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id n9sm140591902wrp.54.2019.08.07.07.20.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 07:20:16 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-14-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2d099a8f-b73a-1729-98cb-132f6a2b2201@redhat.com>
Date: Wed, 7 Aug 2019 16:20:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806151435.10740-14-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 13/29] Clean up inclusion of
 exec/cpu-common.h
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/19 5:14 PM, Markus Armbruster wrote:
> migration/qemu-file.h neglects to include it even though it needs
> ram_addr_t.  Fix that.  Drop a few superfluous inclusions elsewhere.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  accel/stubs/tcg-stub.c          | 1 -
>  balloon.c                       | 1 -
>  hw/smbios/smbios.c              | 1 -
>  include/hw/hw.h                 | 1 -
>  include/hw/ppc/ppc4xx.h         | 1 -
>  include/migration/misc.h        | 1 -
>  include/sysemu/kvm_int.h        | 1 -
>  include/sysemu/memory_mapping.h | 1 -
>  migration/migration.h           | 1 -
>  migration/qemu-file-channel.c   | 1 -
>  migration/qemu-file.h           | 1 +
>  migration/vmstate-types.c       | 1 -
>  qom/cpu.c                       | 1 -
>  tcg/optimize.c                  | 1 -
>  tcg/tcg-common.c                | 1 -
>  tcg/tcg.c                       | 1 -
>  16 files changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
> index 76ae461749..e2d23edafe 100644
> --- a/accel/stubs/tcg-stub.c
> +++ b/accel/stubs/tcg-stub.c
> @@ -14,7 +14,6 @@
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "tcg/tcg.h"
> -#include "exec/cpu-common.h"
>  #include "exec/exec-all.h"
>  
>  void tb_flush(CPUState *cpu)
> diff --git a/balloon.c b/balloon.c
> index 914b3662db..f104b42961 100644
> --- a/balloon.c
> +++ b/balloon.c
> @@ -26,7 +26,6 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/atomic.h"
> -#include "exec/cpu-common.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/balloon.h"
>  #include "trace-root.h"
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 7bcd67b098..11d476c4a2 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -28,7 +28,6 @@
>  #include "hw/firmware/smbios.h"
>  #include "hw/loader.h"
>  #include "hw/boards.h"
> -#include "exec/cpu-common.h"
>  #include "smbios_build.h"
>  
>  /* legacy structures and constants for <= 2.0 machines */
> diff --git a/include/hw/hw.h b/include/hw/hw.h
> index 38d2fb1f40..86ff26b712 100644
> --- a/include/hw/hw.h
> +++ b/include/hw/hw.h
> @@ -6,7 +6,6 @@
>  #error Cannot include hw/hw.h from user emulation
>  #endif
>  
> -#include "exec/cpu-common.h"
>  #include "qom/object.h"
>  #include "exec/memory.h"
>  #include "migration/vmstate.h"
> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> index 90f8866138..7d82259051 100644
> --- a/include/hw/ppc/ppc4xx.h
> +++ b/include/hw/ppc/ppc4xx.h
> @@ -26,7 +26,6 @@
>  #define PPC4XX_H
>  
>  #include "hw/ppc/ppc.h"
> -#include "exec/cpu-common.h"
>  #include "exec/memory.h"
>  
>  /* PowerPC 4xx core initialization */
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 5cdbabd094..b9d8e787af 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -14,7 +14,6 @@
>  #ifndef MIGRATION_MISC_H
>  #define MIGRATION_MISC_H
>  
> -#include "exec/cpu-common.h"
>  #include "qemu/notify.h"
>  #include "qapi/qapi-types-net.h"
>  
> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> index 787dbc7770..5d341cc29b 100644
> --- a/include/sysemu/kvm_int.h
> +++ b/include/sysemu/kvm_int.h
> @@ -9,7 +9,6 @@
>  #ifndef QEMU_KVM_INT_H
>  #define QEMU_KVM_INT_H
>  
> -#include "exec/cpu-common.h"
>  #include "exec/memory.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/accel.h"
> diff --git a/include/sysemu/memory_mapping.h b/include/sysemu/memory_mapping.h
> index 1b440df486..4b20f1a639 100644
> --- a/include/sysemu/memory_mapping.h
> +++ b/include/sysemu/memory_mapping.h
> @@ -15,7 +15,6 @@
>  #define MEMORY_MAPPING_H
>  
>  #include "qemu/queue.h"
> -#include "exec/cpu-common.h"
>  #include "exec/cpu-defs.h"
>  #include "exec/memory.h"
>  
> diff --git a/migration/migration.h b/migration/migration.h
> index 1fdd7b21fd..26f01d00f6 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -16,7 +16,6 @@
>  
>  #include "qapi/qapi-types-migration.h"
>  #include "qemu/thread.h"
> -#include "exec/cpu-common.h"
>  #include "qemu/coroutine_int.h"
>  #include "hw/qdev.h"
>  #include "io/channel.h"
> diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channel.c
> index 8e639eb496..78ef248820 100644
> --- a/migration/qemu-file-channel.c
> +++ b/migration/qemu-file-channel.c
> @@ -24,7 +24,6 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu-file-channel.h"
> -#include "exec/cpu-common.h"
>  #include "qemu-file.h"
>  #include "io/channel-socket.h"
>  #include "qemu/iov.h"
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index 13baf896bd..21f3ae4be2 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -26,6 +26,7 @@
>  #define MIGRATION_QEMU_FILE_H
>  
>  #include <zlib.h>
> +#include "exec/cpu-common.h"
>  
>  /* Read a chunk of data from a file at the given position.  The pos argument
>   * can be ignored if the file is only be used for streaming.  The number of
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 845f4649ee..bee658a1b2 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -11,7 +11,6 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "exec/cpu-common.h"
>  #include "qemu-file.h"
>  #include "migration.h"
>  #include "migration/vmstate.h"
> diff --git a/qom/cpu.c b/qom/cpu.c
> index f376f782d8..fdc1af8f40 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -25,7 +25,6 @@
>  #include "qemu/notify.h"
>  #include "qemu/log.h"
>  #include "exec/log.h"
> -#include "exec/cpu-common.h"
>  #include "qemu/error-report.h"
>  #include "qemu/qemu-print.h"
>  #include "sysemu/sysemu.h"
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index d2424de4af..cee2a36a60 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -24,7 +24,6 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "exec/cpu-common.h"
>  #include "tcg-op.h"
>  
>  #define CASE_OP_32_64(x)                        \
> diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
> index 907d58d0f0..97305a3efc 100644
> --- a/tcg/tcg-common.c
> +++ b/tcg/tcg-common.c
> @@ -23,7 +23,6 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "exec/cpu-common.h"
>  #include "tcg/tcg.h"
>  
>  #if defined(CONFIG_TCG_INTERPRETER)
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index be2c33c400..2db83ce2e8 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -42,7 +42,6 @@
>  #define NO_CPU_IO_DEFS
>  #include "cpu.h"
>  
> -#include "exec/cpu-common.h"
>  #include "exec/exec-all.h"
>  
>  #if !defined(CONFIG_USER_ONLY)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

