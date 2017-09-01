Received: from eggs.gnu.org ([2001:4830:134:3::10]:58752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dni8i-0003FS-W6
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dni8f-0000UR-8o
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:21:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dni8f-0000UB-2U
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:21:21 -0400
Date: Fri, 1 Sep 2017 10:21:11 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170901092111.GC31680@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170831064302.14427-1-famz@redhat.com>
	<20170831064302.14427-5-famz@redhat.com>
	<e5d02327-dcfe-5af9-c036-bd238d1440e6@amsat.org>
	<20170901083938.GD4330@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170901083938.GD4330@lemon.lan>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 04/12] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Fri, Sep 01, 2017 at 04:39:38PM +0800, Fam Zheng wrote:
> On Thu, 08/31 12:59, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Fam,
> >=20
> > On 08/31/2017 03:42 AM, Fam Zheng wrote:
> > > This is the common code to implement a "VM test" to
> > >=20
> > >    1) Download and initialize a pre-defined VM that has necessary
> > >    dependencies to build QEMU and SSH access.
> >=20
> > Looking at this project:
> >=20
> > https://www.packer.io/docs/builders/qemu.html
> >=20
> > Maybe we can have another CI that prepare/upload those images (reprod=
ucible,
> > easy upgrade version...), and document the build process in the JSON =
instead
> > of the wiki (so the doc is up to date).
>=20
> Thanks for the pointer, looks interesting. The json files can be commit=
ted to
> QEMU if we go that way. Though I'm not very convinced by the "screen ca=
pture"
> style automation that is used by the *BSD user recipes I've found with =
google.
> It would be good if *BSD can have cloud-init or kickstart -alike automa=
tion,
> with those we don't even need Packer.

FreeBSD at least supports automation of its installer. eg=20

  https://github.com/clalancette/oz/blob/master/oz/FreeBSD.py

Haven't found info on other *BSDs though.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
