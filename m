Received: from eggs.gnu.org ([2001:4830:134:3::10]:38412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cRhkR-0004gD-Sl
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cRhkQ-0002td-1G
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:57:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cRhkP-0002tR-SC
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:57:05 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECFED70027
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 15:57:05 +0000 (UTC)
Date: Thu, 12 Jan 2017 17:57:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170112175657-mutt-send-email-mst@kernel.org>
References: <20170111173528.30510-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170111173528.30510-1-lersek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 wave 2 0/3] q35: add negotiable
 broadcast SMI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Jan 11, 2017 at 06:35:25PM +0100, Laszlo Ersek wrote:
> This is the second (ICH9-LPC) half of the v5 iteration of the series
> posted here:
> <http://lists.nongnu.org/archive/html/qemu-devel/2016-12/msg00129.html>.
> 
> In this version, the ICH9-LPC patches have been separated into a
> standalone "wave", for helping review / maintenance. More importantly,
> I've addressed Igor's v4 feedback (which happens to address Eduardo's
> feedback as well). See the individual patches for the details.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> 
> Thanks
> Laszlo

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> Laszlo Ersek (3):
>   hw/isa/lpc_ich9: add SMI feature negotiation via fw_cfg
>   hw/isa/lpc_ich9: add broadcast SMI feature
>   hw/isa/lpc_ich9: negotiate SMI broadcast on pc-q35-2.9+ machine types
> 
>  include/hw/i386/ich9.h | 13 ++++++++
>  include/hw/i386/pc.h   |  5 +++
>  hw/isa/lpc_ich9.c      | 91 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 108 insertions(+), 1 deletion(-)
> 
> -- 
> 2.9.3
