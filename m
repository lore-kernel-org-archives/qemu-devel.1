Received: from eggs.gnu.org ([2001:4830:134:3::10]:46928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehchX-00083Y-3X
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehchV-0007hF-Nn
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:52:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ehchV-0007gh-IP
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:52:25 -0500
Date: Fri, 2 Feb 2018 12:52:19 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180202145219.GJ26425@localhost.localdomain>
References: <20180116134217.8725-1-berrange@redhat.com>
	<20180116134217.8725-12-berrange@redhat.com>
	<20180201204646.GK21702@localhost.localdomain>
	<20180202131314.GF15403@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180202131314.GF15403@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 11/14] input: add missing JIS keys to
 virtio input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Miika S <miika9764@gmail.com>, Fam Zheng <famz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Fri, Feb 02, 2018 at 01:13:14PM +0000, Daniel P. Berrang=E9 wrote:
> On Thu, Feb 01, 2018 at 06:46:46PM -0200, Eduardo Habkost wrote:
> > On Tue, Jan 16, 2018 at 01:42:14PM +0000, Daniel P. Berrange wrote:
> > > From: Miika S <miika9764@gmail.com>
> > >=20
> > > keycodemapdb updated to add the QKeyCodes muhenkan and katakanahira=
gana
> > >=20
> > > Signed-off-by: Miika S <miika9764@gmail.com>
> >=20
> > Oops, this conflicts with:
> >=20
> > commit ae6b06ab655b21c19b234ce3422f694d11a013e0
> > Author: Daniel P. Berrange <berrange@redhat.com>
> > Date:   Wed Jan 17 16:41:18 2018 +0000
> >=20
> >     hw: convert virtio-input-hid device to keycodemapdb
> >    =20
> >     [...]
> >=20
> > Patch 11/14 and 12/14 need to be redone.  I'm removing patches
> > 11-14 from python-next until this is sorted out.
>=20
> You can literally just drop the patch chunk which touches
> the hw/input/virtio-input-hid.c file entirely, as that table
> is now auto-generated.  I can resend the series with that if
> you prefer though ?

I will do that when applying the patch.  Thanks!

--=20
Eduardo
