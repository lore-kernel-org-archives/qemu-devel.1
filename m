Received: from eggs.gnu.org ([209.51.188.92]:43782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmz0e-0005je-QT
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:46:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmz0d-0001rD-5W
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:46:52 -0500
Date: Fri, 25 Jan 2019 11:46:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190125104644.GB9055@linux.fritz.box>
References: <20190111191401.18317-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111191401.18317-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/1] block: Eliminate the S_1KiB, S_2KiB,
 ... macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, lbloch@janustech.com, qemu-block@nongnu.org

Am 11.01.2019 um 20:14 hat Markus Armbruster geschrieben:
> Back in September, Leonid Block added a whole bunch of macros (commit
> 540b8492618) to improve readability of qcow2.h a bit (commit
> b6a95c6d100).  He later used them to fix the "vdi" driver's parameter
> cluster_size's default value (commit 3dd5b8f4718).  He has now
> proposed a further patch[1] to auto-generate these macros.  That patch
> feels overengineered to me.
> 
> On closer examination, I found I dislike the macros before his new
> patch.  So did Eric Blake.
> 
> The macros exist because the common KiB, MiB, ... macros aren't usable
> when you need a literal rather than a constant expression.
> stringify() does, and we use it to define the QemuOpts default value.
> 
> Eric proposed to improve QemuOpts to accept integer default values,
> too[2].  Before I review that patch series, I want to establish a
> "stupidest solution that can possibly work" baseline.  And that's what
> this patch is.
> 
> [1] [PATCH v2 0/1] include: Auto-generate the sizes lookup table
> Message-ID: <20190103213320.2653-1-lbloch@janustech.com>
> 
> [2] [PATCH v3 0/6] include: Auto-generate the sizes lookup table
> Message-Id: <20190110191901.5082-1-eblake@redhat.com>

Thanks, applied to the block branch.

Kevin
