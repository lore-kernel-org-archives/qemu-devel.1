Received: from eggs.gnu.org ([2001:4830:134:3::10]:43048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVdvz-0003T7-8f
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:41:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVdvy-0008TN-9r
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:41:19 -0500
Received: from mail-vk0-x234.google.com ([2607:f8b0:400c:c05::234]:35636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cVdvy-0008TI-3o
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:41:18 -0500
Received: by mail-vk0-x234.google.com with SMTP id x75so89388704vke.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 04:41:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484779123-18968-31-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
	<1484779123-18968-31-git-send-email-atar4qemu@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jan 2017 12:40:54 +0000
Message-ID: <CAFEAcA8=gKjbo9YaRAzGHi-tP6AWY08ps_tEPOSzpNFXBC6M+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 30/30] target-sparc: fix up niagara machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>

On 18 January 2017 at 22:38, Artyom Tarasenko <atar4qemu@gmail.com> wrote:
> Remove the Niagara stub implementation from sun4u.c and add a machine,
> compatible with Legion simulator from the OpenSPARC T1 project.
>
> The machine uses the firmware supplied with the OpenSPARC T1 project,
> http://download.oracle.com/technetwork/systems/opensparc/OpenSPARCT1_Arch.1.5.tar.bz2
> in the directory S10image/, and is able to boot the supplied Solaris 10 image.
>
> Note that for compatibility with the naming conventions for SPARC machines
> the new machine name is lowercase niagara.
>
> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

I see that 'make check' now warns:
  GTESTER check-qtest-sparc64
Could not open option rom 'nvram1': No such file or directory
Could not open option rom '1up-md.bin': No such file or directory
Could not open option rom '1up-hv.bin': No such file or directory
Could not open option rom 'reset.bin': No such file or directory
Could not open option rom 'q.bin': No such file or directory
Could not open option rom 'openboot.bin': No such file or directory

(though the tests still pass).

Could we either ship these images in pc-bios if they're
necessary, or not complain that they don't exist if they're
not necessary, please?

thanks
-- PMM
