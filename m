Received: from eggs.gnu.org ([2001:4830:134:3::10]:42026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fX5LP-0004kT-CS
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 09:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fX5LM-0003sR-8h
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 09:46:19 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <bc3cd25b-bdd1-3bc7-8d2d-5c351f2c30d5@linaro.org>
Date: Sun, 24 Jun 2018 09:46:12 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <4CC477CD-237F-480D-B9B5-B35FF507BD3C@gmail.com>
References: <20180623022258.22158-1-programmingkidx@gmail.com>
	<ecf44486-09a4-9c9a-b96e-1db2d6a1bcbe@linaro.org>
	<1E63C3B2-7668-4D05-BC43-02E478FB493B@gmail.com>
	<bc3cd25b-bdd1-3bc7-8d2d-5c351f2c30d5@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


> On Jun 24, 2018, at 12:18 AM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 06/23/2018 01:17 PM, Programmingkid wrote:
>>>> =
https://www.pdfdrive.net/powerpc-microprocessor-family-the-programming-env=
ironments-for-32-e3087633.html
>>>> This document has the information on the fdiv. Page 133 has the =
information on what action is executed when a division by zero situation =
takes place.=20
>=20
> Even in your referenced PDF, table 3-13, it says that frD is =
unmodified.

Actually it says when FPSCR[ZE] is set is when frD is unmodified. When =
FPSCR[ZE] is not set it frD's sign is determined by an XOR of the signs =
of the operands. I have verified that this is what happens on real =
PowerPC 750 and 950 CPUs.=20

>=20
>>> struct sigaction a =3D { .sa_sigaction =3D handle, .sa_flags =3D =
SA_SIGINFO };
>>> sigaction(SIGFPE, &a, NULL);
>>> feenableexcept(FE_ALL_EXCEPT);
>>=20
>> This is C99 code. There are a lot of floating point bugs with this =
implementation. I suggest all future testing be done using PowerPC =
assembly language only.
>=20
> Um.. have you really ever seen an implementation that won't set ZE?

I do know that when I did try to use C99 floating point code I saw a lot =
of problems. Bypassing any library issues by directly setting the FPSCR =
is best for testing. Table 2-4 in the pdf has information on the FPSCR.=20=


>=20
>> What compiler did you use to compile this program?
>=20
> gcc 7.2.
>=20
>> What operating system did you run this program on?
>=20
> CentOS 7, so kernel 3.10, glibc 2.17.
>=20
>> What are the specs of the system you used to test this program on?
>=20
> CHRP IBM,8231-E2B (Power7).

I was just wondering are you able to run a PowerPC operating system in =
QEMU in KVM mode on this Power7 computer?

Thank you.
