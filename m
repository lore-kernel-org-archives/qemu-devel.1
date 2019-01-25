Received: from eggs.gnu.org ([209.51.188.92]:46878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn3u1-0001pK-Ik
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:00:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn3tx-0000bH-3c
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:00:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gn3tv-0000V4-Uj
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:00:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id f7so10891585wrp.1
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 08:00:10 -0800 (PST)
References: <20190123212234.32068-1-stefanha@redhat.com>
	<20190123212234.32068-3-stefanha@redhat.com>
	<f58f9085-c895-1fa5-9fae-afe4ac8de39a@redhat.com>
	<20190125102842.GB28305@stefanha-x1.localdomain>
	<CAFEAcA-Dy0B-qCdojx9j49vF_p7OcAyQAiXYMv-_EZq7CCgT1A@mail.gmail.com>
	<20190125153714.GB305@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7261eadc-367a-cb1a-be0d-fb16a3ac9822@redhat.com>
Date: Fri, 25 Jan 2019 17:00:07 +0100
MIME-Version: 1.0
In-Reply-To: <20190125153714.GB305@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C4RbCEKSiWTwT1ZtfmsdU7tudqXriDKp2"
Subject: Re: [Qemu-devel] [PATCH v2 2/5] pflash: flush rom device memory
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Julia Suvorova <jusual@mail.ru>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C4RbCEKSiWTwT1ZtfmsdU7tudqXriDKp2
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier
 <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>,
 Jim Mussared <jim@groklearning.com>, Max Reitz <mreitz@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Richard Henderson <rth@twiddle.net>
Message-ID: <7261eadc-367a-cb1a-be0d-fb16a3ac9822@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] pflash: flush rom device memory
 region
References: <20190123212234.32068-1-stefanha@redhat.com>
 <20190123212234.32068-3-stefanha@redhat.com>
 <f58f9085-c895-1fa5-9fae-afe4ac8de39a@redhat.com>
 <20190125102842.GB28305@stefanha-x1.localdomain>
 <CAFEAcA-Dy0B-qCdojx9j49vF_p7OcAyQAiXYMv-_EZq7CCgT1A@mail.gmail.com>
 <20190125153714.GB305@stefanha-x1.localdomain>
In-Reply-To: <20190125153714.GB305@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 1/25/19 4:37 PM, Stefan Hajnoczi wrote:
> On Fri, Jan 25, 2019 at 10:36:17AM +0000, Peter Maydell wrote:
>> On Fri, 25 Jan 2019 at 10:28, Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
>>>
>>> On Thu, Jan 24, 2019 at 12:11:55PM +0100, Philippe Mathieu-Daud=E9 wr=
ote:
>>>> The device realize() is also executed before the guest is started, i=
s
>>>> this call really necessary?
>>>
>>> My rationale was that machine init only happens before the guest is
>>> started while ->realize() is called by hotplug too.
>>
>> Yes, but before realize the flash memory can't actually be
>> visible to the guest, so there's no need to invalidate anything.
>>
>>> That said, can pflash devices be hotplugged?
>>
>> I guess you could have one inside a hotplugged device in theory;
>> they can't be directly hotpluggged. (I bet that in practice
>> there are leaks though if you did do that, and we don't have
>> any devices that do so today.)

Can we assume pflash aren't hotpluggable until someone find an use case
and is willing to work on it? I can't find any practical example.

>>> If you guys prefer not flushing from pflash ->realize() then I'll dro=
p
>>> it.
>>
>> I think it makes more sense not to do a flush in the realize method.
>=20
> Okay, I'll resend this patch.

Thanks!

Phil.


--C4RbCEKSiWTwT1ZtfmsdU7tudqXriDKp2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlxLMocACgkQoqP9bt6t
wN4DCg/9Gg8/LJuARsnzUyQLIbqV4TZPQN5IiwBUh71hOeuYtsB/SNUXU0wE2nSM
w30agRvsT62mdc+0sLZiHA+ve/8Iq5VedlLTlk+VU0H2ed7EkKF8W2ovfQC/wbEF
AWfCewELiQCzOxefYLASlwzTInRk1AxhNwz2/I3iVTR8qbRvaFM6+96SZuD0igpr
pkuF3rshM6L2UORVHhMyh8kwZZLaU7nNJV3Bb/s5/Y+zRUmFcB2bfDRakUSeu/EX
uussqgi6h0eESWFOJ45s1g6yclxDDQzcYGlIE5VSXvfG9DXcKrWstvetey3aHJ4p
8Q6/WRtjjHrHunUiWqEsMu/LqiJC7Gz6qvvaFrhQGQk1jcTdU15hQXoeiOg9dy2K
Cg6AqFL9jT6vaoCODYLhf7jh2jSigGbMq8NCvjNU4dxWYuUdc8h0ptooe80gCmA+
Yo8nBjht9EaVpluzvWhAC/MKkvaixInaKxPJV7Z7ruOf7ADuYNTALZ9xvB+AJQVA
WnWYiMSG5Etk1T7SJjPbYOfaTpz0KijuC1bCL260dDmwfblQCvlvP/rsRC/IkyLd
8CZkWIKfm6ZZR8dnANi57f9VCLc/8RjWEHfIdsANb1+n0gcNGoKHgr6k/4tvsjsE
qxCCpa042UwYVl+788M2S2jyFrvPwnNn15YXJed0fvjST0Wf/kk=
=qxBW
-----END PGP SIGNATURE-----

--C4RbCEKSiWTwT1ZtfmsdU7tudqXriDKp2--
