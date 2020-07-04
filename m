Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB522C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981A22073E
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981A22073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkwb-0003QB-Tb
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jrkvt-0002jH-Hu; Sat, 04 Jul 2020 12:22:29 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:50256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jrkvq-0000qv-IK; Sat, 04 Jul 2020 12:22:28 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DA98374594E;
 Sat,  4 Jul 2020 18:22:22 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 72A64745702; Sat,  4 Jul 2020 18:22:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7030A7456F8;
 Sat,  4 Jul 2020 18:22:22 +0200 (CEST)
Date: Sat, 4 Jul 2020 18:22:22 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 02/23] hw/core/qdev: Add
 qdev_warn_deprecated_function_used() helper
In-Reply-To: <20200704153908.12118-3-philmd@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2007041810050.92265@zero.eik.bme.hu>
References: <20200704153908.12118-1-philmd@redhat.com>
 <20200704153908.12118-3-philmd@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1579046126-1593879742=:92265"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 12:22:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1579046126-1593879742=:92265
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 4 Jul 2020, Philippe Mathieu-Daudé wrote:
> When built with --enable-qdev-deprecation-warning, calling
> qdev_warn_deprecated_function_used() will emit a warning such:
>
>  $ qemu-system-arm -M verdex ...
>  qemu-system-arm: warning: use of deprecated non-qdev/non-qom code in pxa2xx_lcdc_init()
>  qemu-system-arm: warning: use of deprecated non-qdev/non-qom code in pxa2xx_i2s_init()
>  qemu-system-arm: warning: use of deprecated non-qdev/non-qom code in pxa27x_keypad_init()
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> I'd rather use --enable-qdev-debug suggested here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg719802.html
> ---
> configure                    |  8 ++++++++
> include/hw/qdev-deprecated.h | 26 ++++++++++++++++++++++++++
> hw/core/qdev.c               |  8 ++++++++
> 3 files changed, 42 insertions(+)
> create mode 100644 include/hw/qdev-deprecated.h
>
> diff --git a/configure b/configure
> index 8a65240d4a..aac3dc0767 100755
> --- a/configure
> +++ b/configure
> @@ -441,6 +441,7 @@ edk2_blobs="no"
> pkgversion=""
> pie=""
> qom_cast_debug="yes"
> +qdev_deprecation_warning="no"
> trace_backends="log"
> trace_file="trace"
> spice=""
> @@ -1124,6 +1125,8 @@ for opt do
>   ;;
>   --enable-qom-cast-debug) qom_cast_debug="yes"
>   ;;
> +  --enable-qdev-deprecation-warning) qdev_deprecation_warning="yes"
> +  ;;
>   --disable-virtfs) virtfs="no"
>   ;;
>   --enable-virtfs) virtfs="yes"
> @@ -1915,6 +1918,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>   virglrenderer   virgl rendering support
>   xfsctl          xfsctl support
>   qom-cast-debug  cast debugging support
> +  qdev-deprecation-warning display qdev deprecation warnings
>   tools           build qemu-io, qemu-nbd and qemu-img tools
>   vxhs            Veritas HyperScale vDisk backend support
>   bochs           bochs image format support
> @@ -6966,6 +6970,7 @@ echo "gcov enabled      $gcov"
> echo "TPM support       $tpm"
> echo "libssh support    $libssh"
> echo "QOM debugging     $qom_cast_debug"
> +echo "QDEV deprecation warnings $qdev_deprecation_warning"
> echo "Live block migration $live_block_migration"
> echo "lzo support       $lzo"
> echo "snappy support    $snappy"
> @@ -7594,6 +7599,9 @@ fi
> if test "$qom_cast_debug" = "yes" ; then
>   echo "CONFIG_QOM_CAST_DEBUG=y" >> $config_host_mak
> fi
> +if test "$qdev_deprecation_warning" = "yes" ; then
> +  echo "CONFIG_QDEV_DEPRECATION_WARNING=y" >> $config_host_mak
> +fi
> if test "$rbd" = "yes" ; then
>   echo "CONFIG_RBD=m" >> $config_host_mak
>   echo "RBD_CFLAGS=$rbd_cflags" >> $config_host_mak
> diff --git a/include/hw/qdev-deprecated.h b/include/hw/qdev-deprecated.h
> new file mode 100644
> index 0000000000..b815f62dae
> --- /dev/null
> +++ b/include/hw/qdev-deprecated.h
> @@ -0,0 +1,26 @@
> +/*
> + * QEMU QOM qdev deprecation helpers
> + *
> + * Copyright (c) 2020 Red Hat, Inc.
> + *
> + * Author:
> + *   Philippe Mathieu-Daudé <philmd@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +#ifndef HW_QDEV_DEPRECATED_H
> +#define HW_QDEV_DEPRECATED_H
> +
> +/**
> + * qdev_warn_deprecated_function_used:
> + *
> + * Display a warning that deprecated code is used.
> + */
> +#define qdev_warn_deprecated_function_used() \
> +    qdev_warn_deprecated_function(__func__)
> +void qdev_warn_deprecated_function(const char *function);
> +
> +#endif
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 2131c7f951..1134f46631 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -35,6 +35,7 @@
> #include "hw/hotplug.h"
> #include "hw/irq.h"
> #include "hw/qdev-properties.h"
> +#include "hw/qdev-deprecated.h"
> #include "hw/boards.h"
> #include "hw/sysbus.h"
> #include "hw/qdev-clock.h"
> @@ -838,6 +839,13 @@ void qdev_alias_all_properties(DeviceState *target, Object *source)
>     } while (class != object_class_by_name(TYPE_DEVICE));
> }
>
> +void qdev_warn_deprecated_function(const char *function)
> +{
> +#ifdef CONFIG_QDEV_DEPRECATION_WARNING
> +    warn_report("use of deprecated non-qdev/non-qom code in %s()", function);
> +#endif
> +}
> +
> static bool device_get_realized(Object *obj, Error **errp)
> {
>     DeviceState *dev = DEVICE(obj);
>

I haven't noticed this series before so sorry that I only comment now. I 
was first thinking maybe you could use qdev_log_mask with some LOG_* value 
instead of #ifdef and warn_report so it can be enabled during runtime with 
some -d option but then I saw that this does not magically detect the 
sites that should be warned about but has to be added manually everywhere. 
In that case, it's probably easier to just add a FIXME comment to the 
places you'd call this function because that's where developers who could 
convert these will see it and probably more effective than having them to 
enable an option that they may not even know about and then search for 
where the warnings are coming from. So likely they'll just see the call in 
source for which a comment is also suffucient and then you can drop this 
patch but keep the rest and not throw away the work of identifying all the 
places that need to be modernised that you've done.

Regards,
BALATON Zoltan
--3866299591-1579046126-1593879742=:92265--

