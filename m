Received: from eggs.gnu.org ([2001:4830:134:3::10]:49677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAgR-00081X-Eo
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAgM-0000hr-Oj
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:04:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faAgM-0000h9-Jb
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:04:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1FEC981A4EB9
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 02:04:42 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-16-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bfebf8c5-3dd3-3798-4d18-691b7cc214d9@redhat.com>
Date: Mon, 2 Jul 2018 21:04:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-16-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/32] qmp: Simplify code around
 monitor_qmp_dispatch_one()
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

On 07/02/2018 11:22 AM, Markus Armbruster wrote:
> Change monitor_qmp_dispatch_one() to take its parameters unwrapped,
> move monitor_resume() to the one caller that needs it, rename the
> function to monitor_qmp_dispatch().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   monitor.c | 58 +++++++++++++++++++++++--------------------------------
>   1 file changed, 24 insertions(+), 34 deletions(-)
> 
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
