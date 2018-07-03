Received: from eggs.gnu.org ([2001:4830:134:3::10]:45640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAaI-0005dp-Eu
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAaG-0002cB-Ur
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:58:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58110 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faAaG-0002bj-Qm
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:58:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53C98401EF07
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 01:58:24 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-14-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <309d5afd-9733-119b-45b9-2dae9d2e4f8c@redhat.com>
Date: Mon, 2 Jul 2018 20:58:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-14-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/32] qmp: Revert change to
 handle_qmp_command tracepoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

On 07/02/2018 11:21 AM, Markus Armbruster wrote:
> Commit 71da4667db6 "monitor: separate QMP parser and dispatcher" moved
> the handle_qmp_command tracepoint from handle_qmp_command() to
> monitor_qmp_dispatch_one().  This delays tracing from enqueue time to
> dequeue time.  Revert that.  Dequeue remains adequately visible via
> tracepoint monitor_qmp_cmd_in_band.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   monitor.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
