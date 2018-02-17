Received: from eggs.gnu.org ([2001:4830:134:3::10]:56589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1en3yi-0005V3-82
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 10:00:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1en3yb-0003qT-Pz
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 10:00:38 -0500
Received: from chuckie.co.uk ([82.165.15.123]:37356
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1en3yb-0003hg-Iw
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 10:00:33 -0500
References: <20180216173111.10270-1-dgilbert@redhat.com>
	<CAFEAcA_0PBYwP_vCTT6dOYVoEwo0XGkGc_-ah5K+JSmewDpFOg@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <6e6dbd27-205e-c8df-f735-f5f042c56733@ilande.co.uk>
Date: Sat, 17 Feb 2018 15:00:11 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_0PBYwP_vCTT6dOYVoEwo0XGkGc_-ah5K+JSmewDpFOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cuda.h: Fix multiple typedef
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16/02/18 18:38, Peter Maydell wrote:

> On 16 February 2018 at 17:31, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> RHEL6's compilers don't like the repeated typedef.
>>
>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   include/hw/misc/macio/cuda.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/misc/macio/cuda.h b/include/hw/misc/macio/cuda.h
>> index 6afbdd13ee..494b709579 100644
>> --- a/include/hw/misc/macio/cuda.h
>> +++ b/include/hw/misc/macio/cuda.h
>> @@ -93,12 +93,12 @@ typedef struct CUDAState {
>>   } CUDAState;
>>
>>   /* MOS6522 CUDA */
>> -typedef struct MOS6522CUDAState {
>> +struct MOS6522CUDAState {
>>       /*< private >*/
>>       MOS6522State parent_obj;
>>
>>       CUDAState *cuda;
>> -} MOS6522CUDAState;
>> +};
>>
>>   #define TYPE_MOS6522_CUDA "mos6522-cuda"
>>   #define MOS6522_CUDA(obj) OBJECT_CHECK(MOS6522CUDAState, (obj), \
>> --
> 
> Thanks; applied to master as a  buildfix.

Thanks both. Apologies I got caught up later than expected yesterday.


ATB,

Mark.
