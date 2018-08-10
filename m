Received: from eggs.gnu.org ([2001:4830:134:3::10]:46490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo8ZW-0004Rj-Dq
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo8ZS-0006LV-Gs
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:39:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55408 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fo8ZS-0006L9-Av
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:39:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1B105A746
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 14:39:17 +0000 (UTC)
References: <20180810115553.32604-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9cfafd00-0f49-8a98-2ff9-2827bf044853@redhat.com>
Date: Fri, 10 Aug 2018 09:39:16 -0500
MIME-Version: 1.0
In-Reply-To: <20180810115553.32604-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Fix F: patterns that don't
 match anything
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 08/10/2018 06:55 AM, Markus Armbruster wrote:
> Commit ba51ef25571 moved hw/dma/sun4m_iommu.c to
> hw/sparc/sun4m_iommu.c without updating MAINTAINERS.
> 
> Commit f5980f757c0 deleted include/hw/sparc/sun4m.h without updating
> MAINTAINERS.
> 
> Commit 0bcc8e5bd8d fat-fingered tests/check-block-qdict.c.
> 
> Commit 33e9e9bd62d fat-fingered include/qemu/job.h.
> 
> Commit eb815e248f5 moved qapi-schema.json to qapi/ without updating
> MAINTAINERS.
> 
> Commit 2e3c8f8dbdd converted docs/devel/migration.txt to
> docs/devel/migration.rst without updating MAINTAINERS.
> 
> Offenders tracked down with the following shell loop:
> 
>      shopt -s nullglob
>      for i in `sed -n 's/^F: //p' <MAINTAINERS `
>      do
>          glob="`echo $i`"
> 	if [ "$glob" = "$i" ]
> 	then [ ! -e $i ]
> 	else [ -z "$glob" ]
> 	fi && echo "$i"
>      done

Clever. The bulk of the time spent on this patch was chasing down the 
faulty commits for the nice archaeology given above.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
