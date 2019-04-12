Received: from eggs.gnu.org ([209.51.188.92]:39690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hElOG-0001Jl-Hw
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 21:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hElOF-0004uA-Ns
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 21:54:04 -0400
References: <87imw5fv45.fsf@dusky.pond.sub.org>
	<abe1d9cd-85bb-2ef8-630f-af28cae6378c@redhat.com>
	<8736n9eb4s.fsf@dusky.pond.sub.org>
	<bf2decd3-b3cb-08eb-3449-b66f023b084a@huawei.com>
	<c57135ae-41a9-ed7b-976b-bf8fe43596a2@redhat.com>
	<b107e0c0-1c4c-3f0f-eb78-8929c315ce28@huawei.com>
	<a8144a1f-364e-cea5-b0a7-05342bdab936@redhat.com>
	<87bm1fiuo8.fsf@dusky.pond.sub.org>
	<20190409082852.GB6610@localhost.localdomain>
	<c03c51a7-1bb0-b05b-9027-2364ab00517c@huawei.com>
	<20190411122246.GB5694@linux.fritz.box>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <0c6c32b7-46f8-cf80-b7a6-1b48995b84e4@huawei.com>
Date: Fri, 12 Apr 2019 09:52:44 +0800
MIME-Version: 1.0
In-Reply-To: <20190411122246.GB5694@linux.fritz.box>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] hw/arm/virt: use variable size of
 flash device to save memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 2019/4/11 20:22, Kevin Wolf wrote:
> Okay, so your problem is that blk_pread() writes to the whole buffer,
> writing explicit zeroes for unallocated parts of the image, while you
> would like to leave those parts of the buffer untouched so that we don't
> actually allocate the memory, but can just use the shared zero page.
> 
> If you just want to read the non-zero parts of the image, that can be
> done by using a loop that calls bdrv_block_status() and only reads from
> the image if the BDRV_BLOCK_ZERO bit is clear.
> 
> Would this solve your problem?

Sounds good! What if guest tried to read/write the zero parts?

-- 

Thanks,
Xiang
