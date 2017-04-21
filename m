Received: from eggs.gnu.org ([2001:4830:134:3::10]:50673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1Yrb-0003Um-97
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1YrW-0001SV-59
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:44:43 -0400
Received: from chuckie.co.uk ([82.165.15.123]:51485
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d1YrV-0001RG-SB
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:44:38 -0400
References: <20170421091632.30900-1-kraxel@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <fac7ad7f-c1a5-d039-56f3-f9672ea63f64@ilande.co.uk>
Date: Fri, 21 Apr 2017 14:44:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170421091632.30900-1-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/9] hw/display: make display updates
 thread safe, part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 21/04/17 10:16, Gerd Hoffmann wrote:

>   Hi,
> 
> Ok, 2.10 is open, lets start tackling the display update race
> conditions.  This series adds the helper functions used to receive
> a dirty bitmap snapshot, which is used by the display adapters then.
> Also a bunch of display adapters are converted to use those helpers.
> 
> Changes from previous version:  Fixed one vga patch.  Left out are the
> sparc adapters for now (Mark Cave-Ayland is busy cleaning them up and
> fixing them).  Also left out the patch dropping the temporary
> workaround, that obviously has to wait until all display adapters are
> switched over.

FWIW I'm going to send a pull request for the SPARC adapter cleanups
later today as I'll be AFK for the next week and don't want to hold you up.

I've also rebased my TCX/CG3 "make display updates thread-safe" patches
onto my v2 cleanup patchset and pushed to result to
https://github.com/mcayland/qemu/tree/vga-fixes-sparc so that in my
absence you can cherry-pick the cg3/tcx conversion patches into your
series while I'm away.


ATB,

Mark.
