Received: from eggs.gnu.org ([209.51.188.92]:37913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghZoR-0005JO-90
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:51:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghZoO-0008C3-08
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:51:55 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190108122021.GB11492@linux.fritz.box>
References: <20190103213320.2653-1-lbloch@janustech.com>
	<20190103213320.2653-2-lbloch@janustech.com>
	<20190108122021.GB11492@linux.fritz.box>
Date: Thu, 10 Jan 2019 13:51:43 +0100
Message-ID: <w517efcekv4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Kevin Wolf <kwolf@redhat.com>, Leonid Bloch <lbloch@janustech.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, Philippe =?utf-8?Q?Mathi?= =?utf-8?Q?eu-Daud=C3=A9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue 08 Jan 2019 01:20:21 PM CET, Kevin Wolf wrote:
> During a downstream review, Max found a problem with the table that we
> could fix while we're touching it:
>
>     Upstream: All >= S_2GiB are not valid ints.  (qemu assumes that
>     sizeof(int) == 4, right?)  So S_2GiB should be 2147483648u and all
>     above should be ...ull or better UINT64_C().

Should it? sizeof(S_2GiB) is already 8 without having to add any suffix.

Berto
