Received: from eggs.gnu.org ([2001:4830:134:3::10]:39867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gxt@mprc.pku.edu.cn>) id 1ctmPB-0002K6-MC
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 22:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gxt@mprc.pku.edu.cn>) id 1ctmPA-0003Pi-Hy
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 22:35:13 -0400
Received: from [2001:da8:201:1203:21a:92ff:fef0:87aa] (port=46483
	helo=mprc.pku.edu.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gxt@mprc.pku.edu.cn>) id 1ctmPA-0003I7-0v
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 22:35:12 -0400
Message-ID: <63185.203.187.182.140.1490924822.squirrel@mprc.pku.edu.cn>
In-Reply-To: <0a3e3590-a641-8ad2-4404-6fc93a19f1ff@redhat.com>
References: <20170330165008.26419-1-shah.suramya@gmail.com>
	<0a3e3590-a641-8ad2-4404-6fc93a19f1ff@redhat.com>
Date: Fri, 31 Mar 2017 09:47:02 +0800 (CST)
From: "Xuetao Guan" <gxt@mprc.pku.edu.cn>
Reply-To: gxt@mprc.pku.edu.cn
MIME-Version: 1.0
Content-Type: text/plain;charset=gb2312
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5] hw/unicore32: remove wrong assertion in
 puv machine init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Suramya Shah <shah.suramya@gmail.com>, qemu-devel@nongnu.org, gxt@mprc.pku.edu.cn

> On 03/30/2017 07:50 PM, Suramya Shah wrote:
>> Running QEMU with qemu-system-unicore32 without the kernel parameter
>> results in an assertion error.
>> Assert should not be used to check user provided parameters. Report an
>> error and exit instead
>> Signed-off-by: Suramya Shah <shah.suramya@gmail.com>

Thanks Suramya
Acked-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

>> ---
>>  hw/unicore32/puv3.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
>> index 032078f..2c17cc9 100644
>> --- a/hw/unicore32/puv3.c
>> +++ b/hw/unicore32/puv3.c
>> @@ -93,8 +93,11 @@ static void puv3_load_kernel(const char
>> *kernel_filename)
>>      if (kernel_filename == NULL && qtest_enabled()) {
>>          return;
>>      }
>> -    assert(kernel_filename != NULL);
>> -
>> +    if (kernel_filename == NULL) {
>> +        error_report("No kernel found");
>> +        exit(1);
>> +    }
>> +
>>      /* only zImage format supported */
>>      size = load_image_targphys(kernel_filename, KERNEL_LOAD_ADDR,
>>              KERNEL_MAX_SIZE);
>>
>
> Hi,
>
> The patch looks good to me.
>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
>
> Thanks,
> Marcel
>
