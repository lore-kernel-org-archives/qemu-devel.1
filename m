Received: from eggs.gnu.org ([2001:4830:134:3::10]:42348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffo18-0001Je-BG
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffo13-0005Ea-Mz
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:05:26 -0400
Date: Wed, 18 Jul 2018 12:05:10 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180718150510.GA31657@localhost.localdomain>
References: <20180717234015.22700-1-f4bug@amsat.org>
	<20180718145312.GZ31657@localhost.localdomain>
	<8fbaf02a-752c-2fec-5bbd-9b31839ce19a@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8fbaf02a-752c-2fec-5bbd-9b31839ce19a@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1] qemu-iotests: Adapt to moved
 location of StringIO module in py3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>

On Wed, Jul 18, 2018 at 12:02:39PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Eduardo,
>=20
> On 07/18/2018 11:53 AM, Eduardo Habkost wrote:
> > On Tue, Jul 17, 2018 at 08:40:15PM -0300, Philippe Mathieu-Daud=E9 wr=
ote:
> > [...]
> >> -    import StringIO
> >> +    try:
> >> +        from StringIO import StringIO
> >> +    except ImportError:
> >> +        from io import StringIO
> >=20
> > Why do we need this?  Python 2.7 has io.StringIO.
>=20
> Python 2 works fine, the problem is the Fedora Docker image uses Python
> 3 and the block tests started to fail...

My question is: why use StringIO.StringIO on Python 2 and
io.StringIO on Python 3, if io.StringIO works on both Python
versions?

--=20
Eduardo
