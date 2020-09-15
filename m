Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2F6C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC33B20936
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTdFCx97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC33B20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEyF-0004dr-Tm
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIEib-0006ex-Ik; Tue, 15 Sep 2020 13:26:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIEiW-0004KZ-6P; Tue, 15 Sep 2020 13:26:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id g4so4200673wrs.5;
 Tue, 15 Sep 2020 10:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+xG3tOVhHePULNbCyXMCGywB6NcCIylWmtejinhA22k=;
 b=BTdFCx977YclbKiqIXQ0aFxQIqMO1bC8mL+eU1udZwrVKQQhhIQIhnfOcJSJrFs6QU
 VEsfGdcFwQUs3EVriqmOx4nOue8SKx+WOL+ZNdeg7gK0W5D+/8ny00NGU9oqBbqcMOC/
 7Xb5VTIGWf2771f2g8Q9P78cZNejOGIuaVynADp0uhCIXer5GTfmaGTVEV5X/Tl0iPDv
 R31FhiT1bIpmrkrJc91F0ENabGbk7imGA72J5Rd6YcPWFyIGzzKOZrjNqOqRrEXq1Rve
 /3pdb9bq0WYAlt9gX6uH4tx/oFBdlslUpS6BPWDzTSv9Izpah9VzltxtiX37/R3jPoJW
 4l9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+xG3tOVhHePULNbCyXMCGywB6NcCIylWmtejinhA22k=;
 b=KbyWy+03vVG84BUIU9LzUHIMBJCsw12hhW6mrsJWxZe86n7CELM7nvMdAgn1L86iIP
 tb7PKmCYmiwNwwFY1s+A1T25ZGulg/KDirN8Pye3gPaw8ehuD7gdxp0sqwgaEBs2ID8z
 XkuLsMhpUsz+vAvXUQCe2V2NVP3oamVX8/jPk0pYjC/FR7Taq6p2TowLqLa46RQIYm2R
 fuD8RVxB9COP4jC8FPkxkj2B+iVv0OtmPQmUO2vvcFTHqv678MRBmRZht44uRr6S475x
 27EUtlbN8DHD8Vzr/dntSoXK0J1wQZPA608jdwNExvBfecsn1G2DVRRMUzj5H+dr9pyl
 LxvA==
X-Gm-Message-State: AOAM533DsgXScSlo8CHOkoMa5SL3DktbmbTPiHwiG9W06kvpnGAORWFK
 SJhC42OP9278MW7yyqcS2as=
X-Google-Smtp-Source: ABdhPJxT1iP0f8CFUe/wJWUF794xsbcc0Ty5XGZli0tjVuXm+pIsi58Hul7O1zkpIc8X6IrwF0woMw==
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr22306282wrt.196.1600190766346; 
 Tue, 15 Sep 2020 10:26:06 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id j14sm29049673wrr.66.2020.09.15.10.26.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 10:26:05 -0700 (PDT)
Subject: Re: [PATCH] hw/input/tsc2xxx: Reduce MouseTransformInfo structure
 exposure
To: qemu-devel@nongnu.org
References: <20200907010155.815131-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d746cb12-0ec9-66b6-242e-957266e26055@amsat.org>
Date: Tue, 15 Sep 2020 19:26:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907010155.815131-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 9/7/20 3:01 AM, Philippe Mathieu-Daudé wrote:
> Commit a5d7eb6534a ("Add TSC2301 touchscreen & keypad controller")
> added the MouseTransformInfo declaration in "ui/console.h",
> however it is only used in "hw/input/tsc2xxx.h".
> Reduce the structure exposure by moving it to the single include
> where it is used.
> 
> This should fix a build failure on OpenBSD:
> 
>   In file included from hw/arm/nseries.c:30:
>   In file included from include/hw/arm/omap.h:24:
>   In file included from include/hw/input/tsc2xxx.h:14:
>   include/ui/console.h:11:11: fatal error: 'epoxy/gl.h' file not found
>   # include <epoxy/gl.h>
>             ^~~~~~~~~~~~
>   1 error generated.
>   gmake: *** [Makefile.ninja:1735:
>   libqemu-aarch64-softmmu.fa.p/hw_arm_nseries.c.o] Error 1
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/input/tsc2xxx.h | 8 +++++++-
>  include/ui/console.h       | 8 --------
>  2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/input/tsc2xxx.h b/include/hw/input/tsc2xxx.h
> index 3cd8f1bf55b..5b76ebc1776 100644
> --- a/include/hw/input/tsc2xxx.h
> +++ b/include/hw/input/tsc2xxx.h
> @@ -11,7 +11,13 @@
>  #ifndef HW_INPUT_TSC2XXX_H
>  #define HW_INPUT_TSC2XXX_H
>  
> -#include "ui/console.h"
> +typedef struct MouseTransformInfo {
> +    /* Touchscreen resolution */
> +    int x;
> +    int y;
> +    /* Calibration values as used/generated by tslib */
> +    int a[7];
> +} MouseTransformInfo;
>  
>  typedef struct uWireSlave {
>      uint16_t (*receive)(void *opaque);
> diff --git a/include/ui/console.h b/include/ui/console.h
> index f35b4fc082b..30eed00dfcd 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -65,14 +65,6 @@ void qemu_remove_led_event_handler(QEMUPutLEDEntry *entry);
>  
>  void kbd_put_ledstate(int ledstate);
>  
> -typedef struct MouseTransformInfo {
> -    /* Touchscreen resolution */
> -    int x;
> -    int y;
> -    /* Calibration values as used/generated by tslib */
> -    int a[7];
> -} MouseTransformInfo;
> -
>  void hmp_mouse_set(Monitor *mon, const QDict *qdict);
>  
>  /* keysym is a unicode code except for special keys (see QEMU_KEY_xxx
> 

