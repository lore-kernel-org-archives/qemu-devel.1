Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F50C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4CF2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4CF2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBKXy-0005sA-Ub
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 12:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kBKXS-0005R2-CD
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 12:14:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:39460
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kBKXQ-0006St-6z
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 12:14:10 -0400
Received: from host217-42-19-185.range217-42.btcentralplus.com
 ([217.42.19.185] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kBKXs-0000oG-CO; Thu, 27 Aug 2020 17:14:37 +0100
To: luoyonggang@gmail.com, qemu-devel@nongnu.org
References: <20200826151006.80-1-luoyonggang@gmail.com>
 <20200826151006.80-4-luoyonggang@gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <431d774b-d8ce-4190-8b06-6a8e8a3c7828@ilande.co.uk>
Date: Thu, 27 Aug 2020 17:14:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826151006.80-4-luoyonggang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.42.19.185
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v5 4/6] configure: Fix include and linkage issue on msys2
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.782,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/08/2020 16:10, luoyonggang@gmail.com wrote:

> From: Yonggang Luo <luoyonggang@gmail.com>
> 
> On msys2, the -I/e/path/to/qemu -L/e/path/to/qemu are not recognized by the compiler
> Cause $PWD are result posix style path such as /e/path/to/qemu that can not be recognized
> by mingw gcc, and `pwd -W` are result Windows style path such as E:/path/to/qemu that can
> be recognized by the mingw gcc. So we replace all $PWD with $build_path that can
> building qemu under msys2/mingw environment.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  configure | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/configure b/configure
> index b1e11397a8..3b9e79923d 100755
> --- a/configure
> +++ b/configure
> @@ -13,8 +13,13 @@ export CCACHE_RECACHE=yes
>  
>  # make source path absolute
>  source_path=$(cd "$(dirname -- "$0")"; pwd)
> +build_path=$PWD
> +if [ "$MSYSTEM" = "MINGW64" -o  "$MSYSTEM" = "MINGW32" ]; then

This still doesn't match the existing indentation as per my previous comment.

> +source_path=$(cd "$(dirname -- "$0")"; pwd -W)
> +build_path=`pwd -W`
> +fi
>  
> -if test "$PWD" = "$source_path"
> +if test "$build_path" = "$source_path"
>  then
>      echo "Using './build' as the directory for build output"
>  
> @@ -346,7 +351,12 @@ ld_has() {
>      $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
>  }
>  
> -if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
> +check_valid_build_path="[[:space:]:]"
> +if [ "$MSYSTEM" = "MINGW64" -o  "$MSYSTEM" = "MINGW32" ]; then

Same again here too.

> +check_valid_build_path="[[:space:]]"
> +fi
> +
> +if printf %s\\n "$source_path" "$build_path" | grep -q "$check_valid_build_path";
>  then
>    error_exit "main directory cannot contain spaces nor colons"
>  fi
> @@ -942,7 +952,7 @@ Linux)
>    linux="yes"
>    linux_user="yes"
>    kvm="yes"
> -  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -I$PWD/linux-headers $QEMU_INCLUDES"
> +  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -I${build_path}/linux-headers $QEMU_INCLUDES"
>    libudev="yes"
>  ;;
>  esac
> @@ -4283,7 +4293,7 @@ EOF
>                symlink "$source_path/dtc/Makefile" "dtc/Makefile"
>            fi
>            fdt_cflags="-I${source_path}/dtc/libfdt"
> -          fdt_ldflags="-L$PWD/dtc/libfdt"
> +          fdt_ldflags="-L${build_path}/dtc/libfdt"
>            fdt_libs="$fdt_libs"
>        elif test "$fdt" = "yes" ; then
>            # Not a git build & no libfdt found, prompt for system install
> @@ -5268,7 +5278,7 @@ case "$capstone" in
>      else
>        LIBCAPSTONE=libcapstone.a
>      fi
> -    capstone_libs="-L$PWD/capstone -lcapstone"
> +    capstone_libs="-L${build_path}/capstone -lcapstone"
>      capstone_cflags="-I${source_path}/capstone/include"
>      ;;
>  
> @@ -6268,8 +6278,8 @@ case "$slirp" in
>        git_submodules="${git_submodules} slirp"
>      fi
>      mkdir -p slirp
> -    slirp_cflags="-I${source_path}/slirp/src -I$PWD/slirp/src"
> -    slirp_libs="-L$PWD/slirp -lslirp"
> +    slirp_cflags="-I${source_path}/slirp/src -I${build_path}/slirp/src"
> +    slirp_libs="-L${build_path}/slirp -lslirp"
>      if test "$mingw32" = "yes" ; then
>        slirp_libs="$slirp_libs -lws2_32 -liphlpapi"
>      fi
> @@ -8212,7 +8222,7 @@ fi
>  mv $cross config-meson.cross
>  
>  rm -rf meson-private meson-info meson-logs
> -NINJA=$PWD/ninjatool $meson setup \
> +NINJA="${build_path}/ninjatool" $meson setup \
>          --prefix "${pre_prefix}$prefix" \
>          --libdir "${pre_prefix}$libdir" \
>          --libexecdir "${pre_prefix}$libexecdir" \
> @@ -8232,7 +8242,7 @@ NINJA=$PWD/ninjatool $meson setup \
>  	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
>  	-Dgettext=$gettext -Dxkbcommon=$xkbcommon \
>          $cross_arg \
> -        "$PWD" "$source_path"
> +        "$build_path" "$source_path"
>  
>  if test "$?" -ne 0 ; then
>      error_exit "meson setup failed"

Is the change to this last section for the NINJA variable really required to fix
linking? It would be useful to keep the NINJA variable and executable detection fix
as a separate patch if possible.


ATB,

Mark.

