Received: from eggs.gnu.org ([2001:4830:134:3::10]:58661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ePJBY-0006Vx-Dc
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ePJBT-0008G6-5c
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:23:44 -0500
Received: from mail-it0-x233.google.com ([2607:f8b0:4001:c0b::233]:37690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1ePJBS-0008Fp-W3
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:23:39 -0500
Received: by mail-it0-x233.google.com with SMTP id d137so7545954itc.2
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 18:23:38 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <9dae1cb6-0ed1-ca51-42c7-e8d0bddf10d3@redhat.com>
Date: Wed, 13 Dec 2017 21:23:35 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <D7DE9C77-75F6-4A26-AC06-C50B8BE1F7D0@gmail.com>
References: <20B182CA-4FA6-444D-87B1-46B04FFC81AE@gmail.com>
	<20171212143421.GD26971@redhat.com>
	<11216FAC-3F62-43AF-ACD8-00F28B7AD886@gmail.com>
	<20171213091458.GA28379@redhat.com>
	<7D487247-C5DA-4902-A21E-B16861F763C8@gmail.com>
	<alpine.BSF.2.21.1712131914560.26243@zero.eik.bme.hu>
	<99BD2069-929C-402A-B38A-778DAB427449@gmail.com>
	<9dae1cb6-0ed1-ca51-42c7-e8d0bddf10d3@redhat.com>
Subject: Re: [Qemu-devel] Adding more function keys support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, QEMU Developers <qemu-devel@nongnu.org>


> On Dec 13, 2017, at 9:20 PM, Eric Blake <eblake@redhat.com> wrote:
>=20
> On 12/13/2017 01:18 PM, Programmingkid wrote:
>=20
>> Thank you BALATON for the file. One thing that caught my eye in this =
file is this:
>>=20
>=20
>> 	if (usage->code =3D=3D KEY_FN) {
>> 		asc->fn_on =3D !!value;
>>=20
>> Why would they need the double !?=20
>=20
> Double '!!' is an idiomatic way to force a value to be converted to =
bool
> (squashing all non-zero values into 1).
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>=20

Thank you for the information.=
