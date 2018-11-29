Received: from eggs.gnu.org ([2001:4830:134:3::10]:42687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gSR9Y-0000XF-00
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 13:35:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gSR9U-0003A2-FH
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 13:35:07 -0500
Received: from chuckie.co.uk ([82.165.15.123]:39845
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gSR9U-00039V-45
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 13:35:04 -0500
References: <1543442171-24863-1-git-send-email-linux@roeck-us.net>
	<1543442171-24863-2-git-send-email-linux@roeck-us.net>
	<3d1287e7-29c1-dbb1-c0f9-273b7b31645c@redhat.com>
	<734e8388-2f0f-1c5b-7767-29e43d261bcb@ilande.co.uk>
	<20181129173845.GA2929@roeck-us.net>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <be4173c3-353b-1bd7-b937-b0d39a7bba26@ilande.co.uk>
Date: Thu, 29 Nov 2018 18:34:54 +0000
MIME-Version: 1.0
In-Reply-To: <20181129173845.GA2929@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] scsi: esp: Improve consistency of
 RSTAT, RSEQ, and RINTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 29/11/2018 17:38, Guenter Roeck wrote:

> Can you try the attached patch ? It is a bit cleaner than the first version,
> and works for me as well.
> 
> Note that this isn't perfect. Specifically, I see differences in handling
> STAT_TC. The controller specification is a bit ambiguous in that regard,
> but comparing the qemu code with real controller behavior shows that the
> real controller does not reset STAT_TC when reading the interrupt status
> register. That doesn't seem to matter for Linux, but it may influence
> other guests.

I've now completed a boot test of all my SPARC32 OpenBIOS CDROM images with this
patch, and whilst it doesn't solve my NextSTEP issue, I don't see any obvious
regressions.

Note that NetBSD SPARC32 tends to spit out the occasional "!TC on data xfer" message
to the console during periods of disk access, however that is something that has
always happened and isn't something new introduced by this patch.


ATB,

Mark.
