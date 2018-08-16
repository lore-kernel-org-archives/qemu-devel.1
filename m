Received: from eggs.gnu.org ([2001:4830:134:3::10]:35149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqIgM-0003AV-4N
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqIgH-0002YQ-Un
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:51:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqIgH-0002Xt-9V
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:51:17 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-53-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b87fbf27-70e1-1abb-14ea-12b0e51ad293@redhat.com>
Date: Thu, 16 Aug 2018 08:51:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-53-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 52/56] json: Eliminate lexer state
 IN_WHITESPACE, pseudo-token JSON_SKIP
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
> Bonus: static json_lexer[] loses its unused elements.  It shrinks from
> 8KiB to 4.75KiB for me.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/qmp/json-lexer.h |  1 -
>   qobject/json-lexer.c          | 30 +++++++++---------------------
>   2 files changed, 9 insertions(+), 22 deletions(-)
> 

Impacted when rebasing atop my earlier ideas for compressing IN_INTERPOL 
initialization, but overall:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
