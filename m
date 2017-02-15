Received: from eggs.gnu.org ([2001:4830:134:3::10]:41056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdzFR-0000xu-7U
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 08:03:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdzFQ-0003zN-8J
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 08:03:53 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:36817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cdzFQ-0003yd-0q
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 08:03:52 -0500
Received: by mail-wr0-x22f.google.com with SMTP id k90so190111538wrc.3
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 05:03:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <tencent_0D7C69D20350D3654337361B@qq.com>
References: <tencent_44FCF9336341E20C3F2A5EB7@qq.com>
	<CAFEAcA_2hK+cYTnBeR-GX1jqkCtUr6JEzaduP9VAu-vLGWTefQ@mail.gmail.com>
	<tencent_0D7C69D20350D3654337361B@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Feb 2017 13:03:29 +0000
Message-ID: <CAFEAcA-13woFEUEbMacux1S4vDM5vaCGwxOrE51nsimKp8wEgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Fw: qemu integrator RAM size can't reach 128M
 whenemulate the arm926
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: heavybird <4345099@qq.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 15 February 2017 at 09:41, heavybird <4345099@qq.com> wrote:
> the issue i reported is caused by my test program, i fixed it by myself now.
> some more concern about your integratorcp.c.
> 1 what is your consideration to use the direct address in the code
> (s->cm_osc = 0x01000048,integratorcm_init), does it take some potential
> trouble for user once it is overlapped in the guest code?

This value is not an address. It is the reset value for the
CM_OSC oscillator control register, and indicates that
the BMODE field is set to 0b10 and the PLL_VDW field
is set to 0b01001000, which is the standard value for this
board as documented in the CM926EJ-S integrator core module
user guide.

> 2 is it possible to create a big DRAM(256M above) memory space to change
> your code integratorcp.c just like the "integrator.flash" with the function
> memory_region_init_ram.

The integratorcp is a model of a specific board, and that
board can't have a large DRAM in it. You'd need to
look at the board's physical address map to find out
if there is space in it to add more RAM.
integrator.flash is a complicated thing because it is
possible for the guest to control at runtime whether
it is mapped; it's not a good example to follow for
simple always-present RAM.

For the standards of the time 256MB was a decent amount
of RAM for an ARM926 core.

thanks
-- PMM
