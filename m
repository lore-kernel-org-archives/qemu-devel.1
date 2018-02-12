Received: from eggs.gnu.org ([2001:4830:134:3::10]:44303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elHRy-0007zA-AH
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:59:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elHRu-0007fW-Nu
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:59:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33442 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elHRu-0007eX-GZ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:59:26 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-5-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1940f375-3a65-5116-3ea4-049efc3feb90@redhat.com>
Date: Mon, 12 Feb 2018 10:59:23 -0600
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/29] qapi: Rename variable holding the
 QAPISchemaGenFOOVisitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com

On 02/11/2018 03:35 AM, Markus Armbruster wrote:
> Rename the variable holding the QAPISchemaGenFOOVisitor from gen to
> vis, to avoid confusion in the next commit.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   scripts/qapi-commands.py   | 8 ++++----
>   scripts/qapi-event.py      | 8 ++++----
>   scripts/qapi-introspect.py | 8 ++++----
>   scripts/qapi-types.py      | 8 ++++----
>   scripts/qapi-visit.py      | 8 ++++----
>   5 files changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
