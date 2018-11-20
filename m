Received: from eggs.gnu.org ([2001:4830:134:3::10]:44899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPAkC-0007kr-Ij
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:27:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPAjB-0000Fj-Rw
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:26:28 -0500
Date: Tue, 20 Nov 2018 19:21:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181120182121.GE7513@localhost.localdomain>
References: <cover.1542031058.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542031058.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/16] Don't pass flags to
 bdrv_reopen_queue()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 12.11.2018 um 15:00 hat Alberto Garcia geschrieben:
> Hi all,
> 
> when reopening a BlockDriverState using bdrv_reopen() and friends the
> new options can be specified either with a QDict or with flags. Both
> methods overlap and that makes the semantics and the implementation
> unnecessarily complicated.
> 
> This series removes the 'flags' parameter from these functions, so
> from now on all option changes must be specified using a QDict. Apart
> from simplifying the API, a few bugs are fixed along the way. See the
> individual patches for more details.
> 
> This was tested with the current master (460f0236c12a86a38692c12d9bf).

Looks good to me, except for that one s/int/bool/ that I could do while
applying.

The only remaining question is - is all of this for 3.1, or which parts
are? It's a long series, but there are also a few bug fixes in there.

Kevin
