Received: from eggs.gnu.org ([2001:4830:134:3::10]:60641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTvVC-0007rP-F2
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTvV8-00032O-Jf
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:02:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cTvV8-00031x-Di
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:02:30 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E1647E9CF
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 19:02:30 +0000 (UTC)
Date: Wed, 18 Jan 2017 21:02:28 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170118210156-mutt-send-email-mst@kernel.org>
References: <20170112182446.9600-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170112182446.9600-1-lersek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 wave 2 0/3] q35: add negotiable
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

On Thu, Jan 12, 2017 at 07:24:43PM +0100, Laszlo Ersek wrote:
> Previous version (v5):
> http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg01902.html
> 
> Changes in v6 (see the individual patches for details):
> - pick up feedback tags
> - rename "smi_broadcast" to "x-smi-broadcast" [Eduardo]
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>

Series:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Paolo, I'm merging wave 1, I assume you will want to merge wave 2?

> Thanks!
> Laszlo
> 
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
