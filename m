Received: from eggs.gnu.org ([2001:4830:134:3::10]:57251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoGOv-0006P0-T7
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoGOs-0007Dj-Q9
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:28:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59104 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eoGOs-0007DG-LP
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:28:38 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C470406AE1C
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 22:28:38 +0000 (UTC)
References: <1519148406-15006-1-git-send-email-thuth@redhat.com>
	<1519148406-15006-3-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cc4d6184-e33b-8a6a-7844-f2f49c4164bc@redhat.com>
Date: Tue, 20 Feb 2018 16:28:34 -0600
MIME-Version: 1.0
In-Reply-To: <1519148406-15006-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/8] net: List available netdevs with
 "-netdev help"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 02/20/2018 11:40 AM, Thomas Huth wrote:
> Other options like "-chardev" or "-device" feature a nice help text
> with the available devices when being called with "help" or "?".
> Since it is quite useful, especially if you want to see which network
> backends have been compiled into the QEMU binary, let's provide such
> a help text for "-netdev", too.
> 
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   net/net.c | 37 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
