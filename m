Received: from eggs.gnu.org ([2001:4830:134:3::10]:57182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp3B1-0000A6-Af
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp3Aw-000247-GW
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:01:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp3Aw-00022v-BE
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:01:14 -0400
Date: Tue, 5 Sep 2017 10:01:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170905020108.GB22515@lemon.lan>
References: <20170831064302.14427-1-famz@redhat.com>
	<20170831064302.14427-2-famz@redhat.com>
	<d1bcc99e-9b28-747a-29e5-337ea43a12e2@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d1bcc99e-9b28-747a-29e5-337ea43a12e2@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 01/12] gitignore: Ignore vm test images
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

On Fri, 09/01 17:32, Philippe Mathieu-Daud=E9 wrote:
> On 08/31/2017 03:42 AM, Fam Zheng wrote:
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >   .gitignore | 2 ++
> >   1 file changed, 2 insertions(+)
> >=20
> > diff --git a/.gitignore b/.gitignore
> > index cf65316863..643e23e515 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -52,6 +52,8 @@
> >   /vscclient
> >   /vhost-user-scsi
> >   /fsdev/virtfs-proxy-helper
> > +/tests/vm/*.img
>=20
> There is a tests/.gitignore, isn't it cleaner to add vm/*.img there?

Yes, probably.

Fam

>=20
> > +*.tmp
> >   *.[1-9]
> >   *.a
> >   *.aux
> >=20
>=20
