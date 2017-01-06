Received: from eggs.gnu.org ([2001:4830:134:3::10]:60701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cPInw-0008B4-Ml
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 19:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cPInt-0002Ed-Mr
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 19:54:48 -0500
Received: from m12-14.163.com ([220.181.12.14]:41338)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cPIns-0002C1-UI
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 19:54:45 -0500
Content-Type: text/plain;
	charset=gb2312
Mime-Version: 1.0 (1.0)
From: =?GB2312?B?1dTQoce/?= <zxq_yx_007@163.com>
In-Reply-To: <CAFEAcA8Tkxye4Qy3Oi5nPjgcJF_Jv9vOdHjiytP_DdFdEfk=bw@mail.gmail.com>
Date: Fri, 6 Jan 2017 08:54:29 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <28CB7E94-36A7-401A-B036-78CDE3ABC504@163.com>
References: <20161225082559.2095-1-zxq_yx_007@163.com>
	<CAFEAcA8Tkxye4Qy3Oi5nPjgcJF_Jv9vOdHjiytP_DdFdEfk=bw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/display: QOM'ify g364fb.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>



=D4=DA 2017=C4=EA1=D4=C25=C8=D5=A3=AC23:10=A3=ACPeter Maydell <peter.maydell=
@linaro.org> =D0=B4=B5=C0=A3=BA

>> sysbus_init_irq(sbd, &s->irq);
>>    sysbus_init_mmio(sbd, &s->mem_ctrl);
>>    sysbus_init_mmio(sbd, &s->mem_vram);
>=20
> This means we call sysbus_init_mmio() on the MemoryRegion*s
> before we have initialized them. That seems like a bad idea.

Opps=A3=ACwill fix.

> This device is used in the MIPS Jazz machine.
> Can you cc the MIPS maintainers and also Herv=A8=A6 Poussineau
> (the Jazz maintainer) on the next version of this patch,
> please?

OK=A3=A1=
