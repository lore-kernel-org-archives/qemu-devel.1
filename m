Received: from eggs.gnu.org ([2001:4830:134:3::10]:43821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clHHZ-0004zV-5S
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:44:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clHHY-0003Xs-8s
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:44:13 -0500
References: <20170221115512.21918-1-berrange@redhat.com>
	<20170221115512.21918-8-berrange@redhat.com>
	<18af21b2-42ed-e037-ab30-a88302d5e0e8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0003c78-9b17-ba2f-ca55-ef4a64ef1e8d@redhat.com>
Date: Tue, 7 Mar 2017 09:44:02 -0600
MIME-Version: 1.0
In-Reply-To: <18af21b2-42ed-e037-ab30-a88302d5e0e8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XAOfN7Q9I4oUaN5vfV5kgCEaGQCdhL0Ou"
Subject: Re: [Qemu-devel] [PATCH v5 07/18] iotests: fix 097 when run with
 qcow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XAOfN7Q9I4oUaN5vfV5kgCEaGQCdhL0Ou
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <d0003c78-9b17-ba2f-ca55-ef4a64ef1e8d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 07/18] iotests: fix 097 when run with qcow
References: <20170221115512.21918-1-berrange@redhat.com>
 <20170221115512.21918-8-berrange@redhat.com>
 <18af21b2-42ed-e037-ab30-a88302d5e0e8@redhat.com>
In-Reply-To: <18af21b2-42ed-e037-ab30-a88302d5e0e8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/22/2017 05:46 PM, Eric Blake wrote:
> On 02/21/2017 05:55 AM, Daniel P. Berrange wrote:
>> The previous commit:
>>
>>   commit a3e1505daec31ef56f0489f8c8fff1b8e4ca92bd
>>   Author: Eric Blake <eblake@redhat.com>
>>   Date:   Mon Dec 5 09:49:34 2016 -0600
>>
>>     qcow2: Don't strand clusters near 2G intervals during commit
>>
>> extended the 097 test case so that it did two passes, once
>> with an internal snapshot, once without.
>>
>> qcow (v1) does not support internal snapshots, so this change
>> broke test 097 when run against qcow.
>>
>> This splits 097 in two, creating a new 173 that tests the

173 is wrong, and 175 is now taken.

>> internal snapshot codepath, effectively putting 097 back
>> to its content before the above commit.
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>> ---
>>  tests/qemu-iotests/097     |  10 +---
>>  tests/qemu-iotests/097.out | 125 ++----------------------------------=
--------
>>  tests/qemu-iotests/175     | 126 ++++++++++++++++++++++++++++++++++++=
+++++++++
>>  tests/qemu-iotests/175.out | 119 ++++++++++++++++++++++++++++++++++++=
++++++

I'll be incorporating this patch into my series on blkdebug
improvements, as I have a further enhancement (to both 97 and what is
now 176) to cover an image that is not cluster-aligned.  You may want to
rebase the rest of your series (which adds two more tests) on top of
that posting.

> I used 175 in v5 of my blkdebug series, but Kevin had comments that are=

> worth me respinning, so I'm rebasing mine to use 176.
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg03049.html

Particularly since my blkdebug series will now be using 177.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--XAOfN7Q9I4oUaN5vfV5kgCEaGQCdhL0Ou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvtVCAAoJEKeha0olJ0Nqxy8H/3A+EcqbJSx3D6kxLnx0r3d8
J9AuL8klaHscMTqmnirwlvnWIfZzWGxL9tsZu39Ap8NGMGb2p1GoxfISbb3vFh+m
vxa0hexqB+5KehsOiZh2u4536A1Bh+jkg6YBOvh1dK2/oOodGedUiSX6UzyNNOHr
Mvjs3albT2IW4eHiMArrQJoVMdcxyt1TfDXc5MdZVVegHfkdXrIGVzA7f30gffAJ
lgNaOrc+xQlMc0oIAphNgVkjXcDD2C88//O1u0Aay2gQtbZ7TXz2zXjgWy/lFF7Q
OalkRz0BZ2AUMPwtYuWTX4VeoNwSk+6Wt29FyPLTwBnh3dhpq9tbz+NN6ppQvWY=
=JBdm
-----END PGP SIGNATURE-----

--XAOfN7Q9I4oUaN5vfV5kgCEaGQCdhL0Ou--
