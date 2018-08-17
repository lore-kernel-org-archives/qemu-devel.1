Received: from eggs.gnu.org ([2001:4830:134:3::10]:34287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqgz7-0001ph-Uj
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqgz6-0006wb-Ki
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:48:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57636 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqgz6-0006wO-G4
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:48:20 -0400
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9f38a734-6358-56b5-5b0f-7e92900be30b@redhat.com>
Date: Fri, 17 Aug 2018 10:48:15 -0500
MIME-Version: 1.0
In-Reply-To: <20180817150559.16243-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/60] check-qjson: Cover whitespace
 more thoroughly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/17/2018 10:05 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/check-qjson.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/check-qjson.c b/tests/check-qjson.c
> index 4daadc272b..188f683317 100644
> --- a/tests/check-qjson.c
> +++ b/tests/check-qjson.c
> @@ -1236,7 +1236,7 @@ static void simple_whitespace(void)
>                       })),
>           },
>           {
> -            .encoded = " [ 43 , { 'h' : 'b' }, [ ], 42 ]",
> +            .encoded = "\t[ 43 , { 'h' : 'b' },\r\n\t[ ], 42 ]\n",

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
