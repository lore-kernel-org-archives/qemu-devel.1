Received: from eggs.gnu.org ([2001:4830:134:3::10]:54153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cXQKO-0004td-Vg
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 05:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cXQKL-0003Xz-Te
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 05:33:52 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:35185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cXQKL-0003XU-Mb
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 05:33:49 -0500
Received: by mail-wm0-x230.google.com with SMTP id r126so149821294wmr.0
	for <qemu-devel@nongnu.org>; Sat, 28 Jan 2017 02:33:49 -0800 (PST)
References: <20170128060834.11421.45757.malonedeb@soybean.canonical.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170128060834.11421.45757.malonedeb@soybean.canonical.com>
Date: Sat, 28 Jan 2017 10:33:46 +0000
Message-ID: <87poj7cw39.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Bug 1660010] [NEW] AArch64 system emulation
 cannot execute virt uefi in 2.7 or 2.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1660010 <1660010@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


Icenowy Zheng <1660010@bugs.launchpad.net> writes:

> Public bug reported:
>
> The UEFI firmware file is retrieved from
> http://snapshots.linaro.org/components/kernel/linaro-
> edk2/latest/release/qemu64/QEMU_EFI.fd .
>
> The error is:
> ```
> TODO /var/lib/abbs/build/tmp.p2dMBBlJ0D/qemu-2.7.0/tci.c:1049: tcg_qemu_tb_exec()
> /var/lib/abbs/build/tmp.p2dMBBlJ0D/qemu-2.7.0/tci.c:1049: tcg fatal error
> ```

What is your command line and why are you running with the TCI?

>
> (both 2.7.0 and 2.8.0 are tested to fail, 2.6.1 works)
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New


--
Alex Bennée
