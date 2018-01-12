Received: from eggs.gnu.org ([2001:4830:134:3::10]:35841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1ea2sG-0006QS-TY
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1ea2sD-0005bv-Mw
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:12:12 -0500
Received: from p3plsmtpa12-06.prod.phx3.secureserver.net
	([68.178.252.235]:54722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <steven.seeger@flightsystems.net>)
	id 1ea2sD-0005aF-GH
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:12:09 -0500
From: Steven Seeger <steven.seeger@flightsystems.net>
Reply-To: steven.seeger@flightsystems.net
Date: Fri, 12 Jan 2018 12:12:04 -0500
Message-ID: <3481129.GfW4dsff78@wirbelwind>
In-Reply-To: <2177d773-9d69-f432-9353-4553e098cf1f@redhat.com>
References: <2465248.BadtJazF69@wirbelwind>
	<2177d773-9d69-f432-9353-4553e098cf1f@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Qemu-devel] ppc icount questions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Friday, January 12, 2018 11:52:57 AM EST Paolo Bonzini wrote:
> What is the guest doing in the meanwhile?

The guest is running vxWorks with several threads. The CPU does idle at times. 

> virtual time increases only when instructions are executed, or when the
> CPUs are idle (in the latter case, behavior depends on "-icount sleep":
> if on, it increases at the same pace as real time, if off, it jumps
> immediately to the next deadline).

If we jump to the next available deadline, won't that run faster than 
realtime? The preferred goal here is to run realtime (sleep as appropriate) 
but slow down if the guest or model world requires too many host resources. 
But, the desire would be to maintain proportionality between number of 
instructions executed and increase in virtual time. 

One of the things happening in the guest code is there is a once-per-second 
interrupt and a once-per-10ms interrupt that the software expects to see in-
phase with each other. If not, then errors occur. I am seeing errors when I do 
more work in the device model. However, even with this extra work disabled I 
still do not see the timer granularity I expect.

Sorry for all the questions.

Steven
