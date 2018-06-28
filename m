Received: from eggs.gnu.org ([2001:4830:134:3::10]:42968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYdSu-0006V4-Vc
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:24:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYdSr-0007BW-Sg
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:24:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36692 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYdSr-0007Ag-NL
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:24:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BEF5400B45F
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 20:24:25 +0000 (UTC)
References: <1530215858-1525-1-git-send-email-pbonzini@redhat.com>
	<1530215858-1525-7-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <67ddeac6-c110-5969-e6fb-847a773aa2d8@redhat.com>
Date: Thu, 28 Jun 2018 15:24:24 -0500
MIME-Version: 1.0
In-Reply-To: <1530215858-1525-7-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] pr-manager-helper: report event on
 connection/disconnection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 06/28/2018 02:57 PM, Paolo Bonzini wrote:
> Let management know if there were any problems communicating with
> qemu-pr-helper.  The event is edge-triggered, and is sent every time
> the connection status of the pr-manager-helper object changes.

Is this something that guest actions can intentionally trigger, and thus 
cause a DoS attack by flooding the management app with events faster 
than they can process?  If so, this event should use rate-limiting.

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   qapi/block.json          | 24 ++++++++++++++++++++++++
>   scsi/pr-manager-helper.c | 14 ++++++++++++++
>   2 files changed, 38 insertions(+)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
