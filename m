Received: from eggs.gnu.org ([2001:4830:134:3::10]:49145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1elkf6-0000jd-96
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 19:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1elkf3-0001Rh-3J
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 19:11:00 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1elkf2-0001NI-Rk
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 19:10:57 -0500
Date: Tue, 13 Feb 2018 19:10:53 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180214001053.GA23702@flamenco>
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
	<1518053328-34687-10-git-send-email-mjc@sifive.com>
	<20180213215541.GA1816@flamenco>
	<731db20e-4d86-e288-504c-30c83b56fd33@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731db20e-4d86-e288-504c-30c83b56fd33@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v5 09/23] RISC-V TCG Code Generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Michael Clark <mjc@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Tue, Feb 13, 2018 at 14:10:20 -0800, Richard Henderson wrote:
> On 02/13/2018 01:55 PM, Emilio G. Cota wrote:
> > Are we planning to use BS_STOP in the future? I see it has no setters,
> > although we check for it in gen_intermediate_code:
> 
> No, but the whole port should be converted to exec/translator.h, which defines
> DisasJumpType.  Not something I'm going to require on initial submission until
> we've gotten most of the other targets cleaned up.

I see. I've just done the conversion for v5:
  https://github.com/cota/qemu/commits/riscv-v5-trloop

Can you please take a look?

Thanks,

		Emilio
