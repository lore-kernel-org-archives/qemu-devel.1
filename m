Received: from eggs.gnu.org ([2001:4830:134:3::10]:42758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gP4tM-000832-Mr
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:12:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gP4tJ-0003ib-Is
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:12:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gP4tJ-0003hm-CG
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:12:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so1706688wrs.10
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 04:12:28 -0800 (PST)
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-2-berrange@redhat.com>
	<23c92cc5-029f-ec4c-03d0-d56045001cab@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b922d120-6303-a26e-0e08-d291b92a2329@redhat.com>
Date: Mon, 19 Nov 2018 17:29:15 +0100
MIME-Version: 1.0
In-Reply-To: <23c92cc5-029f-ec4c-03d0-d56045001cab@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/6 for-3.1] nbd: fix whitespace in server
 error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 16/11/18 17:01, Eric Blake wrote:
> On 11/16/18 9:53 AM, Daniel P. Berrangé wrote:
>> A space was missing after the option number was printed:
>>
>>    Option 0x8not permitted before TLS
>>
>> becomes
>>
>>    Option 0x8 not permitted before TLS
>>
>> This fixes
>>
>>    commit 3668328303429f3bc93ab3365c66331600b06a2d
>>    Author: Eric Blake <eblake@redhat.com>
>>    Date:   Fri Oct 14 13:33:09 2016 -0500
>>
>>      nbd: Send message along with server NBD_REP_ERR errors
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   nbd/server.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/nbd/server.c b/nbd/server.c
>> index 4e8f5ae51b..12e8139f95 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -1135,7 +1135,7 @@ static int nbd_negotiate_options(NBDClient 
>> *client, uint16_t myflags,
>>               default:
>>                   ret = nbd_opt_drop(client, NBD_REP_ERR_TLS_REQD, errp,
>> -                                   "Option 0x%" PRIx32
>> +                                   "Option 0x%" PRIx32 " "
>>                                      "not permitted before TLS", option);
> 
> Visually, I'd include the space in the next line instead of on its own 

Agreed :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> (but that's aesthetics, not semantic). Agree that this is 3.1 material; 
> I'll queue it up and send a PR on Monday.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
