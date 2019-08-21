Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2FCC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F5922D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F5922D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0M84-0002CY-0V
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i0M7P-0001mR-9E
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i0M7O-0003Mq-7Q
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:37:23 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:38131)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i0M7N-0003MB-V0
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:37:22 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MUTxo-1hrexA0lJA-00QR1P; Wed, 21 Aug 2019 10:37:16 +0200
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
 qemu-devel@nongnu.org
References: <20190710225528.409-1-carenas@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <715e2b4d-5b3b-75be-266a-43c3bd3f8a1b@vivier.eu>
Date: Wed, 21 Aug 2019 10:37:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190710225528.409-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ekLiNupoyU6PdszYknSSQNSr8dNdUH4fgTJNdkdt75QoOHY0Oif
 JW2VJZMdoFRacwDZhNYylR+VBniXbt4bz+HZPstHLuSohrMjoeJuGyGnl+dJwLn0A4kB3xM
 WARXGWFQ90ZQnt9bD2ujTWbIl/sTSApB4npbAgZC/04TocZmQXQnzDVTdBi8ESah1qnMeRU
 3wUV6elmBWRXBK0D5d//Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KcD0Gd+ot/Y=:yDqZOLeap0IKxufAtspRpE
 EI7G+0PZsQcgf0/RoNeYE/h3axM32Xpu2te8GCJJC3o5O6OfaZ5d+WUH/oIa9PUT9QudNzw7y
 P/ZJR59MHoBkBI++8MBRVIr7EslVe/qqPQdWbWAewrndPZmGYLrwfwRhBxJaauq/DiVk9X7bY
 wZ2S6z21PuV/lA+OYbKXshyLPEXq5bnz/nISOaoT0JAmHcPBv3qFa7XT2ZaHtvnJTMjMeqAuh
 VCzsuOg+g0bQmNIHWN3/QSSTQrMkHOoDiWyBcroYRLnTiDx9ZsaYbeglVtRuc4a0e2sKI5kJ9
 kVHkYIFehciQOyAjL/r1y9FTBfeuCQW4uuJkCOZr1Jpr+sRS7wzxVqEY0ZUvDS48KrzsOhEOx
 Md3KLUpBp+ajQkRnkh+pmiI0moH0P/oyfmN/g62SaANjcCID5GqSBBsRU/krhUA5v7X/7HObg
 xU3YMPkw0Pu/6yi4y5AHXZ4uWc1si7l/liwnKy3SG/ra8l7IUjN+K9D63v3hSgxNWCrmBgmEM
 bj9JWF+FLvGlKxkDJNlfd/bgB1ylNf4wa+96S0zsXDHpQAa2PRvyqdvhFUmCZPb76EGxYoMGV
 TR2MwzrzjKs6tDFMO0FBbzFPFlvyJuTXeNqhDpyoaL9m7qlG7cEZhYuKXMS/aykt18b/IDL5X
 kC2q5Tl7uU5sp2x8cujE3ykMBGHAQ5QP5+k8xbcTKptc3BNZJLoBPIZzNvAW/U8PpCBhhK+wd
 VFK6KQW8DzxR1Iu5tnWOoqoEix+36E3JrHsKrJNzKvmMFXUTzzeNpi6TTZw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: Re: [Qemu-devel] [PATCH] configure: fix sdl detection using
 sdl2-config
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
Cc: Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 11/07/2019 à 00:55, Carlo Marcelo Arenas Belón a écrit :
> If SDL2 is requested but pkg-config doesn't have a module for it
> configure should fallback to use sdl*-config, but wasn't able to
> because and old variable (from SDL) was being used by mistake.
> 
> Correct the variable name and complete other related changes so
> there are no more references to the old SDL.
> 
> Fixes: 0015ca5cbabe ("ui: remove support for SDL1.2 in favour of SDL2")
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  configure | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/configure b/configure
> index 4983c8b533..0f88ba98a6 100755
> --- a/configure
> +++ b/configure
> @@ -3016,15 +3016,15 @@ fi
>  ##########################################
>  # SDL probe
>  
> -# Look for sdl configuration program (pkg-config or sdl-config).  Try
> -# sdl-config even without cross prefix, and favour pkg-config over sdl-config.
> +# Look for sdl configuration program (pkg-config or sdl2-config).  Try
> +# sdl2-config even without cross prefix, and favour pkg-config over sdl2-config.
>  
>  sdl_probe ()
>  {
>    if $pkg_config sdl2 --exists; then
>      sdlconfig="$pkg_config sdl2"
>      sdlversion=$($sdlconfig --modversion 2>/dev/null)
> -  elif has ${sdl_config}; then
> +  elif has "$sdl2_config"; then
>      sdlconfig="$sdl2_config"
>      sdlversion=$($sdlconfig --version)
>    else
> @@ -3035,7 +3035,7 @@ sdl_probe ()
>      # no need to do the rest
>      return
>    fi
> -  if test -n "$cross_prefix" && test "$(basename "$sdlconfig")" = sdl-config; then
> +  if test -n "$cross_prefix" && test "$(basename "$sdlconfig")" = sdl2-config; then
>      echo warning: using "\"$sdlconfig\"" to detect cross-compiled sdl >&2
>    fi
>  
> @@ -8019,7 +8019,6 @@ preserve_env PKG_CONFIG
>  preserve_env PKG_CONFIG_LIBDIR
>  preserve_env PKG_CONFIG_PATH
>  preserve_env PYTHON
> -preserve_env SDL_CONFIG
>  preserve_env SDL2_CONFIG
>  preserve_env SMBD
>  preserve_env STRIP
> 

Applied to my trivial-patches branch.

Thanks,
Laurent



