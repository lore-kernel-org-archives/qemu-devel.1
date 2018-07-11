Received: from eggs.gnu.org ([2001:4830:134:3::10]:55787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fd2ij-0001S1-Nm
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 20:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fd2ii-0007Oa-Ck
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 20:11:01 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:45771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fd2ii-0007O8-4r
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 20:11:00 -0400
Received: by mail-lf0-x244.google.com with SMTP id m13-v6so19791026lfb.12
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 17:11:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NvN42K7J+G2+PDzkb7btnGykpzrGjd9zFMx8Oh0SHHMfg@mail.gmail.com>
References: <cover.1531182400.git.alistair.francis@wdc.com>
	<93d3ddab10fa45e0fc081b7008f634b635acb204.1531182400.git.alistair.francis@wdc.com>
	<CAHNT7NvN42K7J+G2+PDzkb7btnGykpzrGjd9zFMx8Oh0SHHMfg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 10 Jul 2018 17:10:28 -0700
Message-ID: <CAKmqyKPZ6PYuHo1rEEKauBjLRFxwnABXW6Qi2270YoXZPah7dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/6] riscv64-softmmu.mak: Build Virtio
 Block support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Jul 9, 2018 at 6:54 PM, Michael Clark <mjc@sifive.com> wrote:
>
>
> On Tue, 10 Jul 2018 at 12:29 PM, Alistair Francis <alistair.francis@wdc.c=
om>
> wrote:
>>
>> Add build time support for the VirtIO block device. This allows us to
>> attach a drive using the virtio-blk-device.
>
>
> I=E2=80=99m not sure what has changed in master, but VirtIO block and net=
 for both
> softmmu-riscv32 and softmmu-riscv64 were previously building by default a=
nd
> working. Perhaps i=E2=80=99ve missed some patches that split up VirtIO su=
pport into
> more granular config options.

It just occurred to me that this patch might not be required. Someone
my last patch series had a conflict that results in removing the virt
include in the default configs. I suspect this patch can be dropped.

Alistair

>
> In any case, we should enable both CONFIG_VIRTIO_NET and CONFIG_VIRTIO_BL=
K
> for both riscv32 and riscv64 as these were working in QEMU 2.12. There ar=
e
> folk using the =E2=80=9Cvirt=E2=80=9D machine for riscv32 Linux.
>
> Thanks, at least I know what to expect when I rebase my patch queue again=
st
> master and of course make a PR for the reviewed patches...
>
> I=E2=80=99m not sure of the soft-freeze date but the bulk of the patches =
are the
> same ones that were posted about a month ago... I also have several patch=
es
> that are not yet on the list...
>
> Vectored interrupts. Trap tracing. More spec wording clarifications
> regarding load reservations and interrupts:
>
> -
> https://github.com/riscv/riscv-qemu/commits/qemu-2.13-for-upstream
>
> Michael
>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  default-configs/riscv64-softmmu.mak | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/default-configs/riscv64-softmmu.mak
>> b/default-configs/riscv64-softmmu.mak
>> index 35e74bebe9..8790f3b115 100644
>> --- a/default-configs/riscv64-softmmu.mak
>> +++ b/default-configs/riscv64-softmmu.mak
>> @@ -12,3 +12,5 @@ CONFIG_PCI_XILINX=3Dy
>>
>>  CONFIG_VGA=3Dy
>>  CONFIG_VGA_PCI=3Dy
>> +
>> +CONFIG_VIRTIO_BLK=3Dy
>> --
>> 2.17.1
>>
>
