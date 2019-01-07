Received: from eggs.gnu.org ([209.51.188.92]:60872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ggQhm-0004R9-5i
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ggQhl-0006CV-CN
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:56:18 -0500
References: <20181207090135.7651-1-luc.michel@greensocs.com>
	<CAFEAcA9F2q6fQV13EDWFzuPYiFTDvqSCx_4P9aD=zP2RR5Kp0g@mail.gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <8b118f0c-b2e4-3821-5348-25a9abbd7948@greensocs.com>
Date: Mon, 7 Jan 2019 09:56:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9F2q6fQV13EDWFzuPYiFTDvqSCx_4P9aD=zP2RR5Kp0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 00/16] gdbstub: support for the
 multiprocess extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistair@alistair23.me>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Mark Burton <mark.burton@greensocs.com>, Eduardo Habkost <ehabkost@redhat.com>

On 1/4/19 4:12 PM, Peter Maydell wrote:
> On Fri, 7 Dec 2018 at 09:01, Luc Michel <luc.michel@greensocs.com> wrot=
e:
>> This series adds support for the multiprocess extension of the GDB
>> remote protocol in the QEMU GDB stub.
>>
>> This extension is useful to split QEMU emulated CPUs in different
>> processes from the point of view of the GDB client. It adds the
>> possibility to debug different kind of processors (e.g. an AArch64 and
>> an ARMv7 CPU) at the same time (it is not possible otherwise since GDB
>> expects an SMP view at the thread granularity.
>=20
> I've applied this patchset to target-arm.next, thanks.
> (I fixed up a few checkpatch nits about block comment style.)
Thanks!

>=20
>> To test this patchset, you can use the following commands:
>>
>> (Note that this requires a recent enough GDB, I think GDB 7.2 is OK.
>> Also, it must be compiled to support both ARM and AArch64 architecture=
s)
>>
>> Run QEMU: (-smp 6 in xlnx-zcu102 enables both cortex-a53 and cortex-r5
>> CPUs)
>>
>> qemu-system-aarch64 -M xlnx-zcu102 -gdb tcp::1234 -S -smp 6
>>
>> Run the following commands in GDB:
>>
>> target extended :1234
>> add-inferior
>> inferior 2
>> attach 2
>> info threads
>=20
> This seems a bit clumsy -- is it just the limitations of
> gdb here? I was expecting that just connecting to the
> remote would cause gdb to interrogate it and attach to
> all the inferior processes that it had.
AFAIK this is a "limitation" of GDB. In QEMU context it seems like a
limitation, but when you are connecting to a remote gdbserver that
exposes all the processes currently running on an OS, you probably don't
want to attach them all automatically.

Luc

>=20
> thanks
> -- PMM
>=20
