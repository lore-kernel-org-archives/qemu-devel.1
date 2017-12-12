Received: from eggs.gnu.org ([2001:4830:134:3::10]:42175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1eOlIT-00050x-0R
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1eOlIS-0002xj-5D
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:12:36 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:34674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1eOlIS-0002x5-0m
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:12:36 -0500
Received: by mail-it0-x241.google.com with SMTP id m11so17468316iti.1
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 06:12:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9JzK8sNF5TmENfXZ-NBJwfp03b2La4YQ=N2i1ZCzrNBw@mail.gmail.com>
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
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 12 Dec 2017 14:12:34 +0000
Message-ID: <CAKv+Gu_mzynBKSBSdtUhKRgNd3KmuJTwiNZpmvPCfkRDo_QCgA@mail.gmail.com>
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

On 12 December 2017 at 14:10, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 12 December 2017 at 13:56, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> Given that the DEBUG output is only produced on DEBUG builds, couldn't
>> we simply stipulate that DEBUG output appears on the PL011 with the
>> lowest physical address? That keeps the current status quo, and is
>> probably sufficient for 99% of the use cases of people using the DEBUG
>> builds.
>>
>> Then, we can introduce some code to decode stdout-path in FdtClientDxe
>> (a higher level DT parsing driver) so that the actual serial console
>> gets installed onto whichever UART is described as the system console.
>> Also, given that ArmVirtQemu is tightly coupled to QEMU/mach-virt, we
>> could decide to only use node names in stdout-path (as we do
>> currently) to simplify the parsing logic.
>
> That doesn't actually usefully separate debug output from the
> console, though, because stdout-path is also going to point
> to the UART with the lowest physical address...
>

By default, yes, just like is currently the case. But I would assume
this new serial port could be appointed 'console' and put into
stdout-path by QEMU, based on the command line options?
