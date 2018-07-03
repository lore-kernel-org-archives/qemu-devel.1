Received: from eggs.gnu.org ([2001:4830:134:3::10]:55732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAqa-0004Bw-S9
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAqW-0005AE-Q6
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:15:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56148 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faAqW-00059p-Kd
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:15:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A0488185924
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 02:15:12 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-21-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aad5ca47-e8f6-de37-f4dd-ea5bafbf1037@redhat.com>
Date: Mon, 2 Jul 2018 21:15:10 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-21-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/32] monitor: Peel off @mon_global wrapper
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
> Wrapping global variables in a struct without a use for the wrapper
> struct buys us nothing but longer lines.  Unwrap them.

Well, it also makes it slightly more obvious where you are using a 
global variable, and thus need to be careful of reentrancy.  But I'm not 
opposed to this reduction in size.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   monitor.c | 60 +++++++++++++++++++++++++++----------------------------
>   1 file changed, 29 insertions(+), 31 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
