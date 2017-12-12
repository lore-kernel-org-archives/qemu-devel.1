Received: from eggs.gnu.org ([2001:4830:134:3::10]:49369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1eOlaT-0006qu-1q
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1eOlaN-0007SE-9V
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:31:13 -0500
Received: from mail-it0-x22b.google.com ([2607:f8b0:4001:c0b::22b]:46228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1eOlaN-0007Rj-3u
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:31:07 -0500
Received: by mail-it0-x22b.google.com with SMTP id t1so24878847ite.5
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 06:31:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8OY3PFk_bermKxQBuF_th7SudHgaRk8wf76EAGYnoCGw@mail.gmail.com>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-4-git-send-email-peter.maydell@linaro.org>
	<5A2F6ED9.5030605@huawei.com>
	<ac182406-8011-9f19-38e7-37328434095b@redhat.com>
	<CAFEAcA_9pee99KpL4zwVS5jJuiv2MCGp79crufpU1kH1Okg-Hg@mail.gmail.com>
	<6b4b6351-eeb4-a4d3-8ddf-5401516671ae@redhat.com>
	<CAKv+Gu-Ugm1g8twoKwgXAPtDfETvXntk2h4WzMVuUTDF7GhMvA@mail.gmail.com>
	<5e3798f7-e280-b6c3-1504-828283617c52@redhat.com>
	<CAFEAcA_+NnpeP9Le7bp9yrYQDwtuP79pt8GpVzJ4RBDMx1iomA@mail.gmail.com>
	<09e7b89f-27f2-1787-b371-7b0c0eff78b8@redhat.com>
	<CAFEAcA-357eVt3s_7ULWxssQttvAV0DkUv_tGkyk8umVgfH1QA@mail.gmail.com>
	<d776710c-2255-947b-22c6-336e9491bb81@redhat.com>
	<CAKv+Gu9e6qwJ4=t=UHHGsVs1XM26agh17Mgy0ckAvUsy+2xi2A@mail.gmail.com>
	<CAFEAcA9JzK8sNF5TmENfXZ-NBJwfp03b2La4YQ=N2i1ZCzrNBw@mail.gmail.com>
	<CAKv+Gu_mzynBKSBSdtUhKRgNd3KmuJTwiNZpmvPCfkRDo_QCgA@mail.gmail.com>
	<CAFEAcA9HAcZTi6bT-FbsG9LtqO=4s7rpcz0niZbimG834t4uHA@mail.gmail.com>
	<CAKv+Gu8gZ-Y4-zV2GRgbXPcignAg3vi8__XaFXqAhYOZOL7GcQ@mail.gmail.com>
	<CAFEAcA8OY3PFk_bermKxQBuF_th7SudHgaRk8wf76EAGYnoCGw@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 12 Dec 2017 14:31:05 +0000
Message-ID: <CAKv+Gu_939a=cui76H5FqCZwbWqDUYhegNe18T+tBpq7CW+TrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/arm/virt-acpi-build: Add second
 UART to ACPI tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Drew Jones <drjones@redhat.com>, Andrea Bolognani <abologna@redhat.com>

On 12 December 2017 at 14:17, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 12 December 2017 at 14:16, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> On 12 December 2017 at 14:13, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 12 December 2017 at 14:12, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>>> On 12 December 2017 at 14:10, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>> That doesn't actually usefully separate debug output from the
>>>>> console, though, because stdout-path is also going to point
>>>>> to the UART with the lowest physical address...
>>>>>
>>>>
>>>> By default, yes, just like is currently the case. But I would assume
>>>> this new serial port could be appointed 'console' and put into
>>>> stdout-path by QEMU, based on the command line options?
>>>
>>> We don't have any command line options for doing that, and I'm
>>> generally reluctant to introduce new command line UI, especially
>>> new command line UI that's specific to Arm and not also needed
>>> for x86.
>>>
>>
>> If stdout-path is always going to point to pl011@0x9000000, why would
>> we need to parse it?
>
> If you had always parsed stdout-path, we wouldn't need to worry
> about the order in which the UART nodes appear in the dtb...
>

That's a fair point. But it still does not justify introducing added
complexity in the firmware, if the conclusion is always going to be
that the console will be on pl011@9000000.

To Drew's point re DEBUG builds, I don't think we should generally
enable DEBUG and send the output to nowhereland if the user does not
wire it up. That's a MMIO trap and two world switches for each
character written, if I am not mistaken, and the DEBUG builds are very
noisy.

But still, given that stdout-path is essentially written in stone
anyway, could we also decide that it will always refer to
pl011@9000000 by its nodename? That way, we can easily implement the
early DEBUG logic by using any non-disabled non-secure PL011 that is
not referenced in stdout-path, and falling back to the one that is in
stdout-path, which will essentially work as it does today. And for the
more elaborate DXE driver, we can find the nodename from stdout-path.
