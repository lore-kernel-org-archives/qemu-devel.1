Received: from eggs.gnu.org ([209.51.188.92]:50303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggqN3-0006F3-3w
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:20:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggqN2-0005gb-GM
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:20:37 -0500
Date: Tue, 8 Jan 2019 13:20:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190108122021.GB11492@linux.fritz.box>
References: <20190103213320.2653-1-lbloch@janustech.com>
	<20190103213320.2653-2-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103213320.2653-2-lbloch@janustech.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Alberto Garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>

Am 03.01.2019 um 22:33 hat Leonid Bloch geschrieben:
> The lookup table for power-of-two sizes is now auto-generated during the
> build, and not hard-coded into the units.h file.
> 
> This partially reverts commit 540b8492618eb.
> 
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>

During a downstream review, Max found a problem with the table that we
could fix while we're touching it:

    Upstream: All >= S_2GiB are not valid ints.  (qemu assumes that
    sizeof(int) == 4, right?)  So S_2GiB should be 2147483648u and all
    above should be ...ull or better UINT64_C().

Kevin
