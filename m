Received: from eggs.gnu.org ([2001:4830:134:3::10]:34777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1dLu9P-0001qX-CT
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1dLu9M-00011Q-5i
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:31:11 -0400
In-Reply-To: <201706051722.v55HMrD0024174@linux03a.ddci.com>
References: <201706051722.v55HMrD0024174@linux03a.ddci.com>
MIME-Version: 1.0
From: alarson@ddci.com
Message-ID: <OF9DCCDCC7.1E15B7C2-ON86258141.005A829A-86258141.005ABB35@ddci.com>
Date: Fri, 16 Jun 2017 11:31:02 -0500
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [Qemu-devel] [PATCH v3] target-ppc: Enable open-pic timers to
 count and generate interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: agraf@suse.de, david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

Aaron Larson <alarson@ddci.com> wrote on 06/05/2017 12:22:53 PM:

> From: Aaron Larson <alarson@ddci.com>
> To: agraf@suse.de, alarson@ddci.com, david@gibson.dropbear.id.au, 
qemu-devel@nongnu.org, qemu-ppc@nongnu.org
> Date: 06/05/2017 12:22 PM
> Subject: [PATCH v3] target-ppc: Enable open-pic timers to count and 
generate interrupts
> 
> Previously QEMU open-pic implemented the 4 open-pic timers including
> all timer registers, but the timers did not "count" or generate any
> interrupts.  The patch makes the timers both count and generate
> interrupts.  The timer clock frequency is fixed at 25MHZ.
> 
> --
> 
> Responding to V2 patch comments.
> - Simplify clock frequency logic and commentary.
> - Remove camelCase variables.
> - Timer objects now created at init rather than lazily.
> 
> Signed-off-by: Aaron Larson <alarson@ddci.com>


I haven't received any feedback on this patch, and I don't see a response 
on the mailing list archive.  Did it get lost?
