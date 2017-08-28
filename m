Received: from eggs.gnu.org ([2001:4830:134:3::10]:34530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmIb1-0004wN-VK
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmIaw-0006ij-WF
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:52:48 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170825132332.6734-4-el13635@mail.ntua.gr>
References: <20170825132332.6734-1-el13635@mail.ntua.gr>
	<20170825132332.6734-4-el13635@mail.ntua.gr>
Date: Mon, 28 Aug 2017 13:52:41 +0200
Message-ID: <w51pobfvrhy.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 3/7] block: require job-id when device
 is a node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Fri 25 Aug 2017 03:23:28 PM CEST, Manos Pitsidianakis wrote:
> With implicit filter nodes on the top of the graph it is not possible
> to generate job-ids with the name of the device in block_job_create()
> anymore, since the job's bs will not be a child_root.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
