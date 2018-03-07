Received: from eggs.gnu.org ([2001:4830:134:3::10]:38683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1etVjc-0000JL-UZ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 04:51:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1etVjZ-0003xD-RS
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 04:51:45 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:38089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1etVjZ-0003wt-JX
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 04:51:41 -0500
Received: by mail-wr0-x241.google.com with SMTP id n7so1481886wrn.5
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 01:51:41 -0800 (PST)
References: <20170120152141.14276.42073.malonedeb@soybean.canonical.com>
	<152041267242.7807.1797840678819358821.malone@gac.canonical.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <152041267242.7807.1797840678819358821.malone@gac.canonical.com>
Date: Wed, 07 Mar 2018 09:51:39 +0000
Message-ID: <87muzkz00k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1658120] Re: building with
 gcc-aarch64-linux-gnu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1658120 <1658120@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


Cao Van Dong <1658120@bugs.launchpad.net> writes:

> Hello everyone!!
>
> I am having a issue when build qemu using gcc aarch64-linux-gnu-* on
> ubuntu 16.04:
>
> dong02@dong:~/qemu$ ./configure                                          =
        \
>>     --prefix=3D/usr --cross-prefix=3D/usr/bin/aarch64-linux-gnu-   \
>>     --target-list=3Daarch64-softmmu                              \
>>     --enable-attr       --enable-fdt       --enable-kvm        \
>>     --enable-sdl        --enable-system    --enable-tools      \
>>     --audio-drv-list=3D                                          \
>>     --disable-bluez     --disable-brlapi   --disable-bsd-user  \
>>     --disable-cap-ng    --disable-curl     --disable-curses    \
>>     --disable-docs      --disable-libiscsi --disable-linux-aio \
>>     --disable-rbd       --disable-seccomp  --disable-slirp     \
>>     --disable-sparse    --disable-spice    --disable-strip     \
>>     --disable-usb-redir --disable-vde      --disable-virtfs    \
>>     --disable-vnc       --disable-werror   --disable-xen
>
> ERROR: zlib check failed
>        Make sure to have the zlib libs and headers installed.
>
> I installed zlib library: sudo apt-get install zlib1g-dev. However, resul=
t no change
> Please help me!!

You will have installed the x86 version of the zlib1g-dev libraries.
Unfortunately headers are not uniform across all architectures.

If you want to ensure you have all the appropriate headers for cross
compiling QEMU do:

  apt-get build-dep -a arm64 qemu

But you may well run into problems if the distribution isn't fully
multi-arch clean. This is one of the reasons we use docker to isolate
our various cross build environments:

  make docker-test-build@debian-arm64-cross J=3D9 TARGET_LIST=3Daarch64-sof=
tmmu

--
Alex Benn=C3=A9e
