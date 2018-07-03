Received: from eggs.gnu.org ([2001:4830:134:3::10]:35351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNP5-0004Ji-9U
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNP1-00089K-0L
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:39:43 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:44070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNP0-000896-RO
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:39:38 -0400
Received: by mail-qk0-x242.google.com with SMTP id i188-v6so1214980qkc.11
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 08:39:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180702175030.18621-1-f4bug@amsat.org>
	<20180702175030.18621-2-f4bug@amsat.org>
	<2e367d67-77f4-8d58-53de-409c0b0bf558@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e0ac6484-0f62-66e0-c7b8-fab9775fbc0f@amsat.org>
Date: Tue, 3 Jul 2018 12:39:33 -0300
MIME-Version: 1.0
In-Reply-To: <2e367d67-77f4-8d58-53de-409c0b0bf558@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 01/13] linux-user/syscall: Verify
 recvfrom(addr) is user-writable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>

On 07/03/2018 11:55 AM, Laurent Vivier wrote:
> Le 02/07/2018 à 19:50, Philippe Mathieu-Daudé a écrit :
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Tested-By: Guido Günther <agx@sigxcpu.org>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  linux-user/syscall.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 2117fb13b4..ad40682cee 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -4154,6 +4154,11 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
>>              ret = -TARGET_EINVAL;
>>              goto fail;
>>          }
>> +        if (!access_ok(VERIFY_WRITE, target_addr, addrlen)) {
>> +            ret = -TARGET_EFAULT;
>> +            goto fail;
>> +        }
>> +
>>          addr = alloca(addrlen);
>>          ret = get_errno(safe_recvfrom(fd, host_msg, len, flags,
>>                                        addr, &addrlen));
>>
> 
> This patch breaks the test recvfrom01 of the Linux Test Project.

OK :(

I just sent v4, can you simply drop this patch?
I'll now look at it after 3.0.

Thanks,

Phil.
