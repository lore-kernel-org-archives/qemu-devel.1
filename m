Received: from eggs.gnu.org ([2001:4830:134:3::10]:44089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g82Ks-0006eB-Nx
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g82Kq-0004BD-H0
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:02:30 -0400
References: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
	<43a03645-fa17-3274-9a66-502acc27b2ee@redhat.com>
	<20181004131150.3de8174a@redhat.com>
	<b673ca5c-f38e-b4a5-7abd-debfa8382e22@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3ee4a49b-77fa-da05-262a-ab75ef1ade84@redhat.com>
Date: Thu, 4 Oct 2018 14:02:13 +0200
MIME-Version: 1.0
In-Reply-To: <b673ca5c-f38e-b4a5-7abd-debfa8382e22@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 00/15] ARM virt: PCDIMM/NVDIMM at 2TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, wei@redhat.com, drjones@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, agraf@suse.de, Laszlo Ersek <lersek@redhat.com>, david@gibson.dropbear.id.au

>>> Alternative to have a split model is having a floating RAM base for a
>>> contiguous initial + device memory (contiguity actually depends on
>>> initial RAM size alignment too). This requires significant changes in FW
>>> and also potentially impacts the legacy virt address map as we need to
>>> pass the RAM floating base address in some way (using an SRAM at 1GB) or
>>> using fw_cfg. Is it worth the effort? Also, Peter/Laszlo mentioned their
>>> reluctance to move the RAM earlier
>> Drew is working on it, lets see outcome first.
>>
>> We actually may try implement single region that uses pc-dimm for
>> all memory (including initial) and be still compatible with legacy layout
>> as far as legacy mode sticks to the current RAM limit and device memory
>> region is put at the current RAM base.
>> When flexible RAM base is available, we will move that region to
>> non legacy layout at 2TB (or wherever).
> 
> Oh I did not understand you wanted to also replace the initial memory by
> device memory. So we would switch from a pure static initial RAM setup
> to a pure dynamic device memory setup. Looks quite drastic a change to
> me. As mentionned I am concerned about complexifying the qemu cmd line
> and I asked livirt guys about the induced pain.

One idea was to create internal memory devices (e.g. "memory chip") that
get created and placed automatically in guest physical address space.
These devices would not require a change on the cmdline, they would be
created automatically from the existing parameters.

The machine device memory region would than be one big region for both,
internal memory devices and external ("plugged") memory devices a.k.a.
dimms.

I guess that will require more work to be done.

> 
> Thank you for your feedbacks
> 
> Eric


-- 

Thanks,

David / dhildenb
