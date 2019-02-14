Received: from eggs.gnu.org ([209.51.188.92]:54888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDKG-0001pS-Jz
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDDy-0007Ii-Mc
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:22:31 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:45997)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1guDDw-00077V-U0
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:22:29 -0500
From: Laurent Vivier <laurent@vivier.eu>
References: <20190208173520.15007-1-remi@remlab.net>
	<b7f75e48-e710-46fc-a420-8cba0d663542@vivier.eu>
Message-ID: <ddd021dc-7760-6d38-729e-d7ae534549d3@vivier.eu>
Date: Thu, 14 Feb 2019 10:22:07 +0100
MIME-Version: 1.0
In-Reply-To: <b7f75e48-e710-46fc-a420-8cba0d663542@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: check valid address in
 access_ok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?R=c3=a9mi_Denis-Courmont?= <remi@remlab.net>, qemu-devel@nongnu.org
Cc: remi.denis.courmont@huawei.com

On 08/02/2019 19:33, Laurent Vivier wrote:
> On 08/02/2019 18:35, Rémi Denis-Courmont wrote:
>> This works around the LTP crash, but there are problably better ways to
>> go about it.
>>
>> Signed-off-by: Rémi Denis-Courmont <remi@remlab.net>
>> Cc: <lvivier@redhat.com>
>> ---
>>  linux-user/qemu.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
>> index ef400cb78a..1d222a0cce 100644
>> --- a/linux-user/qemu.h
>> +++ b/linux-user/qemu.h
>> @@ -457,7 +457,8 @@ extern unsigned long guest_stack_size;
>>  
>>  static inline int access_ok(int type, abi_ulong addr, abi_ulong size)
>>  {
>> -    return page_check_range((target_ulong)addr, size,
>> +    return guest_addr_valid(addr) && guest_addr_valid(addr + size) &&
> 
> I think it should be guest_addr_valid(addr + size - 1).

In fact (len == 0 || guest_addr_valid(addr + size - 1)).

Could you send a new version of your patch?

I've received several mail delivery system errors regarding your email
address remi@remlab.net.

Thanks,
Laurent
