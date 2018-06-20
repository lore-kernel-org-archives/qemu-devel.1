Received: from eggs.gnu.org ([2001:4830:134:3::10]:47877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVeL0-00060F-18
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVeKw-0002e9-UJ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:43:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54324 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fVeKw-0002e1-Py
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:43:54 -0400
References: <20180620124827.17106-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <95f6d8c0-7b38-e9da-7944-bc188930a56d@redhat.com>
Date: Wed, 20 Jun 2018 09:43:53 -0500
MIME-Version: 1.0
In-Reply-To: <20180620124827.17106-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Update QAPI stanza for commit
 fb0bc835e56
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

On 06/20/2018 07:48 AM, Markus Armbruster wrote:
> Commit fb0bc835e56 moved code from scripts/qapi-*.py to
> scripts/qapi/*.py.  It neglected to update MAINTAINERS: scripts/qapi*
> matches only the former, not the latter.  Do that now.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index da91501c7a..7fa5c51a98 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1615,7 +1615,8 @@ F: tests/test-*-visitor.c
>   F: tests/test-qapi-*.c
>   F: tests/test-qmp-*.c
>   F: tests/test-visitor-serialization.c
> -F: scripts/qapi*
> +F: scripts/qapi-gen.py
> +F: scripts/qapi/*
>   F: docs/devel/qapi*
>   T: git git://repo.or.cz/qemu/armbru.git qapi-next
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
