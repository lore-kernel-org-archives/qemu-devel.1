Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9F2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B81206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B81206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgqFR-0002tF-3H
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 09:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jgqDr-0000rD-RK
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:47:55 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:11864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jgqDp-00089V-4T
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:47:54 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 2927474632B;
 Thu,  4 Jun 2020 15:47:47 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EC4BA74594E; Thu,  4 Jun 2020 15:47:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EA6F3745702;
 Thu,  4 Jun 2020 15:47:46 +0200 (CEST)
Date: Thu, 4 Jun 2020 15:47:46 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 1/7] qdev: add support for device module loading
In-Reply-To: <20200604131643.1776-2-kraxel@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2006041546480.92788@zero.eik.bme.hu>
References: <20200604131643.1776-1-kraxel@redhat.com>
 <20200604131643.1776-2-kraxel@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: dinechin@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jun 2020, Gerd Hoffmann wrote:
> When compiling devices as modules we'll need some infrastrtucture to
> actually load those modules if needed.  This patch adds it.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> include/hw/qdev-core.h |  3 +++
> include/qemu/module.h  |  1 +
> hw/core/qdev.c         | 50 ++++++++++++++++++++++++++++++++++++++++++
> qdev-monitor.c         |  5 +++++
> qom/qom-qmp-cmds.c     |  1 +
> stubs/hw-module.c      |  6 +++++
> stubs/Makefile.objs    |  1 +
> 7 files changed, 67 insertions(+)
> create mode 100644 stubs/hw-module.c
>
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index b870b279661a..a96c890bb95b 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -552,4 +552,7 @@ void device_listener_unregister(DeviceListener *listener);
>  */
> bool qdev_should_hide_device(QemuOpts *opts);
>
> +void qdev_module_load_type(const char *type);
> +void qdev_module_load_all(void);
> +
> #endif
> diff --git a/include/qemu/module.h b/include/qemu/module.h
> index 011ae1ae7605..077a6b09bca7 100644
> --- a/include/qemu/module.h
> +++ b/include/qemu/module.h
> @@ -64,6 +64,7 @@ typedef enum {
> #define block_module_load_one(lib) module_load_one("block-", lib)
> #define ui_module_load_one(lib) module_load_one("ui-", lib)
> #define audio_module_load_one(lib) module_load_one("audio-", lib)
> +#define hw_module_load_one(lib) module_load_one("hw-", lib)
>
> void register_module_init(void (*fn)(void), module_init_type type);
> void register_dso_module_init(void (*fn)(void), module_init_type type);
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 9e5538aeaebd..7177798840d4 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -146,10 +146,60 @@ DeviceState *qdev_create(BusState *bus, const char *name)
>     return dev;
> }
>
> +/*
> + * Building devices modular is mostly useful in case they have
> + * dependencies to external libraries.  Which is the case for very few
> + * devices.  So with the expecration that this will be rather the

Typo: "expectation"

Regards,
BALATON Zoltan

> + * exception than to rule go with a simple hardcoded list for now ...
> + */
> +static struct {
> +    const char *type;
> +    const char *mod;
> +} const hwmodules[] = {
> +};
> +
> +static bool qdev_module_loaded_all;
> +
> +void qdev_module_load_type(const char *type)
> +{
> +    int i;
> +
> +    if (qdev_module_loaded_all) {
> +        return;
> +    }
> +    for (i = 0; i < ARRAY_SIZE(hwmodules); i++) {
> +        if (strcmp(hwmodules[i].type, type) == 0) {
> +            hw_module_load_one(hwmodules[i].mod);
> +            return;
> +        }
> +    }
> +}
> +
> +void qdev_module_load_all(void)
> +{
> +    int i;
> +
> +    if (qdev_module_loaded_all) {
> +        return;
> +    }
> +    for (i = 0; i < ARRAY_SIZE(hwmodules); i++) {
> +        if (i > 0 && strcmp(hwmodules[i - 1].mod,
> +                            hwmodules[i].mod) == 0) {
> +            /* one module implementing multiple devices -> load only once */
> +            continue;
> +        }
> +        hw_module_load_one(hwmodules[i].mod);
> +    }
> +    qdev_module_loaded_all = true;
> +}
> +
> DeviceState *qdev_try_create(BusState *bus, const char *type)
> {
>     DeviceState *dev;
>
> +    if (object_class_by_name(type) == NULL) {
> +        qdev_module_load_type(type);
> +    }
>     if (object_class_by_name(type) == NULL) {
>         return NULL;
>     }
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index a4735d3bb190..55dddeb2f978 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -147,6 +147,7 @@ static void qdev_print_devinfos(bool show_no_user)
>     int i;
>     bool cat_printed;
>
> +    qdev_module_load_all();
>     list = object_class_get_list_sorted(TYPE_DEVICE, false);
>
>     for (i = 0; i <= DEVICE_CATEGORY_MAX; i++) {
> @@ -224,6 +225,10 @@ static DeviceClass *qdev_get_device_class(const char **driver, Error **errp)
>             oc = object_class_by_name(*driver);
>         }
>     }
> +    if (!oc) {
> +        qdev_module_load_type(*driver);
> +        oc = object_class_by_name(*driver);
> +    }
>
>     if (!object_class_dynamic_cast(oc, TYPE_DEVICE)) {
>         if (*driver != original_name) {
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index c5249e44d020..fe48cd2f9cf0 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -116,6 +116,7 @@ ObjectTypeInfoList *qmp_qom_list_types(bool has_implements,
> {
>     ObjectTypeInfoList *ret = NULL;
>
> +    qdev_module_load_all();
>     object_class_foreach(qom_list_types_tramp, implements, abstract, &ret);
>
>     return ret;
> diff --git a/stubs/hw-module.c b/stubs/hw-module.c
> new file mode 100644
> index 000000000000..1c312d2fc2b3
> --- /dev/null
> +++ b/stubs/hw-module.c
> @@ -0,0 +1,6 @@
> +#include "qemu/osdep.h"
> +#include "hw/qdev-core.h"
> +
> +void qdev_module_load_all(void)
> +{
> +}
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 6a9e3135e8f9..a4eb96514ddc 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -44,4 +44,5 @@ stub-obj-y += pci-host-piix.o
> stub-obj-y += ram-block.o
> stub-obj-y += ramfb.o
> stub-obj-y += fw_cfg.o
> +stub-obj-y += hw-module.o
> stub-obj-$(CONFIG_SOFTMMU) += semihost.o
>

