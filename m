Received: from eggs.gnu.org ([209.51.188.92]:47166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gk7Cl-0001ME-NO
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gk7Cj-0004tR-JY
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:55:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gk7Ch-0004g8-H5
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:55:29 -0500
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-12-git-send-email-imammedo@redhat.com>
	<4c0d5fdb-7bf7-81ca-77c3-c387bd40ab3f@redhat.com>
	<20190116132953.404247ec@redhat.com>
	<20190116110052-mutt-send-email-mst@kernel.org>
	<d594c2b8-5969-a457-6d2e-27a3fb9a3c09@redhat.com>
	<20190117102239.mnixjppxpuprjwau@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a436b1e2-1010-624d-4415-46450f4bedda@redhat.com>
Date: Thu, 17 Jan 2019 13:54:51 +0100
MIME-Version: 1.0
In-Reply-To: <20190117102239.mnixjppxpuprjwau@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

On 01/17/19 11:22, Gerd Hoffmann wrote:
>   Hi,
> 
>>>>>>  create mode 100644 pc-bios/avmf.img
>>>>>>  create mode 100644 pc-bios/avmf_vars.img  
>>>>>
>>>>> "AVMF" is not a great name. "AAVMF" is a downstream name alright, but
>>>>> many dislike it in upstream use. "edk2-aarch64" or "edk2-ArmVirtQemu"
>>>>> would be more precise, but those are verbose. Sigh, why are names so
>>>>> hard. What does everyone think?
>>>> I'm fine with either version.
> 
> How about placing them in pc-bios/efi-$arch subdirs and not renaming the
> files, i.e. that would be ...
> 
> 	pc-bios/efi-aarch64/QEMU_EFI.fd
> 	pc-bios/efi-aarch64/QEMU_VARS.fd
> 
> ... for arm, and ...
> 
> 	pc-bios/efi-x86_64/OVMF_CODE.fd
> 	pc-bios/efi-x86_64/OVMF_VARS.fd
> 
> ... for x86.

That sounds good to me. One thing to note is that the arm/aarch64 images
have to be padded to 64MB, so I generally append ".padded" to those file
names. Would that be OK? Any better ideas?

>> Could we please decide for (1) vs (2), before I put more work into (1)?
> 
> I'd tend to prefer (1).

Thanks. I have a patch set that's almost suitable for posting as an RFC.
I should split the last patch and write some sensible commit messages.

BTW, the bundling under pc-bios is a bit larger task than it immediately
appears:

- there are many build options to consider (as you know perfectly well
  :) ),

- plus now we have the "docs/interop/firmware.json" schema too, hence
  whatever images we build for end-user consumption, should likely be
  accompanied by metafiles that conform to this schema.

I think once we introduce the "roms/edk2" submodule for the current
purpose, we could address the pc-bios binaries (+metafiles) in a
separate series, on top.

Thanks,
Laszlo
