Received: from eggs.gnu.org ([2001:4830:134:3::10]:34353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cnX67-00039U-H4
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cnX63-00012G-MX
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:01:43 -0400
References: <20170313093104.1280-1-nikunj@linux.vnet.ibm.com>
	<8401331f-bea9-b255-442c-161fd1d0b56e@ilande.co.uk>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <43a7620f-e5d7-f220-4a2a-2193417a4490@ilande.co.uk>
Date: Mon, 13 Mar 2017 21:01:12 +0000
MIME-Version: 1.0
In-Reply-To: <8401331f-bea9-b255-442c-161fd1d0b56e@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH fix for-2.9] target/ppc: fix
 cpu_ov setting for 32-bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, rth@twiddle.net

On 13/03/17 12:54, Mark Cave-Ayland wrote:

> With the patch above I'll try bisecting again later today to try and
> understand where these lines are coming from. So far I've spotted them
> in MacOS 9 and OS X during tests...

Okay - I've completed the bisection, and the artifacts I'm seeing aren't
related to any of the PPC patches. Thanks once again for looking into this.


ATB,

Mark.
