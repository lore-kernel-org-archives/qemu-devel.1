Received: from eggs.gnu.org ([2001:4830:134:3::10]:33478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyine-0007HN-RL
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyind-0001u9-IL
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:44:54 -0400
References: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
	<1492104214-29994-3-git-send-email-kwolf@redhat.com>
	<c8d62cd3-73fc-4461-a3f1-c050908e9bec@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fe281bea-1a1f-b259-fcf1-d58e4a90f3a0@redhat.com>
Date: Thu, 13 Apr 2017 12:44:33 -0500
MIME-Version: 1.0
In-Reply-To: <c8d62cd3-73fc-4461-a3f1-c050908e9bec@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JALjtTxxD56Us5Hktsbxmwc4Wtahbjmui"
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-iotests: Filter HMP readline
 escape characters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: lvivier@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JALjtTxxD56Us5Hktsbxmwc4Wtahbjmui
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: lvivier@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, stefanha@redhat.com, mreitz@redhat.com
Message-ID: <fe281bea-1a1f-b259-fcf1-d58e4a90f3a0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-iotests: Filter HMP readline escape
 characters
References: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
 <1492104214-29994-3-git-send-email-kwolf@redhat.com>
 <c8d62cd3-73fc-4461-a3f1-c050908e9bec@redhat.com>
In-Reply-To: <c8d62cd3-73fc-4461-a3f1-c050908e9bec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2017 12:38 PM, Eric Blake wrote:
> On 04/13/2017 12:23 PM, Kevin Wolf wrote:
>> The only thing the escape characters achieve is making the reference
>> output unreadable and lines that are potentially so long that git
>> doesn't want to put them into an email any more. Let's filter them out=
=2E
>=20
> Hear! Hear!
>=20

>> +++ b/tests/qemu-iotests/common.filter
>> @@ -86,6 +86,13 @@ _filter_qmp()
>>          -e '    QMP_VERSION'
>>  }
>> =20
>> +# readline makes HMP command strings so long that git complains
>> +_filter_hmp()
>> +{
>> +    sed -e 's/(qemu).*\o33\[D/(qemu) /g' \
>=20
> \oNN is a GNU sed-ism, as far as I can tell.  Is it portable to our
> BSD/MacOS builds?

And if it's not, qemu-iotests are running under bash, so writing this as:=


sed -e $'s/(qemu).*\e\\[D/(qemu) /g'

>=20
>> +        -e 's/\o33\[K//g'

-e $'s/\e\\[K//g'

is a reliable alternative.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JALjtTxxD56Us5Hktsbxmwc4Wtahbjmui
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY77kBAAoJEKeha0olJ0NqiWcH/R/1xjY3P0cbgjJTINDco81s
U9HpNRn1pXXjR6jj6aonQw9ZOYPw+gJEz3+zRznS2Th0aO52rLGo7dUSCENxmUEd
5prUScufVnZZ+L9h7tmEtRmeBmo8IzS6VyD+RP8DvuDjU/Osq2V9hJOWHH1KpHlT
bdtc+PFei5FCnEs1k1h68kT6LtwknwGJi2M/BQyVjOzpZejLPDZfxKQIVeWsDsCh
i1qJQj9ZtxGkER8M1M7nOGRhDFxv5BZAvbJsJc3Ukkom3YIjWslZ5PMybSHU9K3W
Qf24HJyNio4mWedVVBRaowKpqKL8iLd0DXy6rGbuTOBvCaovJJCOMxLgDnMDgr0=
=BNaQ
-----END PGP SIGNATURE-----

--JALjtTxxD56Us5Hktsbxmwc4Wtahbjmui--
