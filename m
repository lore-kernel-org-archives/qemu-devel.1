Received: from eggs.gnu.org ([209.51.188.92]:50582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmb15-0000Ux-1w
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmb11-0003TI-8Z
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:09:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmb0y-0002ur-3C
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:09:37 -0500
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-17-yang.zhong@intel.com>
	<133ee742-f121-91a3-e947-ed740f31a0b2@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0d456018-42a2-b45c-73d3-e94dbd5ad229@redhat.com>
Date: Thu, 24 Jan 2019 10:09:22 +0100
MIME-Version: 1.0
In-Reply-To: <133ee742-f121-91a3-e947-ed740f31a0b2@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v4 16/44] hw/alpha/Makefile.objs:
 Create CONFIG_* for alpha
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com, pbonzini@redhat.com

On 2019-01-23 22:11, Richard Henderson wrote:
> On 1/22/19 10:55 PM, Yang Zhong wrote:
>> @@ -19,3 +19,5 @@ CONFIG_I8259=3Dy
>>  CONFIG_MC146818RTC=3Dy
>>  CONFIG_ISA_TESTDEV=3Dy
>>  CONFIG_SMC37C669=3Dy
>> +CONFIG_DP264=3Dy
>> +CONFIG_TYPHOON=3Dy
>=20
> There's not really a point in two configs; just use DP264.

Ah, right, typhoon belongs to the clipper/dp264 machine, so that should
be fine to use only one config here.

> But beyond that, is there a point in adding configury that must be set =
to Y?
> There is exactly one machine type implemented for Alpha.  I don't see a=
nyone
> implementing a different machine type in the future either.

I see two reasons:

1) Someone might want to build QEMU as plain instruction set simulator
with just the "none" machine included. Then you need the CONFIG_DP264
switch to disable the main machine. Ok, that's not very likely, but
still a possibility.

2) Since this series is about adding a Kconfig-style system to QEMU,
there might be other CONFIG switches that depend on this one later, e.g.
for the x86 machines, a later patch adds:

 config ACPI_NVDIMM
     bool
     default y
     depends on PC || Q35

Agreed, we do not have any "depends on DP264" in this series yet, but I
think it's cleaner if we add a proper config switch for each machine
right from the start.

 Thomas
