Received: from eggs.gnu.org ([2001:4830:134:3::10]:43748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBenn-0000w5-Qb
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBenn-0005QA-2H
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:38:47 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:51048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eBenm-0005PN-RO
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:38:46 -0500
Received: by mail-wm0-x242.google.com with SMTP id s66so12652561wmf.5
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 02:38:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a381c1f7-b695-8126-982f-610f60a1b992@redhat.com>
References: <1509712671-16299-1-git-send-email-shankerd@codeaurora.org>
	<a381c1f7-b695-8126-982f-610f60a1b992@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Nov 2017 10:38:24 +0000
Message-ID: <CAFEAcA_Jc6YiNyZuAcBtMSfWaw5-o6oSem908xEh5ZhFb8Zr_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/intc/arm_gicv3_its: Fix the VM
 termination in vm_change_state_handler()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Shanker Donthineni <shankerd@codeaurora.org>, qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

On 6 November 2017 at 07:30, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Shanker,
>
> On 03/11/2017 13:37, Shanker Donthineni wrote:
>> The commit cddafd8f353d ("hw/intc/arm_gicv3_its: Implement state save
>> /restore") breaks the backward compatibility with the older kernels
>> where vITS save/restore support is not available. The vmstate function
>> vm_change_state_handler() should not be registered if the running kernel
>> doesn't support ITS save/restore feature. Otherwise VM instance will be
>> killed whenever vmstate callback function is invoked.
>>
>> Observed a virtual machine shutdown with QEMU-2.10+linux-4.11 when testing
>> the reboot command "virsh reboot <domain> --mode acpi" instead of reboot.
>>
>> KVM Error: 'KVM_SET_DEVICE_ATTR failed: Group 4 attr 0x00000000000001'
>>
>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>



Applied to target-arm.next, thanks.

-- PMM
