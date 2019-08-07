Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB29C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F69621BF6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F69621BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvL1A-0006Ws-Ck
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 08:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40531)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvL0c-00066i-L5
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvL0b-0004KB-Jt
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:25:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45152)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvL0b-0004Jj-ED
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:25:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id q12so904836wrj.12
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 05:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eIVfm6yGdKieemZGo1slQ7XXV4JAEU999wYDCxoPg5w=;
 b=ldhrCKrwuBmy9h0O9vytnUuw6fvO7nlqyHOAHwRJ6zMwFhAKPG38xmLrbO/8nYyHFM
 cS31HyFhUEiwQNoXvDGueBG7ONxR6Y+rywlV0ITsZp5heqqXADKNj7gpXGW4IxJGA4s7
 YXFsh8/nnB+VeVOCtY+r3TA9hF6/eCrdw3rwDVOe7vJbOP0A18fGTuQpjXIBawckeMLH
 uxL9yELLcMSr5Uyh7RvG9dTMIKsrwzmOYk+sp3t/R3rxxCdbc4qdWthN/nBnCuC8L5S7
 cAduhA4yZ/Y+raaiet8AoPMOllONmhpTZ49OfVA2KL6O0tKpLJwR3yhV+du9e7Jvk5Rb
 V5QA==
X-Gm-Message-State: APjAAAXfo80T7PpEqPE9YgLsBWrLBDBKSZOQj5OAoHBhQ1T7YZ4VuBkB
 8eDGg3ZyaP9YCEYREn05jO9TdvWHBq8=
X-Google-Smtp-Source: APXvYqz6jelG3vRhhc9s2GqJGe5kxXVrIoZtBZ1OkznO+ccFT50f2lveVMcsk49ZjxoE/lr4pmHITQ==
X-Received: by 2002:a5d:4a42:: with SMTP id v2mr1583772wrs.186.1565180735924; 
 Wed, 07 Aug 2019 05:25:35 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id g19sm112308647wmg.10.2019.08.07.05.25.35
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 05:25:35 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-10-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b14e627d-d9e0-bd33-9f6f-c3e5cb59f8cd@redhat.com>
Date: Wed, 7 Aug 2019 14:25:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806151435.10740-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 09/29] Include
 migration/qemu-file-types.h a lot less
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
> In my "build everything" tree, changing migration/qemu-file-types.h
> triggers a recompile of some 2600 out of 6600 objects (not counting
> tests and objects that don't depend on qemu/osdep.h).
> 
> The culprit is again hw/hw.h, which supposedly includes it for
> convenience.
> 
> Include migration/qemu-file-types.h only where it's needed.  Touching
> it now recompiles less than 200 objects.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/acpi/piix4.c             | 1 +
>  hw/block/virtio-blk.c       | 1 +
>  hw/char/virtio-serial-bus.c | 1 +
>  hw/display/virtio-gpu.c     | 1 +
>  hw/intc/apic_common.c       | 1 +
>  hw/nvram/eeprom93xx.c       | 1 +
>  hw/nvram/fw_cfg.c           | 1 +
>  hw/pci-host/piix.c          | 1 +
>  hw/pci/msix.c               | 1 +
>  hw/pci/pci.c                | 1 +
>  hw/pci/shpc.c               | 1 +
>  hw/ppc/spapr.c              | 1 +
>  hw/s390x/s390-skeys.c       | 1 +
>  hw/s390x/tod.c              | 1 +
>  hw/s390x/virtio-ccw.c       | 1 +
>  hw/scsi/mptsas.c            | 1 +
>  hw/scsi/scsi-bus.c          | 1 +
>  hw/scsi/scsi-disk.c         | 1 +
>  hw/scsi/scsi-generic.c      | 1 +
>  hw/scsi/virtio-scsi.c       | 1 +
>  hw/timer/i8254_common.c     | 1 +
>  hw/timer/twl92230.c         | 1 +
>  hw/usb/redirect.c           | 1 +
>  hw/virtio/vhost.c           | 1 +
>  hw/virtio/virtio-mmio.c     | 1 +
>  hw/virtio/virtio-pci.c      | 1 +
>  hw/virtio/virtio.c          | 1 +
>  include/hw/hw.h             | 1 -
>  include/migration/cpu.h     | 1 +
>  target/ppc/kvm.c            | 1 +
>  30 files changed, 29 insertions(+), 1 deletion(-)
[...]
> diff --git a/include/hw/hw.h b/include/hw/hw.h
> index a4fb2390e8..b399627cbe 100644
> --- a/include/hw/hw.h
> +++ b/include/hw/hw.h
> @@ -11,7 +11,6 @@
>  #include "exec/memory.h"
>  #include "hw/irq.h"
>  #include "migration/vmstate.h"
> -#include "migration/qemu-file-types.h"

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>  void QEMU_NORETURN hw_error(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  
> diff --git a/include/migration/cpu.h b/include/migration/cpu.h
> index 8424f1631a..21c4fc9eab 100644
> --- a/include/migration/cpu.h
> +++ b/include/migration/cpu.h
> @@ -3,6 +3,7 @@
>  #define MIGRATION_CPU_H
>  
>  #include "exec/cpu-defs.h"
> +#include "migration/qemu-file-types.h"
>  
>  #if TARGET_LONG_BITS == 64
>  #define qemu_put_betl qemu_put_be64
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8a06d3171e..4bd95be9cd 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -38,6 +38,7 @@
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/ppc/ppc.h"
> +#include "migration/qemu-file-types.h"
>  #include "sysemu/watchdog.h"
>  #include "trace.h"
>  #include "exec/gdbstub.h"
> 

