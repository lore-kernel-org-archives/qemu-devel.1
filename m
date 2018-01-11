Received: from eggs.gnu.org ([2001:4830:134:3::10]:53144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1eZbLd-0002ht-HU
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 06:48:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1eZbLZ-0000hL-Nh
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 06:48:41 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:46425
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chouteau@adacore.com>)
	id 1eZbLZ-0000fX-GR
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 06:48:37 -0500
References: <20180110204327.22510-1-jcd@tribudubois.net>
From: Fabien Chouteau <chouteau@adacore.com>
Message-ID: <a2aa7ea7-ac15-d69e-82cd-dad6c89c61c7@adacore.com>
Date: Thu, 11 Jan 2018 12:48:33 +0100
MIME-Version: 1.0
In-Reply-To: <20180110204327.22510-1-jcd@tribudubois.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] LEON3 IRQMP: Fix IRQ software ack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk

On 10/01/2018 21:43, Jean-Christophe Dubois wrote:
> With the LEON3 IRQ controller IRQs can be acknoledged 2 ways:
> * Explicitely by software writing to the CLEAR_OFFSET register
> * Implicitely when the procesor is done running the trap handler attached
>   to the IRQ.
> 

Thanks Jean-Christophe,

I tested the patch with our software and it works.

Reviewed-by: Fabien Chouteau <chouteau@adacore.com>
