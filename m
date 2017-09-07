Received: from eggs.gnu.org ([2001:4830:134:3::10]:35828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpvrw-0001s5-NH
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpvrs-0006wv-1n
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:25:16 -0400
Date: Thu, 7 Sep 2017 14:24:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170907122453.GF4461@dhcp-200-186.str.redhat.com>
References: <20170825132332.6734-1-el13635@mail.ntua.gr>
	<20170825132332.6734-4-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825132332.6734-4-el13635@mail.ntua.gr>
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
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 25.08.2017 um 15:23 hat Manos Pitsidianakis geschrieben:
> With implicit filter nodes on the top of the graph it is not possible to
> generate job-ids with the name of the device in block_job_create()
> anymore, since the job's bs will not be a child_root.
> 
> Instead we can require that job-id is not NULL in block_job_create(),
> and check that a job-id has been set in the callers of
> block_job_create() in blockdev.c. It is more consistent to require an
> explicit job-id when the device parameter in the job creation command,
> eg
> 
>  { "execute": "drive-backup",
>    "arguments": { "device": "drive0",
>                   "sync": "full",
>                   "target": "backup.img" } }
> 
> is not a BlockBackend name, instead of automatically getting it from the
> root BS if device is a node name. That information is lost after calling
> block_job_create(), so we can do it in its caller instead.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
