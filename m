Received: from eggs.gnu.org ([2001:4830:134:3::10]:42571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dkx63-0003xZ-Uu
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dkx60-00086P-2l
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:43:16 -0400
Date: Thu, 24 Aug 2017 19:43:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170824184308.GD4368@stefanha-x1.localdomain>
References: <20170822101535.4695-1-el13635@mail.ntua.gr>
	<20170822101535.4695-7-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822101535.4695-7-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v7 6/6] qemu-iotests: add 184 for throttle
 filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>

On Tue, Aug 22, 2017 at 01:15:35PM +0300, Manos Pitsidianakis wrote:
> +_supported_fmt qcow2

What makes this test qcow2-specific?  With additional filtering for
IMGFMT it should be possible to run this on any image format.
