Received: from eggs.gnu.org ([2001:4830:134:3::10]:56721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVd8U-0005IP-6C
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVd8T-0005HW-Cp
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:26:58 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:34250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVd8T-0005HL-8P
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:26:57 -0400
Received: by mail-ot0-x244.google.com with SMTP id r18-v6so3705938otk.1
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 06:26:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619075821.9884-1-zhengxiang9@huawei.com>
References: <20180619075821.9884-1-zhengxiang9@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 14:26:36 +0100
Message-ID: <CAFEAcA_uWp-M804PSZb8=rDMBz6ci=_j-NC_f=-q-=F7N7FXaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target-arm: fix a segmentation fault due
 to illegal memory access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zheng Xiang <zhengxiang9@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Zheng Xiang <xiang.zheng@linaro.org>

On 19 June 2018 at 08:58, Zheng Xiang <zhengxiang9@huawei.com> wrote:
> From: Zheng Xiang <xiang.zheng@linaro.org>
>
> The elements of kvm_devices_head list are freed in kvm_arm_machine_init_done(),
> but we still access these illegal memory in kvm_arm_devlistener_del().
>
> This will cause segment fault when booting guest with MALLOC_PERTURB_=1.
>
> Signed-off-by: Zheng Xiang <xiang.zheng@linaro.org>
> ---
>  target/arm/kvm.c | 1 +
>  1 file changed, 1 insertion(+)



Applied to target-arm.next, thanks.

-- PMM
