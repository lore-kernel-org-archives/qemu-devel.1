Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECD9C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0562173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAXJiRdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0562173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48903 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT0Hm-0000nh-Mo
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 04:38:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hT0Gt-0000Wm-Od
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hT0Gr-0005bH-Qk
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:37:19 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hT0Gr-0005an-HO
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:37:17 -0400
Received: by mail-ot1-x343.google.com with SMTP id r7so15587850otn.6
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 01:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=yO3PF3UtYMtf4SMw0p+gc6JQod5AakYaCn+z4E2DrJM=;
	b=VAXJiRdh0vXcFjtuodr6Rrvce7jIcPW7n8ZAbQ/Zbv2GaCCNtErbZtAygbYVtOIR8B
	5NQYxUojXS2RQx9gZ+96bcl36mEbY+tUFoql+CwwAoYvqRhKarRHvsAZmL1t75SqNvcQ
	MaEikj45IZFeVD0/avv71nBN8Q+/FwpzQVWvSLjpHAdcdxA9r3WAn6kmUx8+kaA6aElm
	A/46frqR1ciAfBK/iqbmbF6+7u7kA5JBHasgX27jY3ML2TZD7JNqGGsK8TBP7L+D6rMM
	Fm5eaxIOX3A0ADEBxlJ0/gGy6lNDM5GXZpY+57gESXZBOGTp5U3xtGCb7BkVyZ47h8Bf
	O9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=yO3PF3UtYMtf4SMw0p+gc6JQod5AakYaCn+z4E2DrJM=;
	b=FcotxubE+HEuRCDTQJkdeYpLlU2pIETSxlI6JOZzg6Gh1VpxZFyKVeVaAt5gM6FnuZ
	IXR0nHZXakNWHpZMMuGWVeT9hU5881V40212GUx2Fj9IyrLpG5GCrKGdcm5/IfHgEaZq
	0M+3C/m1qn45ic1LNTsYuDNdLLiLXyp1rvMiuzFOo5m5rO11qevqbVYN2yguFBkPFhVw
	MP5K/CZvwsvvD6zWUHJeCmY9v7h6NPTd6NRzPiEp4x3elxNabfELf/lpn+3lXwXw0Y3h
	Dhxk5UxcewWJDAkhcI1R4WAnV528O+D2p8jrXXcJuxdPxdv0Yb0xQTNJ0lKae35ddhLj
	gIEw==
X-Gm-Message-State: APjAAAW1m+LjXC8BJx4k7Rzb8EOLKss6VsInD4y3zyrQHSMqkyHyRINj
	jD51CPrZ0Pe/KAOrQY5UIrjhQhY87UeRSvMXCmg=
X-Google-Smtp-Source: APXvYqyFzgL5PRv2sm1gHjfTXMtfEXVYq0RfjsuOt8cxwcOyZTJz6MqJvm+lLVfCfQtXdWAMSWJL00X+eenKUtc3I4E=
X-Received: by 2002:a9d:63c1:: with SMTP id e1mr15371726otl.341.1558427836300; 
	Tue, 21 May 2019 01:37:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Tue, 21 May 2019 01:37:15
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Tue, 21 May 2019 01:37:15
	-0700 (PDT)
In-Reply-To: <20190520231910.12184-3-f4bug@amsat.org>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190520231910.12184-3-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 21 May 2019 10:37:15 +0200
Message-ID: <CAL1e-=hx+Dvfdyv3Nx+fPt8KfQ3T8y_iXeyYAXWoYfNPf+cKUQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 2/4] BootLinuxConsoleTest: Test nanoMIPS
 kernels on the I7200 CPU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Caio Carrara <ccarrara@redhat.com>, qemu-devel@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 21, 2019 1:19 AM, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> wr=
ote:
>
> Similar to the x86_64/pc test, it boots a Linux kernel on a Malta
> machine and verify the serial is working.
>
> Use the documentation added in commit f7d257cb4a17 to test
> nanoMIPS kernels and the I7200 CPU.
>
> This test can be run using:
>
>   $ avocado --show=3Dconsole run -t arch:mipsel
tests/acceptance/boot_linux_console.py
>   console: [    0.000000] Linux version 4.15.18-00432-gb2eb9a8b
(emubuild@mipscs563) (gcc version 6.3.0 (Codescape GNU Tools 2018.04-02 for
nanoMIPS Linux)) #1 SMP Wed Jun 27 11:10:08 PDT 2018
>   console: [    0.000000] GCRs appear to have been moved (expected them
at 0x1fbf8000)!
>   console: [    0.000000] GCRs appear to have been moved (expected them
at 0x1fbf8000)!
>   console: [    0.000000] CPU0 revision is: 00010000 (MIPS GENERIC QEMU)
>   console: [    0.000000] MIPS: machine is mti,malta
>   console: [    0.000000] Determined physical RAM map:
>   console: [    0.000000]  memory: 08000000 @ 00000000 (usable)
>   console: [    0.000000] earlycon: ns16550a0 at I/O port 0x3f8 (options
'38400n8')
>   console: [    0.000000] bootconsole [ns16550a0] enabled
>   console: [    0.000000] User-defined physical RAM map:
>   console: [    0.000000]  memory: 10000000 @ 00000000 (usable)
>   console: [    0.000000] Initrd not found or empty - disabling initrd
>   console: [    0.000000] MIPS CPS SMP unable to proceed without a CM
>   console: [    0.000000] Primary instruction cache 32kB, VIPT, 4-way,
linesize 32 bytes.
>   console: [    0.000000] Primary data cache 32kB, 4-way, VIPT, cache
aliases, linesize 32 bytes
>   console: [    0.000000] This processor doesn't support highmem.
-262144k highmem ignored
>   console: [    0.000000] Zone ranges:
>   console: [    0.000000]   Normal   [mem
0x0000000000000000-0x000000000fffffff]
>   console: [    0.000000]   HighMem  empty
>   console: [    0.000000] Movable zone start for each node
>   console: [    0.000000] Early memory node ranges
>   console: [    0.000000]   node   0: [mem
0x0000000000000000-0x000000000fffffff]
>   console: [    0.000000] Initmem setup node 0 [mem
0x0000000000000000-0x000000000fffffff]
>   console: [    0.000000] random: get_random_bytes called from
start_kernel+0x60/0x2f0 with crng_init=3D0
>   console: [    0.000000] percpu: Embedded 16 pages/cpu @(ptrval) s36620
r8192 d20724 u65536
>   console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total
pages: 64960
>   console: [    0.000000] Kernel command line: printk.time=3D0 mem=3D256m=
@@0x0
console=3DttyS0 earlycon
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Fantastiquement.

Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  tests/acceptance/boot_linux_console.py | 58 ++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py
b/tests/acceptance/boot_linux_console.py
> index 6aa084e049..1c330871c0 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -10,6 +10,8 @@
>
>  import os
>  import logging
> +import lzma
> +import shutil
>
>  from avocado_qemu import Test
>  from avocado.utils import process
> @@ -136,6 +138,62 @@ class BootLinuxConsole(Test):
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
>          self.wait_for_console_pattern(console_pattern)
>
> +    def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
> +        kernel_path_xz =3D self.fetch_asset(kernel_url,
asset_hash=3Dkernel_hash)
> +        kernel_path =3D self.workdir + "kernel"
> +        with lzma.open(kernel_path_xz, 'rb') as f_in:
> +            with open(kernel_path, 'wb') as f_out:
> +                shutil.copyfileobj(f_in, f_out)
> +
> +        self.vm.set_machine('malta')
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE
> +                               + 'mem=3D256m@@0x0 '
> +                               + 'console=3DttyS0')
> +        self.vm.add_args('-no-reboot',
> +                         '-cpu', 'I7200',
> +                         '-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> +        self.wait_for_console_pattern(console_pattern)
> +
> +    def test_mips_malta32el_nanomips_4k(self):
> +        """
> +        :avocado: tags=3Darch:mipsel
> +        :avocado: tags=3Dmachine:malta
> +        :avocado: tags=3Dendian:little
> +        """
> +        kernel_url =3D ('https://mipsdistros.mips.com/LinuxDistro/nanomi=
ps/
'
> +
'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
> +                      'generic_nano32r6el_page4k.xz')
> +        kernel_hash =3D '477456aafd2a0f1ddc9482727f20fe9575565dd6'
> +        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
> +
> +    def test_mips_malta32el_nanomips_16k_up(self):
> +        """
> +        :avocado: tags=3Darch:mipsel
> +        :avocado: tags=3Dmachine:malta
> +        :avocado: tags=3Dendian:little
> +        """
> +        kernel_url =3D ('https://mipsdistros.mips.com/LinuxDistro/nanomi=
ps/
'
> +
'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
> +                      'generic_nano32r6el_page16k_up.xz')
> +        kernel_hash =3D 'e882868f944c71c816e832e2303b7874d044a7bc'
> +        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
> +
> +    def test_mips_malta32el_nanomips_64k_dbg(self):
> +        """
> +        :avocado: tags=3Darch:mipsel
> +        :avocado: tags=3Dmachine:malta
> +        :avocado: tags=3Dendian:little
> +        """
> +        kernel_url =3D ('https://mipsdistros.mips.com/LinuxDistro/nanomi=
ps/
'
> +
'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
> +                      'generic_nano32r6el_page64k_dbg.xz')
> +        kernel_hash =3D '18d1c68f2e23429e266ca39ba5349ccd0aeb7180'
> +        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
> +
>      def test_aarch64_virt(self):
>          """
>          :avocado: tags=3Darch:aarch64
> --
> 2.19.1
>
