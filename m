Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28124C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFCD121BE6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCD121BE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvIeD-00050E-Au
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33719)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvIdo-0004ai-Dj
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvIdm-00072U-RG
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:53:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvIdm-00072G-Kw
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:53:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so81174257wml.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 02:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=spBYbDwCVC5Tu9h1mLOEjUoNEPQQsNdeqREpu0OhMNo=;
 b=acJ5gJUVKiOGGAjp+X1ZvGyDd6unblrCGrdE1poCtqL/69qfMzB/3/Zg/UYEmQP+ma
 Uu53IMwdca4YfYLBm7iaOB5moBIrVc/BN1MNJV3XVYW7XRtYrwbloGUy74mnsbz6Mz2t
 kvdI9JzjGeEkoVJKQulcpT+hm/3GVIc2LAhVx694ILxWQBzRVebTYCap7M9zn5pVyaYs
 hHDOk8ylsVIY6EY3NSdSubY+3k/RVGrkHhJh30QVsD4eanP9hDHz9xtsqitsaoF3JY88
 aPyh5kGVlqB+RGnVsNVq5uNI+BCHv8uWwTkikWB03h1dmVu120tsEapYp+d1etujr2Uh
 U74g==
X-Gm-Message-State: APjAAAVaoNphohJ8IRID10sdfzVBrrbsIzResl0MKf5O9gamDfEvea1z
 2XvO8sxi+9lXHzkYP/7xQty0OFW1/s4=
X-Google-Smtp-Source: APXvYqxicFudD2r2sNKecA325QxPDQ1BiIcQfukzWzBQFpZt4j3www4/+VvrbjXj04e4iPTqUwth1w==
X-Received: by 2002:a1c:a1c1:: with SMTP id k184mr10086132wme.81.1565171633331; 
 Wed, 07 Aug 2019 02:53:53 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id f17sm88040321wmf.27.2019.08.07.02.53.52
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 02:53:52 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f115e089-ee3b-b919-7081-5440237b4aad@redhat.com>
Date: Wed, 7 Aug 2019 11:53:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806151435.10740-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 02/29] Include generated QAPI headers
 less
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
> Some of the generated qapi-types-MODULE.h are included all over the
> place.  Changing a QAPI type can trigger massive recompiling.  Top
> scorers recompile more than 1000 out of some 6600 objects (not
> counting tests and objects that don't depend on qemu/osdep.h):
> 
>     6300 qapi/qapi-builtin-types.h
>     5700 qapi/qapi-types-run-state.h
>     3900 qapi/qapi-types-common.h
>     3300 qapi/qapi-types-sockets.h
>     3000 qapi/qapi-types-misc.h
>     3000 qapi/qapi-types-crypto.h
>     3000 qapi/qapi-types-job.h
>     3000 qapi/qapi-types-block-core.h
>     2800 qapi/qapi-types-block.h
>     1300 qapi/qapi-types-net.h
> 
> Clean up headers to include generated QAPI headers only where needed.
> Impact is negligible except for hw/qdev-properties.h.
> 
> This header includes qapi/qapi-types-block.h and
> qapi/qapi-types-misc.h.  They are used only in expansions of property
> definition macros such as DEFINE_PROP_BLOCKDEV_ON_ERROR() and
> DEFINE_PROP_OFF_AUTO().  Moving their inclusion from
> hw/qdev-properties.h to the users of these macros avoids pointless
> recompiles.  This is how other property definition macros, such as
> DEFINE_PROP_NETDEV(), already work.
> 
> Improves things for some of the top scorers:
> 
>     3600 qapi/qapi-types-common.h
>     2800 qapi/qapi-types-sockets.h
>      900 qapi/qapi-types-misc.h
>     2200 qapi/qapi-types-crypto.h
>     2100 qapi/qapi-types-job.h
>     2100 qapi/qapi-types-block-core.h
>      270 qapi/qapi-types-block.h
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/core/qdev-properties.c            | 2 ++
>  hw/i386/kvm/i8254.c                  | 1 +
>  hw/ide/qdev.c                        | 1 +
>  include/authz/listfile.h             | 1 -
>  include/block/block.h                | 1 -
>  include/hw/acpi/acpi_dev_interface.h | 1 +
>  include/hw/mem/memory-device.h       | 1 +
>  include/hw/ppc/spapr_drc.h           | 1 -
>  include/hw/qdev-properties.h         | 2 --
>  include/hw/virtio/virtio-pmem.h      | 1 +
>  include/migration/global_state.h     | 1 -
>  include/qemu/job.h                   | 2 +-
>  include/sysemu/arch_init.h           | 1 -
>  include/ui/egl-helpers.h             | 1 -
>  monitor/monitor-internal.h           | 1 -
>  target/i386/monitor.c                | 1 +
>  target/i386/sev_i386.h               | 2 +-
>  ui/vnc.h                             | 1 -
>  18 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 81c97f48a7..8510ad14b0 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -3,6 +3,8 @@
>  #include "hw/qdev.h"
>  #include "qapi/error.h"
>  #include "hw/pci/pci.h"
> +#include "qapi/qapi-types-block.h"
> +#include "qapi/qapi-types-misc.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qemu/ctype.h"
>  #include "qemu/error-report.h"
> diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
> index c29956ab77..27e36a2abf 100644
> --- a/hw/i386/kvm/i8254.c
> +++ b/hw/i386/kvm/i8254.c
> @@ -25,6 +25,7 @@
>  
>  #include "qemu/osdep.h"
>  #include <linux/kvm.h>
> +#include "qapi/qapi-types-misc.h"
>  #include "qapi/error.h"
>  #include "qemu/module.h"
>  #include "qemu/timer.h"
> diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
> index 9d8502785d..eea22c09f4 100644
> --- a/hw/ide/qdev.c
> +++ b/hw/ide/qdev.c
> @@ -21,6 +21,7 @@
>  #include "hw/hw.h"
>  #include "sysemu/dma.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-types-block.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
>  #include "hw/ide/internal.h"
> diff --git a/include/authz/listfile.h b/include/authz/listfile.h
> index 33b728d873..24ae2e606c 100644
> --- a/include/authz/listfile.h
> +++ b/include/authz/listfile.h
> @@ -22,7 +22,6 @@
>  #define QAUTHZ_LISTFILE_H
>  
>  #include "authz/list.h"
> -#include "qapi/qapi-types-authz.h"
>  #include "qemu/filemonitor.h"
>  
>  #define TYPE_QAUTHZ_LIST_FILE "authz-list-file"
> diff --git a/include/block/block.h b/include/block/block.h
> index 50a07c1c33..ae79b70e2d 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -2,7 +2,6 @@
>  #define BLOCK_H
>  
>  #include "block/aio.h"
> -#include "qapi/qapi-types-block-core.h"
>  #include "block/aio-wait.h"
>  #include "qemu/iov.h"
>  #include "qemu/coroutine.h"
> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
> index 43ff119179..6465072b7d 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -1,6 +1,7 @@
>  #ifndef ACPI_DEV_INTERFACE_H
>  #define ACPI_DEV_INTERFACE_H
>  
> +#include "qapi/qapi-types-misc.h"
>  #include "qom/object.h"
>  #include "hw/boards.h"
>  
> diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
> index 0293a96abb..2ada6e7bde 100644
> --- a/include/hw/mem/memory-device.h
> +++ b/include/hw/mem/memory-device.h
> @@ -13,6 +13,7 @@
>  #ifndef MEMORY_DEVICE_H
>  #define MEMORY_DEVICE_H
>  
> +#include "qapi/qapi-types-misc.h"
>  #include "qom/object.h"
>  #include "hw/qdev.h"
>  
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index c2c543a591..576c711b86 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -14,7 +14,6 @@
>  #define HW_SPAPR_DRC_H
>  
>  #include <libfdt.h>
> -#include "qapi/qapi-types-run-state.h"
>  #include "qom/object.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/qdev.h"
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 1eae5ab056..bb34a614e2 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -1,8 +1,6 @@
>  #ifndef QEMU_QDEV_PROPERTIES_H
>  #define QEMU_QDEV_PROPERTIES_H
>  
> -#include "qapi/qapi-types-block.h"
> -#include "qapi/qapi-types-misc.h"
>  #include "hw/qdev-core.h"
>  
>  /*** qdev-properties.c ***/
> diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-pmem.h
> index 19b6ee6d75..8bf2ae780f 100644
> --- a/include/hw/virtio/virtio-pmem.h
> +++ b/include/hw/virtio/virtio-pmem.h
> @@ -15,6 +15,7 @@
>  #define HW_VIRTIO_PMEM_H
>  
>  #include "hw/virtio/virtio.h"
> +#include "qapi/qapi-types-misc.h"
>  #include "sysemu/hostmem.h"
>  
>  #define TYPE_VIRTIO_PMEM "virtio-pmem"
> diff --git a/include/migration/global_state.h b/include/migration/global_state.h
> index fd22dd3034..d307de8350 100644
> --- a/include/migration/global_state.h
> +++ b/include/migration/global_state.h
> @@ -13,7 +13,6 @@
>  #ifndef QEMU_MIGRATION_GLOBAL_STATE_H
>  #define QEMU_MIGRATION_GLOBAL_STATE_H
>  
> -#include "qapi/qapi-types-run-state.h"
>  #include "sysemu/sysemu.h"
>  
>  void register_global_state(void);
> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index 9e7cd1e4a0..73c67d3175 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h
> @@ -26,7 +26,7 @@
>  #ifndef JOB_H
>  #define JOB_H
>  
> -#include "qapi/qapi-types-block-core.h"
> +#include "qapi/qapi-types-job.h"
>  #include "qemu/queue.h"
>  #include "qemu/coroutine.h"
>  #include "block/aio.h"
> diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
> index 10cbafe970..62c6fe4cf1 100644
> --- a/include/sysemu/arch_init.h
> +++ b/include/sysemu/arch_init.h
> @@ -1,7 +1,6 @@
>  #ifndef QEMU_ARCH_INIT_H
>  #define QEMU_ARCH_INIT_H
>  
> -#include "qapi/qapi-types-misc.h"
>  
>  enum {
>      QEMU_ARCH_ALL = -1,
> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
> index 58bd3a1ec4..dad19e9873 100644
> --- a/include/ui/egl-helpers.h
> +++ b/include/ui/egl-helpers.h
> @@ -4,7 +4,6 @@
>  #include <epoxy/gl.h>
>  #include <epoxy/egl.h>
>  #include <gbm.h>
> -#include "qapi/qapi-types-ui.h"
>  #include "ui/console.h"
>  #include "ui/shader.h"
>  
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 7760b22ba3..d78f5ca190 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -27,7 +27,6 @@
>  
>  #include "chardev/char-fe.h"
>  #include "monitor/monitor.h"
> -#include "qapi/qapi-types-misc.h"
>  #include "qapi/qmp/dispatch.h"
>  #include "qapi/qmp/json-parser.h"
>  #include "qemu/readline.h"
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 1f3b532fc2..9fb4d641d5 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -33,6 +33,7 @@
>  #include "sysemu/sev.h"
>  #include "qapi/error.h"
>  #include "sev_i386.h"
> +#include "qapi/qapi-commands-misc-target.h"
>  #include "qapi/qapi-commands-misc.h"
>  
>  /* Perform linear address sign extension */
> diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
> index 55313441ae..8ada9d385d 100644
> --- a/target/i386/sev_i386.h
> +++ b/target/i386/sev_i386.h
> @@ -19,7 +19,7 @@
>  #include "sysemu/kvm.h"
>  #include "sysemu/sev.h"
>  #include "qemu/error-report.h"
> -#include "qapi/qapi-commands-misc-target.h"
> +#include "qapi/qapi-types-misc-target.h"
>  
>  #define SEV_POLICY_NODBG        0x1
>  #define SEV_POLICY_NOKS         0x2
> diff --git a/ui/vnc.h b/ui/vnc.h
> index 2f84db3142..18f1b1d6d0 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -27,7 +27,6 @@
>  #ifndef QEMU_VNC_H
>  #define QEMU_VNC_H
>  
> -#include "qapi/qapi-types-ui.h"
>  #include "qemu/queue.h"
>  #include "qemu/thread.h"
>  #include "ui/console.h"
> 

