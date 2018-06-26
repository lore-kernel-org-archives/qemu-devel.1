Received: from eggs.gnu.org ([2001:4830:134:3::10]:60667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fXuw6-00087L-Mj
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 16:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fXuw2-0000IQ-3f
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 16:51:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fXuw1-0000IE-VS
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 16:51:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6843E40676C0
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 20:51:32 +0000 (UTC)
References: <20180626154028.11133-1-pbonzini@redhat.com>
	<20180626154028.11133-5-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64ad9493-8e84-51c0-f492-8424be8647df@redhat.com>
Date: Tue, 26 Jun 2018 15:51:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180626154028.11133-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] pr-manager: add query-pr-managers QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mprivozn@redhat.com

On 06/26/2018 10:40 AM, Paolo Bonzini wrote:
> This command lets you query the connection status of each pr-manager-helper
> object.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

> +++ b/qapi/block.json
> @@ -77,6 +77,33 @@
>   { 'struct': 'BlockdevSnapshotInternal',
>     'data': { 'device': 'str', 'name': 'str' } }
>   
> +##
> +# @PRManagerInfo:
> +#
> +# Information about a persistent reservation manager
> +#
> +# @id: the identifier of the persistent reservation manager
> +#
> +# @is-connected: whether the persistent reservation manager is connected to
> +#                the underlying storage or helper
> +#
> +# Since: 3.0
> +##
> +{ 'struct': 'PRManagerInfo',
> +  'data': {'id': 'str', 'is-connected': 'bool'} }

Bike-shedding: I think 'connected' is a reasonable (and shorter) name 
for this member

> +
> +##
> +# @query-pr-managers:
> +#
> +# Returns a list of information about each persistent reservation manager.
> +#
> +# Returns: a list of @PRManagerInfo for each persistent reservation manager
> +#
> +# Since: 3.0
> +##
> +{ 'command': 'query-pr-managers', 'returns': ['PRManagerInfo'] }
> +

As a query command, does it make sense to consider whether this command 
could be provided during preconfig?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
