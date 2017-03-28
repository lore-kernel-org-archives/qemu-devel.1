Received: from eggs.gnu.org ([2001:4830:134:3::10]:41970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cswXa-0000Bm-0n
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cswXU-0002Gb-Qe
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:12:25 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:32798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cswXU-0002GJ-NM
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:12:20 -0400
Received: by mail-qk0-x244.google.com with SMTP id p22so13754172qka.0
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 12:12:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170324231943.18768-1-Andrew.Baumann@microsoft.com>
	<bb0868d1-5c56-45e5-8b6c-ee08e77dfeaa@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <01b6e2cb-8920-64c5-d985-e67e0325c3ab@amsat.org>
Date: Tue, 28 Mar 2017 16:12:16 -0300
MIME-Version: 1.0
In-Reply-To: <bb0868d1-5c56-45e5-8b6c-ee08e77dfeaa@weilnetz.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.9?] virtio: fix vring_align() on
 64-bit windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>

Hi, I never received Andrew Baumann's mail via the ML...

On 03/28/2017 03:38 PM, Stefan Weil wrote:
> Am 25.03.2017 um 00:19 schrieb QEMU_ALIGN_UP:
>> long is 32-bits on 64-bit windows, which caused the top half of the
>> address to be truncated; this patch changes it to use the
>> QEMU_ALIGN_UP macro which does not suffer the same problem
>>
>> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>> ---
>>  include/hw/virtio/virtio.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index 15efcf2..7b6edba 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -34,7 +34,7 @@ struct VirtQueue;
>>  static inline hwaddr vring_align(hwaddr addr,
>>                                               unsigned long align)
>>  {
>> -    return (addr + align - 1) & ~(align - 1);
>> +    return QEMU_ALIGN_UP(addr, align);
>>  }
>>
>>  typedef struct VirtQueue VirtQueue;
>>
>
> Eric added "for-2.9" to the subject line of v2, but now it was
> missing again for v3.
>
> Is this needed for 2.9? I wonder why I never before noticed
> a problem or got a bug report for this issue.
>
> Regards
> Stefan
>
>
