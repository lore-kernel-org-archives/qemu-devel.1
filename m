Received: from eggs.gnu.org ([2001:4830:134:3::10]:60310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYc5q-0001lJ-Ac
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYc5n-00011J-5B
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:24:18 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:43060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYc5m-00010r-Vs
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:24:15 -0500
Received: by mail-qk0-x243.google.com with SMTP id j137so15334700qke.10
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 10:24:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180108172904.8772-1-f4bug@amsat.org>
	<20180108172904.8772-11-f4bug@amsat.org>
	<CAFEAcA_g7A6BN1qFc0REbjjNPmFCAEp-ReqfWEU1PtF9pURkdQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <941c8e5c-5259-ee1c-25e3-0cc90ffe1e6a@amsat.org>
Date: Mon, 8 Jan 2018 15:24:07 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_g7A6BN1qFc0REbjjNPmFCAEp-ReqfWEU1PtF9pURkdQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="UCp9c9C6Z10XnpaxnAnMJTrmE024xb85x"
Subject: Re: [Qemu-devel] [PATCH 10/12] configure: disable unaligned access
 warning on x86 arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UCp9c9C6Z10XnpaxnAnMJTrmE024xb85x
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <941c8e5c-5259-ee1c-25e3-0cc90ffe1e6a@amsat.org>
Subject: Re: [PATCH 10/12] configure: disable unaligned access warning on x86
 arch
References: <20180108172904.8772-1-f4bug@amsat.org>
 <20180108172904.8772-11-f4bug@amsat.org>
 <CAFEAcA_g7A6BN1qFc0REbjjNPmFCAEp-ReqfWEU1PtF9pURkdQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_g7A6BN1qFc0REbjjNPmFCAEp-ReqfWEU1PtF9pURkdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/08/2018 02:32 PM, Peter Maydell wrote:
> On 8 January 2018 at 17:29, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  configure | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>=20
> This doesn't seem like the right approach to me. We
> want this sort of thing to be a warning/error on x86,
> because that's the host that everybody actually uses
> to develop with. If they only show up on non-x86
> hosts then the result will be a lot more bounced
> pull requests because of only-non-x86 warnings.

Ok, good point.

Thanks,

Phil.


--UCp9c9C6Z10XnpaxnAnMJTrmE024xb85x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpTt0cACgkQ4+MsLN6t
wN7TaA//QgVYQFxf56wjBNrfrAlBL4wnWugFoDqM78l8yHbfAFIBxUrlM9mJAiOj
8n1VZMnOY/TMQ4RM67LbkjO9K2CRO55dTn6+ycOBVQiAljPQFnUlgl2fbmW76Jl4
EG1cHKp3IiShMURWa9XxbZFn37sbrhhoxaOE51nrplI/hquQyLUIZBG7EfuglYvT
piVdHKQdg2IXA0j6RMMAlpvVHxR5T5KNpkELSno+gfsvE4/73Eld85uubDXn1e3W
ws/Ui840Zp231WI5COFo5kksittrUsD+xcFWQyHOSDMb1Byf1IVzPI3A7Zbp77+I
NZazvW5F9ZRGA8JLJfZnU7TZqP6Lou34difuu9iBqh2W52rO6e5bai56UnxBr+LV
0zumhuOzWyYnYb7JuDlLkwtdStjKMbpPfyJyy5R2h/dHY7ZqI5MISkr3+Lrlm3jp
k8H6QdgWgj2t/NtgkIRx0lDyW16SlQcXHsnLbXEplkIV8nwz0Nw7JQB58DYTNTfP
OeOu78EKBrr1WabWB8+Ee/a77uv0wEtrA5HzY39ubRzXWv1dzG9I2UQNsbRawD6W
6xZuB/y18fz7B+XP6/mUsUjYtQpRDsZuyB4L5Tkc+FFUyh/8MF3+SmuUZwgPsCYl
lu/ELqZLm5PGoA2gaZNFZSx6Axs8s9TkurmiIQrniL7wHkJlKkw=
=DOTf
-----END PGP SIGNATURE-----

--UCp9c9C6Z10XnpaxnAnMJTrmE024xb85x--
