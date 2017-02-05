Received: from eggs.gnu.org ([2001:4830:134:3::10]:48559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1caThY-0002K5-AK
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 15:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1caThX-0008B4-H5
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 15:46:24 -0500
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170203172520.GA13825@redhat.com> <87vasq708e.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b8b4c780-6f9d-8b4b-4bb9-f3f3264ddefd@redhat.com>
Date: Sun, 5 Feb 2017 21:46:12 +0100
MIME-Version: 1.0
In-Reply-To: <87vasq708e.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PcFRH43FuK00eXeOo2XTjRE06oKunjcir"
Subject: Re: [Qemu-devel] [Qemu-block] Non-flat command line option argument
 syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PcFRH43FuK00eXeOo2XTjRE06oKunjcir
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <b8b4c780-6f9d-8b4b-4bb9-f3f3264ddefd@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] Non-flat command line option argument
 syntax
References: <87bmukmlau.fsf@dusky.pond.sub.org>
 <20170203172520.GA13825@redhat.com> <87vasq708e.fsf@dusky.pond.sub.org>
In-Reply-To: <87vasq708e.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 04.02.2017 10:51, Markus Armbruster wrote:
> "Richard W.M. Jones" <rjones@redhat.com> writes:
>=20
>> On Thu, Feb 02, 2017 at 08:42:33PM +0100, Markus Armbruster wrote:
>>> There's also the -drive file=3Djson:... syntax.  It's a bad fit for
>>> QemuOpts, because QemuOpts and JSON fight for the comma.  I'd show yo=
u
>>> if I could get it to work.
>>
>> I think this refers to the json: syntax for qemu URIs?
>=20
> The json: pseudo-protocol, i.e. "file names" starting with a "json:"
> protocol prefix.  I think we mean the same.
>=20
>> Anyway we're using this in virt-v2v
>> (https://github.com/libguestfs/libguestfs/blob/master/v2v/input_libvir=
t_xen_ssh.ml)
>>
>> It's very useful, please try not to break it!
>=20
> We're not going to take the json: pseudo-protocol away.  Perhaps we'll
> deprecate it at some point, but even then it'll stay for a sufficiently=

> generous grace period.

It should be noted that there are no current plans to deprecate it. It
won't be superseded by command line changes, considering that it was
originally not introduced to make configuration on the command line more
beautiful but to allow e.g. backing file strings to contain more than
just a filename.

Max


--PcFRH43FuK00eXeOo2XTjRE06oKunjcir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliXjxQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AIE8H/AxMlWkCNicsS8TM2o9HFGIHOdl7dmwN
wpat1hL2rwiTPxUrRjWDP9sa0+A7k3/eSIVL7TtwZZ+3+ju4/Or5g0UbLnKboNAF
xUXchYcWZT/2rb+/hZsMGCA3XLCKc/ngvFfkQ05pWgl4UdydxNcthjzgH4JcSWes
X96oJlFN3DP/8dGkd4NZQ07HO0A7PSqTxJnm77E/S/ul9+6VCpY0X/XH0+39VyGD
nqht2M9oSzRl7GmERm/1s6o+1Q3PhkBF2xjr31KNdrQ9CxGo9DKS54Ss+NwAOqqy
tna0WmIlB8Ml9eGg/SJ/PvSty68byR6I3R9iMzT7LinzT3PwXrVMXaI=
=EgpK
-----END PGP SIGNATURE-----

--PcFRH43FuK00eXeOo2XTjRE06oKunjcir--
