Received: from eggs.gnu.org ([2001:4830:134:3::10]:35919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqIj8-0006Xl-Dq
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqIj4-0004Ks-SE
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:54:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39234 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqIj4-0004I8-Lb
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:54:10 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-54-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <920d3c56-4d10-eb1f-1b25-eeedfa322087@redhat.com>
Date: Thu, 16 Aug 2018 08:54:06 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-54-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 53/56] json: Make JSONToken opaque outside
 json-parser.c
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
>   include/qapi/qmp/json-parser.h   |  4 ++++
>   include/qapi/qmp/json-streamer.h |  7 -------
>   qobject/json-parser.c            | 19 +++++++++++++++++++
>   qobject/json-streamer.c          |  8 +-------
>   4 files changed, 24 insertions(+), 14 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
