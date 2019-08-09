Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFF9C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 019A52166E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019A52166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw1mZ-0005i7-4z
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 06:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54922)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hw1ly-0005FU-KN
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hw1lw-0003Ph-Tf
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:05:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36113)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hw1lw-0003PQ-Mx
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:05:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so3951929wrt.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 03:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vmh6gHXXJ/NW46LyZwXgIRuGJQD6Mq+RG/174vKxPC0=;
 b=XdGzDcuPgfyl/G6D/NhDW9ZiHEYyznTH6w2eYVKSeuEyJBCva5M400Qu1fdbjnOVTa
 XJiaiF2GxRFxkTYPM17t9tgjxELLn9KDQGR7kpZ92KC5Lx2OrTS4QAj6z1UcY47Ztjy1
 rmdhhON8uQ46eyt8D+lCAMORglsN+C/2+wou5sGLWaOUFQSjz7Qz8RzCSIjo/537cbrx
 I7fwLDVdg4B3MHETc/x9f+pQIPSEPu2SkdAQTEkUjyKuLgANZW3QGFxkkyWe+gEZV1KG
 o0IJjtUdPVTTkgR3q6b69qAoKQtXdTdGA2Iz8SGME3ySf2KP0+FTGJycOIf0qmYVIlOe
 FxCA==
X-Gm-Message-State: APjAAAV1BThqAx6Lk87Rxf30kp8WuBVKcxguSCJScu1M0QELTjGFUaMq
 MPR5StXdZRYsKBLgVDJsucdQYyVVKKU=
X-Google-Smtp-Source: APXvYqxf/wKVZWGkrTWfy1qGOBpaTjdde5WKTGPIsG4uRzBGdwdijM6qgtDjROk9w5fSwxRYQHC0EA==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr23709900wrs.88.1565345119466; 
 Fri, 09 Aug 2019 03:05:19 -0700 (PDT)
Received: from [192.168.50.36] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id z2sm2926040wmi.2.2019.08.09.03.05.18
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 03:05:18 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190809064645.22656-1-armbru@redhat.com>
 <20190809064645.22656-20-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <47188c22-a0c4-a300-c4a2-4c9d9f95c306@redhat.com>
Date: Fri, 9 Aug 2019 12:05:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190809064645.22656-20-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v3 19/29] Include qemu/queue.h slightly less
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

On 8/9/19 8:46 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/scsi/vhost-scsi.c        | 1 -
>  hw/vfio/ap.c                | 1 -
>  include/exec/cpu-defs.h     | 1 -
>  include/hw/xen/xen_common.h | 1 -
>  include/net/can_emu.h       | 1 +
>  include/net/filter.h        | 1 +
>  include/qemu/range.h        | 2 --
>  include/qom/object.h        | 1 -
>  include/sysemu/cryptodev.h  | 1 +
>  include/sysemu/rng.h        | 1 +
>  include/sysemu/sysemu.h     | 1 -
>  linux-user/elfload.c        | 1 +
>  linux-user/main.c           | 1 +
>  linux-user/qemu.h           | 1 -
>  linux-user/syscall.c        | 1 +
>  nbd/client.c                | 1 +
>  nbd/nbd-internal.h          | 1 -
>  nbd/server.c                | 1 +
>  qapi/qapi-dealloc-visitor.c | 1 -
>  target/i386/whpx-all.c      | 1 -
>  ui/kbd-state.c              | 1 -
>  util/vfio-helpers.c         | 1 -
>  22 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index 343ca8be7a..83c9d83459 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -20,7 +20,6 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
> -#include "qemu/queue.h"
>  #include "monitor/monitor.h"
>  #include "migration/blocker.h"
>  #include "hw/virtio/vhost-scsi.h"
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index d1c86abb76..2bfc402037 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -20,7 +20,6 @@
>  #include "hw/s390x/ap-device.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
> -#include "qemu/queue.h"
>  #include "qemu/option.h"
>  #include "qemu/config-file.h"
>  #include "cpu.h"
> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
> index 9bc713a70b..57a9a4ffd9 100644
> --- a/include/exec/cpu-defs.h
> +++ b/include/exec/cpu-defs.h
> @@ -25,7 +25,6 @@
>  
>  #include "qemu/host-utils.h"
>  #include "qemu/thread.h"
> -#include "qemu/queue.h"
>  #ifdef CONFIG_TCG
>  #include "tcg-target.h"
>  #endif
> diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
> index 1e3ec4e16e..82e56339dd 100644
> --- a/include/hw/xen/xen_common.h
> +++ b/include/hw/xen/xen_common.h
> @@ -16,7 +16,6 @@
>  
>  #include "hw/xen/xen.h"
>  #include "hw/pci/pci.h"
> -#include "qemu/queue.h"
>  #include "hw/xen/trace.h"
>  
>  extern xc_interface *xen_xc;
> diff --git a/include/net/can_emu.h b/include/net/can_emu.h
> index 1da4d01b95..d4fc51b57d 100644
> --- a/include/net/can_emu.h
> +++ b/include/net/can_emu.h
> @@ -28,6 +28,7 @@
>  #ifndef NET_CAN_EMU_H
>  #define NET_CAN_EMU_H
>  
> +#include "qemu/queue.h"
>  #include "qom/object.h"
>  
>  /* NOTE: the following two structures is copied from <linux/can.h>. */
> diff --git a/include/net/filter.h b/include/net/filter.h
> index 9bc6fa3cc6..e8fb6259db 100644
> --- a/include/net/filter.h
> +++ b/include/net/filter.h
> @@ -10,6 +10,7 @@
>  #define QEMU_NET_FILTER_H
>  
>  #include "qapi/qapi-types-net.h"
> +#include "qemu/queue.h"
>  #include "qom/object.h"
>  #include "net/queue.h"
>  
> diff --git a/include/qemu/range.h b/include/qemu/range.h
> index 71b8b215c6..f62b363e0d 100644
> --- a/include/qemu/range.h
> +++ b/include/qemu/range.h
> @@ -20,8 +20,6 @@
>  #ifndef QEMU_RANGE_H
>  #define QEMU_RANGE_H
>  
> -#include "qemu/queue.h"
> -
>  /*
>   * Operations on 64 bit address ranges.
>   * Notes:
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 7bb82a7f56..128d00c77f 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -15,7 +15,6 @@
>  #define QEMU_OBJECT_H
>  
>  #include "qapi/qapi-builtin-types.h"
> -#include "qemu/queue.h"
>  #include "qemu/module.h"
>  
>  struct TypeImpl;
> diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
> index 92bbb79131..a9afb7e5b5 100644
> --- a/include/sysemu/cryptodev.h
> +++ b/include/sysemu/cryptodev.h
> @@ -23,6 +23,7 @@
>  #ifndef CRYPTODEV_H
>  #define CRYPTODEV_H
>  
> +#include "qemu/queue.h"
>  #include "qom/object.h"
>  
>  /**
> diff --git a/include/sysemu/rng.h b/include/sysemu/rng.h
> index 2a02f47771..9b22c156f8 100644
> --- a/include/sysemu/rng.h
> +++ b/include/sysemu/rng.h
> @@ -13,6 +13,7 @@
>  #ifndef QEMU_RNG_H
>  #define QEMU_RNG_H
>  
> +#include "qemu/queue.h"
>  #include "qom/object.h"
>  
>  #define TYPE_RNG_BACKEND "rng-backend"
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 984c439ac9..77f5df59b0 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -3,7 +3,6 @@
>  /* Misc. things related to the system emulator.  */
>  
>  #include "qapi/qapi-types-run-state.h"
> -#include "qemu/queue.h"
>  #include "qemu/timer.h"
>  #include "qemu/notify.h"
>  #include "qemu/main-loop.h"
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index bd43c4817d..3365e192eb 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -8,6 +8,7 @@
>  #include "qemu.h"
>  #include "disas/disas.h"
>  #include "qemu/path.h"
> +#include "qemu/queue.h"
>  #include "qemu/guest-random.h"
>  
>  #ifdef _ARCH_PPC64
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 8ffc525195..47917bbb20 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -28,6 +28,7 @@
>  #include "qapi/error.h"
>  #include "qemu.h"
>  #include "qemu/path.h"
> +#include "qemu/queue.h"
>  #include "qemu/config-file.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index aac0334627..f6f5fe5fbb 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -16,7 +16,6 @@
>  #include "syscall_defs.h"
>  #include "target_syscall.h"
>  #include "exec/gdbstub.h"
> -#include "qemu/queue.h"
>  
>  /* This is the size of the host kernel's sigset_t, needed where we make
>   * direct system calls that take a sigset_t pointer and a size.
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8367cb138d..8b41a03901 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -20,6 +20,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "qemu/path.h"
> +#include "qemu/queue.h"
>  #include <elf.h>
>  #include <endian.h>
>  #include <grp.h>
> diff --git a/nbd/client.c b/nbd/client.c
> index 4de30630c7..d554ae353d 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -19,6 +19,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qemu/queue.h"
>  #include "trace.h"
>  #include "nbd-internal.h"
>  #include "qemu/cutils.h"
> diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
> index 049f83df77..ec3d2e2ebc 100644
> --- a/nbd/nbd-internal.h
> +++ b/nbd/nbd-internal.h
> @@ -28,7 +28,6 @@
>  #endif
>  
>  #include "qemu/bswap.h"
> -#include "qemu/queue.h"
>  #include "qemu/main-loop.h"
>  
>  /* This is all part of the "official" NBD API.
> diff --git a/nbd/server.c b/nbd/server.c
> index 10faedcfc5..dbd2ff8555 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -19,6 +19,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qemu/queue.h"
>  #include "trace.h"
>  #include "nbd-internal.h"
>  #include "qemu/units.h"
> diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
> index 89ccd905ec..d192724b13 100644
> --- a/qapi/qapi-dealloc-visitor.c
> +++ b/qapi/qapi-dealloc-visitor.c
> @@ -15,7 +15,6 @@
>  #include "qemu/osdep.h"
>  #include "qapi/dealloc-visitor.h"
>  #include "qapi/qmp/qnull.h"
> -#include "qemu/queue.h"
>  #include "qapi/visitor-impl.h"
>  
>  struct QapiDeallocVisitor
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index ed95105eae..2cf66f7804 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -20,7 +20,6 @@
>  #include "qemu/main-loop.h"
>  #include "hw/boards.h"
>  #include "qemu/error-report.h"
> -#include "qemu/queue.h"
>  #include "qapi/error.h"
>  #include "migration/blocker.h"
>  #include "whp-dispatch.h"
> diff --git a/ui/kbd-state.c b/ui/kbd-state.c
> index 1668d17dda..62d42a7a22 100644
> --- a/ui/kbd-state.c
> +++ b/ui/kbd-state.c
> @@ -5,7 +5,6 @@
>   */
>  #include "qemu/osdep.h"
>  #include "qemu/bitmap.h"
> -#include "qemu/queue.h"
>  #include "ui/console.h"
>  #include "ui/input.h"
>  #include "ui/kbd-state.h"
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 2367fe8f7f..26ffd0d6b5 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -17,7 +17,6 @@
>  #include "exec/ramlist.h"
>  #include "exec/cpu-common.h"
>  #include "trace.h"
> -#include "qemu/queue.h"
>  #include "qemu/error-report.h"
>  #include "standard-headers/linux/pci_regs.h"
>  #include "qemu/event_notifier.h"
> 

A lot less, nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

