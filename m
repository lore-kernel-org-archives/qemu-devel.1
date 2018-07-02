Received: from eggs.gnu.org ([2001:4830:134:3::10]:51692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa5uC-0005h7-KF
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa5u8-00020w-0f
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:58:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48778 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fa5u7-00020N-N0
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:58:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F6C781A4EB9
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 20:58:35 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-5-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <50e5e338-6361-f9e9-8c16-70abdb4952a8@redhat.com>
Date: Mon, 2 Jul 2018 15:58:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/32] qmp: Document COMMAND_DROPPED design
 flaw
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

On 07/02/2018 11:21 AM, Markus Armbruster wrote:
> Events are broadcast to all monitors.  If another monitor's client has
> a command with the same ID in flight, the event will incorrectly claim
> that command was dropped.  This must be fixed before out-of-band
> execution can graduate from "experimental".
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   monitor.c      | 6 ++++++
>   qapi/misc.json | 3 +++
>   2 files changed, 9 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

(Seems like we'll get this bug fixed in time for 3.0, even if it misses 
soft freeze)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
