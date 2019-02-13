Received: from eggs.gnu.org ([209.51.188.92]:38165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gu17U-0001jA-0m
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 15:27:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gu0vq-0008HB-Uj
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 15:14:59 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:34253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gu0vq-0008Fo-Oy
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 15:14:58 -0500
Received: by mail-pf1-x42d.google.com with SMTP id j18so1720796pfe.1
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 12:14:58 -0800 (PST)
Date: Wed, 13 Feb 2019 12:14:56 -0800 (PST)
In-Reply-To: <49bd9805-2f40-7d5d-8814-e0a59a9c5be1@redhat.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-88540c09-3b63-4408-b3e8-4e16c9cded81@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] SiFive RISC-V GPIO Device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com
Cc: Peter Maydell <peter.maydell@linaro.org>, alistair23@gmail.com, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org, chouteau@adacore.com, mjc@sifive.com, Alistair Francis <Alistair.Francis@wdc.com>

On Wed, 13 Feb 2019 10:54:08 PST (-0800), thuth@redhat.com wrote:
> On 2019-02-13 18:14, Peter Maydell wrote:
>> On Wed, 13 Feb 2019 at 00:13, Alistair Francis <alistair23@gmail.com> wrote:
>>> I know the other RISC-V files don't do it, but this should go in the
>>> hw/gpio directory instead of hw/riscv.
>>
>> It might be nice to move those existing riscv devices into
>> their proper places at some point: should be a fairly easy
>> cleanup patch if somebody wants to take it on. (Advice
>> on what should live where available on request.)
>
> If devices only work on riscv, they should IMHO stay in hw/riscv/. I
> think hw/gpio/ and friends should primarily be used if a device is
> shared between architectures. If they stay in hw/riscv/ it is way easier
> to match the devices with wildcards in the MAINTAINERS file. Just my
> 0.02 € only, of course.

FWIW, I generally consider things like SiFive's GPIO controller to have nothing 
to do with RISC-V and therefor don't belong in hw/riscv.  That said, I don't 
really care that much so I'm happy with pretty much any source code 
organization that works for everyone else.  Let me know if we should move them 
around.
