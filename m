Received: from eggs.gnu.org ([209.51.188.92]:45648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gk8Mt-00059s-8h
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gk8Ms-0003oM-Hd
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:10:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gk8Ms-0003lC-Ap
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:10:02 -0500
Date: Thu, 17 Jan 2019 15:09:50 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190117140950.grbbjyhcbv6kob74@sirius.home.kraxel.org>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-12-git-send-email-imammedo@redhat.com>
	<4c0d5fdb-7bf7-81ca-77c3-c387bd40ab3f@redhat.com>
	<20190116132953.404247ec@redhat.com>
	<20190116110052-mutt-send-email-mst@kernel.org>
	<d594c2b8-5969-a457-6d2e-27a3fb9a3c09@redhat.com>
	<20190117102239.mnixjppxpuprjwau@sirius.home.kraxel.org>
	<a436b1e2-1010-624d-4415-46450f4bedda@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a436b1e2-1010-624d-4415-46450f4bedda@redhat.com>
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

On Thu, Jan 17, 2019 at 01:54:51PM +0100, Laszlo Ersek wrote:
> On 01/17/19 11:22, Gerd Hoffmann wrote:
> >   Hi,
> > 
> >>>>>>  create mode 100644 pc-bios/avmf.img
> >>>>>>  create mode 100644 pc-bios/avmf_vars.img  
> >>>>>
> >>>>> "AVMF" is not a great name. "AAVMF" is a downstream name alright, but
> >>>>> many dislike it in upstream use. "edk2-aarch64" or "edk2-ArmVirtQemu"
> >>>>> would be more precise, but those are verbose. Sigh, why are names so
> >>>>> hard. What does everyone think?
> >>>> I'm fine with either version.
> > 
> > How about placing them in pc-bios/efi-$arch subdirs and not renaming the
> > files, i.e. that would be ...
> > 
> > 	pc-bios/efi-aarch64/QEMU_EFI.fd
> > 	pc-bios/efi-aarch64/QEMU_VARS.fd
> > 
> > ... for arm, and ...
> > 
> > 	pc-bios/efi-x86_64/OVMF_CODE.fd
> > 	pc-bios/efi-x86_64/OVMF_VARS.fd
> > 
> > ... for x86.
> 
> That sounds good to me. One thing to note is that the arm/aarch64 images
> have to be padded to 64MB, so I generally append ".padded" to those file
> names. Would that be OK? Any better ideas?

Ah, right, the arm versions can't be used as-is with pflash.  In my rpm
builds I've named the padded version "QEMU_EFI-pflash.raw".  Using
.padded looks fine to me too.

Other idea:  Does it make sense to use qcow2 for the pflash images?
i.e. "qemu-img create -f qcow2 -b QEMU_EFI.fd -F raw QEMU_EFI.qcow2 64M"?

cheers,
  Gerd
