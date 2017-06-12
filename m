Received: from eggs.gnu.org ([2001:4830:134:3::10]:45594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dKYVJ-0002vp-1Z
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 19:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dKYVG-0001Cx-CA
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 19:12:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dKYVG-0001CU-6E
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 19:12:10 -0400
From: Laszlo Ersek <lersek@redhat.com>
References: <1497302470-10776-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497302470-10776-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<8028308f-9aac-abb6-25df-599d32d4d0ce@redhat.com>
Message-ID: <880c8bfd-502a-15ab-2695-868dd5657901@redhat.com>
Date: Tue, 13 Jun 2017 01:12:03 +0200
MIME-Version: 1.0
In-Reply-To: <8028308f-9aac-abb6-25df-599d32d4d0ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 1/4] fw_cfg: don't map the fw_cfg IO
 ports in fw_cfg_io_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, imammedo@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, peter.maydell@linaro.org

On 06/13/17 00:27, Laszlo Ersek wrote:

> In fw_cfg_init_io_dma(), you know the object type exactly -- you just
> created it with TYPE_FW_CFG_IO --, so after device realization, you can
> cast the type as narrowly as necessary, and refer to the fields by name.

I understand that in sun4u code like
<https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg02658.html>
you couldn't access those fields by name (such as "comb_iomem") immediately.

I can think of two ways out:

- Instead of accessing the field from the outside, for the board
mapping, pass the parent memory region in to the helper. (This is my
previous suggestion, and you didn't like it :) )

- or else, in patch v2 4/4, make the guts of FWCfgState / FWCfgIoState /
FWCfgMemState public too. Then board code can get at
"FWCfgIoState.comb_iomem" directly.

Thanks
Laszlo
