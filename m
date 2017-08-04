Received: from eggs.gnu.org ([2001:4830:134:3::10]:42856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dde5u-0002AA-8H
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dde5q-0002zY-En
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:00:54 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:33840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dde5q-0002yr-8j
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:00:50 -0400
Received: by mail-io0-x244.google.com with SMTP id m88so1242103iod.1
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 08:00:50 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.88520.1501838500.22740.qemu-devel@nongnu.org>
Date: Fri, 4 Aug 2017 11:00:47 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B694FDA-8C48-4811-A6EA-8B97A8112C1F@gmail.com>
References: <mailman.88520.1501838500.22740.qemu-devel@nongnu.org>
Subject: [Qemu-devel] [PATCH] pc/acpi: Fix booting of macOS with Clover EFI
 bootloader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dhiru Kholia <dhiru.kholia@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, pagupta@redhat.com


> On Aug 4, 2017, at 5:21 AM, qemu-devel-request@nongnu.org wrote:
>=20
> Message: 3
> Date: Fri,  4 Aug 2017 12:15:40 +0530
> From:=20
> To: qemu-devel@nongnu.org
> Cc: Igor Mammedov <imammedo@redhat.com>, Pankaj Gupta
> 	<pagupta@redhat.com>,	Dhiru Kholia <dhiru.kholia@gmail.com>
> Subject: [Qemu-devel] [PATCH] pc/acpi: Fix booting of macOS with
> 	Clover EFI bootloader
> Message-ID: <20170804064540.10523-1-dhiru.kholia@gmail.com>
>=20
> This was tested with macOS 10.12.5 and Clover r4114.
>=20
> Without this patch, the macOS boot process gets stuck at the Apple =
logo
> without showing any progress bar.
>=20
> I have documented the process of running macOS on QEMU/KVM at,
>=20
> https://github.com/kholia/OSX-KVM/
>=20
> Instead of using this patch, adding an additional command-line knob
> which exposes this setting (force_rev1_fadt) to the user might be a =
more
> general solution.
> ---
> hw/i386/acpi-build.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b9c245c..0f8df19 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -145,6 +145,7 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
>             object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, =
NULL);
>     }
>     if (lpc) {
> +        pm->force_rev1_fadt =3D true;
>         obj =3D lpc;
>         pm->cpu_hp_io_base =3D ICH9_CPU_HOTPLUG_IO_BASE;
>     }
> --=20
> 2.9.4

Very interesting. You are using the hackintosh method to install Mac OS =
X in QEMU. I think the supported way is to use Apple's official =
installer. Could you send your full command-line? I think in this =
instance a '-acpi-rev1' option would be useful.=20
