Received: from eggs.gnu.org ([2001:4830:134:3::10]:54057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnkwX-0001KD-2r
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnkwW-0003v4-9S
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:25:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48934 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fnkwV-0003uN-V4
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:25:32 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a743ee3d-9fb5-d62a-fc4a-1bd1f15f6800@redhat.com>
Date: Thu, 9 Aug 2018 08:25:28 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/56] check-qjson: Cover multiple JSON
 objects in same string
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
> qobject_from_json() & friends misbehave when the JSON text has more
> than one JSON value.  Add test coverage to demonstrate the bugs.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/check-qjson.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
