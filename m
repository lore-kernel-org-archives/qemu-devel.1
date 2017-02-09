Received: from eggs.gnu.org ([2001:4830:134:3::10]:57380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cbm4Z-0002Jx-3U
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cbm4Y-00025d-D0
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:31 -0500
Received: from mail-io0-x22e.google.com ([2607:f8b0:4001:c06::22e]:34693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1cbm4Y-00024V-7y
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:30 -0500
Received: by mail-io0-x22e.google.com with SMTP id l66so13406469ioi.1
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 02:35:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8rjjzgvN-RuNPVHM53R9V9xry1Uj_ArmF1va-Y920eBQ@mail.gmail.com>
References: <1486560712-44171-1-git-send-email-agraf@suse.de>
	<ef6b903b-5224-b4eb-1080-a3689fcec70a@redhat.com>
	<f2f119bc-9c22-ad52-ff26-7d6ecc213a3c@suse.de>
	<c1ff3829-b068-881a-1523-317ef0d31689@redhat.com>
	<C4E1DF44-1626-425D-880E-0053AD688422@linaro.org>
	<CAFEAcA8rjjzgvN-RuNPVHM53R9V9xry1Uj_ArmF1va-Y920eBQ@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 9 Feb 2017 10:35:28 +0000
Message-ID: <CAKv+Gu_HJ-MNZ+GPsroodWGNVm4z++CSWLUkPR6tro8jUh2zzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>

(+Leif, Graeme)

On 8 February 2017 at 18:23, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 8 February 2017 at 16:27, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> The _CCA property is mandatory on arm64, and there is no default.
>
> Is there a tool that can check this kind of requirement
> and complain about issues in the ACPI tables (and
> ditto, device tree)? It's really easy to produce a
> dt or ACPI table that works with current kernels and
> then turns out to have a problem six or twelve
> months down the line :-(
>

Perhaps Graeme or Leif could shed some light on this? I know this is
on our roadmap, but I am not up to date with the latest status.
