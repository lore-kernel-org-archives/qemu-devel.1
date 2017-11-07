Received: from eggs.gnu.org ([2001:4830:134:3::10]:43358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eC9f6-00012L-2B
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eC9f2-0005UQ-33
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:35:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eC9f1-0005Tj-Pk
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:35:48 -0500
References: <20170919074314.10350-1-borntraeger@de.ibm.com>
	<a6b1668e-b646-186b-8036-193100f15d54@redhat.com>
	<7c5f5d15-2275-7493-d311-73c21e1e1924@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <16218abe-3484-333e-e3b7-3f35d0b3f57b@redhat.com>
Date: Tue, 7 Nov 2017 13:35:44 -0600
MIME-Version: 1.0
In-Reply-To: <7c5f5d15-2275-7493-d311-73c21e1e1924@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DPEOHsngnSP5bHtnHv6bvgUbJAsAGHuaJ"
Subject: Re: [Qemu-devel] [PATCH v2] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DPEOHsngnSP5bHtnHv6bvgUbJAsAGHuaJ
From: Eric Blake <eblake@redhat.com>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Jing Liu <liujbjl@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
 qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Message-ID: <16218abe-3484-333e-e3b7-3f35d0b3f57b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] s390x/cpu: expose the guest crash
 information
References: <20170919074314.10350-1-borntraeger@de.ibm.com>
 <a6b1668e-b646-186b-8036-193100f15d54@redhat.com>
 <7c5f5d15-2275-7493-d311-73c21e1e1924@linux.vnet.ibm.com>
In-Reply-To: <7c5f5d15-2275-7493-d311-73c21e1e1924@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/07/2017 05:00 AM, QingFeng Hao wrote:

>>> +
>>> +##
>>> +# @GuestPanicInformationS390:
>>> +#
>>> +# S390 specific guest panic information (PSW)
>>> +#
>>> +# Since: 2.11
>>> +##
>>> +{'struct': 'GuestPanicInformationS390',
>>> + 'data': { 'psw-mask': 'uint64',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'psw-ad=
dr': 'uint64',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'reason=
': 'str' } }
>> Missing documentation of the three fields; in particular, whether
> I didn't get your point, do you mean we need to add comments
> for the three fields? But I don't see the comments for Hyper-V either.

Your mailer is eating blank lines, which makes it harder to visually
distinguish where quoting ends and where new content begins (I had a
blank line between your "'reason': 'str' } }" content and my "Missing
documentation..." comment).

I mean something like:

##
# @GuestPanicInformationS390:
#
# S390 specific guest panic information (PSW)
#
# @psw-mask: <description of what this mask represents>
# @psw-addr: Address that was accessed to cause the panic
# @reason: Human-readable explanation of the panic (should not be parsed
#          by a machine)
#
# Since: 2.11
##

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DPEOHsngnSP5bHtnHv6bvgUbJAsAGHuaJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloCCxAACgkQp6FrSiUn
Q2roxAgArJBoQ3JkBhAQHPvhBm3umdgEideizlGF8WitDS/EldYuC9JUuRzIu20z
fJVmH0YkZlGKhEUDasloQOIdxxMxLUdbPN+vW6TAWRh3oev10oRp5pk/8lHGfQbM
yYLCsxI9l4m1pEq1LNtFCr+Kcm5mpAb2dI8ZvMd0H055/u0McEaERftEByugiRw9
YZE11xOuDze+w0PsexiKrJ4nDdyfwk8D/GgzCH8JHAsrSUmnk3MWHBW3D8BvPx3u
gvMmBUSYgQBrPGQ+4JuSyhMy1dBZ+xoPNBE6wBw/asAtcO6/979UOh67HZX67aBL
IszLuHQpvkM8ftF+EVXKu6Fe3XX+Yw==
=7M4l
-----END PGP SIGNATURE-----

--DPEOHsngnSP5bHtnHv6bvgUbJAsAGHuaJ--
