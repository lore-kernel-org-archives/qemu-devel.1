Received: from eggs.gnu.org ([2001:4830:134:3::10]:34024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dYHW0-0001jn-32
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dYHVz-00079o-CU
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:53:40 -0400
Date: Thu, 20 Jul 2017 21:53:25 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170720195325.pjxi45dbm27jzstm@aurel32.net>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 00/23] Implementing FP16 for
 ARMv8.2 using SoftFloat2a and 3c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-15?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net

On 2017-07-20 16:04, Alex Benn=E9e wrote:
> I then implement a few random functions using the softfloat3c code. To
> keep things clean the helper functions are all in advsimd_helper.c. As
> the two implementations are sitting side by side we need to copy the
> exception flags back and forth to ensure the virtual FPU state is
> correct between operations implemented by both libraries. This can
> obviously be removed is an architecture fully transitions to a later
> library.

softfloat3a uses a global FPU state. As it is thread local, that should
not be a problem as long as we have one thread per VCPU (which is the
case with MTTCG). However, how do you plan to handle the switch from one
FPU state to another for the architectures using multiple FPU contexts?
That concerns at least arm, i386, mips and ppc.

Regards,
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
