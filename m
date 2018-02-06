Received: from eggs.gnu.org ([2001:4830:134:3::10]:47127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej78q-0007AY-8W
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej78p-0006T3-FM
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:34:48 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:38833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ej78p-0006SV-65
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:34:47 -0500
Received: by mail-ot0-x233.google.com with SMTP id h14so1700549otj.5
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 09:34:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180205185416.14391.5739.stgit@gimli.home>
References: <20180205185416.14391.5739.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2018 17:34:25 +0000
Message-ID: <CAFEAcA9HMpzXTOHH7sQxQfi9pR9WdJfpfqida6-vnv2yZzqXUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] VFIO updates 2018-02-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 February 2018 at 18:56, Alex Williamson <alex.williamson@redhat.com> wrote:
> The following changes since commit f24ee107a07f093bd7ed475dd48d7ba57ea3d8fe:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180202-pull-request' into staging (2018-02-02 18:54:11 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20180205.0
>
> for you to fetch changes up to 98cc546baeedd43373ecd44c2392bbe9f0bc484c:
>
>   vfio/pci: Add option to disable GeForce quirks (2018-02-05 11:27:15 -0700)
>
> ----------------------------------------------------------------
> VFIO updates 2018-02-05
>
>  - SPAPR in-kernel TCE accleration (Alexey Kardashevskiy)
>
>  - MSI-X relocation (Alex Williamson)
>
>  - Add missing platform mutex init (Eric Auger)
>
>  - Redundant variable cleanup (Alexey Kardashevskiy)
>
>  - Option to disable GeForce quirks (Alex Williamson)
>
> ----------------------------------------------------------------

Hi. This fails to build for Windows:

hw/ppc/spapr_iommu.c:20:23: fatal error: sys/ioctl.h: No such file or directory

thanks
-- PMM
