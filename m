Received: from eggs.gnu.org ([209.51.188.92]:57611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1go8zJ-0007PU-8w
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:38:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1go8zH-00082C-F4
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:38:16 -0500
Date: Mon, 28 Jan 2019 16:37:50 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190128153750.GE5756@localhost.localdomain>
References: <20190128151521.13875-1-antonkuchin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128151521.13875-1-antonkuchin@yandex-team.ru>
Subject: Re: [Qemu-devel] [PATCH] qmp: Deprecate query-nodes option of
 query-blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Kuchin <antonkuchin@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, libvir-list@redhat.com, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>, nsoffer@redhat.com

Am 28.01.2019 um 16:15 hat Anton Kuchin geschrieben:
> This option is broken since a6baa60807 in v2.9 and returns mostly
> zeroes instead of real stats because actual querring of BlockStats
> that resides in blk is missing.
> 
> And it makes no sense because with this option BlockDriverState-s
> are iterated but BlockAcctStats belong to BlockBackend and not BDS
> since 7f0e9da6f13 in v2.5
> 
> Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>

Isn't query-nodes the only way to get wr_highest_offset for the protocol
layer? oVirt depends on this, as far as I know.

Kevin
