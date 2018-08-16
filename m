Received: from eggs.gnu.org ([2001:4830:134:3::10]:51610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqI67-00005c-G6
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqI62-000124-QP
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:13:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqI61-00011N-T5
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:13:50 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-47-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dff3f87a-22cc-a796-8a16-542a4a2f415b@redhat.com>
Date: Thu, 16 Aug 2018 08:13:46 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-47-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 46/56] json: Assert json_parser_parse()
 consumes all tokens on success
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

On 08/08/2018 07:03 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-parser.c | 1 +
>   1 file changed, 1 insertion(+)

Straight-forward, but took a lot of cleanup in earlier patches to get 
here ;)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index c2974d46b3..208dffc96c 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -539,6 +539,7 @@ QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp)
>       QObject *result;
>   
>       result = parse_value(&ctxt, ap);
> +    assert(ctxt.err || g_queue_is_empty(ctxt.buf));
>   
>       error_propagate(errp, ctxt.err);
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
