Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A729C742D2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28ABF2080A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28ABF2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlz5A-0002R8-E6
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32780)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlz50-00022e-HD
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlz4y-0006Pa-Iz
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:11:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlz4w-0006O1-HQ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:11:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so10691664wrl.7
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 10:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IXJwuCMSMXYrcDz0A/4YMhf2r5ukSC8xdOPmNW814VQ=;
 b=T0asXMo1+622WKjva709iwtUNcQgGwTcs0vRCEdWY6AGW8Low0gVFk2V0K0m8mVsQz
 tuQe8i8ySUSITcERO4YGeVcY5l4hr+31XuPQQG8zJGgWgql70+fWyUhBTMZ6j8r7Byxq
 Iti8VvaK9dD0L77w0fathSZrjMOkTooXAKu1ufI9sxS+LLaOFsoT+5Atk/t4AgtSrNw+
 ry0s1C1ycoNRRW9MpMISTLIXzOw6Zl13Hx82CWQNlvAdC82LsFhZCpVCw3TGFH2+V+3b
 2BNifYj6MnqOwX22ZGb8dRjxVnA+EbeSUHYPwuee4ENUzCrCtmXVWO3pRMfKJpzRtRtV
 Il6Q==
X-Gm-Message-State: APjAAAVpATn4ea6qDo+MpnAt9r6/r8OuE2/e87KVfjBbDHr1uzGf2tvs
 erVVhyNl5FaGg2agFrtAK7XANg==
X-Google-Smtp-Source: APXvYqw9+vPyFf6tFNCFEbC7YQI7kzLE+xI3d1AkgHQX2teI++9Ha1nytHK8g/A3sP5LTXcp1nzpiA==
X-Received: by 2002:a5d:4949:: with SMTP id r9mr12140753wrs.289.1562951484608; 
 Fri, 12 Jul 2019 10:11:24 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id t1sm13153459wra.74.2019.07.12.10.11.23
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 10:11:24 -0700 (PDT)
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
 qemu-devel@nongnu.org
References: <20190710225528.409-1-carenas@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1cffc65e-35b3-2be0-9e95-2b99b0c99683@redhat.com>
Date: Fri, 12 Jul 2019 19:11:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190710225528.409-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
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
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Gerd

On 7/11/19 12:55 AM, Carlo Marcelo Arenas Belón wrote:
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

