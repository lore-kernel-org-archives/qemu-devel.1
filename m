Received: from eggs.gnu.org ([2001:4830:134:3::10]:56844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dKP0h-0005Jj-Rr
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dKP0e-0001gz-Mb
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:03:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dKP0e-0001gR-Fi
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:03:56 -0400
Message-ID: <1497272633.30925.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Jun 2017 15:03:53 +0200
In-Reply-To: <20170612133740.2f3eef83@nial.brq.redhat.com>
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497097821-32754-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170612133740.2f3eef83@nial.brq.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] fw_cfg: move setting of FW_CFG_ID into
 fw_cfg_init1()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, somlo@cmu.edu, lersek@redhat.com, mst@redhat.com, ehabkost@redhat.com

On Mon, 2017-06-12 at 13:37 +0200, Igor Mammedov wrote:
> On Sat, 10 Jun 2017 13:30:18 +0100
> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> 
> > The dma_enabled property enables us to set the FW_CFG_ID version
> > accordingly.
> 
> it might be not safe as patch reorders FW_CFG_ID entry.
> 
> (I recall there were patches that sorted fwcfg entries,
> but it's worth checking that it won't break migration)
> 
> CCing Gerd, maybe he would recall how it works.

http://git.qemu.org/?p=qemu.git;a=blob;f=hw/nvram/fw_cfg.c;h=316fca9bc1
dadf8777ad9a9c238381702022bc56;hb=HEAD#l723

So, should be safe to shuffle around stuff.

cheers,
  Gerd
