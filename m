Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C538C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 10:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72384206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 10:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72384206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyZ6j-0007XU-Lp
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 06:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hyZ5t-0006WM-5F
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 06:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hyZ5r-0002HP-In
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 06:04:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hyZ5r-0002G6-Be
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 06:04:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so3603149wmg.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 03:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aT2ZNqO8zTsrWM08AT1iJSt0ruEVkb9Rhd643qEZv5I=;
 b=HmKIC0XVU8EWblXbw98UmYgoREZmRqW0POrRKi6I0v9rJLxG2OmSFb1CV59qP3pIIV
 czMGtiJ9jh5NP3XKBYFVn7jcCUEtTw9WjD6MFYp41Z+cqMPMaakqcY4T4HTtEBwHA3nw
 N8uZ2lwVwXH0TmpS2DpQ0IgzutMV8wrh9NRfuUbQoW6W84ZiuT+s8UcjDJheapmpULNl
 o12uosr6fORy6vUN8tTtU159GQxKWI7yV8tbdcx7zCaGTZxuOABdiDo+9MFPYMRz2pnv
 TliuhcWRePcG0lP2T4fIFsOxmR/RE8a1tak2brMygehiEtqZJHaJaDQsat+xLBiIL8+U
 sMeQ==
X-Gm-Message-State: APjAAAVfVFsQEkhs721POci3X6YQdKXZQ0p2WZTJxq31fBUoxz2tuNrH
 d0Fw/FcSIfiWYTlUPWCWW8Csmw==
X-Google-Smtp-Source: APXvYqz9FADqlGfQPhtp/alJQ2mzQsnVjtWV9tZBB1zOh/6/Xv4Sb2y94Nz96D17mVSCds+06pXYRw==
X-Received: by 2002:a1c:a101:: with SMTP id k1mr6684861wme.98.1565949861986;
 Fri, 16 Aug 2019 03:04:21 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id r190sm5336299wmf.0.2019.08.16.03.04.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2019 03:04:21 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
 <1565940884636.2215@bt.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <989277a4-7f07-aaaf-f963-ee769e0efd00@redhat.com>
Date: Fri, 16 Aug 2019 12:04:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1565940884636.2215@bt.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v7 25/42] hw/misc: Declare device little or
 big endian
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
Cc: frederic.konrad@adacore.com, berto@igalia.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org, jasowang@redhat.com,
 jiri@resnulli.us, ehabkost@redhat.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, stefanha@redhat.com,
 jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com, andrew@aj.id.au,
 claudio.fontana@suse.com, crwulff@gmail.com, laurent@vivier.eu,
 sundeep.lkml@gmail.com, michael@walle.cc, qemu-ppc@nongnu.org,
 kbastian@mail.uni-paderborn.de, imammedo@redhat.com, fam@euphon.net,
 peter.maydell@linaro.org, david@redhat.com, palmer@sifive.com,
 keith.busch@intel.com, jcmvbkbc@gmail.com, hare@suse.com,
 sstabellini@kernel.org, andrew.smirnov@gmail.com, deller@gmx.de,
 magnus.damm@gmail.com, atar4qemu@gmail.com, minyard@acm.org, sw@weilnetz.de,
 yuval.shaia@oracle.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 jan.kiszka@web.de, clg@kaod.org, shorne@gmail.com, qemu-riscv@nongnu.org,
 i.mitsyanko@gmail.com, cohuck@redhat.com, amarkovic@wavecomp.com,
 peter.chubb@nicta.com.au, aurelien@aurel32.net, pburton@wavecomp.com,
 sagark@eecs.berkeley.edu, green@moxielogic.com, kraxel@redhat.com,
 edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn, robh@kernel.org,
 borntraeger@de.ibm.com, joel@jms.id.au, antonynpavlov@gmail.com,
 chouteau@adacore.com, lersek@redhat.com, Andrew.Baumann@microsoft.com,
 mreitz@redhat.com, walling@linux.ibm.com, dmitry.fleytman@gmail.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, jslaby@suse.cz, marex@denx.de,
 proljc@gmail.com, marcandre.lureau@redhat.com, alistair@alistair23.me,
 paul.durrant@citrix.com, david@gibson.dropbear.id.au,
 xiaoguangrong.eric@gmail.com, huth@tuxfamily.org, jcd@tribudubois.net,
 pbonzini@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/16/19 9:34 AM, tony.nguyen@bt.com wrote:
> For each device declared with DEVICE_NATIVE_ENDIAN, find the set of
> targets from the set of target/hw/*/device.o.
> 
> If the set of targets are all little or all big endian, re-declare
> the device endianness as DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN
> respectively.
> 
> This *naive* deduction may result in genuinely native endian devices
> being incorrectly declared as little or big endian, but should not
> introduce regressions for current targets.
> 
> These devices should be re-declared as DEVICE_NATIVE_ENDIAN if 1) it
> has a new target with an opposite endian or 2) someone informed knows
> better =)
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  hw/misc/a9scu.c    | 2 +-
>  hw/misc/applesmc.c | 6 +++---
>  hw/misc/arm11scu.c | 2 +-
>  hw/misc/arm_l2x0.c | 2 +-
>  hw/misc/puv3_pm.c  | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
> index 4307f00..3de8cd3 100644
> --- a/hw/misc/a9scu.c
> +++ b/hw/misc/a9scu.c
> @@ -94,7 +94,7 @@ static void a9_scu_write(void *opaque, hwaddr offset,
>  static const MemoryRegionOps a9_scu_ops = {
>      .read = a9_scu_read,
>      .write = a9_scu_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,

Uh, I doubt that.

>  };
>  
>  static void a9_scu_reset(DeviceState *dev)
> diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
> index 2d7eb3c..6c91f29 100644
> --- a/hw/misc/applesmc.c
> +++ b/hw/misc/applesmc.c
> @@ -285,7 +285,7 @@ static void qdev_applesmc_isa_reset(DeviceState *dev)
>  static const MemoryRegionOps applesmc_data_io_ops = {
>      .write = applesmc_io_data_write,
>      .read = applesmc_io_data_read,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
>      .impl = {
>          .min_access_size = 1,
>          .max_access_size = 1,
> @@ -295,7 +295,7 @@ static const MemoryRegionOps applesmc_data_io_ops = {
>  static const MemoryRegionOps applesmc_cmd_io_ops = {
>      .write = applesmc_io_cmd_write,
>      .read = applesmc_io_cmd_read,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
>      .impl = {
>          .min_access_size = 1,
>          .max_access_size = 1,
> @@ -305,7 +305,7 @@ static const MemoryRegionOps applesmc_cmd_io_ops = {
>  static const MemoryRegionOps applesmc_err_io_ops = {
>      .write = applesmc_io_err_write,
>      .read = applesmc_io_err_read,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
>      .impl = {
>          .min_access_size = 1,
>          .max_access_size = 1,

Being ioport, this one might be OK.

> diff --git a/hw/misc/arm11scu.c b/hw/misc/arm11scu.c
> index 84275df..59fd7c0 100644
> --- a/hw/misc/arm11scu.c
> +++ b/hw/misc/arm11scu.c
> @@ -57,7 +57,7 @@ static void mpcore_scu_write(void *opaque, hwaddr offset,
>  static const MemoryRegionOps mpcore_scu_ops = {
>      .read = mpcore_scu_read,
>      .write = mpcore_scu_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,

I don't think so,

>  };
>  
>  static void arm11_scu_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/misc/arm_l2x0.c b/hw/misc/arm_l2x0.c
> index b88f40a..72ecf46 100644
> --- a/hw/misc/arm_l2x0.c
> +++ b/hw/misc/arm_l2x0.c
> @@ -157,7 +157,7 @@ static void l2x0_priv_reset(DeviceState *dev)
>  static const MemoryRegionOps l2x0_mem_ops = {
>      .read = l2x0_priv_read,
>      .write = l2x0_priv_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,

neither here, but Peter will confirm.

>   };
>  
>  static void l2x0_priv_init(Object *obj)
> diff --git a/hw/misc/puv3_pm.c b/hw/misc/puv3_pm.c
> index b538b4a..cd82b69 100644
> --- a/hw/misc/puv3_pm.c
> +++ b/hw/misc/puv3_pm.c
> @@ -118,7 +118,7 @@ static const MemoryRegionOps puv3_pm_ops = {
>          .min_access_size = 4,
>          .max_access_size = 4,
>      },
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,

This one I can't tell.

>  };
>  
>  static void puv3_pm_realize(DeviceState *dev, Error **errp)
> -- 
> 1.8.3.1
> 
> ​
> 

