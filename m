Received: from eggs.gnu.org ([209.51.188.92]:41980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gk9oy-0000fM-L0
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:43:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gk9ow-0002Vs-Jc
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:43:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gk9ow-000254-7g
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:43:06 -0500
Date: Thu, 17 Jan 2019 16:42:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190117164240.7fc3208d@redhat.com>
In-Reply-To: <a436b1e2-1010-624d-4415-46450f4bedda@redhat.com>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-12-git-send-email-imammedo@redhat.com>
	<4c0d5fdb-7bf7-81ca-77c3-c387bd40ab3f@redhat.com>
	<20190116132953.404247ec@redhat.com>
	<20190116110052-mutt-send-email-mst@kernel.org>
	<d594c2b8-5969-a457-6d2e-27a3fb9a3c09@redhat.com>
	<20190117102239.mnixjppxpuprjwau@sirius.home.kraxel.org>
	<a436b1e2-1010-624d-4415-46450f4bedda@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Andrew Jones <drjones@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>

On Thu, 17 Jan 2019 13:54:51 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

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
if it's non production images (i.e. openssl-less) than maybe use
tests/data/acpi instead of pc-bios for now, once we have pc-bios ones
ready we drop test specific and use production ones.

> That sounds good to me. One thing to note is that the arm/aarch64 images
> have to be padded to 64MB, so I generally append ".padded" to those file
> names. Would that be OK? Any better ideas?
Images could be pre-padded and ready for commit, wrt large size we can commit
them compressed and decompress for using in tests instead of padding padding
I'm doing now before I use them.

> >> Could we please decide for (1) vs (2), before I put more work into (1)?  
> > 
> > I'd tend to prefer (1).  

+1

> 
> Thanks. I have a patch set that's almost suitable for posting as an RFC.
> I should split the last patch and write some sensible commit messages.
> 
> BTW, the bundling under pc-bios is a bit larger task than it immediately
> appears:
> 
> - there are many build options to consider (as you know perfectly well
>   :) ),
> 
> - plus now we have the "docs/interop/firmware.json" schema too, hence
>   whatever images we build for end-user consumption, should likely be
>   accompanied by metafiles that conform to this schema.
> 
> I think once we introduce the "roms/edk2" submodule for the current
> purpose, we could address the pc-bios binaries (+metafiles) in a
> separate series, on top.
> 
> Thanks,
> Laszlo
> 
