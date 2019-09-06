Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07729C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 09:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D86B52081B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 09:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86B52081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6AdX-0006Mm-0h
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 05:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i6Acg-0005vU-Le
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 05:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i6Acf-00082G-CR
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 05:33:42 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50911)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i6Acf-00081R-3Q
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 05:33:41 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MLR5h-1hoMUN1v1f-00ITHU; Fri, 06 Sep 2019 11:33:36 +0200
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20190826195806.15998-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <67f40cbf-39d3-d2d6-0e4b-219f549ae5d5@vivier.eu>
Date: Fri, 6 Sep 2019 11:33:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826195806.15998-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Fm007AG7r/RrpeDyoRbdzGWN3Uaw4Hmdta+2ATfQNnhbLJEAC94
 ZZzWaDQ6xfxhNKPnnzYnHTQcTTz2Uv1dlqs8JxVo935l9yRVEtvVHB/NSEx9HjG4kZ+LjvK
 RQG1bVwI/zhus056WjphslqTrCjyEQZhrhzsT+WkvbW/LFQ9dsJIOb+p+zy7spfapytu0iX
 BDWZPA45zAIcfRIOf5RHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pRgIAbFjjVY=:bOOPtVT9Q08dOGCHZwsapn
 FmGQoKfa1BX/1EFKHaPQFT4sJJM5D5zlzPTpQWVzKPNb9AAGxqkB1VzPm9xLZ/WMJHZ2SRIdu
 zWPxSk9MoBvKaOwshBt+CTt36qStzChVI11qQcO+tEXCl3L+cNfasBrK9UmKYl8L/jNG+upo6
 buaOxEU6zIuA5iKKlQgTC1EbK9nfWkTDp5fluD4WbLN8gODebht0qhvCd81fW2uf9UVuAUYF4
 MutC4tzI7IjryAA3cRYKnvJPYllH4cF2Ge3yoo4nKUJDQaF/hetSwDxCdQLIje0OUTXiWk1pH
 yPYnlyUjRjO2xYxA1UP2nsPY5a7EyTasLki0PKJGY6Cfrd2iJBIaH0v3KZrQmHpCwYSOWzcZo
 Y1G/f8VXgbpIy6BggVaRuyLSC2kbvZ3HSWcbFykYseJgJ5VpJcYLDQwP6HAwrLk/jGt3gkgru
 rC7BvzJoZm/pQuDb4ujBRB30SRZW3Bn8/mQfWSE0f17mP2ZJ30S+sJ+7S81UatzIPNY1NIHR2
 D6FfBre7DaFQ9sx7piklOEc0g14A1fb6IYVi3RrOMq9vwNRUzpH+gBUlf7zqMxeZ45LzfD9pw
 mXimYhMvX0uL1GYQAmjnBNU2h0Fq3B5j+SJTjVCo0DYSq5RARqm6rhX+hIOKghLCSfegD17zZ
 Z4rHigivdoPotLUBgIBlN2ECs0ahOqgNGCwHKJtiHS1dnCT8oNwR5JMFke/9c6M3BojtxRiPG
 Q0CWmONxGfhgME/zB5n3dNfLkfdg0SoeILGr/k7wJwuv8OwrVafi+mVuy8DPHLiCwsgz12mvS
 XrwhBoXJ6g5kAfhvuamVUw6WYdt2Q8X9gQoWcFR0S0NxYq5vjc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [PATCH v3] target/xtensa: linux-user: add call0
 ABI support
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

Le 26/08/2019 à 21:58, Max Filippov a écrit :
> Xtensa binaries built for call0 ABI don't rotate register window on
> function calls and returns. Invocation of signal handlers from the
> kernel is therefore different in windowed and call0 ABIs.
> There's currently no way to determine xtensa ELF binary ABI from the
> binary itself. Add handler for the -xtensa-abi-call0 command line
> parameter/QEMU_XTENSA_ABI_CALL0 envitonment variable to the qemu-user
> and record ABI choice. Use it to initialize PS.WOE in xtensa_cpu_reset.
> Check PS.WOE in setup_rt_frame to determine how a signal should be
> delivered.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v2->v3:
> 
> - revert to checking PS.WOE in the setup_rt_frame
> 
> Changes v1->v2:
> 
> - move handling of QEMU_XTENSA_ABI_CALL0 to linux-user/main.c
> - check xtensa_abi_call0 instead of PS.WOE in the setup_rt_frame
> 
>  linux-user/main.c          | 17 +++++++++++++++++
>  linux-user/xtensa/signal.c | 25 +++++++++++++++++--------
>  target/xtensa/cpu.c        | 24 ++++++++++++++++++++----
>  target/xtensa/cpu.h        |  3 +++
>  4 files changed, 57 insertions(+), 12 deletions(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 47917bbb20fc..9e50b2d2a92f 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -393,6 +393,13 @@ static void handle_arg_trace(const char *arg)
>      trace_file = trace_opt_parse(arg);
>  }
>  
> +#if defined(TARGET_XTENSA)
> +static void handle_arg_abi_call0(const char *arg)
> +{
> +    xtensa_set_abi_call0();
> +}
> +#endif
> +
>  struct qemu_argument {
>      const char *argv;
>      const char *env;
> @@ -446,6 +453,10 @@ static const struct qemu_argument arg_table[] = {
>       "",           "[[enable=]<pattern>][,events=<file>][,file=<file>]"},
>      {"version",    "QEMU_VERSION",     false, handle_arg_version,
>       "",           "display version information and exit"},
> +#if defined(TARGET_XTENSA)
> +    {"xtensa-abi-call0", "QEMU_XTENSA_ABI_CALL0", false, handle_arg_abi_call0,
> +     "",           "assume CALL0 Xtensa ABI"},
> +#endif
>      {NULL, NULL, false, NULL, NULL, NULL}
>  };
>  
> @@ -710,6 +721,12 @@ int main(int argc, char **argv, char **envp)
>          }
>      }
>  
> +#if defined(TARGET_XTENSA)
> +    if (getenv("QEMU_XTENSA_ABI_CALL0")) {
> +        xtensa_set_abi_call0();
> +    }

Not needed, this is done by parse_args() that checks
getenv(arginfo->env) and calls arginfo->handle_opt()
(handle_arg_abi_call0()).

Except that, it looks good.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

