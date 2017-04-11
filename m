Received: from eggs.gnu.org ([2001:4830:134:3::10]:52720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxvlp-00063W-NW
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxvlk-0000ma-0y
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:23:45 -0400
Date: Tue, 11 Apr 2017 15:23:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170411132334.GK4516@noname.str.redhat.com>
References: <20170411131327.10734-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411131327.10734-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9?] block/nfs: Do not strcmp() with
 NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>

Am 11.04.2017 um 15:13 hat Max Reitz geschrieben:
> Parsing the URI is not required to give us a scheme; uri->scheme may be
> NULL.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
