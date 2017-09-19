Received: from eggs.gnu.org ([2001:4830:134:3::10]:60307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duIII-0004lO-6v
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duIIA-0000p6-4b
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:10:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duII9-0000oj-Rt
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:10:22 -0400
References: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1505385610-35529-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<23a3b68e-efa5-5daa-363e-f697e3d8ae2f@redhat.com>
	<7d5e2b72-808b-2a71-b285-35c16a273f94@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <906dd6d0-5012-22d2-c0fa-b21eaf7b24bf@redhat.com>
Date: Tue, 19 Sep 2017 08:10:18 -0500
MIME-Version: 1.0
In-Reply-To: <7d5e2b72-808b-2a71-b285-35c16a273f94@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JUHWSErOiGEscIHhe5mGK7r0JctKSCUdG"
Subject: Re: [Qemu-devel] [PATCH v11 2/6] qmp: Use ThrottleLimits structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JUHWSErOiGEscIHhe5mGK7r0JctKSCUdG
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: alberto garcia <berto@igalia.com>,
 jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org
Message-ID: <906dd6d0-5012-22d2-c0fa-b21eaf7b24bf@redhat.com>
Subject: Re: [PATCH v11 2/6] qmp: Use ThrottleLimits structure
References: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1505385610-35529-3-git-send-email-pradeep.jagadeesh@huawei.com>
 <23a3b68e-efa5-5daa-363e-f697e3d8ae2f@redhat.com>
 <7d5e2b72-808b-2a71-b285-35c16a273f94@huawei.com>
In-Reply-To: <7d5e2b72-808b-2a71-b285-35c16a273f94@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 05:06 AM, Pradeep Jagadeesh wrote:
> On 9/18/2017 7:10 PM, Eric Blake wrote:
>> On 09/14/2017 05:40 AM, Pradeep Jagadeesh wrote:
>>> This patch factors out code to use the ThrottleLimits
>>> strurcture.
>>
>> s/strurcture/structure/
>>
>>>
>>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>>> Reviewed-by: Greg Kurz <groug@kaod.org>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> Echoing the sentiments made elsewhere - this is a significant rewrite
>> from the earlier version, so you WANT reviewers to look at it fresh
>> rather than assuming that previous reviews still apply.
>>
> OK, but shall I send them as V12 or V01 again?

v12 is fine - you really are revising the patches a twelfth time.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JUHWSErOiGEscIHhe5mGK7r0JctKSCUdG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBFzoACgkQp6FrSiUn
Q2rmegf9FHrJTgfl+GAFe4HmPf796xI5w0X4cV//M1OtzYleYTI2lS75e/86O24c
54P1BCjMuteUif6/iQGQJkql7snQIJ50U+MWkC/GcoTDMR7RNWH8dJ5xvL4helK6
egli0Jw81TvwnUMv/wSlfRFXOBcSyBVBV5iRi4WOmHHh1HpoBmK01Nkh9kfHCJD3
lOiuAHoEHXyyvPH6anjed04i+ph+XMPVOe046ozlrE6L+6V2iU2Okp9CLCF74ObO
Svru7negJGC8hznpnlEa5WXQNVtZvhMUYcdauSJS4S6TyPStWoSuvl7jX3Dh2s+B
LeZO/9RStaweHDBmP7rwNYNSNHObVg==
=B+Gs
-----END PGP SIGNATURE-----

--JUHWSErOiGEscIHhe5mGK7r0JctKSCUdG--
