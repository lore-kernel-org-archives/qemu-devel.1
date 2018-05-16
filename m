Received: from eggs.gnu.org ([2001:4830:134:3::10]:52524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIy8w-0005In-Mc
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIy8t-0002Cm-FI
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:15:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53564 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fIy8t-0002Ce-Am
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:15:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF00B40201A1
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 15:15:02 +0000 (UTC)
References: <1526483174-169008-1-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cec99fc1-d981-8318-5533-6f02309e1f8d@redhat.com>
Date: Wed, 16 May 2018 10:15:02 -0500
MIME-Version: 1.0
In-Reply-To: <1526483174-169008-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] numa: clarify error message when node
 index is out of range in -numa dist, ...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com

On 05/16/2018 10:06 AM, Igor Mammedov wrote:
> When using following CLI:
>    -numa dist,src=128,dst=1,val=20
> user gets a rather confusing error message:
>     "Invalid node 128, max possible could be 128"
> 
> Where 128 is number of nodes that QEMU supports (MAX_NODES),
> while src/dst is an index up to that limit, so it should be
> MAX_NODES - 1 in error message.
> Make error message to explicitly state valid range for node
> index to be more clear.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
