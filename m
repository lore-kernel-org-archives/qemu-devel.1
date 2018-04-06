Received: from eggs.gnu.org ([2001:4830:134:3::10]:47284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Christian.Koenig@amd.com>) id 1f4QQS-0006a9-Hz
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Christian.Koenig@amd.com>) id 1f4QQP-0006WQ-Dq
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:25:04 -0400
Received: from mail-sn1nam02on0079.outbound.protection.outlook.com
	([104.47.36.79]:49856
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Christian.Koenig@amd.com>)
	id 1f4QQO-0006VW-MS
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:25:01 -0400
References: <20180316074650.5415-1-kraxel@redhat.com>
	<7547e99b-0e3c-264e-e52b-40ad5d52b49a@gmail.com>
	<20180406093307.s7wkhpmddd5d4r7a@sirius.home.kraxel.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5d88baad-a956-6bd5-e0d6-aabae6647f3e@amd.com>
Date: Fri, 6 Apr 2018 14:24:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180406093307.s7wkhpmddd5d4r7a@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2] Add udmabuf misc device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, qemu-devel@nongnu.org, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>

Am 06.04.2018 um 11:33 schrieb Gerd Hoffmann:
>    Hi,
>
>> The pages backing a DMA-buf are not allowed to move (at least not without a
>> patch set I'm currently working on), but for certain MM operations to work
>> correctly you must be able to modify the page tables entries and move the
>> pages backing them around.
>>
>> For example try to use fork() with some copy on write pages with this
>> approach. You will find that you have only two options to correctly handle
>> this.
> The fork() issue should go away with shared memory pages (no cow).
> I guess this is the reason why vgem is internally backed by shmem.

Yes, exactly that is also an approach which should work fine. Just don't 
try to get this working with get_user_pages().

>
> Hmm.  So I could try to limit the udmabuf driver to shmem too (i.e.
> have the ioctl take a shmem filehandle and offset instead of a virtual
> address).
>
> But maybe it is better then to just extend vgem, i.e. add support to
> create gem objects from existing shmem.
>
> Comments?

Yes, extending vgem instead of creating something new sounds like a good 
idea to me as well.

Regards,
Christian.

>
> cheers,
>    Gerd
>
