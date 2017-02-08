Received: from eggs.gnu.org ([2001:4830:134:3::10]:35520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbXHL-0004Zc-TE
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 13:47:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbXHK-0001Hh-UT
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 13:47:43 -0500
References: <1486560712-44171-1-git-send-email-agraf@suse.de>
	<ef6b903b-5224-b4eb-1080-a3689fcec70a@redhat.com>
	<f2f119bc-9c22-ad52-ff26-7d6ecc213a3c@suse.de>
	<c1ff3829-b068-881a-1523-317ef0d31689@redhat.com>
	<C4E1DF44-1626-425D-880E-0053AD688422@linaro.org>
	<CAFEAcA8rjjzgvN-RuNPVHM53R9V9xry1Uj_ArmF1va-Y920eBQ@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <991fc2e7-e483-c7bc-fc45-3d32d9d37857@redhat.com>
Date: Wed, 8 Feb 2017 19:47:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8rjjzgvN-RuNPVHM53R9V9xry1Uj_ArmF1va-Y920eBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target-arm: Declare virtio-mmio
 as dma-coherent in dt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Shannon Zhao <shannon.zhao@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Heyi Guo <heyi.guo@linaro.org>

On 02/08/17 19:23, Peter Maydell wrote:
> On 8 February 2017 at 16:27, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> The _CCA property is mandatory on arm64, and there is no default.
> 
> Is there a tool that can check this kind of requirement
> and complain about issues in the ACPI tables (and
> ditto, device tree)? It's really easy to produce a
> dt or ACPI table that works with current kernels and
> then turns out to have a problem six or twelve
> months down the line :-(

I think the "bios bits" project or the FWTS (firmware test suite)
project might do some ACPI sanity checks. They could be run in guests.

https://biosbits.org/
https://wiki.ubuntu.com/FirmwareTestSuite

However, I'm unsure if they support aarch64. Also... it's not like those
projects are stationary. Even the ACPI spec is a moving target (and
spec-level regressions exist).

I believe Heyi Guo @ Linaro used to work with FWTS on aarch64. CC'd.

No clue about DT conformance testing. Is there an industry standard or a
working group behind DT?

Thanks
Laszlo
