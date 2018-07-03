Received: from eggs.gnu.org ([2001:4830:134:3::10]:54566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAoU-0002s0-6f
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAoS-0003Of-S3
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:13:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38158 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faAoS-0003OM-OE
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:13:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6335F87A7D
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 02:13:04 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-19-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e8fe56f3-fc28-9f7a-fbad-8ec809f144e0@redhat.com>
Date: Mon, 2 Jul 2018 21:13:00 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-19-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/32] qmp: Don't let JSON errors jump the
 queue
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
> handle_qmp_command() reports JSON syntax errors right away.  This is
> wrong when OOB is enabled, because the errors can "jump the queue"
> then.
> 
> The previous commit fixed the same bug for semantic errors, by
> delaying the checking until dispatch.  We can't delay the checking, so
> delay the reporting.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   monitor.c | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
