Received: from eggs.gnu.org ([2001:4830:134:3::10]:37568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elL9v-00066L-OE
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elL9s-000141-HR
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:57:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41002 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elL9s-000126-CV
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:57:04 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-19-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f8c1aee5-f7a1-a335-11e2-0a2c161827ed@redhat.com>
Date: Mon, 12 Feb 2018 14:56:51 -0600
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-19-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 18/29] qapi: Rename generated
 qmp-marshal.c to qmp-commands.c
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
> All generated .c are named like their .h, except for qmp-marshal.c and
> qmp-commands.h.  To add to the confusion, tests-qmp-commands.c falsely
> matches generated test-qmp-commands.h.
> 
> Get rid of this unnecessary complication.

Yay for saner naming.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   .gitignore                                     |  3 +--
>   Makefile                                       |  6 +++---
>   Makefile.objs                                  |  2 +-
>   docs/devel/qapi-code-gen.txt                   |  6 +++---
>   qga/Makefile.objs                              |  2 +-
>   scripts/qapi/commands.py                       |  2 +-
>   tests/.gitignore                               |  5 ++---
>   tests/Makefile.include                         | 10 +++++-----
>   tests/{test-qmp-commands.c => test-qmp-cmds.c} |  0
>   9 files changed, 17 insertions(+), 19 deletions(-)
>   rename tests/{test-qmp-commands.c => test-qmp-cmds.c} (100%)
> 

> diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-cmds.c
> similarity index 100%
> rename from tests/test-qmp-commands.c
> rename to tests/test-qmp-cmds.c
> 

Noticed while renaming this file - it's non-trivial in length, but bears 
no copyright or license clause.  Perhaps we should add that (but can be 
separate patch).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
