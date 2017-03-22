Received: from eggs.gnu.org ([2001:4830:134:3::10]:57838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cqh0i-0007Lj-9V
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cqh0h-0006Pl-67
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:13:12 -0400
References: <20170317104541.28979-1-stefanha@redhat.com>
	<20170317104541.28979-4-stefanha@redhat.com>
	<20170321221526.2lcwi25rkahla2ks@eukaryote>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <82e86f2c-1a9e-16f8-6a66-483dffc6e68f@redhat.com>
Date: Wed, 22 Mar 2017 15:12:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170321221526.2lcwi25rkahla2ks@eukaryote>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="01ihFSgpvmj72hrcSfGokv3BH5Sv35Gjr"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 3/3] qemu-img: print short
 help on getopt failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--01ihFSgpvmj72hrcSfGokv3BH5Sv35Gjr
From: Max Reitz <mreitz@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <82e86f2c-1a9e-16f8-6a66-483dffc6e68f@redhat.com>
Subject: Re: [Qemu-block] [PATCH v2 3/3] qemu-img: print short help on getopt
 failure
References: <20170317104541.28979-1-stefanha@redhat.com>
 <20170317104541.28979-4-stefanha@redhat.com>
 <20170321221526.2lcwi25rkahla2ks@eukaryote>
In-Reply-To: <20170321221526.2lcwi25rkahla2ks@eukaryote>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 21.03.2017 23:15, Kashyap Chamarthy wrote:
> On Fri, Mar 17, 2017 at 06:45:41PM +0800, Stefan Hajnoczi wrote:
>> Printing the full help output obscures the error message for an invali=
d
>> command-line option or missing argument.
>>
>> Before this patch:
>>
>>   $ ./qemu-img --foo
>>   ...pages of output...
>=20
> That gives me:
>=20
>     $ qemu-img --foo
>     qemu-img: unrecognized option '--foo'

Yes, before this series. But not before this patch (i.e. after the first
two patches of this series).

Max

>=20
> I think you meant any one of the `qemu-img create|convert|... --foo`:
>=20
>     $ qemu-img create --foo
>     [...]
>=20
> Which _does_ give "pages of output".
>=20
> Just noting if you want to tweak the commit message.
>=20
>> After this patch:
>>
>>   $ ./qemu-img --foo
>>   qemu-img: unrecognized option '--foo'
>>   Try 'qemu-img --help' for more information
>>
>=20
> [...]
>=20



--01ihFSgpvmj72hrcSfGokv3BH5Sv35Gjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljShmsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9At5AH/jXvdcC7bkpmwLovCXD3J5uLqaZt8mZ7
bgJYzVoBvYJ+oCfv3O57QqCf5H6xkwENqEeBy2n6CGXRzuNf6mTIZJ8bXw1MA66v
tDWqaf+6qAIrdKxI7/0eP3wmCVpt3YtiwzxkA8MKAkXoBkbf8KKyDJUq01T2pxCN
aITy/aue98vKsRCyC1RnlMIM2TWRwPnsWFe9HCR2wIpq9m17Aaz9an4SH7rXCR6R
WduE1eZiKOny1KD91YGuezYFlqd53So3BbGRZe6I/6x7FElzu0si1czljIoCmkOz
oh62oJ/GpDE6HOAy4+tkPxw3i62Yc0WuRL+WY+345zuR1QDTBzLuyTA=
=Y5Tc
-----END PGP SIGNATURE-----

--01ihFSgpvmj72hrcSfGokv3BH5Sv35Gjr--
