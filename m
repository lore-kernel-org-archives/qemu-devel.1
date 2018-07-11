Received: from eggs.gnu.org ([2001:4830:134:3::10]:36754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fd90J-0006lT-MY
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 02:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fd90I-0001XB-Rb
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 02:53:35 -0400
References: <20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
	<20180709072953.GE7755@andariel.pipo.sk>
	<87k1q3ljgs.fsf@dusky.pond.sub.org>
	<20180710162208.7b1b5cdc.cohuck@redhat.com>
	<20180710143931.GQ1148@andariel.pipo.sk>
	<20180710170122.427ce3a4.cohuck@redhat.com>
	<20180710152406.GS1148@andariel.pipo.sk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <28ef476f-7811-91ef-6c77-515f07235e7a@redhat.com>
Date: Wed, 11 Jul 2018 08:53:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180710152406.GS1148@andariel.pipo.sk>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="W6E9ceVJaFG9T0otegqz2L5jLFx7qNVLZ"
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W6E9ceVJaFG9T0otegqz2L5jLFx7qNVLZ
From: Thomas Huth <thuth@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>,
 Libvirt <libvir-list@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <28ef476f-7811-91ef-6c77-515f07235e7a@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
References: <20180704150256.408d4a07.cohuck@redhat.com>
 <20180704133440.GE4334@localhost.localdomain>
 <CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
 <20180706131103.4e713911.cohuck@redhat.com>
 <20180706145645.GB3939@localhost.localdomain>
 <20180709072953.GE7755@andariel.pipo.sk> <87k1q3ljgs.fsf@dusky.pond.sub.org>
 <20180710162208.7b1b5cdc.cohuck@redhat.com>
 <20180710143931.GQ1148@andariel.pipo.sk>
 <20180710170122.427ce3a4.cohuck@redhat.com>
 <20180710152406.GS1148@andariel.pipo.sk>
In-Reply-To: <20180710152406.GS1148@andariel.pipo.sk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.07.2018 17:24, Peter Krempa wrote:
> On Tue, Jul 10, 2018 at 17:01:22 +0200, Cornelia Huck wrote:
>> On Tue, 10 Jul 2018 16:39:31 +0200
>> Peter Krempa <pkrempa@redhat.com> wrote:
>>> On Tue, Jul 10, 2018 at 16:22:08 +0200, Cornelia Huck wrote:
>>>> On Tue, 10 Jul 2018 07:59:15 +0200
>>>> Markus Armbruster <armbru@redhat.com> wrote:
>=20
> [...]
>=20
>>>> "ERROR: 'old_option' is deprecated and will be removed; use 'modern_=
option' instead"
>>>>
>>>> and do an exit(1).
>>>>
>>>> Would that be workable? =20
>>>
>>> For delivering the warnings via monitor you'll need a store that will=

>>> collect all the warnings and prepare them for delivery. You've got
>>> basically two options:
>>>
>>> 1) monitor command to poll for deprecated options
>>> 2) event with deprecated options
>>>
>>> Both require storing them since libvirt connects to the monitor only
>>> after the command line is processed.
>>>
>>> Warnings printed to stderr are nearly useless because until something=

>>> breaks nobody bothers to read the log files.
>>
>> So, from that I gather that a hard failure would be the easiest for
>> libvirt to detect (and everything else would become complicated really=

>> quickly), right?
>=20
> People start complaining only when stuff breaks. If anything is optiona=
l
> people will usually not enable it. That makes any non-mandatory option
> not work in most cases.

So would it help if we "invert" the logic, i.e. deprecated_report()
would do exit(1) by default? Then, if the (human) users still want to
continue with the deprecated option, they have to add a
"--ignore-deprecation" command line switch to make QEMU start
successfully...

 Thomas


--W6E9ceVJaFG9T0otegqz2L5jLFx7qNVLZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJbRalkAAoJEC7Z13T+cC21MwYP/Ar4Gezw2Zx5P944nKYvZp8m
r6WyLQYO0nePZhqU710kLSfTYKyUKi7DIZ+Ubz1CMjFrqsKJYgeM8402jrzsEbno
25sCDd2Kxb8JR7YsOVpcPvS1+quedFZ145Nu/XdK5ptvs8YMAVjcaynQQkWatuC8
AJc83gGgFiiy72Ygd2BLeC/N0M5Bgk822gX8FsQ8TELikvkWf6apCyBTPpZci+Rw
5Y/uC8Bzb1WeKWfIIGB6dcKAiDWpUXYh1VCCJvm3XLH3nXqBEp9Ypj6oREzoo5wW
gzTalLvF2PkVlT+0Mrca6/8yiFwDNVY1jvi+KXOLQhlX3VsyldCu+mEz0DHHEPD+
DH36RstQgTRM+h5UfRuu5qywEvyoa/GZpS5as4OOoOPCarXqr2kT050wGgiSyGnr
cwzQmVESmaHgIDg4q355hRTN8HpmEWPR5qu8blX2reCj0ORKHl2mI+KLTTVzIiM9
tQ17fF6C+VG4LA9jWQYQ7JI1Iev3WBGnqKXn6TVx4DGX6pmTl9xvrUM2RD3tO/GK
xvt8rYf9GFeNzSot3Xh/EF6cWMuf5WqQv+i5Kyn+dkzSLtrC0b69IPRW9IupUkdX
TCPQ9Q6kuIpOliMqocczH9kR6UGJnZs0RWhvQ3Up/GuQMFAwezBiWqUmM0j1rLcL
xoBfSz8Bjm50LhZHM5Kq
=4VNZ
-----END PGP SIGNATURE-----

--W6E9ceVJaFG9T0otegqz2L5jLFx7qNVLZ--
