Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DD9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9295206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rR+3gmij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9295206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADyM-0005jT-Rj
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADwz-0004vH-Hr
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:59:57 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:43926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADwt-0007f2-Ns
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:59:57 -0400
Received: by mail-ej1-x644.google.com with SMTP id m22so12293418eje.10
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S2K7RnPlwv9bbZgq9QtunSij/GhYcN31cF3lz0Vies8=;
 b=rR+3gmijNeHRAqLILs9eYtOmLa9r1pwm8E6KrIOIztJe1utywjKxdRYvPyLkiTqrMW
 oowuyhpBJ+0WbgYjcxRBXbyN6cwfo+1WxpUt96LgK2CipHG8x4YxdYvpHg/q5At8azou
 947ma2xaB/QQF9ulF/BfaiNZKTFLUnPYYlbl/EUC4vTIu1Ga7rk4kqkn9Hx4WCo9Jm+w
 4EOG8gJWmCv6+jTPetM3aq5EtlFCsJFGR50GPN0di3IwB9Qbm7lyPNyda2/vdIr0smm9
 lBGuomy9JwLphBa8K6Vpy8L9WkajBdkgcCQNQKa2qgp1+l0TMIaIPVsILMsnz8ZNVAob
 v+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S2K7RnPlwv9bbZgq9QtunSij/GhYcN31cF3lz0Vies8=;
 b=rZ/pGgcbiTieSldtqlHfgO9Bt9FWBS6We3RUWqO5A6Ng+8dFGTJ25Niy9XJOSGMA0B
 wIqb1De01Joqh9I+9Qr934Xj7gB7y2jVE0gVbiWRRlBFN6WFRA6TKiSNeV+Ik+mG+18B
 NjTa/BErzRYU4zr2V3xhHB9ATmCe4hXpTJmgfJbXQ/0bk++/bxJQCIlQqjW75APxsHlh
 vmnp5n5sN53V7zJhK15rqDTSX0U2QddnR0ffmdC9vijr6uwFyM75avdeqRkslEldxzao
 II5qQL6zzjKFD/+WstrL8M+/CwbzFUH8E/GuoC6Sv0lpwhHmp1Qcz4RimV051g5yMxtN
 M0eA==
X-Gm-Message-State: AOAM5337JtjWn3JCmLebD084rYLIgCsLP3H2U52myEgNIfgBD6aYrnkO
 HIlolz72GpVj1sHaDVbGDnGZp6ijWuAUKfuMbSrvjnH+7z6NKCA1
X-Google-Smtp-Source: ABdhPJwjzuea+jwpgLMWZYmPy3M49MTonEdFNdS8lFu07MZ7zbZ8ShX/tHNYuzNKYegWP36ZnffsX4RiszBNX7w8v+A=
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr6287544ejn.56.1598281189867; 
 Mon, 24 Aug 2020 07:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200820133201.80577-1-graeme@nuviainc.com>
In-Reply-To: <20200820133201.80577-1-graeme@nuviainc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 15:59:38 +0100
Message-ID: <CAFEAcA_9WRk0Dr97wpDHacsjy2qpmBBq=kp6hOQTvUOvpWF0zw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/sbsa-ref.c : Add a fake embedded controller
To: Graeme Gregory <graeme@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Leif Lindholm <leif@nuviainc.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, rad@semihalf.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Aug 2020 at 14:32, Graeme Gregory <graeme@nuviainc.com> wrote:
>
> A difference between sbsa platform and the virt platform is PSCI is
> handled by ARM-TF in the sbsa platform. This means that the PSCI code
> there needs to communicate some of the platform power changes down
> to the qemu code for things like shutdown/reset control.
>
> Space has been left to extend the EC if we find other use cases in
> future where ARM-TF and qemu need to communicate.
>
> Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
> ---
>  hw/arm/sbsa-ref.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index f030a416fd..c8743fc1d0 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -41,6 +41,7 @@
>  #include "hw/usb.h"
>  #include "hw/char/pl011.h"
>  #include "net/net.h"
> +#include "migration/vmstate.h"
>
>  #define RAMLIMIT_GB 8192
>  #define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
> @@ -62,6 +63,7 @@ enum {
>      SBSA_CPUPERIPHS,
>      SBSA_GIC_DIST,
>      SBSA_GIC_REDIST,
> +    SBSA_SECURE_EC,
>      SBSA_SMMU,
>      SBSA_UART,
>      SBSA_RTC,
> @@ -98,6 +100,14 @@ typedef struct {
>  #define SBSA_MACHINE(obj) \
>      OBJECT_CHECK(SBSAMachineState, (obj), TYPE_SBSA_MACHINE)
>
> +typedef struct {
> +    SysBusDevice parent_obj;
> +    MemoryRegion iomem;
> +} SECUREECState;

Could you put the definition of the device in its own .c file,
please (hw/misc/ seems like the right place). We generally
prefer to keep the board and individual device models
separate. (Some older code in the tree still has devices
lurking in source files, but new stuff generally follows
the rules.)

> +enum sbsa_secure_ec_powerstates {
> +    SBSA_SECURE_EC_CMD_NULL,
> +    SBSA_SECURE_EC_CMD_POWEROFF,
> +    SBSA_SECURE_EC_CMD_REBOOT,

The last two are clear enough, but what's a null power state for?

> +static uint64_t secure_ec_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    /* No use for this currently */
> +    return 0;
> +}
> +
> +static void secure_ec_write(void *opaque, hwaddr offset,
> +                     uint64_t value, unsigned size)
> +{
> +    if (offset == 0) { /* PSCI machine power command register */
> +        switch (value) {
> +        case SBSA_SECURE_EC_CMD_NULL:
> +            break;
> +        case SBSA_SECURE_EC_CMD_POWEROFF:
> +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +            break;
> +        case SBSA_SECURE_EC_CMD_REBOOT:
> +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +            break;
> +        default:
> +            error_report("sbsa-ref: ERROR Unkown power command");

"unknown".

We prefer qemu_log_mask(LOG_GUEST_ERROR, ...) for logging this
kind of "guest code did something wrong" situation.
(you could also do that for attempting to read this w/o register
if you liked).

> +        }
> +    } else {
> +        error_report("sbsa-ref: unknown EC register");

similarly here

> +    }
> +}
> +
> +static const MemoryRegionOps secure_ec_ops = {
> +    .read = secure_ec_read,
> +    .write = secure_ec_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,

Consider explicitly specifying the permitted access size
by setting .valid.min_access_size and .valid.max_access_size
(restricting guests to only doing 32-bit writes will make
life easier when you come to add registers later...)

> +};
> +
> +static void secure_ec_init(Object *obj)
> +{
> +    SECUREECState *s = SECURE_EC(obj);
> +    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->iomem, obj, &secure_ec_ops, s, "secure-ec",
> +                            0x1000);

Minor indent error here.

> +    sysbus_init_mmio(dev, &s->iomem);
> +}
> +
> +static void create_secure_ec(MemoryRegion *mem)
> +{
> +    hwaddr base = sbsa_ref_memmap[SBSA_SECURE_EC].base;
> +    DeviceState *dev = qdev_create(NULL, TYPE_SECURE_EC);
> +    SysBusDevice *s = SYS_BUS_DEVICE(dev);
> +
> +    memory_region_add_subregion(mem, base,
> +                                sysbus_mmio_get_region(s, 0));
> +}
> +
>  static void sbsa_ref_init(MachineState *machine)
>  {
>      unsigned int smp_cpus = machine->smp.cpus;
> @@ -708,6 +778,8 @@ static void sbsa_ref_init(MachineState *machine)
>
>      create_pcie(sms);
>
> +    create_secure_ec(secure_sysmem);
> +
>      sms->bootinfo.ram_size = machine->ram_size;
>      sms->bootinfo.nb_cpus = smp_cpus;
>      sms->bootinfo.board_id = -1;
> @@ -798,8 +870,31 @@ static const TypeInfo sbsa_ref_info = {
>      .instance_size = sizeof(SBSAMachineState),
>  };
>
> +static const VMStateDescription vmstate_secure_ec_info = {
> +    .name = "sbsa-secure-ec",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +};

If you don't have any internal state in a device (as in
this case), then you don't need to set dc->vmsd at all.
Just have a comment in the class init saying
    /* No vmstate or reset required: device has no internal state */

thanks
-- PMM

