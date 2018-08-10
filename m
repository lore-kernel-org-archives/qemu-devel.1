Received: from eggs.gnu.org ([2001:4830:134:3::10]:33283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fo3yx-0001af-9M
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fo3ys-0001KQ-3n
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:45:19 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:33790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fo3yr-0001Hr-TM
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:45:14 -0400
Received: by mail-ed1-x543.google.com with SMTP id x5-v6so4489832edr.0
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 02:45:13 -0700 (PDT)
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-30-e.emanuelegiuseppe@gmail.com>
	<f1bdb55c-9787-f9cb-6da8-c74d192d3c3e@redhat.com>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <9ac51ed7-b93b-0b0d-2925-e1f570c10cde@gmail.com>
Date: Fri, 10 Aug 2018 11:45:10 +0200
MIME-Version: 1.0
In-Reply-To: <f1bdb55c-9787-f9cb-6da8-c74d192d3c3e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 29/34] test/qgraph: virtio-blk test node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 08/09/2018 04:16 PM, Laurent Vivier wrote:
> On 06/08/2018 16:34, Emanuele Giuseppe Esposito wrote:
>> -static void mmio_basic(void)
>> +static void basic_resize(void *obj, void *data, QGuestAllocator *t_alloc)
>>   {
>> -    QVirtioMMIODevice *dev;
>> -    QVirtQueue *vq;
>> -    QGuestAllocator *alloc;
>> +    QVirtioBlk *blk_if = obj;
>> +    QVirtioDevice *dev = blk_if->vdev;
>>       int n_size = TEST_IMAGE_SIZE / 2;
>>       uint64_t capacity;
>> +    QVirtQueue *vq;
>>   
>> -    arm_test_start();
>> -
>> -    dev = qvirtio_mmio_device_new(MMIO_DEV_BASE_ADDR, MMIO_PAGE_SIZE);
> This is the only user of qvirtio_mmio_device_new(), so if you remove the
> call here, you could also remove the function definition.
So you suggest to get rid completely of qvirtio_mmio_device_new() in 
virtio-mmio.c  ?
Couldn't it be useful in future maybe?

Emanuele
