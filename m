Received: from eggs.gnu.org ([2001:4830:134:3::10]:47068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvOl7-0001yh-Kn
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvOl2-0000qS-Lo
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:21:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38052 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fvOl2-0000qD-Gl
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:21:16 -0400
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-3-sameeh@daynix.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <009b673f-7872-af95-77a7-2bc7de4658e6@redhat.com>
Date: Thu, 30 Aug 2018 10:21:14 -0500
MIME-Version: 1.0
In-Reply-To: <20180830142708.14311-3-sameeh@daynix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 2/6] tap: Add support for bpf ioctls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Yan Vugenfirer <yan@daynix.com>

On 08/30/2018 09:27 AM, Sameeh Jubran wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
> 
> Starting from kernel v4.16 tun device supports TUNSETSTEERINGEBPF and
> TUNSETFILTEREBPF.
> 
> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> ---

> +++ b/qapi/net.json
> @@ -692,3 +692,14 @@
>   ##
>   { 'event': 'NIC_RX_FILTER_CHANGED',
>     'data': { '*name': 'str', 'path': 'str' } }
> +
> +##
> +# @BPFType:
> +#
> +# BPF programs types provided as an argument for tap bpf ioctls
> +#
> +# Since: 2.12

You missed 2.12 by a long shot; this should be 3.1.

> +#
> +##
> +{ 'enum': 'BPFType',
> +  'data': [ 'filter', 'steering' ] }

It might also be wise to document these two values in addition to the 
documentation of the enum as a whole.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
