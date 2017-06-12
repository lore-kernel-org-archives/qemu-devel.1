Received: from eggs.gnu.org ([2001:4830:134:3::10]:42176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKNvU-0007ma-9G
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKNvR-0002IQ-7R
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:54:32 -0400
Received: from chuckie.co.uk ([82.165.15.123]:38824
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dKNvR-0002I8-04
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:54:29 -0400
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497097821-32754-3-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170612134328.76c5a352@nial.brq.redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <84a176fb-0d57-09f5-15c3-8e2bd4c66f48@ilande.co.uk>
Date: Mon, 12 Jun 2017 12:54:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170612134328.76c5a352@nial.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] fw_cfg: move qdev_init_nofail() out
 from fw_cfg_init1() into callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: ehabkost@redhat.com, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On 12/06/17 12:43, Igor Mammedov wrote:

> On Sat, 10 Jun 2017 13:30:17 +0100
> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> 
> patch needs a commit message saying why it's needed.
> maybe add something similar to:
> 
> qdev_init_nofail() essentially 'realizes' object,
> taking in account that fw_cfg_init1() will be moved to
> realize in follow up patches, move qdev_init_nofail() outside of
> fw_cfg_init1().

Yes, I can alter the commit message to provide more explanation. For
some background the use case can be found in my follow-up sun4u patches
here (i.e. preparation for moving the ebus device behind a PCI bridge):

https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg02658.html
https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg02656.html


ATB,

Mark.
