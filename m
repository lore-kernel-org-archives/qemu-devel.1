Received: from eggs.gnu.org ([2001:4830:134:3::10]:36902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMxOm-00086E-5b
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMxOh-00029B-6U
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:11:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dMxOh-00028v-0F
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:11:19 -0400
Date: Mon, 19 Jun 2017 11:11:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170619141108.GR5016@thinpad.lan.raisama.net>
References: <1497877149-19253-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497877149-19253-3-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497877149-19253-3-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv6 2/5] fw_cfg: move setting of
 FW_CFG_VERSION_DMA bit to fw_cfg_init1()
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

On Mon, Jun 19, 2017 at 01:59:06PM +0100, Mark Cave-Ayland wrote:
> The setting of the FW_CFG_VERSION_DMA bit is the same across both the
> TYPE_FW_CFG_MEM and TYPE_FW_CFG_IO devices, so unify the logic in
> fw_cfg_init1().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Tested-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
