Received: from eggs.gnu.org ([2001:4830:134:3::10]:60028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG4L2-0007Ox-FG
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG4L1-0000c5-27
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:15:36 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:38736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG4L0-0000bI-RO
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:15:34 -0400
Received: by mail-oi0-x22d.google.com with SMTP id k17-v6so28656941oih.5
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 08:15:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180507170315.11497-1-ehabkost@redhat.com>
References: <20180507170315.11497-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 16:15:13 +0100
Message-ID: <CAFEAcA-VGwh3dsXzwipcug5OwusYYVjJqa5HMRQm4F1Huv1pVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/12] Machine queue, 2018-05-07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 7 May 2018 at 18:03, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e6d9b9:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04' into staging (2018-05-04 14:42:46 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to b40dffdec60c2dbe54806576faa5cb85227586d1:
>
>   scripts/device-crash-test: Removed fixed CAN entries (2018-05-07 10:00:02 -0300)
>
> ----------------------------------------------------------------
> Machine queue, 2018-05-07
>
> * pc-dimm: factor out MemoryDevice
>   (virtio-pmem and virtio-mem will make use of the new abstraction later)
> * scripts/device-crash-test: Removed fixed CAN entries
>
> ----------------------------------------------------------------
>
> Queue for Machine Core patches
>
>
> David Hildenbrand (11):
>   pc-dimm: factor out MemoryDevice interface
>   machine: make MemoryHotplugState accessible via the machine
>   pc-dimm: no need to pass the memory region
>   pc-dimm: pass in the machine and to the MemoryHotplugState
>   pc-dimm: factor out address search into MemoryDevice code
>   pc-dimm: factor out capacity and slot checks into MemoryDevice
>   pc-dimm: move actual plug/unplug of a memory region to MemoryDevice
>   machine: rename MemoryHotplugState to DeviceMemoryState
>   pc: rename "hotplug memory" terminology to "device memory"
>   spapr: rename "hotplug memory" terminology to "device memory"
>   vl: allow 'maxmem' without 'slot'
>
> Thomas Huth (1):
>   scripts/device-crash-test: Removed fixed CAN entries

Applied, thanks.

-- PMM
