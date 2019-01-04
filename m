Received: from eggs.gnu.org ([208.118.235.92]:51390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gfMAK-00070A-NC
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:53:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gfMAF-0004OA-VH
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:53:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gfMAF-0004Nc-Q7
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:53:15 -0500
Date: Fri, 4 Jan 2019 15:23:10 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <fcb58ca9-5019-5c46-24f8-3c09961ddd56@ilande.co.uk>
Message-ID: <nycvar.YSQ.7.76.1901041521590.2878@xnncv>
References: <20190103093704.32635-1-ppandit@redhat.com>
	<cd325b25-15ee-46e4-896e-e5904340b1bf@ilande.co.uk>
	<nycvar.YSQ.7.76.1901041111410.31402@xnncv>
	<fcb58ca9-5019-5c46-24f8-3c09961ddd56@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] sun4u: add power_mem_read routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>

+-- On Fri, 4 Jan 2019, Mark Cave-Ayland wrote --+
| I asked someone with real Ultra-5 hardware to check this for me, and they've 
| sent me back the following output:
| 
| ok .properties
| address                  fffb8000
| button
| interrupts               00000001
| reg                      00000014 00724000 00000004
| name                     power
| ok fffb8000 l@ u.
| 0
| 
| Looks like the read value should be all 0s rather than all 1s. Can you resubmit the
| patch with this change?

Done. Sent patch v1.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
