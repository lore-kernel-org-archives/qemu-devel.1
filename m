Received: from eggs.gnu.org ([2001:4830:134:3::10]:49603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fiFUK-0004ge-Gm
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 04:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fiFUH-0006yP-IW
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 04:49:40 -0400
Date: Wed, 25 Jul 2018 10:49:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180725084928.GB4879@localhost.localdomain>
References: <20180724200343.13733-1-lbloch@janustech.com>
	<20180724200343.13733-2-lbloch@janustech.com>
	<3edeb663-8e53-ec83-bc19-45a5804d6be3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3edeb663-8e53-ec83-bc19-45a5804d6be3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/5 for-3.0] A grammar fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 24.07.2018 um 23:00 hat Eric Blake geschrieben:
> On 07/24/2018 03:03 PM, Leonid Bloch wrote:
> 
> Subject line is rather vague; at a bare minimum, mentioning 'qcow2:' might
> be helpful. But the maintainer can improve that. My suggestion:
> 
> qcow2: grammar fix for conflicting cache sizing

How about "qcow2: Grammar fix for conflicting cache size options"?

> > Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> > ---
> >   block/qcow2.c              | 2 +-
> >   tests/qemu-iotests/103.out | 2 +-

You replaced only one of the two places in the reference output, so 103
fails for me now.

Kevin
