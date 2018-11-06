Received: from eggs.gnu.org ([2001:4830:134:3::10]:34463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJyR7-0003KB-78
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:18:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJyQz-00046n-2g
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:18:17 -0500
References: <20181101102303.16439-1-sameo@linux.intel.com>
	<20181101102303.16439-4-sameo@linux.intel.com>
	<a7c05368-908e-0249-5702-63a844f9dc71@gmail.com>
	<0a0f830b-e9a3-8cb4-12f5-d3fc234036cc@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <26bc6ef8-f9c4-b75b-4157-62f81d972340@redhat.com>
Date: Tue, 6 Nov 2018 11:17:42 +0100
MIME-Version: 1.0
In-Reply-To: <0a0f830b-e9a3-8cb4-12f5-d3fc234036cc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 03/23] hw: acpi: Export the RSDP build
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 02/11/2018 10:56, Philippe Mathieu-Daud=C3=A9 wrote:
>>>
>>> =C2=A0 }
>>> =C2=A0 /* RSDP */
>>> -static GArray *
>>> +static void
>>> =C2=A0 build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned
>>> xsdt_tbl_offset)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AcpiRsdpDescriptor *rsdp =3D acpi_data=
_push(rsdp_table, sizeof
>>> *rsdp);
>>
>> Why change this? It's not related to your patch purpose.
>=20
> This patch updates include/hw/acpi/aml-build.h to export the
> build_rsdp() function.
> Since this file includes this header, the orototype needs to match.

But then it should also remove the "return".  I think something is
broken for bisectability between this patch and patch 4.

Perhaps this patch should already rename the function to
build_rsdp_rsdt, and patch 4 should move build_rsdp from hw/arm to hw/acp=
i?

Paolo
