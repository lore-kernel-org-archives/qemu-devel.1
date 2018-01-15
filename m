Received: from eggs.gnu.org ([2001:4830:134:3::10]:52507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eb7Ws-0003my-Ll
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eb7Wp-0004zq-FD
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:22:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eb7Wp-0004zS-99
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:22:31 -0500
References: <20180113050717.22969-1-f4bug@amsat.org>
	<CAFEAcA9YNOfZW6tY_OWZ+cyF1Gvc9-9Sq81WgdL_JRDUxcfAqw@mail.gmail.com>
	<70091140-1b3e-6000-0add-b4e980db295e@amsat.org>
	<CAFEAcA9zdxMBosPJOg25vUzg6sdsBORkMRwaVqyAGq6wHxE_Dg@mail.gmail.com>
	<CAAdtpL5xbZ3BQjb6Sm9HkeSiqpV-KfT-HDaohD5Xh2MF=Nw2ZQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <42c141c9-c475-38bc-e29b-e492b01cf8c3@redhat.com>
Date: Mon, 15 Jan 2018 17:22:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAAdtpL5xbZ3BQjb6Sm9HkeSiqpV-KfT-HDaohD5Xh2MF=Nw2ZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 00/14] SDHCI: housekeeping (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Kevin O'Connor <kevin@koconnor.net>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

On 15/01/2018 16:17, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
> The only 2 properties specific to sysbus are:
>=20
> static Property sdhci_sysbus_properties[] =3D {
>     DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert=
_quirk,
>                      false),
>     DEFINE_PROP_LINK("dma", SDHCIState, dma_mr,
>                      TYPE_MEMORY_REGION, MemoryRegion *),
> }
>=20
> I guess I assumed the Property to be const (being compilation-time
> allocated, ended with DEFINE_PROP_END_OF_LIST),
> so I couldn't add more properties to it, but it seems each device has
> his properties allocated at runtime, so I can use the same
> sdhci_common_properties[] array and only use
> qdev_property_add_static() for the 2 sysbus specific properties.

You can define a macro DEFINE_SDHCI_PROPERTIES for the "common" propertie=
s.

Paolo
