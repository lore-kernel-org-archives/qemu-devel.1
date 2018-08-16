Received: from eggs.gnu.org ([2001:4830:134:3::10]:53986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqIEM-0000pI-PJ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqIEI-0000Ow-4l
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:22:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqIEH-0000Oc-WE
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:22:22 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-49-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0ab1a7fe-35bc-a8d8-fc0a-3321ec41eb29@redhat.com>
Date: Thu, 16 Aug 2018 08:22:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-49-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 48/56] json: Enforce token count and size
 limits more tightly
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
> Token count and size limits exist to guard against excessive heap
> usage.  We check them only after we created the token on the heap.
> That's assigning a cowboy to the barn to lasso the horse after it has
> bolted.  Close the barn door instead: check before we create the
> token.

Love the imagery.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-streamer.c | 36 ++++++++++++++++++------------------
>   1 file changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
