Received: from eggs.gnu.org ([2001:4830:134:3::10]:51466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqjC5-0003j1-Fn
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqjC1-0000on-B4
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:09:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48582 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqjC1-0000oK-1N
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:09:49 -0400
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-59-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e22978e1-9b4a-c185-62a0-ed38481f11b0@redhat.com>
Date: Fri, 17 Aug 2018 13:09:45 -0500
MIME-Version: 1.0
In-Reply-To: <20180817150559.16243-59-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 58/60] json: Keep interpolation state in
 JSONParserContext
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
> The recursive descent parser passes along a pointer to
> JSONParserContext.  It additionally passes a pointer to interpolation
> state (a va_alist *) as needed to reach its consumer
> parse_interpolation().
> 
> Stuffing the latter pointer into JSONParserContext saves us the
> trouble of passing it along, so do that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-parser.c | 59 ++++++++++++++++++++++---------------------
>   1 file changed, 30 insertions(+), 29 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
