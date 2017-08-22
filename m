Received: from eggs.gnu.org ([2001:4830:134:3::10]:36691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dkBNq-0007Ar-Re
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dkBNn-0005Xu-Je
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:46:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42825)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dkBNn-0005XW-Ae
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:46:23 -0400
Date: Tue, 22 Aug 2017 11:46:19 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1256985773.1887717.1503416779700.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170822171404.7b11bca6.cohuck@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-52-marcandre.lureau@redhat.com>
	<20170822162400.51f07d89.cohuck@redhat.com>
	<d1574f35-ebe5-8ede-180a-e584834e9d9a@redhat.com>
	<1880955910.1845734.1503412894881.JavaMail.zimbra@redhat.com>
	<20170822171404.7b11bca6.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 51/54] qapi: make s390 commands depend
 on TARGET_S390X
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

----- Original Message -----
> On Tue, 22 Aug 2017 10:41:34 -0400 (EDT)
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>=20
> > Hi
> >=20
> > ----- Original Message -----
> > > On 22.08.2017 16:24, Cornelia Huck wrote:
> > > > On Tue, 22 Aug 2017 15:22:52 +0200
> > > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>=20
> > > >> @@ -4621,7 +4622,9 @@
> > > >>  ##
> > > >>  { 'command': 'query-cpu-model-comparison',
> > > >>    'data': { 'modela': 'CpuModelInfo', 'modelb': 'CpuModelInfo' },
> > > >> -  'returns': 'CpuModelCompareInfo' }
> > > >> +  'returns': 'CpuModelCompareInfo',
> > > >> +  'if': ['defined(NEED_CPU_H)', 'defined(TARGET_S390X)']}
> > > >> +
> > > >> =20
> > > >>  ##
> > > >>  # @CpuModelBaselineInfo:
> > > >> @@ -4673,7 +4676,8 @@
> > > >>  { 'command': 'query-cpu-model-baseline',
> > > >>    'data': { 'modela': 'CpuModelInfo',
> > > >>              'modelb': 'CpuModelInfo' },
> > > >> -  'returns': 'CpuModelBaselineInfo' }
> > > >> +  'returns': 'CpuModelBaselineInfo',
> > > >> +  'if': ['defined(NEED_CPU_H)', 'defined(TARGET_S390X)']}
> > > >=20
> > > > ...but I'm not sure about the cpu model stuff. Wasn't the idea to m=
ove
> > > > to this model for all architectures later? (Given that we have stub=
s
> > > > for architectures not implementing this, instead of ifdeffing it in
> > > > monitor.c)
> > > >  =20
> > >=20
> > > +1, not architecture specific (in contrast to skey), simply not
> > > supported _yet_ on other architectures.
> >=20
> > We can add other archs once they implement it. See for example:
> > "qapi: make query-cpu-model-expansion depend on s390 or x86"
>=20
> That seems a bit like whack-a-mole, though. Depending on something like
> "provides cpumodel feature xy" makes it clearer that this is supposed
> to be non-architecture-specific.

I would say the function name and documentation should say if it's architec=
ture specific. The #ifdef in qapi generation or in qemu code base is just a=
n implementation detail. I suggest to add FIXME in the schema so people loo=
king at this realize it's not yet there (instead of error stubs in qemu cod=
e / runtime).
>=20
