Received: from eggs.gnu.org ([2001:4830:134:3::10]:52365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eiQlR-00005I-92
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 15:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eiQlP-0006b0-SF
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 15:19:49 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:39561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eiQlP-0006Zu-KM
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 15:19:47 -0500
Received: by mail-oi0-x244.google.com with SMTP id j188so18413853oib.6
	for <qemu-devel@nongnu.org>; Sun, 04 Feb 2018 12:19:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180108143105.GC10273@lst.de>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-12-git-send-email-mjc@sifive.com>
	<20180108143105.GC10273@lst.de>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 5 Feb 2018 09:19:46 +1300
Message-ID: <CAHNT7Nss8ewkpgo2OTPpBV11WaisgU5a-h22-AbotyKdVqjxwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 11/21] RISC-V HTIF Console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoph Hellwig <hch@lst.de>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Tue, Jan 9, 2018 at 3:31 AM, Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Jan 03, 2018 at 01:44:15PM +1300, Michael Clark wrote:
> > HTIF (Host Target Interface) provides console emulation for QEMU. HTIF
> > allows identical copies of BBL (Berkeley Boot Loader) and linux to run
> > on both Spike and QEMU. BBL provides HTIF console access via the
> > SBI (Supervisor Binary Interface) and the linux kernel SBI console.
>
> Do you have a current spec for the SBI?  I haven't been able to find
> any current reference since it was removed from the privileged spec.
>

AFAIK it still needs to be documented.

BTW I've created branches in my own personal trees for Privileged ISA
v1.9.1. These trees are what I use for v1.9.1 backward compatibility
testing in QEMU:

- https://github.com/michaeljclark/riscv-linux/tree/riscv-linux-4.6.2
- https://github.com/michaeljclark/riscv-pk/tree/bbl-1.9.1

We need to be a little more disciplined with software releases, especially
when there are backward incompatible changes in the specification. The
repos need to be branched and tagged. It should be possible to somehow
derive the conformance level. Perhaps the SBI should have an API for this.
This is one of the driving reasons behind adding version conformance levels
to QEMU. Previously we had repos in a state of flux and if you didn't have
the magic commit ids you were out of luck. For example, when we have
priv isa v1.11 released, we will still need a priv isa v1.10 mode which
masks out all of the new features. Given there are no "feature bits"
besides the extensions "IMAFDSU", all we have to go on presently is the
privileged ISA spec version number.
