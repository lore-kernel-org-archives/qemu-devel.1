Received: from eggs.gnu.org ([2001:4830:134:3::10]:45389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bigeasy@linutronix.de>) id 1gCqJa-0000J4-QK
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bigeasy@linutronix.de>) id 1gCqJa-0003Dj-0Q
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:13:02 -0400
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1]:36965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bigeasy@linutronix.de>)
	id 1gCqJZ-000337-PV
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:13:01 -0400
Date: Wed, 17 Oct 2018 20:12:52 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-ID: <20181017181251.fpnh6y5ldrmgb7j5@linutronix.de>
References: <20180928104319.3296-1-bigeasy@linutronix.de>
	<20180928145411.GN5738@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180928145411.GN5738@habkost.net>
Subject: Re: [Qemu-devel] [PATCH] i386: correct cpu_x86_cpuid(0xd)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, tglx@linutronix.de, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 2018-09-28 11:54:11 [-0300], Eduardo Habkost wrote:
> On Fri, Sep 28, 2018 at 12:43:19PM +0200, Sebastian Andrzej Siewior wrote:
> > Intel SDM says for CPUID function 0DH, sub-function 0:
> >=20
> > | =E2=80=A2 ECX enumerates the size (in bytes) required by the XSAVE in=
struction for an
> > |   XSAVE area containing all the user state components supported by th=
is
> > |   processor.
> > | =E2=80=A2 EBX enumerates the size (in bytes) required by the XSAVE in=
struction for an
> > |   XSAVE area containing all the user state components corresponding t=
o bits
> > |   currently set in XCR0.
> >=20
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  target/i386/cpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index f24295e6e4bb7..00c18444c0bac 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -4178,7 +4178,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t ind=
ex, uint32_t count,
> >              *ecx =3D xsave_area_size(x86_cpu_xsave_components(cpu));
> >              *eax =3D env->features[FEAT_XSAVE_COMP_LO];
> >              *edx =3D env->features[FEAT_XSAVE_COMP_HI];
> > -            *ebx =3D *ecx;
> > +            *ebx =3D xsave_area_size(env->xcr0);
>=20
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

ping

Sebastian
