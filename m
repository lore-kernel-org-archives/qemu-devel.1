Received: from eggs.gnu.org ([2001:4830:134:3::10]:40867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKNrG-00052d-2z
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKNrC-0000yC-QZ
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:50:10 -0400
Received: from chuckie.co.uk ([82.165.15.123]:38811
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dKNrC-0000xZ-J8
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:50:06 -0400
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497097821-32754-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170612133740.2f3eef83@nial.brq.redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <5834ba7c-f386-da2c-791c-ef8f48bb23da@ilande.co.uk>
Date: Mon, 12 Jun 2017 12:49:57 +0100
MIME-Version: 1.0
In-Reply-To: <20170612133740.2f3eef83@nial.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: ehabkost@redhat.com, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, lersek@redhat.com

On 12/06/17 12:37, Igor Mammedov wrote:

> On Sat, 10 Jun 2017 13:30:18 +0100
> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> 
>> The dma_enabled property enables us to set the FW_CFG_ID version
>> accordingly.
> it might be not safe as patch reorders FW_CFG_ID entry.
> 
> (I recall there were patches that sorted fwcfg entries,
> but it's worth checking that it won't break migration)
> 
> CCing Gerd, maybe he would recall how it works.

Ah so the order in fw_cfg needs to be preserved? (my assumption was that
the slot-id also specified the order). I'll have a look and see if I can
fix this with a simple re-ordering.


ATB,

Mark.
