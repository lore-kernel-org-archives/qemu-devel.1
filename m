Received: from eggs.gnu.org ([2001:4830:134:3::10]:48595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1g9asH-0006wU-Jk
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1g9apS-0000WO-IZ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:04:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1g9apR-0000SC-Gy
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:04:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F90830820C0
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 19:04:28 +0000 (UTC)
Date: Mon, 8 Oct 2018 13:04:27 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181008130427.16012dfe@w520.home>
In-Reply-To: <20181008173125.19678-5-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-5-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/31] vfio: Use warn_report() & friends to
 report warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon,  8 Oct 2018 19:30:58 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> The vfio code reports warnings like
> 
>     error_report(WARN_PREFIX "Could not frobnicate", DEV-NAME);
> 
> where WARN_PREFIX is defined so the message comes out as
> 
>     vfio warning: DEV-NAME: Could not frobnicate
> 
> This usage predates the introduction of warn_report() & friends in
> commit 97f40301f1d.  It's time to convert to that interface.  Since
> these functions already prefix the message with "warning: ", replace
> WARN_PREFIX by VFIO_MSG_PREFIX, so the messages come out like
> 
>     warning: vfio DEV-NAME: Could not frobnicate
> 
> The next commit will replace ERR_PREFIX.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/vfio/pci.c                 | 14 +++++++-------
>  hw/vfio/platform.c            |  4 ++--
>  include/hw/vfio/vfio-common.h |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)

Acked-by: Alex Williamson <alex.williamson@redhat.com>
