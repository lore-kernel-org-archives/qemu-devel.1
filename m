Received: from eggs.gnu.org ([2001:4830:134:3::10]:40101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clXfU-0001XT-0t
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clXfT-0001et-6Y
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:13:59 -0500
Date: Wed, 8 Mar 2017 10:13:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170308091346.GB5211@noname.redhat.com>
References: <20170308021533.78292-1-bjsdjshi@linux.vnet.ibm.com>
	<20170308021533.78292-2-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308021533.78292-2-bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] block: Handle NULL options
 correctly in raw_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, pasic@linux.vnet.ibm.com

Am 08.03.2017 um 03:15 hat Dong Jia Shi geschrieben:
> A normal call for raw_open should always pass in a non-NULL @options,
> but for some certain cases (e.g. trying to applying snapshot on a RBD
> image), they call raw_open with a NULL @options right after the calling
> for raw_close.
> 
> Let's take the NULL @options as a sign of trying to do raw_open again,
> and just simply return a success code.
> 
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

I think we rather need to fix bdrv_snapshot_goto() so that it doesn't
pass NULL, but the actual options that were given for the node (i.e.
bs->options).

Kevin
