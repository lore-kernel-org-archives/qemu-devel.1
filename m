Received: from eggs.gnu.org ([2001:4830:134:3::10]:54042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqMQM-0002J3-2e
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqMQI-0007xH-Bs
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:51:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqMQI-0007x9-7W
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:51:02 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-56-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ebb968b0-d3e5-80a9-72c3-ecf620c1fa3c@redhat.com>
Date: Thu, 16 Aug 2018 12:50:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-56-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 55/56] json: Clean up headers
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
> The JSON parser has three public headers, json-lexer.h, json-parser.h,
> json-streamer.h.  They all contain stuff that is of no interest
> outside qobject/json-*.c.
> 
> Collect the public interface in include/qapi/qmp/json-parser.h, and
> everything else in qobject/json-parser-int.h.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Nice separation.

>   10 files changed, 51 insertions(+), 76 deletions(-)
>   delete mode 100644 include/qapi/qmp/json-streamer.h
>   rename include/qapi/qmp/json-lexer.h => qobject/json-parser-int.h (62%)


> 
> diff --git a/include/qapi/qmp/json-parser.h b/include/qapi/qmp/json-parser.h
> index 55f75954c3..7345a9bd5c 100644
> --- a/include/qapi/qmp/json-parser.h
> +++ b/include/qapi/qmp/json-parser.h
> @@ -1,5 +1,5 @@
>   /*
> - * JSON Parser
> + * JSON Parser

I'm not sure what git tried to flag here.

Otherwise, looks like a good reorganization.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
