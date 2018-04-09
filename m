Received: from eggs.gnu.org ([2001:4830:134:3::10]:44509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f5T6J-0006ey-MZ
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f5T6F-0000oA-Kp
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:28:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55456 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f5T6F-0000nf-Dc
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:28:31 -0400
References: <20180327164141.19075-1-famz@redhat.com>
	<b00ba0ab-538f-a6f1-3b99-1a0d9adb6eab@redhat.com>
	<20180409110844.0a5188af@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d16e553-d0ae-81ac-26f9-95fd1619f8a2@redhat.com>
Date: Mon, 9 Apr 2018 11:28:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180409110844.0a5188af@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aMUKiT8CMU6M15HRT7Xm4jwvSkryvkPYY"
Subject: Re: [Qemu-devel] [PATCH v2] scsi-disk: Don't enlarge min_io_size to
 max_io_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <dgibson@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, danielhb@linux.vnet.ibm.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aMUKiT8CMU6M15HRT7Xm4jwvSkryvkPYY
From: Paolo Bonzini <pbonzini@redhat.com>
To: David Gibson <dgibson@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org,
 danielhb@linux.vnet.ibm.com, eblake@redhat.com
Message-ID: <8d16e553-d0ae-81ac-26f9-95fd1619f8a2@redhat.com>
Subject: Re: [PATCH v2] scsi-disk: Don't enlarge min_io_size to max_io_size
References: <20180327164141.19075-1-famz@redhat.com>
 <b00ba0ab-538f-a6f1-3b99-1a0d9adb6eab@redhat.com>
 <20180409110844.0a5188af@umbus.fritz.box>
In-Reply-To: <20180409110844.0a5188af@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/04/2018 03:08, David Gibson wrote:
> On Thu, 5 Apr 2018 17:54:00 +0200 Paolo Bonzini <pbonzini@redhat.com> w=
rote:
>> On 27/03/2018 18:41, Fam Zheng wrote:
>>> Some backends report big max_io_sectors. Making min_io_size the same
>>> value in this case will make it impossible for guest to align memory,=

>>> therefore the disk may not be usable at all.
>>>
>>> Do not enlarge them when they are zero.
>>
>> Queued, thanks.
>>
>> Paolo
>=20
> Any ETA on going from queued to actually merged?  This is holding up a
> handful of Power bugfixes for 2.12, because I can't complete my usual
> testing cycle.

Hi David,

it's already included in my pull request from Friday.

Paolo


--aMUKiT8CMU6M15HRT7Xm4jwvSkryvkPYY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlrLMjAACgkQv/vSX3jH
roOj5gf+MvOIjorT4aU2WAtOsTNKoXnksOEfze3rwK2L0Qa7BsU0SLt6a9kklILc
WYU56E0wjWXSi/TLq14ij/crvN1LE2uQwjN+vvSsNHsx3v8/f4cbi2KVwyYasNoK
YBh9v9juMxUYbLuR1JcB9ZEnpG6rutDen9niRE7XirL2768aJJnz4rKIxch760sG
9nRMODjqCxhnz1qTC6BQeAdYY9zUr6+M+bmHg1tdt3WS2Vq1goUCMgw2QpmEvU2e
S266mdgtrvyiAJ06KdhXTIXOlTo0RAAdt72m6IKplUIoFPDZdu4iz4sjKBbju6MY
k4o1ThzUu7eKOv5aL+sdycHXgU6gnw==
=b3ZL
-----END PGP SIGNATURE-----

--aMUKiT8CMU6M15HRT7Xm4jwvSkryvkPYY--
