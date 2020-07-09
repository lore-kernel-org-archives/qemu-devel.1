Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971D5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6252C207DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z7Z2/lri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6252C207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYM6-0003bj-MD
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYLT-00039F-5v
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:20:19 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYLR-0001J3-7I
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:20:18 -0400
Received: by mail-oi1-x241.google.com with SMTP id k4so2182191oik.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 08:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T7/zCGA22Ngtvb4/MPX9h5Tza+9mGX7z8XLEHzLUC3Y=;
 b=z7Z2/lriazVcXDyoT9EVqKFssJtw2sc5kkcnlXJ7Arhcx1LVz67lYBTSN9hB2zPMeW
 Ea+rgPPbTcCSHBZaxeE7gkKc3yEkS6qTEP0gWkZnNvrQTrmTCvLYemlmRY26Mpqya7EC
 NyAZzvewc1U/jAnU0Lq9hjP6PSHMdf4CAb5AUvNA4w0ikmCDJSzVvctMFZFo+XmZPv7o
 Y2OA0/CmpVdrdYKfLYPzHf2rSZ0lUt/rCZOxt8IZH4iArKvpN/dQUfCwyaQiSAQx7HsO
 66ExSakM3zih4fRlJeq7OkqY+PUzj4eKaTgYABa0o4hqSf/Q8GRfQ+Gw8HunVBMeCPZz
 QRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T7/zCGA22Ngtvb4/MPX9h5Tza+9mGX7z8XLEHzLUC3Y=;
 b=qTStr/Tyz4+RdeXaMArAexOgUQ4bKJP52w5uGjII6nE9wLEfagTrfjbCf6xx5jDQzC
 ATaeq3tUIdsFj/zOGGcGayd+7mqo8q75dv23Awt32s962199staf5umkh9G86AR0cTwR
 QPIqr1WXDAsVLUUrSdSTSl/KQk+GYrcPobgBcGQQbydrzYb/m7JqMr/xg1T+C04bzEGr
 uWqsUtZH8/gbyqRwER3fUVIE45CTDaZNpYgCOcQ5NPCO4+WLC1Do0hfb6UCBW46EVl6+
 cYrcl8Q5OzvxfHkGeuFLn4H7lSCNnEk30Buo9+K3lgE/VFr3E3GbpyI5l6LIXuTZe9ju
 86AQ==
X-Gm-Message-State: AOAM530PjVASf6ySv/uCtDYh6oAgepcYpiZnwxGMdb7gfg6VQYPQhaZM
 cSW99Cn+vyYnuQ0/jC6uWTr6evzUmk2Y3HqCHon3Kw==
X-Google-Smtp-Source: ABdhPJwbenphork55+7Pdc/MOWw9AXYRUwfItiq9h0EKgBThAAWydrJW6kMGsQkuaBWzNfr+6aTH18mkAAyTa+YJ/iA=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr446107oib.163.1594308015819; 
 Thu, 09 Jul 2020 08:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200704162545.311133-1-laurent@vivier.eu>
 <20200704162545.311133-12-laurent@vivier.eu>
In-Reply-To: <20200704162545.311133-12-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 16:20:04 +0100
Message-ID: <CAFEAcA-AYy_ixjHsX+OYN=Vx-63qdeEDY-cTit7A7wHLMiq_xA@mail.gmail.com>
Subject: Re: [PULL 11/12] linux-user: Add strace support for printing
 arguments of ioctl()
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 4 Jul 2020 at 17:36, Laurent Vivier <laurent@vivier.eu> wrote:
>
> From: Filip Bozuta <Filip.Bozuta@syrmia.com>
>
> This patch implements functionality for strace argument printing for ioctls.

Hi; Coverity points out some issues in this change:


> +#ifdef TARGET_NR_ioctl
> +static void
> +print_syscall_ret_ioctl(const struct syscallname *name, abi_long ret,
> +                        abi_long arg0, abi_long arg1, abi_long arg2,
> +                        abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_err(ret);
> +
> +    if (ret >= 0) {
> +        qemu_log(TARGET_ABI_FMT_ld, ret);
> +
> +        const IOCTLEntry *ie;
> +        const argtype *arg_type;
> +        void *argptr;
> +        int target_size;
> +
> +        for (ie = ioctl_entries; ie->target_cmd != 0; ie++) {
> +            if (ie->target_cmd == arg1) {
> +                break;
> +            }
> +        }
> +
> +        if (ie->target_cmd == arg1 &&
> +           (ie->access == IOC_R || ie->access == IOC_RW)) {
> +            arg_type = ie->arg_type;
> +            qemu_log(" (");
> +            arg_type++;
> +            target_size = thunk_type_size(arg_type, 0);
> +            argptr = lock_user(VERIFY_READ, arg2, target_size, 1);

Here we fail to check that lock_user() didn't return NULL...

> +            thunk_print(argptr, arg_type);

...which would cause a segfault in thunk_print().
This is CID 1430271.

> +            unlock_user(argptr, arg2, target_size);
> +            qemu_log(")");
> +        }
> +    }
> +    qemu_log("\n");
> +}
> +#endif

> +#ifdef TARGET_NR_ioctl
> +static void
> +print_ioctl(const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
> +{

> +            case TYPE_PTR:
> +                switch (ie->access) {
> +                case IOC_R:
> +                    print_pointer(arg2, 1);
> +                    break;
> +                case IOC_W:
> +                case IOC_RW:
> +                    arg_type++;
> +                    target_size = thunk_type_size(arg_type, 0);
> +                    argptr = lock_user(VERIFY_READ, arg2, target_size, 1);
> +                    thunk_print(argptr, arg_type);

Similarly here we need to check that lock_user didn't fail.
This is CID 1430272.

> +                    unlock_user(argptr, arg2, target_size);
> +                    break;
> +                }
> +                break;
> +            default:
> +                g_assert_not_reached();
> +            }
> +        }
> +    }
> +    print_syscall_epilogue(name);
> +}

thanks
-- PMM

