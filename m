Received: from eggs.gnu.org ([2001:4830:134:3::10]:36354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvOvD-0006n4-Vl
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvOvD-0004BF-4e
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:55:00 -0400
References: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
	<0e1c78f3-1b82-58e4-035e-944484e66f29@redhat.com>
	<ef9e10c4-3986-32ba-da2d-1b8f71d58319@redhat.com>
	<20170404132815.aactqo2o5izpzclf@eukaryote>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8420253d-261f-f040-6815-c949b8a2cce2@redhat.com>
Date: Tue, 4 Apr 2017 08:54:50 -0500
MIME-Version: 1.0
In-Reply-To: <20170404132815.aactqo2o5izpzclf@eukaryote>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jev4QUCEQt3lDOS2lWa5D3wR1UFowGnPA"
Subject: Re: [Qemu-devel] [Qemu-block] Making QMP 'block-job-cancel'
 transactionable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jev4QUCEQt3lDOS2lWa5D3wR1UFowGnPA
From: Eric Blake <eblake@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <8420253d-261f-f040-6815-c949b8a2cce2@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] Making QMP 'block-job-cancel'
 transactionable
References: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
 <0e1c78f3-1b82-58e4-035e-944484e66f29@redhat.com>
 <ef9e10c4-3986-32ba-da2d-1b8f71d58319@redhat.com>
 <20170404132815.aactqo2o5izpzclf@eukaryote>
In-Reply-To: <20170404132815.aactqo2o5izpzclf@eukaryote>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/04/2017 08:28 AM, Kashyap Chamarthy wrote:

>> Minor or not, it is a useful viewpoint. Either way, as long as the new=

>> way of getting a transactional non-pivot successful completion is
>> something that libvirt can learn via introspection,=20
>=20
> Can you elaborate a little more on the above, for my own edification --=

> how might it be possible for "libvirt can learn via introspection"?  Is=

> it via some method using the QMP 'query-commands' /
> 'query-command-line-options'?

Those, and query-qmp-schema.  If the change includes the addition of
something new in the .json files describing QMP, then query-qmp-schema
will let libvirt probe whether the version of qemu it it talking to has
that new field or not (presumably, in this case it would be a new
optional bool member to select the mode when creating a job, as well as
a new command visible through query-commands to change the mode of a
running job).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--jev4QUCEQt3lDOS2lWa5D3wR1UFowGnPA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY46WqAAoJEKeha0olJ0Nq7JAH/izBwy/P8f2i/UGZs2r6zpTF
4kyAcmyrfKIQDl75Z3TfoXEIA4+8agwndXhDZ1vl8K/Z8x40MQSgyMO1U+NQzIsc
2fVPIRe+sfBgiKm6Doq1N76r37O+/0uwKw7SenXFe4ARyYu4TfLfDDIdj38jpmDN
9Ich+XQy5Dz2d44Q9IvRK+gUWi1OAnl+1H46nQUegGyrzTwuCe13zU3xG3T8Fj9m
ZXhZPjq/rHhEG5nuZ/zfwU46OhlgvXZSYsRM61w6tyLm2QLpqtwWOjS/+S0WNoWD
YDbqH/OsKDVaQJIUaS2qASftaPBUKvJjEOoxV66rC/VKkauiBZmPgcEk8EI+iio=
=imaW
-----END PGP SIGNATURE-----

--jev4QUCEQt3lDOS2lWa5D3wR1UFowGnPA--
