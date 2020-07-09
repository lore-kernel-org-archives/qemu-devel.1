Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A74AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 20:40:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0108520774
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 20:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nu0mgk3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0108520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtdL8-0004sh-95
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 16:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtdKI-0004Ro-8w
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 16:39:26 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:34066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtdKG-0007Jq-Hl
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 16:39:25 -0400
Received: by mail-oo1-xc43.google.com with SMTP id j1so599324oof.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 13:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A/RTq+gVnlbC3J25oTnbiMnAyx/4LZMyNuOOr7Jdx+M=;
 b=Nu0mgk3SWQb4JrqMxbnoVNQ3bd7Iz8ohA+jxF1QDWq4hDmF5Wk4p/+pKUuh/6U1Prj
 b5OEJXu57qEHvhrNagSl68aXSG+oIq4xjq46l1YAR2UDcFkcHnYvVvsmu/ovut4J/Ri+
 4ri1nVrxaEZGxNW7gGujp6txuEK3SB9PO2bRABMx9QPQg/aZF8tO3f+R0i1IpX/OsPIx
 xqCvW0WSHQ2ufOHYXZAZptfiB4kGTCao+hs761PfgDPAvNz36QbhSWE95gGHyMF5Soa7
 Y92TP8S05/UB56MTiAfIlmfGBmdBiHHn94FoJFC+xvoOMyIqmtsbRmpKv4RJpmj2SMw/
 fkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A/RTq+gVnlbC3J25oTnbiMnAyx/4LZMyNuOOr7Jdx+M=;
 b=eP9BSUWgo98eKm0djUV3x+gGwDCl2d+EUOXbZ/Vz8wYJm64IUh2t6rWzhn16xwVRkh
 C+v7b0VF/t9orNVTfmipqG7VkC+d4tHMKAdDBRh2TXSmDTWUdpv/rycq9C1pvFK7qsF7
 geqgCn118sjnnKXEce5f5OISXb9vt6tC+Z2l1K3jnJFVCRhABjnyO772CMpmeM99lvcz
 2X9RtY2qFHANzBfCKC1diEGAfyb9fxVjq9L9pzZjgynD5aKpNv/PB6kpsWcQkzp0NNJ7
 UrEh35HrS+y674kPnCJIrpQ5wsWjYVAvIpvfgXg4smsrCYxrcvqJHp/6UOXGJUal1Ggu
 OhwA==
X-Gm-Message-State: AOAM530e+2xYL/WfrupHxmHph2C9Za8qKLNKfvzDn7p+vloYE26/4NXx
 SoU2gK48BL1BWh3mgmStfPJ4zWUkzbICGSJsR8gwyQ==
X-Google-Smtp-Source: ABdhPJwppdr1KWrRlwuZwzKxJvBR0oZ9X0N+3o0ancrmALJIw1yy0k66fOuauLkTpyvRNc9NRUg0GCfDTGmZEnH+AWI=
X-Received: by 2002:a4a:9653:: with SMTP id r19mr34298650ooi.85.1594327163325; 
 Thu, 09 Jul 2020 13:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200709200010.1016741-1-laurent@vivier.eu>
In-Reply-To: <20200709200010.1016741-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 21:39:12 +0100
Message-ID: <CAFEAcA8XKOhPzoMh6o7=Wy==_+Fvi_+G8+=pphJjTFOBvO=HaQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Fix Coverity CID 1430271 / CID 1430272
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc43.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jul 2020 at 21:00, Laurent Vivier <laurent@vivier.eu> wrote:
>
> In new functions print_ioctl() and print_syscall_ret_ioctl(), we don't
> check if lock_user() returns NULL and this would cause a segfault in
> thunk_print().
>
> If lock_user() returns NULL don't call thunk_print() but prints only the
> value of the (invalid) pointer.
>
> Tested with:
>
>     # cat ioctl.c
>     #include <unistd.h>
>     #include <sys/ioctl.h>
>
>     int main(void)
>     {
>         int ret;
>
>         ret = ioctl(STDOUT_FILENO, TCGETS, 0xdeadbeef);
>         ret = ioctl(STDOUT_FILENO, TCSETSF, 0xdeadbeef);
>         return 0;
>     }
>     # QEMU_STRACE= ./ioctl
>     ...
>     578 ioctl(1,TCGETS,0xdeadbeef) = -1 errno=2 (Bad address)
>     578 ioctl(1,TCSETSF,0xdeadbeef) = -1 errno=2 (Bad address)
>     ...
>     # QEMU_STRACE= passwd
>     ...
>     623 ioctl(0,TCGETS,0x3fffed04) = 0 ({})
>     623 ioctl(0,TCSETSF,{}) = 0
>     ...
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 79482e5987c8 ("linux-user: Add strace support for printing arguments of ioctl()")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/strace.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 5235b2260cdd..39554d903911 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -889,8 +889,12 @@ print_syscall_ret_ioctl(const struct syscallname *name, abi_long ret,
>              arg_type++;
>              target_size = thunk_type_size(arg_type, 0);
>              argptr = lock_user(VERIFY_READ, arg2, target_size, 1);
> -            thunk_print(argptr, arg_type);
> -            unlock_user(argptr, arg2, target_size);
> +            if (argptr) {
> +                thunk_print(argptr, arg_type);
> +                unlock_user(argptr, arg2, target_size);
> +            } else {
> +                print_pointer(arg2, 1);
> +            }
>              qemu_log(")");
>          }
>      }
> @@ -3119,8 +3123,12 @@ print_ioctl(const struct syscallname *name,
>                      arg_type++;
>                      target_size = thunk_type_size(arg_type, 0);
>                      argptr = lock_user(VERIFY_READ, arg2, target_size, 1);
> -                    thunk_print(argptr, arg_type);
> -                    unlock_user(argptr, arg2, target_size);
> +                    if (argptr) {
> +                        thunk_print(argptr, arg_type);
> +                        unlock_user(argptr, arg2, target_size);
> +                    } else {
> +                        print_pointer(arg2, 1);
> +                    }
>                      break;
>                  }
>                  break;

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

