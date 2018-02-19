Received: from eggs.gnu.org ([2001:4830:134:3::10]:56004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1enp5E-0002aK-NB
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1enp5C-0001uS-1d
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:18:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36252 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1enp5B-0001uD-S6
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:18:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85A594084FEF
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 17:18:29 +0000 (UTC)
References: <1519031728-9850-1-git-send-email-thuth@redhat.com>
	<1519031728-9850-3-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97dcd694-220b-422d-8dea-cef441846532@redhat.com>
Date: Mon, 19 Feb 2018 11:18:24 -0600
MIME-Version: 1.0
In-Reply-To: <1519031728-9850-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/8] net: List available netdevs with
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 02/19/2018 03:15 AM, Thomas Huth wrote:
> Other options like "-chardev" or "-device" feature a nice help text
> with the available devices when being called with "help" or "?".
> Since it is quite useful, especially if you want to see which network
> backends have been compiled into the QEMU binary, let's provide such
> a help text for "-netdev", too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   net/net.c | 37 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)

> @@ -1094,7 +1126,10 @@ int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
>       int ret = -1;
>       Visitor *v = opts_visitor_new(opts);
>   
> -    {
> +    if (is_netdev && is_help_option(qemu_opt_get(opts, "type"))) {
> +        show_netdevs();
> +        exit(1);

Please make this status 0 (we were successful at giving the user help); 
it matches at least '--device help'.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
