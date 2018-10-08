Received: from eggs.gnu.org ([2001:4830:134:3::10]:48494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1g9asI-0006vu-Oa
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1g9apR-0000Ta-Io
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:04:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1g9apQ-0000QE-Dx
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:04:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6CC9330821C5
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 19:04:25 +0000 (UTC)
Date: Mon, 8 Oct 2018 13:04:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181008130424.6d369434@w520.home>
In-Reply-To: <20181008173125.19678-6-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-6-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/31] vfio: Clean up error reporting after
 previous commit
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

On Mon,  8 Oct 2018 19:30:59 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> The previous commit changed vfio's warning messages from
> 
>     vfio warning: DEV-NAME: Could not frobnicate
> 
> to
> 
>     warning: vfio DEV-NAME: Could not frobnicate
> 
> To match this change, change error messages from
> 
>     vfio error: DEV-NAME: On fire
> 
> to
> 
>     vfio DEV-NAME: On fire
> 
> Note the loss of "error".  If we think marking error messages that way
> is a good idea, we should mark *all* error messages, i.e. make
> error_report() print it.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/vfio/pci-quirks.c          | 4 ++--
>  hw/vfio/pci.c                 | 8 ++++----
>  hw/vfio/platform.c            | 2 +-
>  include/hw/vfio/vfio-common.h | 1 -
>  4 files changed, 7 insertions(+), 8 deletions(-)

Acked-by: Alex Williamson <alex.williamson@redhat.com>
