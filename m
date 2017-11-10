Received: from eggs.gnu.org ([2001:4830:134:3::10]:59503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eD7Y2-0002ka-VU
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 06:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eD7Xx-0005ha-Hl
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 06:32:34 -0500
References: <1510341591-22817-1-git-send-email-gengdongjiu@huawei.com>
	<1510341591-22817-10-git-send-email-gengdongjiu@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3017b1b9-24d7-565b-1180-a0eb93c6d57a@redhat.com>
Date: Fri, 10 Nov 2017 12:32:02 +0100
MIME-Version: 1.0
In-Reply-To: <1510341591-22817-10-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v12 09/12] Move related hwpoison page
 function to accel/kvm/ folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>, mst@redhat.com, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, james.morse@arm.com, lersek@redhat.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, guohanjun@huawei.com, lijinyue@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, zhengqiang10@huawei.com, linuxarm@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 10/11/2017 20:19, Dongjiu Geng wrote:
> +typedef struct HWPoisonPage {
> +    ram_addr_t ram_addr;
> +    QLIST_ENTRY(HWPoisonPage) list;
> +} HWPoisonPage;
> +

Is this actually needed outside accel/kvm/kvm-all.c?

Thanks,

Paolo
