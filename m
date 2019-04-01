Received: from eggs.gnu.org ([209.51.188.92]:58321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hApbz-0001Il-1r
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 01:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hApby-00005x-3K
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 01:35:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hApbx-00005K-QE
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 01:35:58 -0400
References: <CAP8WD_bf=0=tyCumcNpVLtneio+vbd4JuFMmtWqSwXWFC-7PMg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6da0c28c-ef4f-8199-1cee-bf1f08387ff1@redhat.com>
Date: Mon, 1 Apr 2019 07:35:50 +0200
MIME-Version: 1.0
In-Reply-To: <CAP8WD_bf=0=tyCumcNpVLtneio+vbd4JuFMmtWqSwXWFC-7PMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Pentium Pro Feature Bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: whiteheadm@acm.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 01/04/2019 05.36, tedheadster wrote:
> I just noticed this in the code regarding MMX and I wonder if it is cor=
rect:
>=20
> target/i386/cpu.c:
>=20
> #define PPRO_FEATURES (CPUID_FP87 | CPUID_DE | CPUID_PSE | CPUID_TSC | =
\
>           CPUID_MSR | CPUID_MCE | CPUID_CX8 | CPUID_PGE | CPUID_CMOV | =
\
>           CPUID_PAT | CPUID_FXSR | CPUID_MMX | CPUID_SSE | CPUID_SSE2 |=
 \
>           CPUID_PAE | CPUID_SEP | CPUID_APIC)
>=20
> The problem I see is that the PentiumPro never supported the MMX
> instruction extensions (oddly supported in the the Pentium MMX), nor
> the even later SSE (Pentium III) and SSE2 (Pentium 4) features.
>=20
> Also, the Pentium Pro never officially supported  SYSENTER/SYSEXIT
> (CPUID_SEP), though they originally intended to. Intel discovered
> shortly before the product release that the hardware didn't work
> correctly, so they never documented it as a feature to prevent its
> use.
>=20
> Should these be removed?

Looking at the output of "qemu-system-x86_64 -cpu help", it seems to me
like QEMU does not emulate the Pention Pro at all. So maybe we should
simply rename that macro to "QEMU32_FEATURES" or something similar?

 Thomas
