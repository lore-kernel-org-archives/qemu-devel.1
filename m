Received: from eggs.gnu.org ([2001:4830:134:3::10]:49190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dLOsn-0008As-5m
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 03:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dLOsi-0006sf-7B
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 03:07:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dLOsi-0006rT-04
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 03:07:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED87C8553C
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 07:07:49 +0000 (UTC)
Message-ID: <1497510465.5952.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 15 Jun 2017 09:07:45 +0200
In-Reply-To: <20170614211927-mutt-send-email-mst@kernel.org>
References: <20170608161013.17920-1-lersek@redhat.com>
	<20170608204026-mutt-send-email-mst@kernel.org>
	<1496951333.29761.5.camel@redhat.com>
	<20170608224942-mutt-send-email-mst@kernel.org>
	<7a7647cd-3d7a-0b6f-0691-d656c9026f44@redhat.com>
	<1497038478.10080.1.camel@redhat.com>
	<20170614211927-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] q35/mch: implement extended TSEG sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>

  Hi,

> To be specific, what I meant is a bit that tells guest that a
> config space register is available, and lets host find out
> that guest is going to use it.
> 
> This to ensure full forward and backward compatibility.
> 
> I agree a fw cfg file for a single bit seems like an overkill, that's
> why I thought sharing feature files with SMI would be a good idea.
> 
> Do you see an issue with that?

The point of placing the extended-tseg-size register in mch pci config
is that the firmware can figure this easily *without* looking somewhere
else, as all the other tseg (and smram) config bits are in mch pci
config space too.

When involving fw_cfg there is no reason to keep the extended-tseg-size 
register in mch.  We can simply place a "etc/q35-extended-tseg-size"
file in fw_cfg then (which is either not present or contains the
extended tseg size).  So a feature bit in fw_cfg looks absolutely
pointless to me.

I still think the approach and patch by Laszlo is perfectly fine. 
While being at it:

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd
