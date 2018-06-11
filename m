Received: from eggs.gnu.org ([2001:4830:134:3::10]:37535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSR8G-0007vS-Oc
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 14:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSR8D-0001NB-Gm
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 14:01:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSR8D-0001Mi-Ap
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 14:01:29 -0400
Date: Mon, 11 Jun 2018 15:01:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180611180125.GQ7451@localhost.localdomain>
References: <20180608173558.8122-1-ehabkost@redhat.com>
	<20180608173558.8122-2-ehabkost@redhat.com>
	<20180611092721.GF11636@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180611092721.GF11636@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] python: Remove scripts/argparse.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Mon, Jun 11, 2018 at 10:27:21AM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, Jun 08, 2018 at 02:35:57PM -0300, Eduardo Habkost wrote:
> > Python 2.7 (the minimum Python version we require) already
> > provides the argparse module on the standard library.
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  scripts/argparse.py | 2406 -----------------------------------------=
--
> >  1 file changed, 2406 deletions(-)
> >  delete mode 100644 scripts/argparse.py
>=20
> When this was added in 47e1cb1f0a130baa438d895eff5d05004c9a9aa2, it
> also added a COPYING.PYTHON file so that needs removing  in this
> commit too - eg a straight revert of that commit.

Thanks for noting that.  This is already in a pull request, so
I'm sending a separate patch.

>=20
> Second, various source files were then modified to add 'scripts' to
> their import path with a line like this:
>=20
>  sys.path.append(os.path.join(os.path.dirname(__file__),
>                              '..', '..', 'scripts'))
>=20
> so those all need removing too, but I'd suggest that is done
> as a separate patch.

I have the impression that most scripts do this trick to be able
to use other modules like 'qemu' and 'qmp' too.  In either case,
we need to review the code to find out.  I will take a look.

--=20
Eduardo
