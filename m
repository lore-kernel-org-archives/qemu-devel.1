Received: from eggs.gnu.org ([2001:4830:134:3::10]:55405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fT3Wz-0005nZ-HC
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 07:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fT3Wt-0007X1-Md
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 07:01:37 -0400
References: <1528374154-14680-1-git-send-email-thuth@redhat.com>
	<6e3c0582-86e0-383b-d6d3-7ba127198fd6@linux.vnet.ibm.com>
	<66156118-02da-7bf4-3a7d-6261dee27180@redhat.com>
	<2d029b4f-c14c-cdd3-37ca-2e93e6690e2e@linux.vnet.ibm.com>
	<1a67bc9e-b36c-3c88-701f-f47bf5e819f6@redhat.com>
	<fa6e041f-93a5-905b-dd62-ec525a90b18a@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2742a03e-76b3-c7d8-d1bb-514df1dc0bab@redhat.com>
Date: Wed, 13 Jun 2018 13:01:21 +0200
MIME-Version: 1.0
In-Reply-To: <fa6e041f-93a5-905b-dd62-ec525a90b18a@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="uGfC1y41dZZJVLfNRnmu6iyTfdFmieChB"
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 0/4] pc-bios/s390-ccw:
 Allow network booting via pxelinux.cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uGfC1y41dZZJVLfNRnmu6iyTfdFmieChB
From: Thomas Huth <thuth@redhat.com>
To: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck
 <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2742a03e-76b3-c7d8-d1bb-514df1dc0bab@redhat.com>
Subject: Re: [qemu-s390x] [PATCH v2 0/4] pc-bios/s390-ccw: Allow network
 booting via pxelinux.cfg
References: <1528374154-14680-1-git-send-email-thuth@redhat.com>
 <6e3c0582-86e0-383b-d6d3-7ba127198fd6@linux.vnet.ibm.com>
 <66156118-02da-7bf4-3a7d-6261dee27180@redhat.com>
 <2d029b4f-c14c-cdd3-37ca-2e93e6690e2e@linux.vnet.ibm.com>
 <1a67bc9e-b36c-3c88-701f-f47bf5e819f6@redhat.com>
 <fa6e041f-93a5-905b-dd62-ec525a90b18a@linux.vnet.ibm.com>
In-Reply-To: <fa6e041f-93a5-905b-dd62-ec525a90b18a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.06.2018 12:56, Viktor VM Mihajlovski wrote:
> On 12.06.2018 08:17, Thomas Huth wrote:
>> On 11.06.2018 14:03, Viktor VM Mihajlovski wrote:
> [...]
>>
>> If you have the time to look at the traffic, could you please also che=
ck
>> the TFTP block size option that is negotiated at the beginning of the
>> TFTP transfer? If this other client is negotiating a transfer block si=
ze
>> that is bigger than the one from the s390-ccw firmware, this could
>> explain the differences in the downloading time, too.
>>
>> libnet from SLOF currently uses a block size of 1428. This is the size=

>> where all TFTP data should still fit nicely into one ethernet packet -=

>> and this is also the size which is still supported by all TFTP servers=

>> that support the blksize option. But theoretically it's also possible =
to
>> use a bigger block sizes if both, the server and the client support
>> fragmented UDP packets. Unfortunately, as far as I can see, SLOF's
>> libnet does not support fragmented UDP packets, so we can't increase t=
he
>> block size here anymore so easily.
>
> You will be pleased to hear that the SLOF TFTP client outperforms the
> busybox version (which uses 544-byte packets) by 30%. There's some
> randomness introduced by the differences in DHCP response times which i=
s
> clearly not the client's fault. All is good...

Ah, great, thanks for checking!

So I'm going to prepare a pull request for this next...

 Thomas


--uGfC1y41dZZJVLfNRnmu6iyTfdFmieChB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJbIPmGAAoJEC7Z13T+cC21vaAQAJRP7LujV5DI5Y9adRaeRmAv
bk/45iNPolaMFCSbYzcr5mQSmyzS6xQpWQK5YXGdHj/0DZl7L7FRdsXuaIGpnVwz
kTHBLGTG38EoUR5zacggj8xWSigp4IF0OXb7nInXMMP5NYDmkZes8VMKV/6iKTj3
qxKmeNrGcNRW8/6b26uClBsG91mjdmcJpdY4mWxNNgWg8u/66Mvpr4YeOa37af43
WU8hnv7zuumtxPBZxzZ+L0QjgTuO78tWzC4+AKzDRgTa5gz10FlKutfV9oWzx6lE
krnYed8oiaW8ReSKb+9dmtzn13GCG3DWQKtS6oi9Q3eNV/dbuSSPu+5Yj8HY1qk9
XHK9mhw45ga372A/ZNbbwUKhQYXJ4HHKvTk9Q3u8T3fbnnpSikoZ59bwVNqBBZB5
kUeiwcQDKkTzWkBIxZ1y3LfCNYIraf0bqJQnlkXP1EyGI7T8oY8bUzqBoe09f3Os
Imhm1/H2LpCWTkSOcWvqNi5uPbQ2GoyE/TX0nLB8SXi7MywmY9+cTq0KttomTJm+
JxFKsCx7aCnMCc0cRtmx77Xef+03qi2tWM83r8Cju8O5Cl6KEEjfJGMjIeeFuyiL
Cf5XgTdafs9iDSl1DUs0fFBfX28gBpUjU2uyLJX7Jj95OvaOG3K5WZSDAkVpyY5A
5ZHCO5U78kXPMxTBIgUT
=uTgX
-----END PGP SIGNATURE-----

--uGfC1y41dZZJVLfNRnmu6iyTfdFmieChB--
