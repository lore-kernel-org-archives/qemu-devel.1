Received: from eggs.gnu.org ([2001:4830:134:3::10]:33922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0PDh-0008Tl-T3
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0PDh-0001nI-16
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:19:17 -0400
Date: Mon, 26 Mar 2018 12:18:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180326101851.GA5267@localhost.localdomain>
References: <20180321173714.14741-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321173714.14741-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2 00/12] block: Follow-up for
 .bdrv_co_create (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

Am 21.03.2018 um 18:37 hat Kevin Wolf geschrieben:
> This series adds qemu-iotests for a few more block drivers (yet more to
> come in another series) and fixes a few things that previous review and
> these tests brought up.
> 
> The only major design change is that I converted the vdi block driver
> from a boolean 'static' create option to the standard 'preallocation'
> one that other drivers are using. This seems like a good move to make
> while the interface isn't stable yet.
> 
> v2:
> - Patch 1: Mention allowed values for 'preallocation' [Eric]
> - Patch 3: Fixed comments, removed 2^63-512 case [Eric]
> - Patch 6: Added missing reference output change [Eric]
> - Patch 7: s/UINT64_MAX/INT64_MAX/ [Eric]
> - Patches 8 and 12: Fixed comments [Eric]

Applied to the block branch.

Kevin
