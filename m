Received: from eggs.gnu.org ([2001:4830:134:3::10]:54724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAow-00037E-09
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAor-0003iZ-Tr
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:13:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38026 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faAor-0003iQ-P5
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:13:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73956857AB
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 02:13:29 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-20-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6cfc417d-f4ab-e6df-efcc-864fdad75129@redhat.com>
Date: Mon, 2 Jul 2018 21:13:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-20-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/32] monitor: Rename use_io_thr to
 use_io_thread
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
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   monitor.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index fd83a57dda..10b6634d3e 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -206,11 +206,11 @@ struct Monitor {
>       int flags;
>       int suspend_cnt;            /* Needs to be accessed atomically */
>       bool skip_flush;
> -    bool use_io_thr;
> +    bool use_io_thread;

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
