Received: from eggs.gnu.org ([2001:4830:134:3::10]:33032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRIoF-0008Fd-4H
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRIoA-00066Y-92
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:56:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fRIoA-00065h-2z
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:56:06 -0400
Date: Fri, 8 Jun 2018 11:55:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180608145559.GI7451@localhost.localdomain>
References: <20180608143026.20167-1-ehabkost@redhat.com>
	<20180608143747.GR18233@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180608143747.GR18233@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Require Python 2.7 or newer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>

On Fri, Jun 08, 2018 at 03:37:47PM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, Jun 08, 2018 at 11:30:26AM -0300, Eduardo Habkost wrote:
> > All of the supported build platforms documented in qemu-doc.texi
> > should already support Python 2.7.
> >=20
> > Removing support for Python 2.6 will allow us to remove some
> > compatibility modules we carry in the QEMU tree:
> >=20
> > * scripts/argparse.py
> > * scripts/ordereddict.py
>=20
> Lets delete those in this patch then....

I will do it, but I prefer to do this in a separate patch.

--=20
Eduardo
