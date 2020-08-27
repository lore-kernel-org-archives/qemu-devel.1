Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDA7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 15:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6202922B40
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 15:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6202922B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBKI7-0004uw-Ll
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 11:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kBKHP-0004QK-Gf
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 11:57:35 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:39398
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kBKHN-0003DD-2V
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 11:57:35 -0400
Received: from host217-42-19-185.range217-42.btcentralplus.com
 ([217.42.19.185] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kBKHi-0000iU-Nk; Thu, 27 Aug 2020 16:57:59 +0100
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200826190245.22810-1-pbonzini@redhat.com>
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
Message-ID: <f04c27c7-84b1-c43c-6919-53fffcd5c360@ilande.co.uk>
Date: Thu, 27 Aug 2020 16:57:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826190245.22810-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.42.19.185
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2] configure: add --ninja option
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/08/2020 20:02, Paolo Bonzini wrote:

> On Windows it is not possible to invoke a Python script as $NINJA.
> If ninja is present use it directly, while if it is not we can
> keep using ninjatool.
> 
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 9db9bb89b9..6ecaff429b 100755
> --- a/configure
> +++ b/configure
> @@ -568,6 +568,7 @@ rng_none="no"
>  secret_keyring=""
>  libdaxctl=""
>  meson=""
> +ninja=""
>  skip_meson=no
>  gettext=""
>  
> @@ -1052,6 +1053,8 @@ for opt do
>    ;;
>    --meson=*) meson="$optarg"
>    ;;
> +  --ninja=*) ninja="$optarg"
> +  ;;
>    --smbd=*) smbd="$optarg"
>    ;;
>    --extra-cflags=*)
> @@ -1820,6 +1823,7 @@ Advanced options (experts only):
>    --python=PYTHON          use specified python [$python]
>    --sphinx-build=SPHINX    use specified sphinx-build [$sphinx_build]
>    --meson=MESON            use specified meson [$meson]
> +  --ninja=NINJA            use specified ninja [$ninja]
>    --smbd=SMBD              use specified smbd [$smbd]
>    --with-git=GIT           use specified git [$git]
>    --static                 enable static build [$static]
> @@ -2058,6 +2062,16 @@ case "$meson" in
>      *) meson=$(command -v meson) ;;
>  esac
>  
> +# Probe for ninja (used for compdb)
> +
> +if test -z "$ninja"; then
> +    for c in ninja ninja-build samu; do
> +        if has $c; then
> +            ninja=$(command -v "$c")
> +            break
> +        fi
> +    done
> +fi
>  
>  # Check that the C compiler works. Doing this here before testing
>  # the host CPU ensures that we had a valid CC to autodetect the
> @@ -8197,7 +8211,7 @@ fi
>  mv $cross config-meson.cross
>  
>  rm -rf meson-private meson-info meson-logs
> -NINJA=$PWD/ninjatool $meson setup \
> +NINJA=${ninja:-$PWD/ninjatool} $meson setup \
>          --prefix "${pre_prefix}$prefix" \
>          --libdir "${pre_prefix}$libdir" \
>          --libexecdir "${pre_prefix}$libexecdir" \

I've just tested this, but it gives me a python stacktrace if I run it without
passing a --ninja argument to configure. With a bit of extra debugging added to see
what is being generated:

###XXX ['C:/msys64/mingw64/bin/ninja', '--version']
Traceback (most recent call last):
  File "C:/msys64/home/Mark/qemu/meson/mesonbuild/mesonmain.py", line 131, in run
    return options.run_func(options)
  File "C:/msys64/home/Mark/qemu/meson/mesonbuild/msetup.py", line 245, in run
    app.generate()
  File "C:/msys64/home/Mark/qemu/meson/mesonbuild/msetup.py", line 159, in generate
    self._generate(env)
  File "C:/msys64/home/Mark/qemu/meson/mesonbuild/msetup.py", line 215, in _generate
    intr.backend.generate()
  File "C:/msys64/home/Mark/qemu/meson/mesonbuild/backend/ninjabackend.py", line 483,
in generate
    ninja = environment.detect_ninja_command_and_version(log=True)
  File "C:/msys64/home/Mark/qemu/meson/mesonbuild/environment.py", line 177, in
detect_ninja_command_and_version
    name = os.path.basename(n)
  File "C:/msys64/mingw64/lib/python3.8/ntpath.py", line 231, in basename
    return split(p)[1]
  File "C:/msys64/mingw64/lib/python3.8/ntpath.py", line 200, in split
    p = os.fspath(p)
TypeError: expected str, bytes or os.PathLike object, not NoneType

ERROR: meson setup failed

It seems that it doesn't like parsing the discovered ninja path. I can make configure
work by passing --ninja=ninja to configure which falls back to PATH and appears to do
the right thing:

###XXX ['ninja', '--version']
Found ninja.EXE-1.10.1 at C:\msys64\mingw64\bin/ninja.EXE

I tried a few other things too:

 --ninja=C:/msys64/mingw64/bin/ninja - fails
 --ninja=C:/msys64/mingw64/bin/ninja.exe - works
 --ninja=ninja.exe - works
 --ninja=/c/msys64/mingw64/bin/ninja - fails similar as above
 --ninja=/c/msys64/mingw64/bin/ninja.exe - works
 --ninja=C:\\msys64\\mingw64\\bin\\ninja - fails similar as above
 --ninja=C:\\msys64\\mingw64\\bin\\ninja.exe - works

From these tests it looks as if the .exe prefix is required when using a full path to
the ninja executable.


ATB,

Mark.

