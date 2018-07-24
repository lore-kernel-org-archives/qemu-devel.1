Received: from eggs.gnu.org ([2001:4830:134:3::10]:43876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fhtnh-0007bw-BG
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:40:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fhtnc-0005mj-Cp
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:40:13 -0400
Date: Tue, 24 Jul 2018 11:40:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180724114004.67bc1281.cohuck@redhat.com>
In-Reply-To: <153238409419.10934.1652388192245648682@sif>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
	<20180723201748.25573-6-mdroth@linux.vnet.ibm.com>
	<153238409419.10934.1652388192245648682@sif>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/99] s390-ccw: force diag 308 subcode to
 unsigned long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>

On Mon, 23 Jul 2018 17:14:54 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Quoting Michael Roth (2018-07-23 15:16:14)
> > From: Cornelia Huck <cohuck@redhat.com>
> > 
> > We currently pass an integer as the subcode parameter. However,
> > the upper bits of the register containing the subcode need to
> > be 0, which is not guaranteed unless we explicitly specify the
> > subcode to be an unsigned long value.
> > 
> > Fixes: d046c51dad3 ("pc-bios/s390-ccw: Get device address via diag 308/6")
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Tested-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > (cherry picked from commit 63d8b5ace31c1e1f3996fe4cd551d6d377594d5a)
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>  
> 
> Hi Cornelia,
> 
> Would you be able to do an s390 BIOS build for this one as well?

Sure, will do a build for 2.12-stable.
