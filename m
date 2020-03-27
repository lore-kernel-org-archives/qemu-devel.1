Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7060EC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451F520578
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451F520578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHmZe-00048m-G2
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 06:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jHmZ2-0003de-6V
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jHmZ0-0005mn-U7
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:50:11 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:46419)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jHmZ0-0005bh-Jt
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:50:10 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MCb2L-1j9I7S0PJb-009j5H; Fri, 27 Mar 2020 11:50:05 +0100
Subject: Re: [PATCH v1 4/7] linux-user: more debug for init_guest_space
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200327094945.23768-1-alex.bennee@linaro.org>
 <20200327094945.23768-5-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <db45e9a1-1f2e-c03f-deac-992b848908c0@vivier.eu>
Date: Fri, 27 Mar 2020 11:50:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327094945.23768-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:23hJIGMFFXnEEXCLPm9a7eF4Z/q812btiIGNGXOupq2cRFRTcJD
 0hMD1GknFc3CFOmiidwM6BI6WXGuSRdKTAgc8Mw9qr5TzEUKgxNfRdy9kKRFGwd5EIUJ/2C
 CEdYyMbJnE17VJ2VTbPEqqAk18VXth6DMStQ8nRbu59qlckYkMlBKX6am7D8giR4GAyaBEG
 FlZ/Wx4kCvUot/92Y5HRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rmJfPLgHR2o=:jSu1Ixb+pp3h10QGQ91Wu7
 G7DllOHUAidnYWZ7mYslUtghTMTqeuwuJc/kggaHkobq6sYTsx3YcVDc9XWTH1jj/O4fCfm3n
 x3Rj1Ufpzml3cxfpyUqqRtNNpjer+ITyQ6IXgD+hAb+9v1eD6xS8BxQnTK+JkIaEM6pzflGzS
 Uv527SDtfHo3CN2lMBeMdTg7bKpQKbktTZjTiZdPm1b+lbGNd8lJjrAHR8VRo7jHFuMFFVmQB
 UCAO/BEhs6qBdoUwI0XI4tLBUOOOMpeS5TB6650nxksEuLwBdxz8Y7APF1UhKTw3eVEUpG64u
 U3gFBbrIMB6ZEaWAZD5DQtxdz59EgpUIw8NOl5BYZDnDXW6/7eiHPBl5p4h+DIp8O5q2qjnJl
 G2pcUBEmUFZYh/DcAU9YonqKKwkBJUyl+pF1nEIgGtOjfaXDmJokIbiAAFbSShLpRdFpZHo3a
 I7B+LOiZj2eB/ctwhRnPjK/6yZKILpG7GyW5iQ0XQ5ugNSY/lIwyPh1YPbQhdYnpR0ssDbc1A
 9cjk9EpySvgwKtwJ9DD7uwMzDYVPUkJT8/hOctSe+C2rqQx4MhTI7b76D7RrLBNjXtT029J8x
 6iOnF1JKwAWgrlwNUSHu8hlFiZf/OAVf/1w8tfgiYrOehkvkGSB3P6+A7qmrGUYnulrrexCIg
 Tfqdl0wm/WkltTOojV1Bg6zm9V6WfZ1sNFrGzu5NTeOEHEdQcldGl2J9A3bvbwE0atg8XXtbf
 3EDM+GKiTM/X9pDmfwyxC7BnJC3jSW6lCp+BX0SmFcP4+yD0NiVaEM/BbwdY9Fd3Uh5hjW1c5
 Hab4ZGNc/f6HMAqlW6urmdRFhUl4E5uYlqn2/tJXBR4y1MSnCxdMy06L4FkvrbTN0Zd8aw9
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 27/03/2020 à 10:49, Alex Bennée a écrit :
> Searching for memory space can cause problems so lets extend the
> CPU_LOG_PAGE output so you can watch init_guest_space fail to
> allocate memory. A more involved fix is actually required to make this
> function play nicely with the large guard pages the sanitiser likes to
> use.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/elfload.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 8198be04460..619c054cc48 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2172,6 +2172,8 @@ unsigned long init_guest_space(unsigned long host_start,
>  
>          /* Check to see if the address is valid.  */
>          if (host_start && real_start != current_start) {
> +            qemu_log_mask(CPU_LOG_PAGE, "invalid %lx && %lx != %lx\n",
> +                          host_start, real_start, current_start);
>              goto try_again;
>          }
>  
> @@ -2240,7 +2242,11 @@ unsigned long init_guest_space(unsigned long host_start,
>           * probably a bad strategy if not, which means we got here
>           * because of trouble with ARM commpage setup.
>           */
> -        munmap((void *)real_start, real_size);
> +        if (munmap((void *)real_start, real_size) != 0) {
> +            error_report("%s: failed to unmap %lx:%lx (%s)", __func__,
> +                         real_start, real_size, strerror(errno));
> +            abort();
> +        }
>          current_start += align;
>          if (host_start == current_start) {
>              /* Theoretically possible if host doesn't have any suitably
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

