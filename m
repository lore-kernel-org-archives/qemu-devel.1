Received: from eggs.gnu.org ([2001:4830:134:3::10]:52733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkr3V-0006qz-86
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkr3Q-0008Qe-GQ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:16:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dkr3Q-0008QD-A9
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:16:08 -0400
Date: Thu, 24 Aug 2017 13:15:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170824121558.GB28021@stefanha-x1.localdomain>
References: <20170818142613.32394-1-ldoktor@redhat.com>
	<f8f1684a-0684-7261-57c3-63aa58892000@redhat.com>
	<87bmn8qd3z.fsf@dusky.pond.sub.org>
	<c560b757-6bb1-2ded-a25b-193e5f9318c2@amsat.org>
	<20170822190709.GJ19998@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170822190709.GJ19998@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/10] qemu.py: Pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, qemu-devel@nongnu.org, famz@redhat.com, apahim@redhat.com, mreitz@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Tue, Aug 22, 2017 at 04:07:09PM -0300, Eduardo Habkost wrote:
> (CCing Cleber and Stefan)
>=20
> On Tue, Aug 22, 2017 at 07:19:45AM -0300, Philippe Mathieu-Daud=E9 wrot=
e:
> [...]
> > Can we predict how the python scripts will evolve? Only fast-testing?
> >=20
>=20
> I guess it depends on how you define "fast".  Does "fast-testing"
> include a full device-crash-test run (that could take ~30
> minutes) or the full set of iotests?
>=20
>=20
> > Is there some users hacking on qemu.py unaware they can/should use
> > libvirt-python?
>=20
> I believe the existing users of qemu.py wouldn't want to have
> dependencies on libvirt or other external modules (e.g. code that
> test specific QMP commands and/or is run by "make check").

Yes, most QEMU tests interact with QEMU at a lower level than the
libvirt API.  They may exercise new features that are not available via
libvirt so we'd end up bypassing it anyway.

It is easier to debug a test case that interacts directly with QEMU.
Investigating a failed test where libvirt is involved is more
time-consuming.

libvirt and tools built on it, like virt-builder, are good for tests
that need a fully-fledged operating system inside the guest.  Avocado
Virt is aimed at higher-level tests involving guests too:
https://avocado-virt.readthedocs.io/en/latest/WritingTests.html

Stefan
