Received: from eggs.gnu.org ([2001:4830:134:3::10]:38172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHYTI-0002yO-Qb
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 14:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHYTD-00014f-Pr
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 14:10:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHYT8-0000um-FL
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 14:10:23 -0400
References: <5BD881F6.0B8479.13021@m12-12.163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bae04798-e583-cbe9-3474-f317ebbc8333@redhat.com>
Date: Tue, 30 Oct 2018 19:10:18 +0100
MIME-Version: 1.0
In-Reply-To: <5BD881F6.0B8479.13021@m12-12.163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Question] About object oriented programming in
 qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 30/10/2018 17:08, Li Qiang wrote:
> Hello all,
>=20
> =C2=A0
>=20
> Today I read the BusClass=E2=80=99 definition.
>=20
> =C2=A0
>=20
> The comment
>=20
> /* FIXME first arg should be BusState */
>=20
> remind me that OOP in qemu is not very OOP.

It is not "not very OOP", it is not language-supported and so it can
take a few more liberties.

Perhaps these functions should be moved to DeviceClass instead.  That
would make sense, I think.

Paolo

> Maybe we should take the first arg as the Object pointer, just as the
> cpp=E2=80=99s this pointer.
>=20
> For example, we can define the BusClass function as this
>=20
> void (*print_dev)(BusState*, Monitor *mon, DeviceState *dev, int indent=
);
> char *(*get_dev_path)(BusState*, =C2=A0DeviceState *dev);
> char *(*get_fw_dev_path)(BusState*, DeviceState *dev);
>=20
> So we don=E2=80=99t need get the BusState in the callback function, suc=
h as
> =E2=80=98usb_bus_dev_print=E2=80=99.
>=20
> =C2=A0
>=20
> I want to know do do you think it make senses?
>=20
> If not I will not spend time to write the patch.
>=20
> =C2=A0
>=20
> Thanks,
>=20
> Li Qiang
>=20
