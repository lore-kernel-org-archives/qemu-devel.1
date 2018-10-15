Received: from eggs.gnu.org ([2001:4830:134:3::10]:44884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCRGH-0004fd-PM
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCRGG-0006eS-UU
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:27:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62795)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gCRGG-0006dz-Np
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:27:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04074C045770
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 15:27:56 +0000 (UTC)
References: <20181015115309.17089-1-armbru@redhat.com>
	<20181015115309.17089-6-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <10ce81ed-62b5-09a9-7d2a-2389fe1ee043@redhat.com>
Date: Mon, 15 Oct 2018 13:53:30 -0500
MIME-Version: 1.0
In-Reply-To: <20181015115309.17089-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/35] vfio: Use warn_report() & friends
 to report warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>

On 10/15/18 6:52 AM, Markus Armbruster wrote:
> The vfio code reports warnings like
> 
>      error_report(WARN_PREFIX "Could not frobnicate", DEV-NAME);
> 
> where WARN_PREFIX is defined so the message comes out as
> 
>      vfio warning: DEV-NAME: Could not frobnicate
> 
> This usage predates the introduction of warn_report() & friends in
> commit 97f40301f1d.  It's time to convert to that interface.  Since
> these functions already prefix the message with "warning: ", replace
> WARN_PREFIX by VFIO_MSG_PREFIX, so the messages come out like
> 
>      warning: vfio DEV-NAME: Could not frobnicate
> 
> The next commit will replace ERR_PREFIX.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>   hw/vfio/pci.c                 | 14 +++++++-------
>   hw/vfio/platform.c            |  4 ++--
>   include/hw/vfio/vfio-common.h |  2 +-
>   3 files changed, 10 insertions(+), 10 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
