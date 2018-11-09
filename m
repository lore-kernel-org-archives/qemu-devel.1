Received: from eggs.gnu.org ([2001:4830:134:3::10]:59380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gKwqP-0006BY-0C
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 21:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gKwqK-00085J-MY
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 21:48:24 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:19049
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gKwqK-00083C-8w
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 21:48:20 -0500
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-3-git-send-email-lizhijian@cn.fujitsu.com>
	<CAFEAcA8XBa2BSfWkSMyd-iQO_=RRcZ1atpUS3QnnoSoLHERkqg@mail.gmail.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <1b6aff40-2d5a-c64d-32cc-033720c129b0@cn.fujitsu.com>
Date: Fri, 9 Nov 2018 10:48:16 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8XBa2BSfWkSMyd-iQO_=RRcZ1atpUS3QnnoSoLHERkqg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 2/3] change size type from int to
 int64_t on load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Philip Li <philip.li@intel.com>, zhijianx.li@intel.com


On 11/08/2018 07:04 PM, Peter Maydell wrote:
> On 8 November 2018 at 10:59, Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>> allow load_image to load >= 2G file
>>
>> CC: Philip Li <philip.li@intel.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> ---
>>   hw/core/loader.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>> index aa0b3fc..8fbc4bd 100644
>> --- a/hw/core/loader.c
>> +++ b/hw/core/loader.c
>> @@ -77,7 +77,8 @@ int64_t get_image_size(const char *filename)
>>   /* deprecated, because caller does not specify buffer size! */
>>   int load_image(const char *filename, uint8_t *addr)
>>   {
>> -    int fd, size;
>> +    int fd;
>> +    int64_t size;
>>       fd = open(filename, O_RDONLY | O_BINARY);
>>       if (fd < 0)
>>           return -1;
> This function returns "size", so changing the type of "size"
> without also changing its return type looks wrong.
>
> load_image_size() uses ssize_t here, which may be what we want.

will change to ssize_t at next version

Thanks
Zhijian

>
> thanks
> -- PMM
>
>
>
