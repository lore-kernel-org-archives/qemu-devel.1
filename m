Received: from eggs.gnu.org ([2001:4830:134:3::10]:56854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnl6m-0001ha-0K
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnl6i-000244-O7
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:36:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58948 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fnl6i-00023G-Ic
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:36:04 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd935f52-11d1-8fee-a239-9d32cdff261a@redhat.com>
Date: Thu, 9 Aug 2018 08:36:02 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/56] check-qjson: Cover whitespace more
 thoroughly
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

On 08/08/2018 07:02 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/check-qjson.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/check-qjson.c b/tests/check-qjson.c
> index 81b92d6b0c..0a9a054c7b 100644
> --- a/tests/check-qjson.c
> +++ b/tests/check-qjson.c
> @@ -1236,7 +1236,7 @@ static void simple_whitespace(void)
>                       })),
>           },
>           {
> -            .encoded = " [ 43 , { 'h' : 'b' }, [ ], 42 ]",
> +            .encoded = "\t[ 43 , { 'h' : 'b' },\n\t[ ], 42 ]\n",

I would also test \r, since that is the final whitespace character 
mentioned in RFC 7159.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
