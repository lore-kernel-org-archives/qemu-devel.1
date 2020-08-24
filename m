Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADF3C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3772078D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3772078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAJ41-0002yf-BD
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 16:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kAJ3T-0002Zb-TD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:26:59 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:33606
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kAJ3R-0006hD-Iu
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:26:59 -0400
Received: from host217-42-19-185.range217-42.btcentralplus.com
 ([217.42.19.185] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kAJ3n-0000aw-GX; Mon, 24 Aug 2020 21:27:24 +0100
To: Paolo Bonzini <pbonzini@redhat.com>
References: <d3adbbd0-fb9e-7f7f-8eaf-857c1d14d233@ilande.co.uk>
 <CABgObfZ13taiRpWxcwjpfUA57+N523yDKcYR4un3=D+FXrxPrg@mail.gmail.com>
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
Message-ID: <c04489d3-e3f6-24d0-11d4-3ad6ed4f88c9@ilande.co.uk>
Date: Mon, 24 Aug 2020 21:26:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CABgObfZ13taiRpWxcwjpfUA57+N523yDKcYR4un3=D+FXrxPrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.42.19.185
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: meson: problems building under msys2/mingw-w64 native
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.25,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/08/2020 14:18, Paolo Bonzini wrote:

> Il lun 24 ago 2020, 13:06 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk
> <mailto:mark.cave-ayland@ilande.co.uk>> ha scritto:
> 
>     Within configure the default location to ninja is overridden via
>     "NINJA=$PWD/ninjatool $meson setup ..." and subprocess.Popen() sends the filename to
>     Win32's CreateProcess() which fails because ninjatool is not a native executable but
>     a shell script. Any thoughts as to what would be the best solution here?
> 
> 
> The simplest stopgap solution is to remove the NINJA= override and install ninja. It
> will only be used to build the compile_commands.json file.

I can confirm this works - I changed "NINJA=$PWD/ninjatool $meson setup ..." to
"NINJA=ninja $meson setup ..." and that allows configure to complete successfully.
However running make afterwards fails with this error:

/mingw64/bin/python3 -B /home/Mark/qemu/scripts/qapi-gen.py -o tests -p "test-"
/home/Mark/qemu/tests/qapi-schema/qapi-schema-test.json
Makefile.ninja:26: *** multiple target patterns.  Stop.
make[1]: Leaving directory '/home/Mark/qemu/build'
make: *** [GNUmakefile:11: all] Error 2

Looking at build/Makefile.ninja there seems to be an escaping issue with the "C:\"
being replaced with "C$$:" throughout the file:

PHONY:
version.rc_version.o: ../version.rc C$$:/msys64/mingw64/bin/windres.EXE
../pc-bios/qemu-nsis.ico | ; ${ninja-command}
...
...

I was able to fix this using the substitution '%s/C\$\$:/C:/g' in vim which allows
make to get much further:

"cc" "-Iqemu-system-ppc.exe.p" "-I." "-I.." "-Iqapi" "-Itrace" "-Iui" "-Iui/shader"
"-I/home/Mark/qemu/dtc/libfdt" "-I/home/Mark/qemu/capstone/include"
"-I/home/Mark/qemu/slirp/src" "-I/home/Mark/qemu/build/slirp/src"
"-IC:/msys64/mingw64/include/libpng16" "-IC:/msys64/mingw64/include"
"-IC:/msys64/mingw64/include/pixman-1" "-IC:/msys64/mingw64/include/glib-2.0"
"-IC:/msys64/mingw64/lib/glib-2.0/include" "-fdiagnostics-color=always" "-pipe"
"-Wall" "-Winvalid-pch" "-Werror" "-std=gnu99" "-O2" "-g" "-Werror"
"-U_FORTIFY_SOURCE" "-D_FORTIFY_SOURCE=2" "-pthread" "-mms-bitfields" "-m64" "-mcx16"
"-D_GNU_SOURCE" "-D_FILE_OFFSET_BITS=64" "-D_LARGEFILE_SOURCE" "-Wstrict-prototypes"
"-Wredundant-decls" "-Wundef" "-Wwrite-strings" "-Wmissing-prototypes"
"-fno-strict-aliasing" "-fno-common" "-fwrapv" "-Wold-style-declaration"
"-Wold-style-definition" "-Wtype-limits" "-Wformat-security" "-Wformat-y2k"
"-Winit-self" "-Wignored-qualifiers" "-Wempty-body" "-Wnested-externs"
"-Wendif-labels" "-Wexpansion-to-defined" "-Wno-missing-include-dirs"
"-Wno-shift-negative-value" "-Wno-psabi" "-fstack-protector-strong" "-iquote"
"/home/Mark/qemu/tcg/i386" "-iquote" "." "-iquote" "/home/Mark/qemu" "-iquote"
"/home/Mark/qemu/accel/tcg" "-iquote" "/home/Mark/qemu/include" "-iquote"
"/home/Mark/qemu/disas/libvixl" "-fPIE" "-mms-bitfields" "-mms-bitfields"
"-Dmain=SDL_main" "-isystemC:/msys64/mingw64/include/SDL2" "-Wno-undef"
"-DNEED_CPU_H" "-DCONFIG_TARGET=\"ppc-softmmu-config-target.h\""
"-DCONFIG_DEVICES=\"ppc-softmmu-config-devices.h\"" -MD -MQ
qemu-system-ppc.exe.p/softmmu_main.c.obj -MF
"qemu-system-ppc.exe.p/softmmu_main.c.obj.d" -o
qemu-system-ppc.exe.p/softmmu_main.c.obj "-c" ../softmmu/main.c -MP
../softmmu/main.c:31:10: fatal error: SDL.h: No such file or directory
   31 | #include <SDL.h>
      |          ^~~~~~~
compilation terminated.
make[1]: *** [Makefile.ninja:1402: qemu-system-ppc.exe.p/softmmu_main.c.obj] Error 1

After checking carefully I spotted the problem is with
"-isystemC:/msys64/mingw64/include/SDL2" not being quoted correctly at multiple
places in Makefile.ninja.

Again I was able to fix this in vim using the substitution '%s/isystemC:/isystem"
"C:/g' to turn "-isystemC:/msys64/mingw64/include/SDL2" into "-isystem"
"C:/msys64/mingw64/include/SDL2".

With this I can get all the way to the link phase so I think it's fairly close. I'm
not sure whether these escaping/quoting problems are with meson or the way in which
configure is using it?


ATB,

Mark.

