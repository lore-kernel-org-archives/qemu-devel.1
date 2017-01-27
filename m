Received: from eggs.gnu.org ([2001:4830:134:3::10]:53381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX88e-0007vO-7b
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX88V-00064h-V1
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:08:32 -0500
Received: from mail-vk0-x229.google.com ([2607:f8b0:400c:c05::229]:34127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX88V-00064O-Qy
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:08:23 -0500
Received: by mail-vk0-x229.google.com with SMTP id r136so177115795vke.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 07:08:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170127120528.30959-1-ppandit@redhat.com>
References: <20170127120528.30959-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 15:08:02 +0000
Message-ID: <CAFEAcA-2eZdd6jwQtAOYx0rmLzSzgcLBu8p7YUawtJg4hH-U3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] dma: omap: check dma channel data_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Jiang Xin <jiangxin1@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 27 January 2017 at 12:05, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> When setting dma channel 'data_type', if (value & 3) == 3,
> the set 'data_type' is said to be bad. This also leads to an
> OOB access in 'omap_dma_transfer_generic', while doing
> cpu_physical_memory_r/w operations. Add check to avoid it.
>
> Reported-by: Jiang Xin <jiangxin1@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

The data sheet just says the behaviour with value == 3
is "undefined", so I guess this is as good a way as
any other to handle it.

Applied to target-arm.next, thanks.

-- PMM
