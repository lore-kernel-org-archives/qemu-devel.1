Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67851C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFE0206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFE0206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiiVd-0006UG-Ej
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jiiHV-0002gc-R1; Tue, 09 Jun 2020 13:43:25 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:35503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jiiHT-0005yF-O6; Tue, 09 Jun 2020 13:43:25 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MEVBa-1jkP640ehm-00Fytz; Tue, 09 Jun 2020 19:43:02 +0200
Subject: Re: [PATCH 3/3] target/unicore32: Prefer qemu_semihosting_log_out()
 over curses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200603123754.19059-1-f4bug@amsat.org>
 <20200603123754.19059-4-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <865c1389-4444-11e3-b156-256407a326d7@vivier.eu>
Date: Tue, 9 Jun 2020 19:42:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603123754.19059-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:74N0TvpahoEA4U+8Iw2199kA/lY93CKS9Fvcly20dQBCIpn9+pG
 grP94dMGvfoIkCZHOTd/QjM85eE+Ph+ek6GN1Ih82CgUVClqy5jAp/BEocoFWWMKW11zMlD
 pR1oXggq3bgdiXl+7hghVEALxEb2qdO0S6RJl2wQvmvXLL8oul1Oa5WPrxsl5fXE89JwJmG
 eOzTNO7UmuFKPkjPuSAKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:48dtioJH82k=:au6qjY9qGzPae1FcndH6Z8
 SbmFVVvCUUHZ2Ymz3lrLf+ORrRbNKC0jds56f8FQrhD8qtfih18725P3lHoF4rxiAf4MOvnqe
 9Edn++Cdl2uzvTczGRdTcgd3/zXXBIG8zZ9akg4QLJvnZ+bhuxafwJk7nkF/pa5S/tDwtbAay
 Ac8KHOVbzMtlKyowdGhH7WCFDzGdb11IDqpV6eG8cR5CTzNiu2wTg2F+s1H6CQtWl2UyhFOIf
 kXqIC3zqnv+EQGocyt270JekCI4a44pEGyQ5gZWMYSCkGl/ebAte29Gdbl2KlA5R+GUJJ4hTE
 iQLYhAPsvRfl+CGUhxYajSI2eBMdRhxWSjmwU4SJIxpYiLUyG/oHJcYvSGVlMGPz+IwfRVfju
 xVQIOj2+pSJtpOtWlU7ESiquBhGzjNfFl6fvZVmVjvxtYuBiCB1Bcq/D18JlD6gPX3p021bqY
 bexaBZo+XxmCv2WDnc0R1buBV6K9CorLbL/YJ9FdsmOi6cV0H+dSh3ugLQtZc9f1qA0bggV8H
 ulQXRzTcP58XThfl1vBzsgY2KKgEN4WsqR1EpgP2OLj5X74NDJ3GalvBTK5hDacEkOogSQRn5
 JQk9Xmw+CeFW5IedwriSLHgS6Q9DS1rgskfbbx3osCOhTbz8vSkC3u6kYC039uR0V10Oh41/d
 15kWG9pva/D6k7YSNS3r139QkXtawgKDpzmAQubYfXamzU0xLyqHo0s2oJcAc4e1F9fd+U0+O
 tXmnAvnja+TGJw/fojSAtTCzDbtozlsu9l9PlzdsNHJ1Z8/b3/6bjsLM0RQteLKudGnncXWDz
 71b2csz1oh0DlYNPmyy0ncbiZLNVHzfFw/oxCKEKE6zJAK7adYlHz0zbJwhuSZvVaViHrCn
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 13:15:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 03/06/2020 à 14:37, Philippe Mathieu-Daudé a écrit :
> Use the common API for semihosting logging.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  default-configs/unicore32-softmmu.mak |  1 +
>  target/unicore32/helper.c             | 57 +++------------------------
>  2 files changed, 6 insertions(+), 52 deletions(-)
> 
> diff --git a/default-configs/unicore32-softmmu.mak b/default-configs/unicore32-softmmu.mak
> index 0bfce48c6d..899288e3d7 100644
> --- a/default-configs/unicore32-softmmu.mak
> +++ b/default-configs/unicore32-softmmu.mak
> @@ -3,3 +3,4 @@
>  # Boards:
>  #
>  CONFIG_PUV3=y
> +CONFIG_SEMIHOSTING=y
> diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
> index 00371a7da6..54c26871fe 100644
> --- a/target/unicore32/helper.c
> +++ b/target/unicore32/helper.c
> @@ -14,9 +14,7 @@
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "exec/helper-proto.h"
> -#ifndef CONFIG_USER_ONLY
> -#include "ui/console.h"
> -#endif
> +#include "hw/semihosting/console.h"
>  
>  #undef DEBUG_UC32
>  
> @@ -161,58 +159,13 @@ uint32_t helper_cp0_get(CPUUniCore32State *env, uint32_t creg, uint32_t cop)
>      return 0;
>  }
>  
> -#ifdef CONFIG_CURSES
> -
> -/* KEY_EVENT is defined in wincon.h and in curses.h. Avoid redefinition. */
> -#undef KEY_EVENT
> -#include <curses.h>
> -#undef KEY_EVENT
> -
> -/*
> - * FIXME:
> - *     1. curses windows will be blank when switching back
> - *     2. backspace is not handled yet
> - */
> -static void putc_on_screen(unsigned char ch)
> +void helper_cp1_putc(target_ulong regval)
>  {
> -    static WINDOW *localwin;
> -    static int init;
> +    const char c = regval;
>  
> -    if (!init) {
> -        /* Assume 80 * 30 screen to minimize the implementation */
> -        localwin = newwin(30, 80, 0, 0);
> -        scrollok(localwin, TRUE);
> -        init = TRUE;
> -    }
> -
> -    if (isprint(ch)) {
> -        wprintw(localwin, "%c", ch);
> -    } else {
> -        switch (ch) {
> -        case '\n':
> -            wprintw(localwin, "%c", ch);
> -            break;
> -        case '\r':
> -            /* If '\r' is put before '\n', the curses window will destroy the
> -             * last print line. And meanwhile, '\n' implifies '\r' inside. */
> -            break;
> -        default: /* Not handled, so just print it hex code */
> -            wprintw(localwin, "-- 0x%x --", ch);
> -        }
> -    }
> -
> -    wrefresh(localwin);
> +    qemu_semihosting_log_out(&c, sizeof(c));
>  }
> -#else
> -#define putc_on_screen(c)               do { } while (0)
> -#endif
> -
> -void helper_cp1_putc(target_ulong x)
> -{
> -    putc_on_screen((unsigned char)x);   /* Output to screen */
> -    DPRINTF("%c", x);                   /* Output to stdout */
> -}
> -#endif
> +#endif /* !CONFIG_USER_ONLY */
>  
>  bool uc32_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  {
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


