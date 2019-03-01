Received: from eggs.gnu.org ([209.51.188.92]:51923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzkQ9-0007aB-4E
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzkQ8-0001G8-Cx
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:49:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gzkQ8-0001Eu-5n
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:49:56 -0500
References: <20190301154051.23317-1-armbru@redhat.com>
	<20190301154051.23317-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ee5bb917-718e-3586-a662-d52538f3012b@redhat.com>
Date: Fri, 1 Mar 2019 09:49:53 -0600
MIME-Version: 1.0
In-Reply-To: <20190301154051.23317-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] qapi: Pass file name to QAPIGen
 constructor instead of methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, quintela@redhat.com

On 3/1/19 9:40 AM, Markus Armbruster wrote:
> Not much of an improvement now, but the next commit will profit.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/commands.py |  2 +-
>  scripts/qapi/common.py   | 68 +++++++++++++++++++++-------------------
>  scripts/qapi/doc.py      |  4 +--
>  3 files changed, 38 insertions(+), 36 deletions(-)
> 
Looks like a straightforward refactoring, and I can indeed guess how it
becomes useful later.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
