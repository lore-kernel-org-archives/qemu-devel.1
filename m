Received: from eggs.gnu.org ([2001:4830:134:3::10]:43462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gF1w5-0007tD-0a
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gF1w4-0003mB-09
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:01:48 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gF1w3-0003lt-Pg
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:01:47 -0400
Received: by mail-oi1-x242.google.com with SMTP id u74-v6so2017759oia.11
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 12:01:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181022183656.4902-1-sameo@linux.intel.com>
References: <20181022183656.4902-1-sameo@linux.intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Oct 2018 20:01:26 +0100
Message-ID: <CAFEAcA9s9hJch1YNtS-0CrL73FTK5nxEEXA-ZnZm+x8+Ov-ZHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/27] ACPI hardware-reduced support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 October 2018 at 19:36, Samuel Ortiz <sameo@linux.intel.com> wrote:
> This patch set implements support for the ACPI hardware-reduced
> specification.
>
> The changes are coming from the NEMU [1] project where we're defining
> a new x86 machine type: i386/virt. This is an EFI only, ACPI
> hardware-reduced platform and as such we had to implement support
> for the latter.
>
> As a preliminary for adding hardware-reduced support to QEMU, we did
> some ACPI code reorganization with the following goals:
>
> * Share as much as possible of the current ACPI build APIs between
>   legacy and hardware-reduced ACPI.
> * Share the ACPI build code across machine types and architectures and
>   remove the typical PC machine type dependency.
>   Eventually we hope to see arm/virt also re-use much of that code.
>
> The rest of the patchset adds the hardware-reduced support on top of
> this code reorganization. Here again, the implementation is machine
> type, platform and architecture independent.
>
> [1] https://github.com/intel/nemu
>
>
> The following changes since commit b312532fd03413d0e6ae6767ec793a3e30f487b8:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-10-19 19:01:07 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:intel/nemu topic/upstream/acpi
>
> for you to fetch changes up to 4133ebe0d638d0a3d583bd89aa2360ef35ba746b:
>
>   hw: acpi: reduced: Add PCI hotplug support (2018-10-22 20:32:23 +0200)

Hi -- I'd appreciate it if you don't send pull-requests for
patch series. They show up in my queue of things to merge directly
into master otherwise. Just send them as a patch-series email with
a cover letter, please.

thanks
-- PMM
