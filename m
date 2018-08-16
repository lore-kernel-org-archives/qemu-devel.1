Received: from eggs.gnu.org ([2001:4830:134:3::10]:32794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqIXl-0003wq-UU
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqIXh-0006HX-W4
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:42:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46132 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqIXh-0006HM-Qy
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:42:25 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-51-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3190b058-104b-5d8c-21be-f8f0b00b07e2@redhat.com>
Date: Thu, 16 Aug 2018 08:42:22 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-51-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 50/56] json: Unbox tokens queue in
 JSONMessageParser
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
>   include/qapi/qmp/json-streamer.h |  2 +-
>   qobject/json-parser.c            |  1 -
>   qobject/json-streamer.c          | 30 +++++++++++-------------------
>   3 files changed, 12 insertions(+), 21 deletions(-)
> 

Nice reduction as a result.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
