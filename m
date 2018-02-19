Received: from eggs.gnu.org ([2001:4830:134:3::10]:53149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1enleI-0007cW-Vn
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 08:38:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1enleI-0007zl-5H
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 08:38:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55828 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1enleH-0007zc-Vg
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 08:38:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BDD340363B6
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 13:38:29 +0000 (UTC)
References: <1519031728-9850-1-git-send-email-thuth@redhat.com>
	<1519031728-9850-2-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e1d035d1-84b0-588d-3d9b-1d83b6bee80e@redhat.com>
Date: Mon, 19 Feb 2018 07:38:26 -0600
MIME-Version: 1.0
In-Reply-To: <1519031728-9850-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/8] net: Move error reporting from
 net_init_client/netdev to the calling site
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 02/19/2018 03:15 AM, Thomas Huth wrote:
> It looks strange that net_init_client() and net_init_netdev() both
> take an "Error **errp" parameter, but then do the error reporting
> with "error_report_err(local_err)" on their own. Let's move the
> error reporting to the calling site instead to simplify this code
> a little bit.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/net/net.h |  2 +-
>   net/net.c         | 29 +++++------------------------
>   vl.c              |  3 ++-
>   3 files changed, 8 insertions(+), 26 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
