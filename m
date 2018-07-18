Received: from eggs.gnu.org ([2001:4830:134:3::10]:58849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffotE-0001bO-1z
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 12:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffotD-00024H-47
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 12:01:20 -0400
Date: Wed, 18 Jul 2018 13:01:10 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180718160110.GB31657@localhost.localdomain>
References: <20180717234015.22700-1-f4bug@amsat.org>
	<20180718145312.GZ31657@localhost.localdomain>
	<8fbaf02a-752c-2fec-5bbd-9b31839ce19a@amsat.org>
	<20180718150510.GA31657@localhost.localdomain>
	<82b3df6e-6e83-ab3a-ea64-04692fc5f40b@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <82b3df6e-6e83-ab3a-ea64-04692fc5f40b@amsat.org>
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

On Wed, Jul 18, 2018 at 12:22:19PM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 07/18/2018 12:05 PM, Eduardo Habkost wrote:
> > On Wed, Jul 18, 2018 at 12:02:39PM -0300, Philippe Mathieu-Daud=E9 wr=
ote:
> >> Hi Eduardo,
> >>
> >> On 07/18/2018 11:53 AM, Eduardo Habkost wrote:
> >>> On Tue, Jul 17, 2018 at 08:40:15PM -0300, Philippe Mathieu-Daud=E9 =
wrote:
> >>> [...]
> >>>> -    import StringIO
> >>>> +    try:
> >>>> +        from StringIO import StringIO
> >>>> +    except ImportError:
> >>>> +        from io import StringIO
> >>>
> >>> Why do we need this?  Python 2.7 has io.StringIO.
> >>
> >> Python 2 works fine, the problem is the Fedora Docker image uses Pyt=
hon
> >> 3 and the block tests started to fail...
> >=20
> > My question is: why use StringIO.StringIO on Python 2 and
> > io.StringIO on Python 3, if io.StringIO works on both Python
> > versions?
>=20
> Oh I missed your question because I was not aware of this, and looked
> how this was handled in the tree (7a5d936b6fc and 5f90af8e6b).
>=20
> TIL we can use "from io import StringIO" regardless the version, the
> 2->3 conversion looks a bit less absurd, thanks!

Note that it's not always an obvious conversion: on Python 3 you
need to decide if you want a text file or binary file.
io.StringIO is a text file, io.BinaryIO is a binary file.  See
https://www.mail-archive.com/qemu-devel@nongnu.org/msg545627.html
for an example where io.StringIO wasn't appropriate.

In the case of iotests.py it looks like the code expects a text
file, though.

--=20
Eduardo
