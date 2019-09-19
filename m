Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26137C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF79321907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF79321907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtcR-00076p-Lw
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iAtXi-0001AX-44
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iAtXf-0006UY-W3
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:20:05 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:33789)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iAtXd-0006Sv-Ap; Thu, 19 Sep 2019 06:20:01 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M8hIl-1iF0HP3i1x-004k4L; Thu, 19 Sep 2019 12:19:59 +0200
To: qemu-devel@nongnu.org
References: <20190821082546.5252-1-laurent@vivier.eu>
 <20190821082546.5252-2-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <89256120-20ac-54e1-0b30-9d70cad99520@vivier.eu>
Date: Thu, 19 Sep 2019 12:19:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821082546.5252-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JF0BaepEvKoMWlzSkOBkwNu0iJBT878LHP9pWdXHkj2mF0I2x0N
 jIL+iAn37ErlqpqrATyMLzunyfeZO0zIWwMIEyo+o3X/Nr2QqROfYX5TNuYOD0mceXyl+H/
 2b1lbdqy+9tSQZLu1Q3XJ843Ua7QCYUFmAk80pF+LdFCDtDRb5XR7XoY8tXcAOLnauXTDO2
 EhpEuoqbARKV7zxbiDtPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KXd+xGahwIQ=:lB/df4YjeRQQEr7TS8T3Ef
 LiqG0RAI1SXCBD5U77skcFdbkwydk1SMyM0g9Q/iTeSmDYg5q4rgrzISYFVbPXeE3pE2+LG79
 oQvwfvZ/Oq7llqHlFL/fgSqZxsfNpl0HjTkPHso3Xy2Ph8Lvos0cfuXKkpMhEkwLP8Bh0uk8e
 qTklgHmel9+hgL9byK25F2YHFCDPxSaheFvsRlPzfJ5ldG/kiWq4Rret/AmDBsok2OwrZVZpf
 +mZxM+GR+15IK3h6AbNs5fEFLW61UndEGzpR6+40RKe22eWXFZMYd3O6JO+NlJcvXj3IYGLdF
 4X/jY4BTC5oO8LlPO2ipxOpjEi4suG6N21+Lvr0Xp3SJqEx0isRKuZdQw0us0+exS0WE2l8AK
 ZXhZi2h8pjhjIhBMA3cubPYsjIQ68jAHnxhFP5G0EyQ8bsIacVQwFgaLHxtNNP8kD4j/znKSr
 SjblrIqtAtTU/x/APwxwY+2rDJ/wYJaLbzDcBKSpKvM5mWl26wwqk/nhxvvyqoplpv+7XYAer
 FT5ti7pJ78mkegkZP+CGs6svSqG79d+e9vOgu+Y2ENbmc4xr4ggkJ69U9CQtuwIVLc86Lss1k
 GDID0MMW9xAJyOe05FmltTT9dEubahI0lXVINYiL4KkNMqrot9oQXLFXXnGER4MXx5J0qbtLp
 OpX4MgQrixiWwLNnZyUl1Wk9tqA/0yio3VTx6FPi+QxGdnEaISQ9vG6Nc8nqQwbTOuV2JqioI
 MjY+76uykj/pUgAm4LfFmreO1zyYWruFBA0es1WPDma20pKsSkn4Ab9eMcfZNBY2s22TxDmDa
 awfcNz1pgTjtsG/wGzIHtQ79Rj6i5LoCJ0/JICbE5Ra8nz/T4/DTGOFBy5wD5cKfvi7EIhuMK
 4KyWnbLBaK6uqMmjDkXvC687j33msmLkgHeDdCoas=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [PATCH 1/1] Fix cacheline detection on
 FreeBSD/powerpc.
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Justin Hibbits <chmeeedalf@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 21/08/2019 à 10:25, Laurent Vivier a écrit :
> From: Justin Hibbits <chmeeedalf@gmail.com>
> 
> machdep.cacheline_size is an integer, not a long.  Since PowerPC is
> big-endian this causes sysctlbyname() to fill in the upper bits of the
> argument, rather than the correct 'lower bits' of the word.  Specify the
> correct type to fix this.
> 
> Fixes: b255b2c8a548 ("util: add cacheinfo")
> Signed-off-by: Justin Hibbits <chmeeedalf@gmail.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  util/cacheinfo.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/util/cacheinfo.c b/util/cacheinfo.c
> index eebe1ce9c5d2..ea6f3e99bf4a 100644
> --- a/util/cacheinfo.c
> +++ b/util/cacheinfo.c
> @@ -65,25 +65,28 @@ static void sys_cache_info(int *isize, int *dsize)
>      g_free(buf);
>  }
>  
> -#elif defined(__APPLE__) \
> -      || defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
> +#elif defined(__APPLE__)
>  # include <sys/sysctl.h>
> -# if defined(__APPLE__)
> -#  define SYSCTL_CACHELINE_NAME "hw.cachelinesize"
> -# else
> -#  define SYSCTL_CACHELINE_NAME "machdep.cacheline_size"
> -# endif
> -
>  static void sys_cache_info(int *isize, int *dsize)
>  {
>      /* There's only a single sysctl for both I/D cache line sizes.  */
>      long size;
>      size_t len = sizeof(size);
> -    if (!sysctlbyname(SYSCTL_CACHELINE_NAME, &size, &len, NULL, 0)) {
> +    if (!sysctlbyname("hw.cachelinesize", &size, &len, NULL, 0)) {
> +        *isize = *dsize = size;
> +    }
> +}
> +#elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
> +# include <sys/sysctl.h>
> +static void sys_cache_info(int *isize, int *dsize)
> +{
> +    /* There's only a single sysctl for both I/D cache line sizes.  */
> +    int size;
> +    size_t len = sizeof(size);
> +    if (!sysctlbyname("machdep.cacheline_size", &size, &len, NULL, 0)) {
>          *isize = *dsize = size;
>      }
>  }
> -
>  #else
>  /* POSIX */
>  
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


