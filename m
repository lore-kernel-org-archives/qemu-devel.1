Received: from eggs.gnu.org ([2001:4830:134:3::10]:53841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cnP9H-0000pW-B0
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cnP9E-0001HQ-7D
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:32:27 -0400
Received: from mail.ispras.ru ([83.149.199.45]:59766)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cnP9D-0001GA-Vx
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:32:24 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170307155054.5833-1-alex.bennee@linaro.org>
In-Reply-To: <20170307155054.5833-1-alex.bennee@linaro.org>
Date: Mon, 13 Mar 2017 15:32:20 +0300
Message-ID: <001801d29bf5$dcba37d0$962ea770$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v3 00/11] MTTCG fix-ups for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com

Hi,

> From: mttcg-request@listserver.greensocs.com =
[mailto:mttcg-request@listserver.greensocs.com]
>=20
> The next thing on my list it to look at the icount problems and review
> Paolo's fixes for it. However those fixes should go in a separate
> series and I assume via Paolo's tree.
=20
Do you mean those problems that completely broke icount?
Are you going to fix it?


> Alex Benn=C3=A9e (9):
>   vl/cpus: be smarter with icount and MTTCG
>   target/i386/cpu.h: declare TCG_GUEST_DEFAULT_MO
>   cpus.c: add additional error_report when !TARGET_SUPPORT_MTTCG
>   sparc/sparc64: grab BQL before calling cpu_check_irqs
>   s390x/misc_helper.c: wrap IO instructions in BQL
>   target/xtensa: hold BQL for interrupt processing
>   translate-all: exit cpu_restore_state early if translating
>   target/arm/helper: make it clear the EC field is also in hex
>   hw/intc/arm_gic: modernise the DPRINTF
>=20
> Paolo Bonzini (1):
>   target-i386: defer VMEXIT to do_interrupt
>=20
> Yongbok Kim (1):
>   target/mips: hold BQL for timer interrupts


Pavel Dovgalyuk
