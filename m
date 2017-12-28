Received: from eggs.gnu.org ([2001:4830:134:3::10]:45244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eUZSq-0007Yv-68
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 09:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eUZSp-0004BA-Bp
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 09:47:20 -0500
From: gengdongjiu <gengdongjiu@huawei.com>
Date: Thu, 28 Dec 2017 14:46:55 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F201A3F2BE@DGGEMA503-MBS.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v14 1/9] ACPI: add some GHES structures and
 macros definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Zhaoshenglong <zhaoshenglong@huawei.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "james.morse@arm.com" <james.morse@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Huangshaoyu <huangshaoyu@huawei.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>, "xuwei (O)" <xuwei5@hisilicon.com>

[...]
> > +/*
> >   * MADT sub-structures (Follow MULTIPLE_APIC_DESCRIPTION_TABLE)
> >   */
> >  #define ACPI_SUB_HEADER_DEF   /* Common ACPI sub-structure header */\
> > @@ -474,6 +493,39 @@ struct AcpiSystemResourceAffinityTable {  }
> > QEMU_PACKED;  typedef struct AcpiSystemResourceAffinityTable
> > AcpiSystemResourceAffinityTable;
> >
> > +/*
> > + * Generic Error Status Block
> > + */
> > +struct AcpiGenericErrorStatus {
> > +    /* It is a bitmask composed of ACPI_GEBS_xxx macros */
> > +    uint32_t block_status;
> > +    uint32_t raw_data_offset;
> > +    uint32_t raw_data_length;
> > +    uint32_t data_length;
> > +    uint32_t error_severity;
> > +} QEMU_PACKED;
> > +typedef struct AcpiGenericErrorStatus AcpiGenericErrorStatus;
> > +
> > +/*
> > + * Masks for Block Status field above  */
> > +#define ACPI_GEBS_UNCORRECTABLE          (1)
> () are usually used with an expression and not with single value, so drop=
 that to be consistent with style of the header


Igor, sure, it is. I will drop it. Appreciate for your point out.

>=20
> > +
> > +/*
> > + * Value for Error Severity field above  */ enum
> > +AcpiGenericErrorSeverity {
> > +    ACPI_CPER_SEV_RECOVERABLE,
> > +    ACPI_CPER_SEV_FATAL,
> > +    ACPI_CPER_SEV_CORRECTED,
> > +    ACPI_CPER_SEV_NONE,
> > +};
> > +
> > +/*
> > + * Generic Hardware Error Source version 2  */
> > +#define ACPI_HEST_SOURCE_GENERIC_ERROR_V2    (10)
> ditto


You are right, will drop it. Thanks you very much.

>=20
> > +
> >  #define ACPI_SRAT_PROCESSOR_APIC     0
> >  #define ACPI_SRAT_MEMORY             1
> >  #define ACPI_SRAT_PROCESSOR_x2APIC   2
[...]
