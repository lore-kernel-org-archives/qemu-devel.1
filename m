Received: from eggs.gnu.org ([2001:4830:134:3::10]:43256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecGte-0006I7-O9
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecGtd-0003P7-Kg
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:34:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ecGtd-0003OB-AE
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:34:49 -0500
References: <20180118025245.13042-1-famz@redhat.com>
	<d1dd1750-c487-be35-05eb-ffb12f18e805@redhat.com>
	<a81a812f-065c-e8be-0d6d-92525a379a82@amsat.org>
	<cf2b427d-a8a0-a124-16dd-598d4f7eea46@redhat.com>
	<CAAdtpL4kR9qWjWHBuYYbZXv=FBoKXRgLE5tzaaC1nZyJZNHXNA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <59cde1ab-cf5f-b40a-4377-b33091b593a2@redhat.com>
Date: Thu, 18 Jan 2018 14:34:39 -0600
MIME-Version: 1.0
In-Reply-To: <CAAdtpL4kR9qWjWHBuYYbZXv=FBoKXRgLE5tzaaC1nZyJZNHXNA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q2pmCFsZ87GRdYr23I9kC0Yk1x9IIksmV"
Subject: Re: [Qemu-devel] [PATCH] scsi-generic: Simplify error handling code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q2pmCFsZ87GRdYr23I9kC0Yk1x9IIksmV
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Fam Zheng <famz@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <59cde1ab-cf5f-b40a-4377-b33091b593a2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi-generic: Simplify error handling code
References: <20180118025245.13042-1-famz@redhat.com>
 <d1dd1750-c487-be35-05eb-ffb12f18e805@redhat.com>
 <a81a812f-065c-e8be-0d6d-92525a379a82@amsat.org>
 <cf2b427d-a8a0-a124-16dd-598d4f7eea46@redhat.com>
 <CAAdtpL4kR9qWjWHBuYYbZXv=FBoKXRgLE5tzaaC1nZyJZNHXNA@mail.gmail.com>
In-Reply-To: <CAAdtpL4kR9qWjWHBuYYbZXv=FBoKXRgLE5tzaaC1nZyJZNHXNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2018 09:55 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On Thu, Jan 18, 2018 at 9:03 AM, Paolo Bonzini <pbonzini@redhat.com> wr=
ote:
>> On 18/01/2018 12:21, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> I'm not a fan of bool return types, in general (because "!" is often=

>>>> success while "< 0" is failure) and especially when there is an Erro=
r**;
>>>> I disagree with commit 9d3b155186.  But the function is not in an ar=
ea I
>>>> maintain so I'm queuing this, thanks.
>>> Do you prefer "if (local_err)" and "if (errp && *errp)" ?
>>
>> The latter is wrong.  I do prefer
>=20
> Ok so my 253674981e24 missed that train too.

Markus has expressed as desire, as the error maintainer, to make errp
functions return a useful value for less boilerplate, and at one point
was even debating about Coccinelle scripts to make the conversion
easier.  Perhaps int with -1 is more reliable than bool for that useful
value, but this is definitely a topic of past discussion.

By the way, if (local_err) is definitely preferable; 'if (errp &&
*errp)' means that your behavior is different depending on whether the
caller wanted to ignore the error, and not whether you wanted to handle
the error.

>=20
>>
>>     if (local_err) {
>>         error_propagate(errp, local_err);
>>         return;
>>     }

Yes, that's the right boilerplate if you don't have a return value witnes=
s.

>>
>> or maybe (but only if there is a meaning to a zero vs. positive return=

>> value, or if errno is an important part of the returned Error *)
>>
>>     ret =3D f(..., errp);
>>     if (ret < 0) {
>>         return;
>>     }
>>
>>> I wondered once if a macro might improve this pattern but thought the=

>>> code would get more obscure.
>>
>> Eduardo had a series to avoid error_propagate, where NULL was replaced=

>> by a (non-NULL) IGNORED_ERRORS macro.  Then you could do:
>>
>>     f(..., errp);
>>     if (error_is_set(errp)) {
>>         return;
>>     }
>>
>> See here:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg03139.html
>=20
> This series never hit /master!
>=20
> Reading the thread I'm not sure what was the expected outcome.

And since Markus may not answer this thread for a while, I'm still not
sure if there is any expected outcome.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Q2pmCFsZ87GRdYr23I9kC0Yk1x9IIksmV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlphBOAACgkQp6FrSiUn
Q2qsdwf/ZpW5jzOtpISeGV+VsNOW2NtVYNFI7KpQQRLXZnSvbAqS6hs5maqD05N2
FrHKt+pf2DHWzTT7fWrnui+4CHNapOKYsohCX+/2oXIc2/CbmDrAfw1fMilWtkz0
aGQxqUDOLS0Nf6LkebzcvY450SJ9eZE7NVlui2eQhF44GoPdOkhomW8B4c94uhbs
8xs1Yd35c4H6yAD7dLshC3XMNe/3OppPeeJprksj5R0bBW+CZWxYUB2fxz7cB0Ss
tDKyN+USM7Kl8+/Wzroz8hG3VGQyQdp9WrXAUYf+oKG0BmJxCQauNBc/jvC+V9Ra
vhP44fd5fP6qa5HmGuX6qRFK1sryNg==
=s/oU
-----END PGP SIGNATURE-----

--Q2pmCFsZ87GRdYr23I9kC0Yk1x9IIksmV--
