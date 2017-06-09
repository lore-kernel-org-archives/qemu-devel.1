Received: from eggs.gnu.org ([2001:4830:134:3::10]:42049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1dJ8k6-00028i-Dt
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 21:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1dJ8k5-0002QV-OG
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 21:29:38 -0400
Message-ID: <5939F9B2.5050708@huawei.com>
Date: Fri, 9 Jun 2017 09:28:18 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <1492173995-14140-1-git-send-email-eric.auger@redhat.com>
	<1492173995-14140-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1492173995-14140-3-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v5 2/4] hw/intc/arm_gicv3_its: Implement
 state save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: drjones@redhat.com, vijay.kilari@gmail.com, quintela@redhat.com, dgilbert@redhat.com, Vijaya.Kumar@cavium.com, christoffer.dall@linaro.org



On 2017/4/14 20:46, Eric Auger wrote:
[...]
> @@ -43,6 +50,7 @@ struct GICv3ITSState {
>  
>      /* Registers */
>      uint32_t ctlr;
> +    uint32_t iidr;
I think this should reset in gicv3_its_common_reset

Thanks,
-- 
Shannon
