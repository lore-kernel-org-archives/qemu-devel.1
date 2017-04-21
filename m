Received: from eggs.gnu.org ([2001:4830:134:3::10]:51423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1XWK-0003CR-Fa
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1XWH-0005hq-A3
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:18:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d1XWH-0005hl-0q
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:18:37 -0400
References: <1492684955-27154-1-git-send-email-lu.zhipeng@zte.com.cn>
	<bd4021f8-1f41-e904-1f1e-e965bec2584d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <915b6275-b67f-07d2-718f-0c92fd619094@redhat.com>
Date: Fri, 21 Apr 2017 07:18:34 -0500
MIME-Version: 1.0
In-Reply-To: <bd4021f8-1f41-e904-1f1e-e965bec2584d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6AslldBxrjUK3BbePksIxXe6ibBG94uGP"
Subject: Re: [Qemu-devel] [PATCH v2] qga: Add support network interface
 statistics in guest-network-get-interfaces command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>, mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6AslldBxrjUK3BbePksIxXe6ibBG94uGP
From: Eric Blake <eblake@redhat.com>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>, mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org
Message-ID: <915b6275-b67f-07d2-718f-0c92fd619094@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qga: Add support network interface
 statistics in guest-network-get-interfaces command
References: <1492684955-27154-1-git-send-email-lu.zhipeng@zte.com.cn>
 <bd4021f8-1f41-e904-1f1e-e965bec2584d@redhat.com>
In-Reply-To: <bd4021f8-1f41-e904-1f1e-e965bec2584d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2017 08:14 AM, Eric Blake wrote:

>> @@ -648,7 +673,8 @@
>>  { 'struct': 'GuestNetworkInterface',
>>    'data': {'name': 'str',
>>             '*hardware-address': 'str',
>> -           '*ip-addresses': ['GuestIpAddress'] } }
>> +           '*ip-addresses': ['GuestIpAddress'],
>> +           '*interface-statics': ['GuestNetworkInterfaceStat'] } }
>=20
> s/interface-statics/statistics/ (the 'interface-' prefix is redundant,
> and you typo'd the remaining portion of the name)
>=20
> Missing documentation, including a (since 2.10) tag.

More specifically, I'm expecting a line like:

# @statistics: various statistic counters related to the interface
(since 2.10)

Which makes me think that you want this to be:
'*statistics':'GuestNetworkInterfaceStat'

that is, you want it to be a single struct, not an array of structs.  An
array of GuestIpAddress makes sense (a single guest interface can have
multiple IP addresses), but an array of statistics does not (the
interface only has one counter of how many packets were transmitted).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6AslldBxrjUK3BbePksIxXe6ibBG94uGP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+fiaAAoJEKeha0olJ0NqEokH/1ny7fkqnG9wzT2IwAMUzi/i
LKdcc1yLkPp3zmz+ZdmnxWSYQNekzip5M7jcppGPa4dWJ3pxiDiFCIaCTK2ooWlK
Ip9y1BYAFFuzg3KcJdFvrBbtni56r90634IlmbF9/tiCxCWmJ5SbEp2NqER2fKpH
Y5ADJ4uyYKctmuGtoxWr78GBqcX5Rlfhs9KzhGUfeoygEXxIBWVQxx1SJTZYdqbi
TQfIc5A8DD/k8yuG4cknYwSaCyskFbtqt1+rpWM1lDn7Yige6UFkU4SsXyEy/Mz0
Fg4PFKhc95CToclST4FHp0tTH+9f+SBnRqY67DgnjdZyujFd62zVNnSe+LTPx2M=
=TqWN
-----END PGP SIGNATURE-----

--6AslldBxrjUK3BbePksIxXe6ibBG94uGP--
