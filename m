Received: from eggs.gnu.org ([2001:4830:134:3::10]:53078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb7ZC-000519-B6
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb7ZB-00068g-Gs
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:24:58 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:40294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb7ZB-00068R-BS
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:24:57 -0500
Received: by mail-io0-x241.google.com with SMTP id t22so1425691ioa.7
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 08:24:57 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <42c141c9-c475-38bc-e29b-e492b01cf8c3@redhat.com>
References: <20180113050717.22969-1-f4bug@amsat.org>
	<CAFEAcA9YNOfZW6tY_OWZ+cyF1Gvc9-9Sq81WgdL_JRDUxcfAqw@mail.gmail.com>
	<70091140-1b3e-6000-0add-b4e980db295e@amsat.org>
	<CAFEAcA9zdxMBosPJOg25vUzg6sdsBORkMRwaVqyAGq6wHxE_Dg@mail.gmail.com>
	<CAAdtpL5xbZ3BQjb6Sm9HkeSiqpV-KfT-HDaohD5Xh2MF=Nw2ZQ@mail.gmail.com>
	<42c141c9-c475-38bc-e29b-e492b01cf8c3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 15 Jan 2018 13:24:56 -0300
Message-ID: <CAAdtpL4cNz98y7GC-=WYQ7MOR9pi7tqENGz6xg6wkVZa65JQZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Kevin O'Connor <kevin@koconnor.net>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

On Mon, Jan 15, 2018 at 1:22 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 15/01/2018 16:17, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>> The only 2 properties specific to sysbus are:
>>
>> static Property sdhci_sysbus_properties[] =3D {
>>     DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_=
quirk,
>>                      false),
>>     DEFINE_PROP_LINK("dma", SDHCIState, dma_mr,
>>                      TYPE_MEMORY_REGION, MemoryRegion *),
>> }
>>
>> I guess I assumed the Property to be const (being compilation-time
>> allocated, ended with DEFINE_PROP_END_OF_LIST),
>> so I couldn't add more properties to it, but it seems each device has
>> his properties allocated at runtime, so I can use the same
>> sdhci_common_properties[] array and only use
>> qdev_property_add_static() for the 2 sysbus specific properties.
>
> You can define a macro DEFINE_SDHCI_PROPERTIES for the "common" propertie=
s.

Clever :)

Thanks Paolo!

Phil.
