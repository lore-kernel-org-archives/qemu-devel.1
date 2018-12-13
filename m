Received: from eggs.gnu.org ([2001:4830:134:3::10]:57039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.rutland@arm.com>) id 1gXPct-0001TO-Fw
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.rutland@arm.com>) id 1gXPcs-0003tm-OA
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:57:59 -0500
Date: Thu, 13 Dec 2018 11:57:45 +0000
From: Mark Rutland <mark.rutland@arm.com>
Message-ID: <20181213115745.ronekr5cz67nap4b@lakrids.cambridge.arm.com>
References: <20181213115503.24188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181213115503.24188-1-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/2] Fix kvm guest debugging of AA32
 guests on AA64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, ard.biesheuvel@linaro.org, marc.zyngier@arm.com

Hi Alex,

On Thu, Dec 13, 2018 at 11:55:01AM +0000, Alex Benn=C3=A9e wrote:
> Hi,
>=20
> This is an attempt to fix debugging of AArch32 binaries when running
> under KVM on AArch64 hardware. There are two parts to this, the first i=
s
> a handling the possibility of AArch32 software breakpoints with a
> heuristic based on the current execution mode. The second part is
> delaying the setup of aarch64 debugging until the shared arm_cpu_realiz=
e
> function is run by which point we have parsed and decoded the actual
> execution mode of the guest. This doesn't solve the problem of split
> mode guests which switch between an AA64 EL1 and an AA32 EL0 though.
>=20
> I still ran into a problem with single-step. Even with Mark's
> single-step fixup series:
>=20
>   To: linux-arm-kernel@lists.infradead.org
>   Cc: kvmarm@lists.cs.columbia.edu,
>   Subject: [PATCH 0/2] kvm/arm: make singlestep behaviour consistent
>   Date: Fri, 9 Nov 2018 15:07:09 +0000
>   Message-Id: <20181109150711.45864-1-mark.rutland@arm.com>
>=20
> some instructions do single-step but sometimes the single-step doesn't
> return leading to a runaway until it hits a breakpoint. I'm not sure wh=
y
> this is the case because the SS state machine shouldn't be instruction
> sensitive.

Could you please give an example sequence where this occurs? I'd be
happy to take a look.

Thanks,
Mark.
