Received: from eggs.gnu.org ([2001:4830:134:3::10]:44767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gOlu9-0000ks-13
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gOlu4-0005qC-VI
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:56:04 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:39972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gOlu4-0005p1-Mn
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:56:00 -0500
Date: Mon, 19 Nov 2018 16:55:48 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181119155548.GB2405@sx9>
References: <20181118203312.5376-1-f4bug@amsat.org>
	<20181118203312.5376-2-f4bug@amsat.org> <87wop9i7db.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wop9i7db.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] docker: Add
 gentoo-mipsr5900el-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Mike Frysinger <vapier@gentoo.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>

Hi Alex,

> This fails to build glibc, but doesn't exactly give much info:
> 
>    * Log: /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-binutils.log
>    * Emerging cross-binutils ...                                            [ ok ]
>    * Log: /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-linux-headers-quick.log
>    * Emerging cross-linux-headers-quick ...                                 [ ok ]
>    * Log: /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-glibc-headers.log
>    * Emerging cross-glibc-headers ...
> 
>    * error: glibc failed :(
>    *
>    * If you file a bug, please attach the following logfiles:
>    * /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-info.log
>    * /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-glibc-headers.log.xz
>    * /var/tmp/portage/cross-mipsr5900el-unknown-linux-gnu/glibc*/temp/glibc-config.logs.tar.xz
>   The command '/bin/sh -c crossdev -s3 -t mipsr5900el-unknown-linux-gnu --binutils ">=2.30" --gcc ">=7.2.0"' returned a non-zero code: 1

I would recommend using GCC 8.2.0, by omitting the --binutils and --gcc
options to crossdev, unless you would like to debug this particular
combination of GCC and Glibc (which I can confirm seems broke). Updated
and much simplified R5900 patches are available in my previous email:

http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg03649.html

Hopefully soon, with upcoming GCC and Gblic releases, no R5900 patches
are needed at all. Also, a new -mfix-r5900 option has been proposed to
both GAS and GCC:

http://www.sourceware.org/ml/binutils/2018-10/msg00301.html

https://gcc.gnu.org/ml/gcc-patches/2018-11/msg00773.html

With that option one can compile e.g. MIPS II or MIPS III that also
work with the R5900.

The R3900 and the R5900 could for example run the same programs then,
and I do hope that Philippe will be able to merge his R3900 series
eventually.

Fredrik
