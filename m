Received: from eggs.gnu.org ([2001:4830:134:3::10]:37671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1d5jEG-0001vC-CD
	for qemu-devel@nongnu.org; Tue, 02 May 2017 21:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1d5jEB-00059P-Qp
	for qemu-devel@nongnu.org; Tue, 02 May 2017 21:37:20 -0400
In-Reply-To: <20170426043441.GN16882@umbus.fritz.box>
References: <201704212158.v3LLwNYl031738@linux03a.ddci.com>
	<20170426043441.GN16882@umbus.fritz.box>
MIME-Version: 1.0
From: alarson@ddci.com
Message-ID: <OF2ACF2223.8C7339DB-ON86258115.000819F0-86258115.0008E549@ddci.com>
Date: Tue, 2 May 2017 20:37:09 -0500
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [Qemu-devel] Subject: [PATCH] target-ppc: Add global timer
 group A to open-pic.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

David Gibson <david@gibson.dropbear.id.au> wrote on 04/25/2017 11:34:41 
PM:

Thanks for the review David.  I'll send an updated patch soon with all
your comments addressed and all other s/0/NULL or false/ as
appropriate and a better commit message.

Just to clarify my concern; the patch causes the QEMU openpic timer to
be hard coded at 100MHZ.  This is common, but the openpic spec has
numerous ways the clock could be driven and the actual frequency
depends on target board configuration.  Given that no other users are
apparently using the QEMU openpic timer, it is probably ok, but I did
want to point out the deficiency.
