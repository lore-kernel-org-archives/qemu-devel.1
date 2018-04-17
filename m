Received: from eggs.gnu.org ([2001:4830:134:3::10]:54373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f8LfH-0002j4-Km
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f8LfE-0007K7-GT
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:08:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50406 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f8LfE-0007JC-3r
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:08:32 -0400
References: <1523861081-3600-1-git-send-email-thuth@redhat.com>
	<1523861081-3600-2-git-send-email-thuth@redhat.com>
	<20180417072134.GJ10770@stefanha-x1.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <275bfe53-7c94-0ad0-b388-d8a44a7fb76f@redhat.com>
Date: Tue, 17 Apr 2018 10:08:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180417072134.GJ10770@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="CF5cBVDKUnHzbeLA5A6kbklcnjmpkrvAA"
Subject: Re: [Qemu-devel] [PATCH v3 for-2.13 1/3] net: Remove the deprecated
 "vlan" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CF5cBVDKUnHzbeLA5A6kbklcnjmpkrvAA
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
Message-ID: <275bfe53-7c94-0ad0-b388-d8a44a7fb76f@redhat.com>
Subject: Re: [PATCH v3 for-2.13 1/3] net: Remove the deprecated "vlan"
 parameter
References: <1523861081-3600-1-git-send-email-thuth@redhat.com>
 <1523861081-3600-2-git-send-email-thuth@redhat.com>
 <20180417072134.GJ10770@stefanha-x1.localdomain>
In-Reply-To: <20180417072134.GJ10770@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.04.2018 09:21, Stefan Hajnoczi wrote:
> On Mon, Apr 16, 2018 at 08:44:39AM +0200, Thomas Huth wrote:
>> @@ -499,10 +497,11 @@
>>  # @opts: device type specific properties (legacy)
>>  #
>>  # Since: 1.2
>> +#
>> +# 'vlan' - removed with 2.12
>=20
> Not sure how to interpret this.  How about "removed in 2.13"?

Sure, will change it.

>> @@ -2028,10 +2028,9 @@ DEF("nic", HAS_ARG, QEMU_OPTION_nic,
>>      "                provided a 'user' network connection)\n",
>>      QEMU_ARCH_ALL)
>>  DEF("net", HAS_ARG, QEMU_OPTION_net,
>> -    "-net nic[,vlan=3Dn][,netdev=3Dnd][,macaddr=3Dmac][,model=3Dtype]=
[,name=3Dstr][,addr=3Dstr][,vectors=3Dv]\n"
>> +    "-net nic[,macaddr=3Dmac][,model=3Dtype][,name=3Dstr][,addr=3Dstr=
][,vectors=3Dv]\n"
>>      "                configure or create an on-board (or machine defa=
ult) NIC and\n"
>> -    "                connect it either to VLAN 'n' or the netdev 'nd'=
 (for pluggable\n"
>> -    "                NICs please use '-device devtype,netdev=3Dnd' in=
stead)\n"
>> +    "                connect it to hub 0 (please use -nic for direct =
connections)\n"
>=20
> What does "direct connections" means?

I mean a 1:1 connection between the backend and frontend here, without a
hub inbetween. Can you think of a better wording?

 Thomas


--CF5cBVDKUnHzbeLA5A6kbklcnjmpkrvAA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJa1atyAAoJEC7Z13T+cC21TQAP/2nXTZHnSSWKRE4Te2VYPb0U
B4n0zynB7N+BdhQNQrmZZ7djG+Bm6px0UnVydJRYmh+v3v9NlMMwhNYf63xfdZsM
c0ZeUhfBbMTGtb2oPGZ8UnTQcmKWN7DEBHPiRqlIfFgmNqZA8kieiteR7ExelU7Y
isn7KDZjjmXxsAFjs18muAdjITxjZGzpkKBFlAAs4oBfHPcrQtegmULtU3gSuVZc
cn3x+AGdzi5VhGFsToRRDvb5YPtvHJp6uQCDyJle/jwrAr+dfuQ/teQOJqySgrA0
ffcCjaj6J9E0ud9C7aO1wwJaC63s/zVNv0k4S4CpR71kLJFZM8wHNc4Knm3x1TXU
WJRKvlTHJj9o17K0/mEnfwrMBukgEz1s+Uq3O9A+o0FaBscph2Vfn29mWlrn3gcY
uTXZDk0d1dhLO5o4wf+LYiDdSS/bVuIIjJOBXGYVlazPDYJhyAmiBZJnYDG5hKaY
/ortJ7Ar7qXRW3t6E8kXfjMFVLvT5UbRQ6jQxs1Fq8RcOprXY2+krTx7vYiFH7gZ
oksrgJttm0pqmQJubLc0s9KvIxKZJeLlVylshLYuN2aU65iFI+e+1lP4UPPii1Gi
F8OHsGDOGR5UKBvSoo4Ewj5JqueZTvj20qbTEPLGVM8HN8SLcEky46uWwNcWFiq6
WIY0TPo5frO1HNR+Nrb3
=JeLk
-----END PGP SIGNATURE-----

--CF5cBVDKUnHzbeLA5A6kbklcnjmpkrvAA--
