Received: from eggs.gnu.org ([2001:4830:134:3::10]:35789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkEWK-0005xM-GL
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 15:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkEWH-0008K2-BL
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 15:07:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dkEWH-0008JN-6A
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 15:07:21 -0400
Date: Tue, 22 Aug 2017 16:07:09 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170822190709.GJ19998@localhost.localdomain>
References: <20170818142613.32394-1-ldoktor@redhat.com>
	<f8f1684a-0684-7261-57c3-63aa58892000@redhat.com>
	<87bmn8qd3z.fsf@dusky.pond.sub.org>
	<c560b757-6bb1-2ded-a25b-193e5f9318c2@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c560b757-6bb1-2ded-a25b-193e5f9318c2@amsat.org>
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, qemu-devel@nongnu.org, famz@redhat.com, apahim@redhat.com, mreitz@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

(CCing Cleber and Stefan)

On Tue, Aug 22, 2017 at 07:19:45AM -0300, Philippe Mathieu-Daud=E9 wrote:
[...]
> Can we predict how the python scripts will evolve? Only fast-testing?
>=20

I guess it depends on how you define "fast".  Does "fast-testing"
include a full device-crash-test run (that could take ~30
minutes) or the full set of iotests?


> Is there some users hacking on qemu.py unaware they can/should use
> libvirt-python?

I believe the existing users of qemu.py wouldn't want to have
dependencies on libvirt or other external modules (e.g. code that
test specific QMP commands and/or is run by "make check").


> If so, shouldn't we think about running more tests through libvirt and =
add
> effort there?

Even if the existing test code wouldn't benefit from libvirt, I
agree there is some value in writing test code that uses libvirt.
But in this case would the test code belong to the QEMU source
tree, or somewhere else?

--=20
Eduardo
