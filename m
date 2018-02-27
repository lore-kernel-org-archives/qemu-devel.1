Received: from eggs.gnu.org ([2001:4830:134:3::10]:52372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eqalb-0004t5-70
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eqalV-00010H-OG
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:37:43 -0500
Date: Tue, 27 Feb 2018 16:37:18 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180227083718.GA25412@lemon.usersys.redhat.com>
References: <20180122220806.22154-1-mreitz@redhat.com>
	<20180122220806.22154-7-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180122220806.22154-7-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/16] block/mirror: Use CoQueue to wait
 on in-flight ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, 01/22 23:07, Max Reitz wrote:
>      qemu_iovec_destroy(&op->qiov);
> -    g_free(op);
>  
> -    if (s->waiting_for_io) {
> -        qemu_coroutine_enter(s->common.co);
> -    }
> +    qemu_co_queue_restart_all(&op->waiting_requests);
> +    g_free(op);

OK, this answers my question to patch 5.

Fam
