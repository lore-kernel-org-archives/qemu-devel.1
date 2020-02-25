Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA07C4BA06
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 23:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903D42176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 23:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntMIJPrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903D42176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6jJp-0003WV-N0
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 18:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j6jJD-00033I-25
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 18:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j6jJB-00077B-Be
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 18:08:10 -0500
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f]:34856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j6jJB-00072n-21; Tue, 25 Feb 2020 18:08:09 -0500
Received: by mail-il1-x12f.google.com with SMTP id g126so712322ilh.2;
 Tue, 25 Feb 2020 15:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=uwhRSZ3g9ZtGSoenxD0eDfT6hiKCVQJkJGUCdxiEVdk=;
 b=ntMIJPrSens1Mi3ojhL7iqksmCO22sYMoIIPVkxlmGSjqxeCleckXcE0L8wKOeMfG1
 nNDkme4OvLTB++yOHEvQiHvhNrllteS4LCN6QrjQCtFUO6a9V1Zd7jmMI5pTp++4BGxP
 jGGJGSeZ8P9IpiBGpEi79XzweFOTTEIyP89hhwB33+9VvyVvskGEhoqekjounLrOvhcJ
 PE+LfL427nJNvC/zzBgBX98R6ZoHaRJQ5FECruq54pPcy2IWD3d9GM3oiAXZJ6Gzv7tS
 R2RRhZy+e7yYWDXTjbscAH/ZfpihQCLJ05gWRbunbD8lQoEXoCsQ1xm78XimhihY4Ifx
 ZshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=uwhRSZ3g9ZtGSoenxD0eDfT6hiKCVQJkJGUCdxiEVdk=;
 b=o3uU+C5q2YQ4T556LSvtQpM4JesrVZ5NvZMEMJgY+kWpU0XBwStgVDXmju9DhQx2Ww
 r/E89KB+YO0OMBxoH8U66gMQU6U+rWKM8UHJERmVMp5o+i+ixBFqxLQtMKqgid/D5VQC
 EZ/5Ynt2bB/h4Ihuite9oXuSRTvqicHWEfDbydxiqGjZG6XH5V8JNrDl4H9TcyB8By8N
 AJrgotMT/RImBwhGu+FZO6/HMO2b/m9ajoe/Y6xvufAVR/7eVk1WUz2HMIWzD1+qIZmm
 CGsKRql9WZTx34ibF5EJVnWrzzG2w1hqiRAhLJtLBQVbOezBxPTRytFJRlQhW1sZxf2q
 NbcA==
X-Gm-Message-State: APjAAAUIjsGVRazT8DhZw+c62EoOeLQcUK6mmIh2CzMjDrdyBi+f5KWq
 e6K7y72FqKtk/cx6AdEMdEfrPXG+lFr0nxWE/bM=
X-Google-Smtp-Source: APXvYqwHaC10jPI/fqXmkfmh3sv9IUhRghep6sOb3fHFBuRG/uHQkM0VBGBMv4in0/QKoLqmPfSQb8pxiW7w+yTP2xs=
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr1029773ilq.306.1582672086198; 
 Tue, 25 Feb 2020 15:08:06 -0800 (PST)
MIME-Version: 1.0
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 26 Feb 2020 00:07:55 +0100
Message-ID: <CAPan3Wq-MVwcJQELP8n+g33CR7tsiGXQ698gA177nd2my9hWCw@mail.gmail.com>
Subject: Sudden slowdown of ARM emulation in master
To: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007e6dbf059f6e8f0e"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::12f
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007e6dbf059f6e8f0e
Content-Type: text/plain; charset="UTF-8"

Hello Igor and Paolo,

Just now I was working on some small fixes for the cubieboard machine and
rebasing my Allwinner H3 branches.
While doing some testing, I noticed that suddenly the machines were much
slower than before.
I only see this happening when I rebase to this commit:
   ca6155c0f2bd39b4b4162533be401c98bd960820 ("Merge tag 'patchew/
20200219160953.13771-1-imammedo@redhat.com' of
https://github.com/patchew-project/qemu into HEAD")

Also the avocado tests I'm running started to timeout:

+ AVOCADO_ALLOW_LARGE_STORAGE=yes avocado --show=app,console run -t
machine:cubieboard tests/acceptance/boot_linux_console.py
...
(1/2)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_cubieboard_initrd:
|console: Uncompressing Linux... done, booting the kernel.
|console: Booting Linux on physical CPU 0x0
console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version 7.2.1
20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 2019
console: CPU: ARMv7 Processor [410fc080] revision 0 (ARMv7), cr=50c5387d
console: CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing
instruction cache
console: OF: fdt: Machine model: Cubietech Cubieboard
...
INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout
reached\n
Original status: ERROR\n{'name':
'1-tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_cubieboard_initrd',
'logdir': '/home/me/avocado/job-results/job-2020-02-25T23.58-d43884...
(90.41 s)
...
console: random: crng init done
/console: mount: mounting devtmpfs on /dev failed: Device or resource busy
-console: EXT4-fs (sda): re-mounted. Opts:
block_validity,barrier,user_xattr,acl
/console: Starting logging: OK
INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout
reached\nOriginal status: ERROR\n{'name':
'2-tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_cubieboard_sata',
'logdir': '/home/fox/avocado/job-results/job-2020-02-25T23.58-d438849/...
(90.53 s)
RESULTS    : PASS 0 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 2 |
CANCEL 0
JOB TIME   : 181.22 s
 ....

Have you noticed a similar performance change?
Do you have any clue if there may be something changed here that could
cause a slowdown?

Regards,
Niek


-- 
Niek Linnenbank

--0000000000007e6dbf059f6e8f0e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Igor and Paolo,</div><div><br></div><div>Just n=
ow I was working on some small fixes for the cubieboard machine and rebasin=
g my Allwinner H3 branches.</div><div>While doing some testing, I noticed t=
hat suddenly the machines were much slower than before.</div><div>I only se=
e this happening when I rebase to this commit:</div><div>=C2=A0=C2=A0 ca615=
5c0f2bd39b4b4162533be401c98bd960820 (&quot;Merge tag &#39;patchew/<a href=
=3D"mailto:20200219160953.13771-1-imammedo@redhat.com">20200219160953.13771=
-1-imammedo@redhat.com</a>&#39; of <a href=3D"https://github.com/patchew-pr=
oject/qemu">https://github.com/patchew-project/qemu</a> into HEAD&quot;)</d=
iv><div><br> </div><div>Also the avocado tests I&#39;m running started to t=
imeout:</div><div><br></div><div>+ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes avocad=
o --show=3Dapp,console run -t machine:cubieboard tests/acceptance/boot_linu=
x_console.py</div><div>...<br></div><div>(1/2) tests/acceptance/boot_linux_=
console.py:BootLinuxConsole.test_arm_cubieboard_initrd: |console: Uncompres=
sing Linux... done, booting the kernel.<br>|console: Booting Linux on physi=
cal CPU 0x0<br>console: Linux version 4.20.7-sunxi (<a href=3D"mailto:root@=
armbian.com">root@armbian.com</a>) (gcc version 7.2.1 20171011 (Linaro GCC =
7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 2019<br>console: CPU: ARMv7 =
Processor [410fc080] revision 0 (ARMv7), cr=3D50c5387d<br>console: CPU: PIP=
T / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache<br>cons=
ole: OF: fdt: Machine model: Cubietech Cubieboard</div><div>...<br></div><d=
iv>INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout=
 reached\n</div><div>Original status: ERROR\n{&#39;name&#39;: &#39;1-tests/=
acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_cubieboard_initr=
d&#39;, &#39;logdir&#39;: &#39;/home/me/avocado/job-results/job-2020-02-25T=
23.58-d43884... (90.41 s)</div><div>...</div><div>console: random: crng ini=
t done<br>/console: mount: mounting devtmpfs on /dev failed: Device or reso=
urce busy<br>-console: EXT4-fs (sda): re-mounted. Opts: block_validity,barr=
ier,user_xattr,acl<br>/console: Starting logging: OK<br>INTERRUPTED: Test i=
nterrupted by SIGTERM\nRunner error occurred: Timeout reached\nOriginal sta=
tus: ERROR\n{&#39;name&#39;: &#39;2-tests/acceptance/boot_linux_console.py:=
BootLinuxConsole.test_arm_cubieboard_sata&#39;, &#39;logdir&#39;: &#39;/hom=
e/fox/avocado/job-results/job-2020-02-25T23.58-d438849/... (90.53 s)<br>RES=
ULTS =C2=A0 =C2=A0: PASS 0 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT=
 2 | CANCEL 0<br>JOB TIME =C2=A0 : 181.22 s</div><div>=C2=A0....</div><div>=
<br></div><div>Have you noticed a similar performance change?<br></div><div=
>Do you have any clue if there may be something changed here that could cau=
se a slowdown?</div><div><br></div><div>Regards,</div><div>Niek<br></div><d=
iv><br></div><div><br>-- <br><div dir=3D"ltr" class=3D"gmail_signature" dat=
a-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><b=
r></div></div></div></div></div>

--0000000000007e6dbf059f6e8f0e--

