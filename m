Received: from eggs.gnu.org ([2001:4830:134:3::10]:42322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fVGKq-0004CC-FM
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fVGKn-0006MM-B9
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:06:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fVGKn-0006MH-4i
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:06:09 -0400
Date: Tue, 19 Jun 2018 10:06:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180619130606.GB25787@localhost.localdomain>
References: <20180618175958.29073-1-armbru@redhat.com>
	<20180618175958.29073-2-armbru@redhat.com>
	<20180618213526.GJ24764@localhost.localdomain>
	<87tvpzz3wn.fsf@dusky.pond.sub.org>
	<20180619105032.GO7451@localhost.localdomain>
	<20180619120510.GS20929@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180619120510.GS20929@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qapi: Open files with
 encoding='utf-8'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, tamiko@43-1.org, qemu-devel@nongnu.org, arfrever.fta@gmail.com

On Tue, Jun 19, 2018 at 01:05:10PM +0100, Daniel P. Berrang=E9 wrote:
[...]
> > > > The python-future package would help us write code for a single
> > > > file/string API instead of two different APIs, but it's not a
> > > > QEMU build dependency (yet?), so this patch is good enough for
> > > > now.
> > >=20
> > > Please do not invest more than absolutely necessary in Python 2 sup=
port.
> > > All such investment will turn into technical debt in less than two
> > > years.  If you must invest, pick a solution that will result in les=
s
> > > technical debt.  We can accept local ugliness for that.
> > >=20
> > > In my personal opinion, dumb ideas like supporting Python 2 this cl=
ose
> > > to its EOL ought to look ugly.
> >=20
> > That's the whole point: python-future allows us to not worry
> > about Python 2 support in the code anymore because it exposes the
> > Python 3 string API (and others) even if we're running Python 2.
> >=20
> > After we stop supporting Python 2, we can simply delete the "from
> > __future__ import .*" and "from builtins import .*" lines.
> >=20
> > Anyway, I will send a RFC series demonstrating that, and then we
> > can discuss if it's worth it.  My main worry is not the extra
> > imports in Python code, but the introduction of a new build
> > dependency only for a few (one?) releases.
>=20
> Using __future__ doesn't add an build dependancy AFAIK. __future__ is
> bundled with core python library rather than being an addon module.

The extra dependency is because of the "builtins" module,
provided by python-future in Python 2.7.

--=20
Eduardo
