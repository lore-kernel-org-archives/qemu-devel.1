Received: from eggs.gnu.org ([2001:4830:134:3::10]:36550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnlYS-0004oQ-Ne
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnlYS-0004Np-1S
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:04:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fnlYR-0004NX-RH
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:04:43 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-11-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <51736a13-535f-1b84-9f70-c7f0e463b158@redhat.com>
Date: Thu, 9 Aug 2018 09:04:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-11-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/56] check-qjson: Drop redundant string
 tests
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
> simple_string() and single_quote_string() add nothing to
> escaped_string() anymore.  Drop them.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/check-qjson.c | 59 ---------------------------------------------
>   1 file changed, 59 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
