Received: from eggs.gnu.org ([209.51.188.92]:34334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxdZo-0004di-AT
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 15:07:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxdZn-00036n-KU
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 15:07:12 -0500
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64bbaa68-b98c-7735-fc84-bf1a8dc0b976@redhat.com>
Date: Sat, 23 Feb 2019 14:06:54 -0600
MIME-Version: 1.0
In-Reply-To: <20190223000614.13894-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/10] block/dirty-bitmap: add recording
 and busy properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, libvir-list@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>

On 2/22/19 6:06 PM, John Snow wrote:
> The current API allows us to report a single status, which we've defined as:
> 
> Frozen: has a successor, treated as qmp_locked, may or may not be enabled.
> Locked: no successor, qmp_locked. may or may not be enabled.
> Disabled: Not frozen or locked, disabled.
> Active: Not frozen, locked, or disabled.
> 
> The problem is that both "Frozen" and "Locked" mean nearly the same thing,
> and that both of them do not intuit whether they are recording guest writes
> or not.
> 
> This patch deprecates that status field and introduces two orthogonal
> properties instead to replace it.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

> +++ b/qemu-deprecated.texi
> @@ -67,6 +67,12 @@ topologies described with -smp include all possible cpus, i.e.
>  "autoload" parameter is now ignored. All bitmaps are automatically loaded
>  from qcow2 images.
>  
> +@subsection query-block result field(s) dirty-bitmaps[i].status (since 4.0)

I suspect you wrote "field(s)" since there can be more than one
dirty-bitmaps[i]. But it still sound funny; within a single
dirty-bitmaps[i], there is only one field being deprecated. Dropping the
'(s)' makes this subsection read better to me.

That's minor enough that a maintainer could fix it, if you don't have
any other reason to spin v4.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
