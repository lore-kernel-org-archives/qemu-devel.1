Received: from eggs.gnu.org ([2001:4830:134:3::10]:50201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDbJ2-0000Hq-Lp
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDbJ1-0003Ok-LR
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:23:36 -0400
Date: Fri, 19 Oct 2018 17:23:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181019202321.GM31060@habkost.net>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<CAFEAcA9p0dLoNQy7kBdcXMz0HiMGEZTBX67Lq2SizTY3kgeksw@mail.gmail.com>
	<20181019184408.GG31060@habkost.net>
	<20181019215345.521d58d7@igors-macbook-pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181019215345.521d58d7@igors-macbook-pro.local>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/45] Machine queue, 2018-10-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Libvirt <libvir-list@redhat.com>, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Walle <michael@walle.cc>, qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, Oct 19, 2018 at 09:53:45PM +0200, Igor Mammedov wrote:
> On Fri, 19 Oct 2018 15:44:08 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
> > On Fri, Oct 19, 2018 at 03:12:31PM +0100, Peter Maydell wrote:
> > > On 18 October 2018 at 21:03, Eduardo Habkost <ehabkost@redhat.com> =
wrote:
> > > > The following changes since commit 09558375a634e17cea6cfbfec883ac=
2376d2dc7f:
> > > >
> > > >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target=
-arm-20181016-1' into staging (2018-10-16 17:42:56 +0100)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   git://github.com/ehabkost/qemu.git tags/machine-next-pull-reque=
st
> > > >
> > > > for you to fetch changes up to 6d8e1bcc7dd5e819ce81e6a87fffe23e39=
c700cc:
> > > >
> > > >   numa: Clean up error reporting in parse_numa() (2018-10-17 16:3=
3:40 -0300)
> > > >
> > > > ----------------------------------------------------------------
> > > > Machine queue, 2018-10-18
> > > >
> > > > * sysbus init/realize cleanups
> > > >   (C=E9dric Le Goater, Philippe Mathieu-Daud=E9)
> > > > * memory-device refactoring (David Hildenbrand)
> > > > * -smp: deprecate incorrect CPUs topology (Igor Mammedov)
> > > > * -numa parsing cleanups (Markus Armbruster)
> > > > * Fix hostmem-file memory leak (Zhang Yi)
> > > > * Typo fix (Li Qiang)
> > > >
> > > > ----------------------------------------------------------------
> > > >
> > >=20
> > > Hi. This had some problems in merge testing, I'm afraid:
> > >=20
> > > On aarch64 host, warnings running tests/cpu-plug-test for i386 and =
s390 targets:
> > >=20
> > > TEST: tests/cpu-plug-test... (pid=3D12602)
> > >   /i386/cpu-plug/pc-i440fx-3.0/cpu-add/1x3x2&maxcpus=3D12:
> > > qemu-system-i386: warning: Invalid CPU topology deprecated: sockets
> > > (1) * cores (3) * threads (2) !=3D maxcpus (12)
> > [...]
> > >=20
> > > (plus similar ppc64, x86_64 targets)
> >=20
> > Ouch.  Apologies.
> >=20
> > Can we please do something make sure "make check" will fail on
> > these cases?  I'd like to be able to trust CI systems like
> > travis-ci.
> >=20
>=20
> we probably don't want make check fail on warning.

I disagree.  If a warning is blocking a pull request from being
merged, it must make CI systems fail too.  Otherwise we're
defeating the purpose of CI systems.


> Test was written with assumption that s/c/t tuples matches initially pr=
esent CPUs, hence a warning.
> Would something like following fix the issue (local x86 build/test look=
s fixed with it)?

It works for me.  I will queue it on machine-next, thanks!

>=20
> diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
> index 3e93c8e..f4a677d 100644
> --- a/tests/cpu-plug-test.c
> +++ b/tests/cpu-plug-test.c
> @@ -32,12 +32,12 @@ static void test_plug_with_cpu_add(gconstpointer da=
ta)
>      unsigned int i;
> =20
>      args =3D g_strdup_printf("-machine %s -cpu %s "
> -                           "-smp sockets=3D%u,cores=3D%u,threads=3D%u,=
maxcpus=3D%u",
> +                           "-smp 1,sockets=3D%u,cores=3D%u,threads=3D%=
u,maxcpus=3D%u",
>                             s->machine, s->cpu_model,
>                             s->sockets, s->cores, s->threads, s->maxcpu=
s);
>      qtest_start(args);
> =20
> -    for (i =3D s->sockets * s->cores * s->threads; i < s->maxcpus; i++=
) {
> +    for (i =3D 1; i < s->maxcpus; i++) {
>          response =3D qmp("{ 'execute': 'cpu-add',"
>                         "  'arguments': { 'id': %d } }", i);
>          g_assert(response);
> @@ -56,7 +56,7 @@ static void test_plug_without_cpu_add(gconstpointer d=
ata)
>      QDict *response;
> =20
>      args =3D g_strdup_printf("-machine %s -cpu %s "
> -                           "-smp sockets=3D%u,cores=3D%u,threads=3D%u,=
maxcpus=3D%u",
> +                           "-smp 1,sockets=3D%u,cores=3D%u,threads=3D%=
u,maxcpus=3D%u",
>                             s->machine, s->cpu_model,
>                             s->sockets, s->cores, s->threads, s->maxcpu=
s);
>      qtest_start(args);
> @@ -79,12 +79,12 @@ static void test_plug_with_device_add_x86(gconstpoi=
nter data)
>      unsigned int s, c, t;
> =20
>      args =3D g_strdup_printf("-machine %s -cpu %s "
> -                           "-smp sockets=3D%u,cores=3D%u,threads=3D%u,=
maxcpus=3D%u",
> +                           "-smp 1,sockets=3D%u,cores=3D%u,threads=3D%=
u,maxcpus=3D%u",
>                             td->machine, td->cpu_model,
>                             td->sockets, td->cores, td->threads, td->ma=
xcpus);
>      qtest_start(args);
> =20
> -    for (s =3D td->sockets; s < td->maxcpus / td->cores / td->threads;=
 s++) {
> +    for (s =3D 1; s < td->sockets; s++) {
>          for (c =3D 0; c < td->cores; c++) {
>              for (t =3D 0; t < td->threads; t++) {
>                  char *id =3D g_strdup_printf("id-%i-%i-%i", s, c, t);
> @@ -113,7 +113,7 @@ static void test_plug_with_device_add_coreid(gconst=
pointer data)
>                             td->sockets, td->cores, td->threads, td->ma=
xcpus);
>      qtest_start(args);
> =20
> -    for (c =3D td->cores; c < td->maxcpus / td->sockets / td->threads;=
 c++) {
> +    for (c =3D 1; c < td->cores; c++) {
>          char *id =3D g_strdup_printf("id-%i", c);
>          qtest_qmp_device_add(td->device_model, id, "{'core-id':%u}", c=
);
>          g_free(id);
> @@ -148,7 +148,7 @@ static void add_pc_test_case(const char *mname)
>      data->sockets =3D 1;
>      data->cores =3D 3;
>      data->threads =3D 2;
> -    data->maxcpus =3D data->sockets * data->cores * data->threads * 2;
> +    data->maxcpus =3D data->sockets * data->cores * data->threads;
>      if (g_str_has_suffix(mname, "-1.4") ||
>          (strcmp(mname, "pc-1.3") =3D=3D 0) ||
>          (strcmp(mname, "pc-1.2") =3D=3D 0) ||
> @@ -203,7 +203,7 @@ static void add_pseries_test_case(const char *mname=
)
>      data->sockets =3D 2;
>      data->cores =3D 3;
>      data->threads =3D 1;
> -    data->maxcpus =3D data->sockets * data->cores * data->threads * 2;
> +    data->maxcpus =3D data->sockets * data->cores * data->threads;
> =20
>      path =3D g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=3D=
%u",
>                             mname, data->sockets, data->cores,
> @@ -229,7 +229,7 @@ static void add_s390x_test_case(const char *mname)
>      data->sockets =3D 1;
>      data->cores =3D 3;
>      data->threads =3D 1;
> -    data->maxcpus =3D data->sockets * data->cores * data->threads * 2;
> +    data->maxcpus =3D data->sockets * data->cores * data->threads;
> =20
>      data2 =3D g_memdup(data, sizeof(PlugTestData));
>      data2->machine =3D g_strdup(data->machine);
>=20
>=20

--=20
Eduardo
