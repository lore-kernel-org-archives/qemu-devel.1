Received: from eggs.gnu.org ([2001:4830:134:3::10]:49172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eAUjt-0001jb-FT
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 01:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eAUjq-0007ko-Cy
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 01:41:57 -0400
References: <20171101154204.27146-1-vsementsov@virtuozzo.com>
	<9b3661dd-0ace-9040-e8ae-1983b3f63e3d@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cf2b2dee-419b-ec7b-12e7-342e694b1893@virtuozzo.com>
Date: Fri, 3 Nov 2017 08:41:46 +0300
MIME-Version: 1.0
In-Reply-To: <9b3661dd-0ace-9040-e8ae-1983b3f63e3d@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] nbd/server: fix
 nbd_negotiate_handle_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: den@openvz.org

02.11.2017 20:54, Eric Blake wrote:
> On 11/01/2017 10:42 AM, Vladimir Sementsov-Ogievskiy wrote:
>
> It's best to send a 0/2 cover letter for a series, even when both
> patches are small, as that helps automation tools.

ok.

>
>> namelen should be here, lenght is unrelated.
> s/lenght/length/

my eternal problem...

>
> Broken in introduction in commit f37708f6; hence adding qemu-stable in cc.
>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   nbd/server.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>> diff --git a/nbd/server.c b/nbd/server.c
>> index 70b40ed27e..7fcec0af7e 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -433,7 +433,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
>>   
>>       /* Don't bother sending NBD_INFO_NAME unless client requested it */
>>       if (sendname) {
>> -        rc = nbd_negotiate_send_info(client, opt, NBD_INFO_NAME, length, name,
>> +        rc = nbd_negotiate_send_info(client, opt, NBD_INFO_NAME, namelen, name,
> Interestingly enough, length == 0 at this point, so we would always
> report that the export name is '' (aka the default export), without
> actually being a protocol violation.  Doesn't hurt qemu as a client,
> since we don't ask for NBD_INFO_NAME, but may break other NBD client
> implementations, if they then use NBD_OPT_GO on the '' name expecting it
> to resolve to the same non-empty name they just queried on NBD_OPT_INFO.
>


-- 
Best regards,
Vladimir
