Received: from eggs.gnu.org ([2001:4830:134:3::10]:44446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6GcQ-0005WZ-DK
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6GcP-0007XI-AK
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:16:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6GcP-0007X6-16
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:16:29 -0400
References: <20170427215821.19397-1-eblake@redhat.com>
	<20170427215821.19397-11-eblake@redhat.com>
	<149374359665.32299.11589637295145834940@loki>
	<149374416427.32299.10266856249198036332@loki>
	<87a86u48sa.fsf@dusky.pond.sub.org>
	<149384116260.9473.5031989947486335691@loki>
	<87lgqdnl0f.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2af99142-4bb8-1fcd-5114-c53b9e1504ff@redhat.com>
Date: Thu, 4 May 2017 08:16:26 -0500
MIME-Version: 1.0
In-Reply-To: <87lgqdnl0f.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2El42o8Gb9biwTdbcvg2ixaVWtTNhmukS"
Subject: Re: [Qemu-devel] [PATCH v5 10/10] test-qga: Actually test 0xff sync
 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2El42o8Gb9biwTdbcvg2ixaVWtTNhmukS
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org
Message-ID: <2af99142-4bb8-1fcd-5114-c53b9e1504ff@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 10/10] test-qga: Actually test 0xff sync
 bytes
References: <20170427215821.19397-1-eblake@redhat.com>
 <20170427215821.19397-11-eblake@redhat.com>
 <149374359665.32299.11589637295145834940@loki>
 <149374416427.32299.10266856249198036332@loki>
 <87a86u48sa.fsf@dusky.pond.sub.org>
 <149384116260.9473.5031989947486335691@loki>
 <87lgqdnl0f.fsf@dusky.pond.sub.org>
In-Reply-To: <87lgqdnl0f.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/04/2017 02:23 AM, Markus Armbruster wrote:

>>> Feel free to suggest something for me to add to the commit message.
>>
>> Maybe change:
>>
>>   "which matches the documented actions that a real QGA client
>>    is supposed to do."
>>
>> to
>>
>>   "which is compatible with the documented actions that a real
>>    QGA client is supposed to do."
>>
>> and add the following comment to test_qga_sync_delimited
>>
>>   /*=20
>>    * Note that the full reset sequence would involve checking the
>>    * response of guest-sync-delimited and repeating the loop if
>>    * 'id' field of the response does not match the 'id' field of=20
>>    * the request. Testing this fully would require inserting
>>    * garbage in the response stream and is left as a future test
>>    * to implement.
>>    */
>=20
> Eric, want me to squash that in?

Yes, those changes are reasonable.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2El42o8Gb9biwTdbcvg2ixaVWtTNhmukS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCymqAAoJEKeha0olJ0NqtTYH/3Qv1f6EpEjV4P35xqOvrmHo
ucbL7HP49GsPnTfBxmP7AJpLAgo6X+4dmtQFJ25VCU6WvLnTOcMUq7Xw7qZ6u2Tt
jP95JBB3i01pyzuXnZcXOXHV5w0Vk06JcVnoMu1hbZYyc4cpdZyR8aIdgjFzSENp
8DQo+BV8LJlvFLy6zGMtUlY2ydDzMXk96NTUgePVwArTGxtoMIitWVxKB4x1vrNg
S3CSRkP8kR02uu+Cg89o6niT0zl1xVv1BjXB/bkoo+Q/M5y6pKBbgNSfhDOmOH8e
lb/O3IPfOPwPlgFX/mN/nar6elGvAyB8U4rzYELpQ/RG9kYNRV6wwfTokFCPkqA=
=yPl5
-----END PGP SIGNATURE-----

--2El42o8Gb9biwTdbcvg2ixaVWtTNhmukS--
