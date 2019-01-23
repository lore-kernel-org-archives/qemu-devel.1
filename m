Received: from eggs.gnu.org ([209.51.188.92]:49378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gm6rr-0004Yr-9e
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 19:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gm6dE-0000Tj-NA
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 19:43:05 -0500
References: <20190120143452.21683-1-stefanha@redhat.com>
	<20190120143452.21683-2-stefanha@redhat.com>
	<CAFEAcA9KkYC7MHquASjoghuDrvkkE_brnM6teLknj1H-waM_0A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6970b4c-891a-3885-f92c-e0d7eb4a389a@redhat.com>
Date: Wed, 23 Jan 2019 01:34:47 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9KkYC7MHquASjoghuDrvkkE_brnM6teLknj1H-waM_0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] memory: add
 memory_region_flush_rom_device()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>

On 22/01/19 17:36, Peter Maydell wrote:
>> +void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwaddr size)
>> +{
>> +    /* In principle this function would work on other memory region types too,
>> +     * but the ROM device use case is the only one where this operation is
>> +     * necessary.  Other memory regions should use the
>> +     * address_space_read/write() APIs.
>> +     */
>> +    assert(memory_region_is_romd(mr));
>> +
>> +    invalidate_and_set_dirty(mr, addr, size);
>> +}
>> +
>>  static int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
>>  {
>>      unsigned access_size_max = mr->ops->valid.max_access_size;
> API and implementation make sense to me, but better that Paolo reviews
> this I think. I guess we should add calls to this to the pflash device
> models too...

Yes, I agree.   The implementation makes sense, though maybe we could
just rename invalidate_and_set_dirty to
memory_region_invalidate_and_set_dirty.  Whatever you guys prefer.

Paolo
