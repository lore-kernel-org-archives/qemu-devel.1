Received: from eggs.gnu.org ([2001:4830:134:3::10]:51455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eDBHH-00086v-0p
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eDBHG-0005SP-7d
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:31:31 -0500
Date: Fri, 10 Nov 2017 23:31:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171110153103.GB9235@lemon.Home>
References: <20171109204315.27072-1-mreitz@redhat.com>
	<20171110024557.GB4849@lemon>
	<20171110131752.GD5466@localhost.localdomain>
	<20171110133207.GA9235@lemon.Home>
	<d0e58edd-39cf-2bb5-61bd-442825b82ff9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0e58edd-39cf-2bb5-61bd-442825b82ff9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] block: Keep strong reference when
 draining all BDS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Fri, 11/10 16:23, Max Reitz wrote:
> But bdrv_unref() is safe only in the main loop.  Without having checked,
> I'm not sure whether all callers of bdrv_next() are running in the main
> loop.

They must be. The reasoning is simple:

1) one needs to acquire the ctx of all the BDSes for safe access;
2) only main loop can acquire any BDS' ctx;

So there is no way bdrv_next can work in an IOThread.

Fam
