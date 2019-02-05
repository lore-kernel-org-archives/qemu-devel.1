Received: from eggs.gnu.org ([209.51.188.92]:47522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gr3Q2-0007gR-AI
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:17:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gr3Q1-0007Ex-G7
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:17:54 -0500
Date: Tue, 5 Feb 2019 16:17:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190205161725.GJ20321@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-10-philmd@redhat.com>
	<87imxy43pn.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87imxy43pn.fsf@zen.linaroharston>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/18] tests/vm/openbsd: Install Bash
 from the ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>, Brad Smith <brad@comstyle.com>

On Tue, Feb 05, 2019 at 04:09:24PM +0000, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
> > Various iotests scripts (run via 'make check-block')  use bash
> > specific extentions.  OpenBSD comes with the Korn shell as default.
> > Install bash to be able to run those tests.
>=20
> Hmmm given we use plain POSIX shell for configure portability is there =
a
> reason the check-block test scripts use bash? I guess it doesn't get
> picked up as check-block isn't run normally.

configure requests any POSIX shell (#!/bin/sh) & aim for portability.

The block iotests though made an explicit choice not to care for POSIX
shell portability and so explicitly request bash (#!/bin/bash).

The block iotests are not something we expect every user of QEMU
to run, so it is valid to have a more specific requirement for
executing them, than is required by configure for general purpose
build + unit tests.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
