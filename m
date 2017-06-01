Received: from eggs.gnu.org ([2001:4830:134:3::10]:35743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGUgI-0003o3-Ls
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 14:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGUgE-0006oA-ML
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 14:18:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGUgE-0006no-Cv
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 14:18:42 -0400
References: <20170601130325.6433-1-marcandre.lureau@redhat.com>
	<20170601130325.6433-2-marcandre.lureau@redhat.com>
	<465a7b69-a3c0-1492-8e30-c562a76cd65a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0a434f41-1131-713d-1fc9-a9edba425f7a@redhat.com>
Date: Thu, 1 Jun 2017 13:18:37 -0500
MIME-Version: 1.0
In-Reply-To: <465a7b69-a3c0-1492-8e30-c562a76cd65a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wHCoQciKwLqpGqGCMhNeO6P2RWsmHlRCf"
Subject: Re: [Qemu-devel] [PATCH v2 1/4] dump: add DumpInfo structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qiaonuohan@cn.fujitsu.com, anderson@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wHCoQciKwLqpGqGCMhNeO6P2RWsmHlRCf
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: qiaonuohan@cn.fujitsu.com, anderson@redhat.com
Message-ID: <0a434f41-1131-713d-1fc9-a9edba425f7a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] dump: add DumpInfo structure
References: <20170601130325.6433-1-marcandre.lureau@redhat.com>
 <20170601130325.6433-2-marcandre.lureau@redhat.com>
 <465a7b69-a3c0-1492-8e30-c562a76cd65a@redhat.com>
In-Reply-To: <465a7b69-a3c0-1492-8e30-c562a76cd65a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 01:06 PM, Laszlo Ersek wrote:
> On 06/01/17 15:03, Marc-Andr=C3=A9 Lureau wrote:
>> One way or another, the guest could communicate various dump info (via=

>> guest agent or vmcoreinfo device) and populate that structure. It can
>> then be used to augment the dump with various details, as done in the
>> following patch.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  include/sysemu/dump-info.h | 18 ++++++++++++++++++
>>  dump.c                     |  3 +++
>>  2 files changed, 21 insertions(+)
>>  create mode 100644 include/sysemu/dump-info.h
>>
>> diff --git a/include/sysemu/dump-info.h b/include/sysemu/dump-info.h
>> new file mode 100644
>> index 0000000000..d2378e15e2
>> --- /dev/null
>> +++ b/include/sysemu/dump-info.h
>> @@ -0,0 +1,18 @@
>> +#ifndef DUMP_INFO_H
>> +#define DUMP_INFO_H

>>
>=20
> Can you please spell out, in the commit message, the reason for
> introducing a new header file? (I suspect your reason, but it should be=

> documented explicitly.)

Also, should you have a copyright header in the new file?  And does
MAINTAINERS cover it?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wHCoQciKwLqpGqGCMhNeO6P2RWsmHlRCf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMFp9AAoJEKeha0olJ0NqzekH/1IXTdJw6Mj2Vz8wdmOLnoS7
P5CxPWzjKNvhfEEJYQv4C0BSqXF8wVocb3cdJj7vLAUPyW77tlOqp/86XIPu4Oc8
L9NI/GtPsyQC0UNFFUlI19xQHuPe+hW6sCFuPu0K6YhsHP99rxPrGyxJQXT6IRes
gxmG2IoIwe0vHFeeFQ+5XLELo+WhPOllbyjJ/BW7S3cflujUF/8A6Y0ZPCRbRRNQ
ceMvit2KNB/g7+VKLtu3VqeU5T31bTFKv2CD2kiueLHvuq1gzd/WzkFQCDfVAapj
ISODkGxJMuGydeRC/SJbdXoTBBNDXrSAAz4TbEhfEPM4uTFkw/ghtMfoNjK1EMM=
=4y5h
-----END PGP SIGNATURE-----

--wHCoQciKwLqpGqGCMhNeO6P2RWsmHlRCf--
