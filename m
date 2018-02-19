Received: from eggs.gnu.org ([2001:4830:134:3::10]:54963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1enp1A-0007qc-Ag
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1enp17-0007Mz-Kb
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:14:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53970 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1enp17-0007Mo-Fp
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:14:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9D474023EDE
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 17:14:05 +0000 (UTC)
References: <1519031728-9850-1-git-send-email-thuth@redhat.com>
	<1519031728-9850-6-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1eec3e33-bd85-d28b-d476-6a44cc29e339@redhat.com>
Date: Mon, 19 Feb 2018 11:14:00 -0600
MIME-Version: 1.0
In-Reply-To: <1519031728-9850-6-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 5/8] net: Remove the deprecated way of
 dumping network packets
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
> "-net dump" has been marked as deprecated since QEMU v2.10, since it
> only works with the deprecated 'vlan' parameter. Network dumping should
> be done with "-object filter-dump" nowadays instead. Since nobody
> complained so far about the deprecation message, let's finally get rid
> of "-net dump" now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   net/dump.c      | 102 ++------------------------------------------------------
>   net/net.c       |   9 +----
>   qapi/net.json   |  27 +++------------
>   qemu-doc.texi   |   6 ----
>   qemu-options.hx |   8 -----
>   5 files changed, 7 insertions(+), 145 deletions(-)
> 

> +++ b/qapi/net.json
> @@ -39,8 +39,8 @@
>   #
>   # Add a network backend.
>   #
> -# @type: the type of network backend.  Current valid values are 'user', 'tap',
> -#        'vde', 'socket', 'dump' and 'bridge'
> +# @type: the type of network backend.  Current valid values are for example
> +#        'user', 'tap', 'vde', 'socket', 'hubport' and 'bridge'
>   #

Look at qapi/block-core.json:BlockDeviceInfo::drv for precedence on how 
we've documented removal of options that used to work; you may want to 
copy that in the documentation here if it will help future readers 
figure out why their command no longer works.  But I'm not seeing 
anything wrong from the UI perspective given that we have had a 
deprecation period, so

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
