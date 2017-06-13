Received: from eggs.gnu.org ([2001:4830:134:3::10]:43375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKqXR-0006mR-OT
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKqXN-0005Jt-Kp
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:27:37 -0400
Received: from chuckie.co.uk ([82.165.15.123]:45455
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dKqXN-0005Jg-D2
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:27:33 -0400
References: <1497302470-10776-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497302470-10776-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<8028308f-9aac-abb6-25df-599d32d4d0ce@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <23a71020-eb37-3c4b-5260-550935bb074d@ilande.co.uk>
Date: Tue, 13 Jun 2017 19:27:11 +0100
MIME-Version: 1.0
In-Reply-To: <8028308f-9aac-abb6-25df-599d32d4d0ce@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, peter.maydell@linaro.org

On 12/06/17 23:27, Laszlo Ersek wrote:

> It turns out that we introduced the "iobase" and "dma_iobase" properties
> *solely* so that we could pass arguments to fw_cfg_io_realize(). But
> fw_cfg_io_realize() only needed those parameters for the *wrong* purpose
> (namely calling sysbus_add_io()). By eliminating the sysbus_add_io()
> calls from fw_cfg_io_realize(), the related properties become
> unnecessary too.
> 
> (NB, setting the "dma_enabled" property in fw_cfg_init_io_dma(), and
> setting "data_width" and "dma_enabled" in fw_cfg_init_mem_wide(), remain
> necessary, because those aren't related to region mapping.)
> 
> What do you think?

Yeah, I like the sound of this approach much better since it keeps the
functionality similar between both the memory and ioport instances. I've
got something basic going but I don't think I'm going to have time to
finish it tonight.


ATB,

Mark.
