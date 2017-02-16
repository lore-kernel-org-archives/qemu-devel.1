Received: from eggs.gnu.org ([2001:4830:134:3::10]:38589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceKdw-0000kP-VD
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 06:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceKdw-0001NJ-62
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 06:54:37 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:38894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceKdv-0001Mt-W2
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 06:54:36 -0500
Received: by mail-wm0-x22f.google.com with SMTP id r141so13225480wmg.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 03:54:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CALicx6u=i0ukrbQiiVTq4gFKM_Har925UdRrpmJuErk-U5o58Q@mail.gmail.com>
References: <1485879782-6075-1-git-send-email-vijay.kilari@gmail.com>
	<1485879782-6075-6-git-send-email-vijay.kilari@gmail.com>
	<CAFEAcA-7PE_T7BsV=vSCEkQDeekB9KnX33Ou5NiUec4XeUu+zw@mail.gmail.com>
	<CALicx6vWBR_bM2g_DObYgw-12girdK9YgGS8X=zAwenz2EmPFg@mail.gmail.com>
	<CAFEAcA9aQwJiwsMSgvPs=vj+qfrFbVVv6-AuhFVsEKX_xO7J2Q@mail.gmail.com>
	<CALicx6u=i0ukrbQiiVTq4gFKM_Har925UdRrpmJuErk-U5o58Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 11:54:14 +0000
Message-ID: <CAFEAcA_m30zGGDeUPT98rMtTp00kS2qyv33vp9wYBb_+f7YEiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v7 RESEND 5/5] hw/intc/arm_gicv3_kvm: Reset
 GICv3 cpu interface registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vijay Kilari <vijay.kilari@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, Eric Auger <eric.auger@redhat.com>, Pavel Fedin <p.fedin@samsung.com>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

On 16 February 2017 at 11:28, Vijay Kilari <vijay.kilari@gmail.com> wrote:
> On Thu, Feb 16, 2017 at 3:39 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 16 February 2017 at 09:54, Vijay Kilari <vijay.kilari@gmail.com> wrote:
>>> On Tue, Feb 7, 2017 at 8:19 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>> If you want to do nothing in a read/write function there are
>>>> already arm_cp_read_zero and arm_cp_write_ignore functions for
>>>> this. But using the ARM_CP_NOP flag is better still.
>>>
>>> With ARM_CP_NOP qemu fails to boot.
>>> qemu-system-aarch64: KVM_SET_DEVICE_ATTR failed: Invalid argument
>>> Group 6 attr 0x000000000000c665
>>
>> Not clear to me why using ARM_CP_NOP should result in a KVM
>> call failure -- can you dig further into why that is happening?
>
> if ARM_CP_NOP is set, .reset function is not called and there by KVM fails
> when SRE_EL1 is written with 0x0.

OK. Use the arm_cp_read_zero/arm_cp_write_ignore functions, and
add a comment that we don't use CP_NOP because that means our
reset function isn't called.

thanks
-- PMM
