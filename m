Received: from eggs.gnu.org ([2001:4830:134:3::10]:47535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZdhQ-0006qM-Q8
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:15:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZdh9-0004bH-PS
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:14:48 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZdh9-0004a1-Fu
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:14:31 -0500
Received: by mail-wm0-x229.google.com with SMTP id b65so28495503wmf.0
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 05:14:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9H8NTnHaQEUUbuC0VC4oSfPywWR3aTDzymRc+A84yfrw@mail.gmail.com>
References: <20170130064736.9236-1-ppandit@redhat.com>
	<CAFEAcA9H8NTnHaQEUUbuC0VC4oSfPywWR3aTDzymRc+A84yfrw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 13:14:09 +0000
Message-ID: <CAFEAcA_3zVuneY_6VF4RaDST1uGH5ZCNZVz5YxMJAEOPF-s6YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] sd: sdhci: check data length during
 dma_memory_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Jiang Xin <jiangxin1@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>, qemu-stable <qemu-stable@nongnu.org>

On 30 January 2017 at 10:30, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 30 January 2017 at 06:47, P J P <ppandit@redhat.com> wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> While doing multi block SDMA transfer in routine
>> 'sdhci_sdma_transfer_multi_blocks', the 's->fifo_buffer' starting
>> index 'begin' and data length 's->data_count' could end up to be same.
>> This could lead to an OOB access issue. Correct transfer data length
>> to avoid it.
>>
>> Reported-by: Jiang Xin <jiangxin1@huawei.com>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>>  hw/sd/sdhci.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>> index 01fbf22..5bd5ab6 100644
>> --- a/hw/sd/sdhci.c
>> +++ b/hw/sd/sdhci.c
>> @@ -536,7 +536,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
>>                  boundary_count -= block_size - begin;
>>              }
>>              dma_memory_read(&address_space_memory, s->sdmasysad,
>> -                            &s->fifo_buffer[begin], s->data_count);
>> +                            &s->fifo_buffer[begin], s->data_count - begin);
>>              s->sdmasysad += s->data_count - begin;
>>              if (s->data_count == block_size) {
>>                  for (n = 0; n < block_size; n++) {
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-stable@nongnu.org



Applied to target-arm.next, thanks.

-- PMM
