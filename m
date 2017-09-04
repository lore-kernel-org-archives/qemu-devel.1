Received: from eggs.gnu.org ([2001:4830:134:3::10]:35563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dowi4-0000Dv-HV
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 15:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dowhz-0007sh-RX
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 15:07:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dowhz-0007qw-In
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 15:06:55 -0400
Date: Mon, 4 Sep 2017 21:06:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170904210649.1266364c@Igors-MacBook-Pro.local>
In-Reply-To: <ee6dfcaa-c2fd-a3f3-a2ea-8fe9cce69099@amsat.org>
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
	<1504533662-198084-4-git-send-email-imammedo@redhat.com>
	<ee6dfcaa-c2fd-a3f3-a2ea-8fe9cce69099@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] cpu: rename cpu_parse_features() to
 cpu_parse_cpu_model()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, 4 Sep 2017 12:03:09 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi Igor,
>=20
> On 09/04/2017 11:00 AM, Igor Mammedov wrote:
> > function not just parses features but also converts CPU model
> > name to CPU type, rename it to reflect what it actualy does.
>=20
> Why not squash this with your 1st patch "split cpu_generic_init()"?
there I went with current/exiting way to call that part of code,
and here I'm renaming it to show what it does exactly.

But I don't have any preference here, so I can squash this patch
into 1/6 on respin, if you prefer.

>=20
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >   include/qom/cpu.h | 4 ++--
> >   qom/cpu.c         | 4 ++--
> >   2 files changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> > index 392ae75..a718daf 100644
> > --- a/include/qom/cpu.h
> > +++ b/include/qom/cpu.h
> > @@ -643,7 +643,7 @@ ObjectClass *cpu_class_by_name(const char *typename=
, const char *cpu_model);
> >   CPUState *cpu_create(const char *typename);
> >  =20
> >   /**
> > - * cpu_parse_features:
> > + * cpu_parse_cpu_model:
> >    * @typename: The CPU base type or CPU type.
> >    * @cpu_model: The model string including optional parameters.
> >    *
> > @@ -652,7 +652,7 @@ CPUState *cpu_create(const char *typename);
> >    * Returns: type of CPU to create or prints error and terminates proc=
ess
> >    *          if an error occurred.
> >    */
> > -const char *cpu_parse_features(const char *typename, const char *cpu_m=
odel);
> > +const char *cpu_parse_cpu_model(const char *typename, const char *cpu_=
model);
> >  =20
> >   /**
> >    * cpu_generic_init:
> > diff --git a/qom/cpu.c b/qom/cpu.c
> > index 307d638..199ad57 100644
> > --- a/qom/cpu.c
> > +++ b/qom/cpu.c
> > @@ -66,7 +66,7 @@ CPUState *cpu_create(const char *typename)
> >       return cpu;
> >   }
> >  =20
> > -const char *cpu_parse_features(const char *typename, const char *cpu_m=
odel)
> > +const char *cpu_parse_cpu_model(const char *typename, const char *cpu_=
model)
> >   {
> >       ObjectClass *oc;
> >       CPUClass *cc;
> > @@ -99,7 +99,7 @@ CPUState *cpu_generic_init(const char *typename, cons=
t char *cpu_model)
> >       /* TODO: all callers of cpu_generic_init() need to be converted to
> >        * call cpu_parse_features() only once, before calling cpu_generi=
c_init().
> >        */
> > -    const char *cpu_type =3D cpu_parse_features(typename, cpu_model);
> > +    const char *cpu_type =3D cpu_parse_cpu_model(typename, cpu_model);
> >  =20
> >       assert(cpu_type);
> >       return cpu_create(cpu_type);
> >=20
