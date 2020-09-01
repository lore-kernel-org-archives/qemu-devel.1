Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2563C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8548C20767
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8548C20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDDeE-0003h5-O3
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 17:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kDDcq-0002qr-Ig
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:15:32 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:48288
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kDDcn-0001ng-QS
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:15:32 -0400
Received: from host86-179-247-31.range86-179.btcentralplus.com
 ([86.179.247.31] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kDDdB-0003U2-B9; Tue, 01 Sep 2020 22:15:58 +0100
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200901062020.26660-1-pbonzini@redhat.com>
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
Message-ID: <156da43a-4744-ac6c-fc4b-54788a40b3e9@ilande.co.uk>
Date: Tue, 1 Sep 2020 22:14:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901062020.26660-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.179.247.31
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 00/13] Make QEMU installation relocatable
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
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
Cc: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/09/2020 07:20, Paolo Bonzini wrote:

> Right now, the installation of QEMU is not relocatable; there is
> a local hack in os_find_datadir() so that Windows binaries look
> for ROMs in the executable directory, but that has several limitations:
> 
> - it does not extend to configuration files, icons, etc.
> 
> - it does not allow changing the data directory in any way
> 
> - it does not apply to POSIX platforms
> 
> This series fixes that by making all paths within the installation
> prefix relative to the executable.  This in practice means all paths
> will be relocatable, except for /etc and /var if they're moved
> outside the prefix.
> 
> Here is an example of relocatability; before:
> 
>   $ make DESTDIR=$PWD/test install
>   $ cd test/usr/local/bin
>   $ ./qemu-system-ppc -L help
>   /usr/local/share/qemu-firmware
>   /usr/local/share/qemu
> 
> After:
> 
>   $ make DESTDIR=$PWD/test install
>   $ cd test/usr/local/bin
>   $ ./qemu-system-ppc -L help
>   /home/pbonzini/work/upstream/qemu/+build/test/usr/local/bin/../share/qemu-firmware
>   /home/pbonzini/work/upstream/qemu/+build/test/usr/local/bin/../share/qemu
> 
> The main benefit of this is on Windows, as mentioned above; but it also
> makes behavior more consistent across platforms and allows the removal
> of the hack that hides the "c:/Program Files/QEMU" prefix from Meson
> during cross compilation.
> 
> Paolo

Hi Paolo,

I've managed to give this a quick go this evening and I see the same link error
reported by Yonggang Luo at
https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg00586.html, i.e.:

"cc"  -o storage-daemon/qemu-storage-daemon.exe version.rc_version.o
storage-daemon/qemu-storage-daemon.exe.p/meson-generated_.._qapi_qapi-introspect.c.obj storage-daemon/qemu-storage-daemon.exe.p/meson-generated_.._qapi_qapi-commands.c.obj
storage-daemon/qemu-storage-daemon.exe.p/meson-generated_.._qapi_qapi-emit-events.c.obj
storage-daemon/qemu-storage-daemon.exe.p/meson-generated_.._qapi_qapi-events.c.obj
storage-daemon/qemu-storage-daemon.exe.p/meson-generated_.._qapi_qapi-visit.c.obj
storage-daemon/qemu-storage-daemon.exe.p/meson-generated_.._qapi_qapi-init-commands.c.obj
storage-daemon/qemu-storage-daemon.exe.p/meson-generated_.._qapi_qapi-types.c.obj
storage-daemon/qemu-storage-daemon.exe.p/qemu-storage-daemon.c.obj
storage-daemon/qemu-storage-daemon.exe.p/.._iothread.c.obj
storage-daemon/qemu-storage-daemon.exe.p/.._blockdev-nbd.c.obj
storage-daemon/qemu-storage-daemon.exe.p/.._blockdev.c.obj
storage-daemon/qemu-storage-daemon.exe.p/.._job-qmp.c.obj
"-L/home/Mark/qemu/build/dtc/libfdt" "-Wl,--allow-shlib-undefined"
"-Wl,--whole-archive" "libqmp.fa" "libblock.fa" "crypto/libcrypto.fa"
"authz/libauthz.fa" "qom/libqom.fa" "io/libio.fa" "chardev/libchardev.fa"
"-Wl,--no-whole-archive" "-Wl,--nxcompat" "-Wl,--no-seh" "-Wl,--dynamicbase"
"-Wl,--warn-common" "-m64" "-fstack-protector-strong" "-Wl,--start-group"
"libqemuutil.a" "libqmp.fa" "libblock.fa" "crypto/libcrypto.fa" "authz/libauthz.fa"
"qom/libqom.fa" "io/libio.fa" "chardev/libchardev.fa" "@block.syms" "-lwinmm"
"-LC:/msys64/mingw64/lib" "-lgio-2.0" "-lgobject-2.0" "-lglib-2.0" "-lintl"
"-pthread" "-lm" "-LC:/msys64/mingw64/lib" "-lgthread-2.0" "-lglib-2.0" "-lintl"
"-lws2_32" "-LC:/msys64/mingw64/lib" "-lzstd" "-LC:/msys64/mingw64/lib" "-lxml2"
"-LC:/msys64/mingw64/lib" "-lz" "-lbz2" "-LC:/msys64/mingw64/lib" "-lgthread-2.0"
"-lglib-2.0" "-lintl" "-mconsole" "-lkernel32" "-luser32" "-lgdi32" "-lwinspool"
"-lshell32" "-lole32" "-loleaut32" "-luuid" "-lcomdlg32" "-ladvapi32" "-Wl,--end-group"
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
cannot find -lfdt
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
cannot find -lcapstone
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
cannot find -lfdt
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
cannot find -lcapstone
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
cannot find -lslirp
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
cannot find -lslirp
collect2.exe: error: ld returned 1 exit status
make[1]: *** [Makefile.ninja:1405: qemu-system-ppc.exe] Error 1
make[1]: *** Waiting for unfinished jobs....
collect2.exe: error: ld returned 1 exit status
make[1]: *** [Makefile.ninja:1407: qemu-system-ppcw.exe] Error 1
make[1]: Leaving directory '/home/Mark/qemu/build'
make: *** [GNUmakefile:11: install] Error 2

I think this means that it's missing something from Yonggang Luo's patch here:
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg07668.html. I haven't looked
at patch 1 in that series for converting undefsym.sh to undefsym.py yet, although
last time I was able to get a working build without it.

Also patch 13 wouldn't apply for me to git master: I ended up having to make the
changes by hand, so looks like something requiring a rebase has recently snuck in.


ATB,

Mark.

