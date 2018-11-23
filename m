Received: from eggs.gnu.org ([2001:4830:134:3::10]:51696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gQ7Jp-0007bp-W4
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:00:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gQ7Jn-0004Wc-U2
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:00:09 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:41717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gQ7Jn-0004VC-Ly
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:00:07 -0500
Received: by mail-oi1-x236.google.com with SMTP id j21so9390406oii.8
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 01:00:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e8dae726-8853-4e44-1eb8-b9cfb0bc44f2@mentor.com>
References: <e8dae726-8853-4e44-1eb8-b9cfb0bc44f2@mentor.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Nov 2018 08:59:46 +0000
Message-ID: <CAFEAcA_EM39P8HFoC=B=XP3Ax8NgNSotn=wMJJsG05P8Ywdruw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-discuss] How to select specific qemu net
 'nic' device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mbilal <muhammad_bilal@mentor.com>
Cc: qemu-discuss <qemu-discuss@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 23 November 2018 at 04:13, mbilal <muhammad_bilal@mentor.com> wrote:
> Hi,
>
> I'm using qemu emulation for xilinx zcu102 platform, this board have four
> networking GEM0, GEM1, GEM2 and GEM3 devices.
>
> To run network demo on this board *only* require GEM3 device to be configure
> while other GEM devices don't need to be configure, that's why u-boot and
> other RTOS only configure GEM3 device.
>
>
> QEMU is enabling these GEM devices  with networking '-net nic' option and
> QEMU consider first '-net nic' option for GEM0 and second '-net nic' option
> for GEM1 and so on. that's why if need to enable GEM3 network device we must
> need to give following full command line options
>
> -net nic -net nic -net nic -net nic -net user, ...
>
> In this way all four GEM devices would be enable but first three GEM0-GEM2
> devices are un-configured and useless. In our case QEMU is being *crashed*
> due to trying to use these un-configured GEM devices to o send/receive GDB
> breakoint/interrupt cause. IIUC QEMU uses first device in the -nic loop
> i.e
>
> qemu-system-aarch64: hw/net/cadence_gem.c:921: gem_receive: Assertion
> `!first_desc' failed.

If QEMU asserts like this, this is a bug in QEMU. I've cc'd
the maintainers of the Xilinx board.

Could you provide a complete set of instructions to reproduce
this bug, please ? (full command line, guest image, etc)

Could you also tell us which version of QEMU you are using?
If possible, try with the current git master or
with the 3.1 rc2 release candidate we've just put out, to
see if it's already been fixed.

thanks
-- PMM
