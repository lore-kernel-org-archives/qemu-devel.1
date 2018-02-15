Received: from eggs.gnu.org ([2001:4830:134:3::10]:48632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1emGTn-0005RH-HC
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1emGTm-0001jF-LV
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:09:27 -0500
Date: Thu, 15 Feb 2018 11:09:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180215100918.GB4575@localhost.localdomain>
References: <20180213233324.5096-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213233324.5096-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 0/2] s/size/entries/ when
 dealing with non-byte units
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 14.02.2018 um 00:33 hat Eric Blake geschrieben:
> I mentioned this while reviewing Berto's series on L2 slice handling;
> this is a first cut at patches that I think are worth doing throughout
> the qcow2 code base if we like the idea.

I agree it's a good change.

While we're at it, something I noticed in your block status series:
If something points to bytes, it should be an 'offset', and if it
points to entries, it's an 'index'. You changed a few things to byte
granularity, but still call them 'index'. Maybe we should clean that up
as well.

Kevin
