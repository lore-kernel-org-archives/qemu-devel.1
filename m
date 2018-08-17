Received: from eggs.gnu.org ([2001:4830:134:3::10]:53990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqjKR-0001mG-5C
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqjKN-0006TG-Ru
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:18:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51514 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqjKN-0006Sy-NK
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:18:27 -0400
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-61-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7e49b7ec-cdfc-45a3-5af1-e7f06d682741@redhat.com>
Date: Fri, 17 Aug 2018 13:18:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180817150559.16243-61-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 60/60] json: Support %% in JSON strings
 when interpolating
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
> The previous commit makes JSON strings containing '%' awkward to
> express in templates: you'd have to mask the '%' with an Unicode

s/an Unicode/a Unicode/

> escape \u0025.  No template currently contains such JSON strings.
> Support the printf conversion specification %% in JSON strings as a
> convenience anyway, because it's trivially easy to do.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-parser.c | 3 ++-
>   tests/check-qjson.c   | 4 ++--
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
