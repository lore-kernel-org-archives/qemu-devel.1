Received: from eggs.gnu.org ([2001:4830:134:3::10]:36684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eno1d-0000Fq-5V
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:10:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eno1Z-0003NB-2u
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:10:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40044 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eno1Y-0003Mi-SS
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:10:40 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 887B1EAE9B
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 16:10:40 +0000 (UTC)
References: <1519031728-9850-1-git-send-email-thuth@redhat.com>
	<1519031728-9850-4-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e671980-590e-827b-78de-6049874a54d3@redhat.com>
Date: Mon, 19 Feb 2018 17:10:35 +0100
MIME-Version: 1.0
In-Reply-To: <1519031728-9850-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/8] net: Only show vhost-user in the
 help text if CONFIG_POSIX is defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 19/02/2018 10:15, Thomas Huth wrote:
> According to net/Makefile.objs we only link in the vhost-user code
> if CONFIG_POSIX has been set. So the help screen should also only
> show this information if CONFIG_POSIX has been defined.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-options.hx | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5050a49..b81b53b 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1998,8 +1998,10 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>      "                VALE port (created on the fly) called 'name' ('nmname' is name of the \n"
>      "                netmap device, defaults to '/dev/netmap')\n"
>  #endif
> +#ifdef CONFIG_POSIX
>      "-netdev vhost-user,id=str,chardev=dev[,vhostforce=on|off]\n"
>      "                configure a vhost-user network, backed by a chardev 'dev'\n"
> +#endif
>      "-netdev hubport,id=str,hubid=n[,netdev=nd]\n"
>      "                configure a hub port on QEMU VLAN 'n'\n", QEMU_ARCH_ALL)
>  DEF("net", HAS_ARG, QEMU_OPTION_net,
> 


I would have thought that #ifdef is not allowed within macro arguments,
but there is an obvious precedent right in the context, so:

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
