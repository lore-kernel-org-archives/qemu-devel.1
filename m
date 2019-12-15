Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2089FC43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 16:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8146206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 16:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8146206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igXAz-0005Qf-5g
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 11:55:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1igXAN-0004xm-8i
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 11:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1igXAL-00016g-Ql
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 11:54:47 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:43779)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1igXAL-0000yx-Gh
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 11:54:45 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M72wZ-1icyvY1G3j-008dCC; Sun, 15 Dec 2019 17:54:39 +0100
To: Joakim Tjernlund <joakim.tjernlund@infinera.com>, qemu-devel@nongnu.org
References: <20191214122022.17255-1-joakim.tjernlund@infinera.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] linux-user: make binfmt flag O require P
Message-ID: <b5e5743e-009f-397b-43d7-ae4a38443f9a@vivier.eu>
Date: Sun, 15 Dec 2019 17:54:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191214122022.17255-1-joakim.tjernlund@infinera.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aiperMHy02xGHxf+fEoG3HpheDD8yU4TEgqJcV+z4AdQ+58lR9l
 ezbjqNMNVS/XGFyJK/8+W5ajChMNW3c0O5g4MDGlpuLeX5KdvwhKLqV7uqs5EKUHQ/OLnWA
 PffuHeyTsY2RH+gvV27hKipOF6Rg9ERglQw6tgQmIFvJMXgocFX1Yg53D81r6d5QVSl9Pyw
 uNuUIcP0Iv5PAMQtxpJsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d0xXbMibAs0=:NP7Os5ov3gjuJfFhVeFMK8
 3W5YcRmWQaaenP7FWAYQtHkhapmooaSVv7Xz+6q6fKi7Bl2Y7wngN4xBzL3+pkAIoIe3xq5ar
 fCkHInpVgOyHxy39Zj45nRhvvpcmnwksIz4vyqvoG0eYTBrRrnA/usgm+zJbCepz8dBmavJN2
 LEyFDKZ5brVwgEwz5a9oMrWrEWzLj/PWmWUsCIcEOzYZE5ws+b2/HmnP8MUQ88PEXgajX2vT4
 hGdK3YdagcKp4eyE84oeNI0aJz8Px8LqQA1hFIXd+LZfXfgZt9E84MsthF3rBB7B2+Y8ni0q4
 fUtKMHjL9mFb78cl+Jh+62ZHMPh0XXE664HWniNJO261Bsr9Y0G5DyW5tO2Iz8RsS9SMJlmlD
 4FAJbi13CdpBd4N9LiE5PaPfRqQ2FH7UtvRFiImaLMv3EuP7wFdTxTzMvuhSoWdY2YyRiUBv6
 KsCnbaEb6Sed3GPYT7E/WODr+rlDWJpAzFTG9pKuNW9YspYwswnNLRa87QGHeGHOeLkNKpp/w
 Qk2VZX4sBbyeuMecD6QCgW1OMJGIsr2Aco/n5BtyaqSLkgWWmZCg6rZt7MbNOdbc27V/VroWX
 b8gSEC8irDt/BVRUKKCzj50dBGe4C0gIqyifoXYKE5G3Pssr3FquJUnWtOigxIwZlgMGlwmW3
 2p2T0jYoeeYrIHF4Deo0SyNU50/+QI3anCXoyaxcR763KLKJptwIRcFe/t0mMpUrDwyrswJE3
 cRX6VnoqdZOtHKlw+KHu/szXbv/nejJvjanuQj24icHQrUM9BdQJNhjzz+oB842rXGPtfUMxw
 Gd4IIkDdh+IpeqJTNBVv3hfblHnMTexjT1l8Ib646Wb4SRCO3+hRBYj5U0iYV99fL3tXmZ1Zr
 ZjkKOVNS7H7Z/eD6v/Ooj9Xp87phu5IVSAa9P4txI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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

Le 14/12/2019 à 13:20, Joakim Tjernlund a écrit :
> From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> 
> QEMU can autodetect if it is started from Linux binfmt loader
> when binfmt flag O is on.
> Use that and require binfmt flag P as well which will enable QEMU
> to pass in correct argv0 to the application.

I agree it's a good idea to try to detect the P flag if we use the O but
it changes the current behavior and breaks the compatibility with
previous version. This will prevent to run old and new version of QEMU
on the same system.

I already try to find a solution to this problem.

The first one is at QEMU level:

https://patchew.org/QEMU/20191024153847.31815-1-laurent@vivier.eu/

Another would be at linux level to provide a way to detect binfmt flags
(like you try to do with AT_EXECFD):

https://lore.kernel.org/patchwork/patch/1158151/

I also found another one from another author:

https://patchwork.kernel.org/patch/10902935/

Thanks,
Laurent


> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> ---
>  linux-user/main.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 6ff7851e86..1b626e5762 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -544,7 +544,7 @@ static void usage(int exitcode)
>      exit(exitcode);
>  }
>  
> -static int parse_args(int argc, char **argv)
> +static int parse_args(int argc, char **argv, int assume_P_flag)
>  {
>      const char *r;
>      int optind;
> @@ -560,7 +560,17 @@ static int parse_args(int argc, char **argv)
>              arginfo->handle_opt(r);
>          }
>      }
> -
> +    if (assume_P_flag) {
> +        /* Assume started by binmisc and binfmt P flag is set */
> +        if (argc < 3) {
> +            fprintf(stderr, "%s: Please use me through binfmt with P flag\n",
> +                    argv[0]);
> +            exit(1);
> +        }
> +        exec_path = argv[1];
> +        /* Next argv must be argv0 for the app */
> +        return 2;
> +    }
>      optind = 1;
>      for (;;) {
>          if (optind >= argc) {
> @@ -659,7 +669,8 @@ int main(int argc, char **argv, char **envp)
>      qemu_add_opts(&qemu_trace_opts);
>      qemu_plugin_add_opts();
>  
> -    optind = parse_args(argc, argv);
> +    execfd = qemu_getauxval(AT_EXECFD);
> +    optind = parse_args(argc, argv,  execfd > 0);
>  
>      if (!trace_init_backends()) {
>          exit(1);
> @@ -682,7 +693,6 @@ int main(int argc, char **argv, char **envp)
>  
>      init_qemu_uname_release();
>  
> -    execfd = qemu_getauxval(AT_EXECFD);
>      if (execfd == 0) {
>          execfd = open(exec_path, O_RDONLY);
>          if (execfd < 0) {
> 


