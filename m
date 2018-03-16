Received: from eggs.gnu.org ([2001:4830:134:3::10]:50500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewn9s-0006jn-RC
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewn9j-0005C9-7I
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:04:24 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewn9i-0005Bn-Rr
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:04:14 -0400
Received: by mail-oi0-x242.google.com with SMTP id x12so8247141oie.13
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 04:04:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180313201415.2327.62402.stgit@gimli.home>
References: <20180313201415.2327.62402.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Mar 2018 11:03:53 +0000
Message-ID: <CAFEAcA9WdtB3faUSdNnWs6QVAGLV0c+SvqcoXUUD-feDDXA0sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] vfio updates for QEMU-2.12 soft freeze
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

On 13 March 2018 at 20:17, Alex Williamson <alex.williamson@redhat.com> wrote:
> The following changes since commit 9f750794985d7386f088da941c76b73880b2b6c4:
>
>   sev/i386: add sev_get_capabilities() (2018-03-13 17:36:06 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20180313.0
>
> for you to fetch changes up to fcad0d2121976df4b422b4007a5eb7fcaac01134:
>
>   ppc/spapr, vfio: Turn off MSIX emulation for VFIO devices (2018-03-13 11:17:31 -0600)
>
> ----------------------------------------------------------------
> VFIO updates 2018-03-13
>
>  - Display support for vGPUs (Gerd Hoffmann)
>
>  - Enable new kernel support for mmaps overlapping MSI-X vector table,
>    disable MSI-X emulation on POWER (Alexey Kardashevskiy)
>
> ----------------------------------------------------------------
>
> NOTE: Above tag is based on Paolo's v2 KVM pull request[1] as both
>       series here depend on v4.16 header updates.
>
> [1] 1520959261-96820-1-git-send-email-pbonzini@redhat.com
>
> Alexey Kardashevskiy (3):
>       vfio/pci: Relax DMA map errors for MMIO regions
>       vfio-pci: Allow mmap of MSIX BAR
>       ppc/spapr, vfio: Turn off MSIX emulation for VFIO devices
>
> Gerd Hoffmann (8):
>       standard-headers: add drm/drm_fourcc.h
>       ui/pixman: add qemu_drm_format_to_pixman()
>       console: minimal hotplug suport
>       secondary-vga: properly close QemuConsole on unplug
>       vfio/common: cleanup in vfio_region_finalize
>       vfio/display: core & wireup
>       vfio/display: adding region support
>       vfio/display: adding dmabuf support

Applied, thanks.

-- PMM
