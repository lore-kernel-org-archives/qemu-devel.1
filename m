Received: from eggs.gnu.org ([2001:4830:134:3::10]:47685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnhUT-00080W-AN
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 04:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnhUP-0002KM-Di
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 04:39:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dnhUP-0002K8-7l
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 04:39:45 -0400
Date: Fri, 1 Sep 2017 16:39:38 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170901083938.GD4330@lemon.lan>
References: <20170831064302.14427-1-famz@redhat.com>
	<20170831064302.14427-5-famz@redhat.com>
	<e5d02327-dcfe-5af9-c036-bd238d1440e6@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e5d02327-dcfe-5af9-c036-bd238d1440e6@amsat.org>
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Thu, 08/31 12:59, Philippe Mathieu-Daud=E9 wrote:
> Hi Fam,
>=20
> On 08/31/2017 03:42 AM, Fam Zheng wrote:
> > This is the common code to implement a "VM test" to
> >=20
> >    1) Download and initialize a pre-defined VM that has necessary
> >    dependencies to build QEMU and SSH access.
>=20
> Looking at this project:
>=20
> https://www.packer.io/docs/builders/qemu.html
>=20
> Maybe we can have another CI that prepare/upload those images (reproduc=
ible,
> easy upgrade version...), and document the build process in the JSON in=
stead
> of the wiki (so the doc is up to date).

Thanks for the pointer, looks interesting. The json files can be committe=
d to
QEMU if we go that way. Though I'm not very convinced by the "screen capt=
ure"
style automation that is used by the *BSD user recipes I've found with go=
ogle.
It would be good if *BSD can have cloud-init or kickstart -alike automati=
on,
with those we don't even need Packer.

Fam
