Received: from eggs.gnu.org ([209.51.188.92]:55241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hBLlt-0000Dt-Ih
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hBLlr-0006n0-HZ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:56:21 -0400
From: Laszlo Ersek <lersek@redhat.com>
References: <20190321104745.28068-1-shameerali.kolothum.thodi@huawei.com>
	<20190321104745.28068-8-shameerali.kolothum.thodi@huawei.com>
	<98c7f0fd-8446-8897-0808-e7615af29670@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA83933836A@lhreml524-mbs.china.huawei.com>
	<0dcd3f3c-15c4-318f-28bd-4b6706708c0d@redhat.com>
	<CAKv+Gu_-nRqeCT0s6ZwW+q3=sbGmtazFJ9R=19U5SJ=gSUmJLw@mail.gmail.com>
	<a2c37d40-e2ee-e7aa-3f34-ab39a9a6449d@redhat.com>
	<459862f9-18f7-0a37-dfb9-b8ca9aa6a2d2@redhat.com>
	<20190402094257.218aa0e5@redhat.com>
	<9b776e3b-7b1b-239d-bc36-6bbd78f8b67e@redhat.com>
	<fed34443-e5b0-41be-21ab-323fb7137163@redhat.com>
	<91a906c2-ef90-3aec-2b2c-fbb63c41f7c2@redhat.com>
Message-ID: <59dfd9cd-3762-cbb6-0823-e1247ec5fcd7@redhat.com>
Date: Tue, 2 Apr 2019 17:56:00 +0200
MIME-Version: 1.0
In-Reply-To: <91a906c2-ef90-3aec-2b2c-fbb63c41f7c2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/10] hw/arm/virt: Introduce opt-in
 feature "fdt"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Linuxarm <linuxarm@huawei.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei (O)" <xuwei5@huawei.com>, "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>, Leif Lindholm <Leif.Lindholm@arm.com>

On 04/02/19 17:52, Laszlo Ersek wrote:
> On 04/02/19 17:42, Auger Eric wrote:

>>>>> The firmware does consume DT:
>>>>>
>>>>> - If you start QEMU *with* "-no-acpi", then the DT is both consumed by
>>>>> the firmware (for its own information needs), and passed on to the OS.
>>>>>
>>>>> - If you start QEMU *without* "-no-acpi" (the default), then the DT is
>>>>> consumed only by the firmware (for its own information needs), and the
>>>>> DT is hidden from the OS. The OS gets only the ACPI content
>>>>> (processed/prepared as described above).
> 
>> I am confused by the above statement actually. In the above case what
>> does happen if you pass the acpi=off in the kernel boot parameters?
> 
> If you launch QEMU with "-no-acpi" and you pass "acpi=off" to the guest
> kernel, then the kernel will not boot successfully, as it will not get
> DT from the firmware, and it will ignore the ACPI tables that it does
> get from the firmware.

Sorry, I ended up answering "what happens when you run QEMU *without*
-no-acpi and pass acpi=off to the guest kernel".

To explain what happens when you boot *with* -no-acpi: in that case,
"acpi=off" doesn't matter, since the guest kernel doesn't get ACPI
tables anyway. The kernel will go for DT.

Thanks
Laszlo
