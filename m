Received: from eggs.gnu.org ([209.51.188.92]:57638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gkAho-0005DV-Qx
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gkAho-0001ss-4R
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:39:48 -0500
Date: Thu, 17 Jan 2019 17:39:39 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190117163939.GB6761@localhost.localdomain>
References: <20190117153321.29749-1-eblake@redhat.com>
	<20190117153321.29749-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117153321.29749-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] block: Expose protocol-specific data
 to 'qemu-img info'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Am 17.01.2019 um 16:33 hat Eric Blake geschrieben:
> 'qemu-img info' is useful for showing additional information
> about an image - but sometimes the interesting information is
> specific to the protocol rather than to the format layer.  Set
> the groundwork for showing this information; further patches
> will then enable specific pieces of information.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Isn't this making invalid assumptions about the structure of the block
graph? Who says that I don't have a quorum node below the format layer
with five different protocol layer children? Some of which may have
filter nodes on top?

Kevin
