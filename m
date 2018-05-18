Received: from eggs.gnu.org ([2001:4830:134:3::10]:52839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fJaLG-0005UG-8D
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fJaLD-0002HR-5P
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:02:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fJaLD-0002Gm-17
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:02:19 -0400
Date: Fri, 18 May 2018 10:02:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180518100214.5e14a753@redhat.com>
In-Reply-To: <CAHNT7NtoqQDpQCMF9C92KHvn6jLAy0K1fOJaT6nTTAAJ0s+utQ@mail.gmail.com>
References: <1526382973-49342-1-git-send-email-imammedo@redhat.com>
	<1526400000-66561-1-git-send-email-imammedo@redhat.com>
	<CAHNT7NtoqQDpQCMF9C92KHvn6jLAy0K1fOJaT6nTTAAJ0s+utQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] riscv: remove define cpu_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?= =?UTF-8?B?w6k=?= <f4bug@amsat.org>

On Fri, 18 May 2018 14:10:24 +1200
Michael Clark <mjc@sifive.com> wrote:

> On Wed, May 16, 2018 at 4:00 AM, Igor Mammedov <imammedo@redhat.com> wrot=
e:
>=20
> > cpu_init() was removed since 2.12, so drop the define that is now unuse=
d.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > =20
>=20
> Reviewed-by: Michael Clark <mjc@sifive.com>
Michael,

could you merge it through RISCV queue?

>=20
> ---
> > v2:
> >   * refine commit message (Eric Blake <eblake@redhat.com>)
> > ---
> >  target/riscv/cpu.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 34abc38..0562a02 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -251,7 +251,6 @@ int riscv_cpu_handle_mmu_fault(CPUState *cpu, vaddr
> > address, int size,
> >  char *riscv_isa_string(RISCVCPU *cpu);
> >  void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
> >
> > -#define cpu_init(cpu_model) cpu_generic_init(TYPE_RISCV_CPU, cpu_model)
> >  #define cpu_signal_handler cpu_riscv_signal_handler
> >  #define cpu_list riscv_cpu_list
> >  #define cpu_mmu_index riscv_cpu_mmu_index
> > --
> > 2.7.4
> >
> > =20
