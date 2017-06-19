Received: from eggs.gnu.org ([2001:4830:134:3::10]:36471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMxNg-0007DT-2w
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMxNa-0001VV-20
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:10:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dMxNZ-0001Ua-T8
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:10:10 -0400
Date: Mon, 19 Jun 2017 11:10:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170619141001.GQ5016@thinpad.lan.raisama.net>
References: <1497877149-19253-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497877149-19253-2-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497877149-19253-2-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv6 1/5] fw_cfg: don't map the fw_cfg IO
 ports in fw_cfg_io_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

On Mon, Jun 19, 2017 at 01:59:05PM +0100, Mark Cave-Ayland wrote:
> As indicated by Laszlo it is a QOM bug for the realize() method to actually
> map the device. Set up the IO regions within fw_cfg_io_realize() and defer
> the mapping with sysbus_add_io() to the caller, as already done in
> fw_cfg_init_mem_wide().
> 
> This makes the iobase and dma_iobase properties now obsolete so they can be
> removed.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Tested-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
