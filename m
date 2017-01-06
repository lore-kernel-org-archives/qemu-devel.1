Received: from eggs.gnu.org ([2001:4830:134:3::10]:58772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPXeS-00016L-Ey
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPXeR-0003qt-HI
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:46:00 -0500
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e]:36856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPXeR-0003qk-D2
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:45:59 -0500
Received: by mail-ua0-x22e.google.com with SMTP id 88so405386744uaq.3
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 08:45:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170102200153.28864-1-drjones@redhat.com>
References: <20170102200153.28864-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 16:45:38 +0000
Message-ID: <CAFEAcA_Qu=DU0HT=8FqZscKPp6Z3t6nRX7TfvLyXj-8ToLx10A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 00/16] Remove VirtGuestInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Shannon Zhao <shannon.zhao@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 2 January 2017 at 20:01, Andrew Jones <drjones@redhat.com> wrote:
> v2:
>  - all Igor's suggestions
>  - added four mach-virt acpi cleanup patches
>  - added the remaining two acpi patches needed to bring equivalence
>    to Peter's DT changes
>
> This series is based on Peter's qemu-arm gicv3-virt branch. It's
> main goal (patches 07-13), which was suggested by Eduardo, is to
> remove an unnecessary structure, VirtGuestInfo, which is a
> maintenance burden, as it requires duplicating Virt machine state.
> Additionally patches 05-06 do some mach-virt cleanups and patches
> 14-16 add the ACPI equivalents of the DT patches in Peter's
> gicv3-virt branch. The first four patches are cleanups to mach-virt's
> acpi code.
>
> Patches available here
> https://github.com/rhdrjones/qemu/commits/virt/remove-guest-info-v2

Thanks. Apart from the last 2 patches which depend on the gicv3-virt
changes, I think this is all OK to go in now.

Since the gicv3-virt code still needs a respin (I haven't looked at
the failure to boot smp secondaries into EL2 yet), I have taken the
first 3 patches from gicv3-virt and put them into target-arm.next:
 hw/arm/virt: Merge VirtBoardInfo and VirtMachineState
 hw/arm/virt: Rename 'vbi' variables to 'vms'
 hw/arm/virt: Don't incorrectly claim architectural timer to be edge-triggered

and then rebased patches 1-14 from this series on top of that, and
applied all that to target-arm.next.

I'll put patches 15 and 16 into my gicv3-virt branch for when I
send out v2 of that.

thanks
-- PMM
