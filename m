Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405DDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1419C206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1419C206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAAJC-0006a5-CW
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 07:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kAAIh-0006AN-9n
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 07:06:07 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:60950
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kAAId-0006i6-JL
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 07:06:07 -0400
Received: from host217-42-19-185.range217-42.btcentralplus.com
 ([217.42.19.185] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kAAIz-0005ko-UU; Mon, 24 Aug 2020 12:06:28 +0100
To: qemu-devel <qemu-devel@nongnu.org>
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
Message-ID: <d3adbbd0-fb9e-7f7f-8eaf-857c1d14d233@ilande.co.uk>
Date: Mon, 24 Aug 2020 12:05:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.42.19.185
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: meson: problems building under msys2/mingw-w64 native
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

Yesterday I updated my msys2/mingw-w64 Windows 10 build environment for QEMU to the
latest git to see if I could get the meson build to work, and found a couple of issues:


1) Unable to launch build/ninjatool at the end of configure

At the very end of configure after the build variables are displayed the build would
terminate with the following stack trace:

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
  File "C:/msys64/home/Mark/qemu/meson/mesonbuild/environment.py", line 167, in
detect_ninja_command_and_version
    p, found = Popen_safe([n, '--version'])[0:2]
  File "C:/msys64/home/Mark/qemu/meson/mesonbuild/mesonlib.py", line 1197, in Popen_safe
    p, o, e = Popen_safe_legacy(args, write=write, stdout=stdout, stderr=stderr,
**kwargs)
  File "C:/msys64/home/Mark/qemu/meson/mesonbuild/mesonlib.py", line 1213, in
Popen_safe_legacy
    p = subprocess.Popen(args, universal_newlines=False, close_fds=False,
  File "C:/msys64/mingw64/lib/python3.8/subprocess.py", line 854, in __init__
    self._execute_child(args, executable, preexec_fn, close_fds,
  File "C:/msys64/mingw64/lib/python3.8/subprocess.py", line 1307, in _execute_child
    hp, ht, pid, tid = _winapi.CreateProcess(executable, args,
OSError: [WinError 193] %1 is not a valid Win32 application


I managed to catch up with some meson devs on IRC last night and they helped me
figure out the problem is trying to launch "ninja --version" from configure.

Within configure the default location to ninja is overridden via
"NINJA=$PWD/ninjatool $meson setup ..." and subprocess.Popen() sends the filename to
Win32's CreateProcess() which fails because ninjatool is not a native executable but
a shell script. Any thoughts as to what would be the best solution here?


2) GTK UI now depends on CONFIG_VTE

This one I spotted on my local Linux setup as I didn't have the libvte-dev package
installed and couldn't understand why I couldn't run QEMU with the GTK UI as I always
do, even though configure reported that it found the GTK library and headers.

A quick search showed that the GTK UI was being guarded by "if
config_host.has_key('CONFIG_GTK') and config_host.has_key('CONFIG_VTE')" in
ui/meson.build.

For me the easy solution was to install libvte-dev, but since there are no VTE
packages for Windows my guess is this will now make the GTK UI unavailable for
Windows users.


ATB,

Mark.

