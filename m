Received: from eggs.gnu.org ([2001:4830:134:3::10]:34639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <max7255@yandex-team.ru>) id 1gHUZT-0004CY-Q3
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <max7255@yandex-team.ru>) id 1gHUZM-00031p-9k
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:00:39 -0400
Received: from forwardcorp1o.cmail.yandex.net ([2a02:6b8:0:1a72::290]:35007)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <max7255@yandex-team.ru>)
	id 1gHUZL-0002wG-Lk
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:00:32 -0400
References: <1540512223-21199-1-git-send-email-max7255@yandex-team.ru>
	<1540512223-21199-5-git-send-email-max7255@yandex-team.ru>
	<ba3b8e2d-8d3a-b738-3d87-d56def3ab1e3@redhat.com>
From: Maxim Samoylov <max7255@yandex-team.ru>
Message-ID: <f16cf85c-61ee-ed2a-f089-050fb32607aa@yandex-team.ru>
Date: Tue, 30 Oct 2018 17:00:26 +0300
MIME-Version: 1.0
In-Reply-To: <ba3b8e2d-8d3a-b738-3d87-d56def3ab1e3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 4/4] net/slirp: add ipv6-hostfwd option
 for user netdev type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>



On 26.10.2018 09:14, Thomas Huth wrote:
> On 2018-10-26 01:03, Maxim Samoylov wrote:
>> This allows forwarding TCP6 and UDP6 connections down to
>> netdev=user connected guests.
>>
>> Signed-off-by: Maxim Samoylov <max7255@yandex-team.ru>
>> ---
>>   hmp-commands.hx     |  31 ++++++++
>>   include/net/slirp.h |   2 +
>>   net/slirp.c         | 214 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   qapi/net.json       |   3 +-
>>   4 files changed, 249 insertions(+), 1 deletion(-)
>>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index db0c681..b0e1a08 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -1448,6 +1448,37 @@ STEXI
>>   Remove host-to-guest TCP or UDP redirection.
>>   ETEXI
>>   
>> +#ifdef CONFIG_SLIRP
>> +    {
>> +        .name       = "ipv6_hostfwd_add",
>> +        .args_type  = "arg1:s,arg2:s?,arg3:s?",
>> +        .params     = "[hub_id name]|[netdev_id] [tcp|udp]:[hostaddr6]:hostport-guestaddr6:guestport",
>> +        .help       = "redirect TCP6 or UDP6 connections from host to guest (requires -net user)",
>> +        .cmd        = hmp_ipv6_hostfwd_add,
>> +    },
>> +#endif
>> +STEXI
>> +@item hostfwd_add
>> +@findex hostfwd_add
>> +Redirect TCP6 or UDP6 connections from host to guest (requires -net user).
>> +ETEXI
>> +
>> +#ifdef CONFIG_SLIRP
>> +    {
>> +        .name       = "ipv6_hostfwd_remove",
>> +        .args_type  = "arg1:s,arg2:s?,arg3:s?",
>> +        .params     = "[hub_id name]|[netdev_id] [tcp|udp]:[hostaddr6]:hostport",
>> +        .help       = "remove host-to-guest TCP6 or UDP6 redirection",
>> +        .cmd        = hmp_ipv6_hostfwd_remove,
>> +    },
> 
>   Hi,
> 
> could you please remove the "[hub_id name]" touple here? I recently sent
> a patch to deprecate it for the IPv4 version, too:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03198.html
> 

Ok

> Also I think it would make sense if you mention in the help text that
> IPv6 addresses have to be given with square brackets?
> 
>   Thanks,
>    Thomas
>

Sure, missed that thing.

---
Maxim Samoylov, max7255@yandex-team.ru
