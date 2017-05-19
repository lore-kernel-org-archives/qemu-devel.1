Received: from eggs.gnu.org ([2001:4830:134:3::10]:35251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1dBiQy-0005pX-6j
	for qemu-devel@nongnu.org; Fri, 19 May 2017 09:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1dBiQt-0000Lt-JB
	for qemu-devel@nongnu.org; Fri, 19 May 2017 09:59:12 -0400
Received: from jessie.kos.to ([212.47.231.226]:40418 helo=pilvi.kos.to)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <voipio@kos.to>) id 1dBiQt-0000Kl-D2
	for qemu-devel@nongnu.org; Fri, 19 May 2017 09:59:07 -0400
Date: Fri, 19 May 2017 13:59:05 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20170519135905.GA19553@kos.to>
References: <20170311175019.GA7195@ls3530.fritz.box>
	<b4ca5292-bee3-1e3b-13ba-7dd6c1f00f8a@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4ca5292-bee3-1e3b-13ba-7dd6c1f00f8a@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix TARGET_MAP* and
 TARGET_F_??LCK for hppa arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org

On Sun, Mar 12, 2017 at 08:17:46AM +1000, Richard Henderson wrote:
> On 03/12/2017 03:50 AM, Helge Deller wrote:
> >TARGET_MAP_TYPE needs to be 0x03 instead of 0x0f on the hppa
> >architecture, otherwise it conflicts with MAP_FIXED which is 0x04.
> >
> >Add missing TARGET_MAP_STACK and TARGET_MAP_HUGETLB values.
> >
> >Fix TARGET_F_RDLCK, TARGET_F_WRLCK and TARGET_F_UNLCK.
> >
> >Signed-off-by: Helge Deller <deller@gmx.de>
> 
> I applied the MAP_FIXED and TARGET_F_* parts separately in my tree.  I'd
> like to see what others think about the other MAP_* defines before including
> that.

What's the current state of these patches? Are these patches still waiting for
opinions?

Riku
