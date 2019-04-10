Received: from eggs.gnu.org ([209.51.188.92]:37917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hEFZh-0006sb-G6
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hEFZg-00057x-KX
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:55:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hEFZg-00057Z-AB
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:55:44 -0400
References: <5CADFEB7.01C57B.25694@m12-14.163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e7a59573-5252-71b7-210b-5a8335f5a5c1@redhat.com>
Date: Wed, 10 Apr 2019 17:55:17 +0200
MIME-Version: 1.0
In-Reply-To: <5CADFEB7.01C57B.25694@m12-14.163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?q?Questions_about_acpi_interrupt_link_devic?=
 =?utf-8?b?ZSdzIOKAmF9QUlMnIGZpZWxk?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "liq3ea@gmail.com" <liq3ea@gmail.com>

On 10/04/19 16:33, Li Qiang wrote:
> Hi all,
>=20
> =C2=A0
>=20
> I see the link device =E2=80=98_PRS=E2=80=99=C2=A0 uses irq line 5, 10,=
 11 in
> =E2=80=98build_link_dev=E2=80=99 function.
>=20
> But I never see the 5 lines uses in the guest, just uses 10 and 11.
>=20
> Why this happen? =C2=A0Maybe related with the guest?

Because the MADT table tells the guest to only use lines 10 and 11.  The
BIOS configures the chipset that way.

Paolo
