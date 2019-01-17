Received: from eggs.gnu.org ([209.51.188.92]:35899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gk4p2-0003wo-4b
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:22:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gk4p0-0001Jk-1k
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:22:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gk4oy-0001HJ-2q
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:22:48 -0500
Date: Thu, 17 Jan 2019 11:22:39 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190117102239.mnixjppxpuprjwau@sirius.home.kraxel.org>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-12-git-send-email-imammedo@redhat.com>
	<4c0d5fdb-7bf7-81ca-77c3-c387bd40ab3f@redhat.com>
	<20190116132953.404247ec@redhat.com>
	<20190116110052-mutt-send-email-mst@kernel.org>
	<d594c2b8-5969-a457-6d2e-27a3fb9a3c09@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d594c2b8-5969-a457-6d2e-27a3fb9a3c09@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/14] tests: acpi: add AVMF firmware blobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

  Hi,

> >>>>  create mode 100644 pc-bios/avmf.img
> >>>>  create mode 100644 pc-bios/avmf_vars.img  
> >>>
> >>> "AVMF" is not a great name. "AAVMF" is a downstream name alright, but
> >>> many dislike it in upstream use. "edk2-aarch64" or "edk2-ArmVirtQemu"
> >>> would be more precise, but those are verbose. Sigh, why are names so
> >>> hard. What does everyone think?
> >> I'm fine with either version.

How about placing them in pc-bios/efi-$arch subdirs and not renaming the
files, i.e. that would be ...

	pc-bios/efi-aarch64/QEMU_EFI.fd
	pc-bios/efi-aarch64/QEMU_VARS.fd

... for arm, and ...

	pc-bios/efi-x86_64/OVMF_CODE.fd
	pc-bios/efi-x86_64/OVMF_VARS.fd

... for x86.

> Could we please decide for (1) vs (2), before I put more work into (1)?

I'd tend to prefer (1).

cheers,
  Gerd
