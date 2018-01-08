Received: from eggs.gnu.org ([2001:4830:134:3::10]:45032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eYYgH-0008U3-Ai
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eYYgG-0003J4-KC
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:45:41 -0500
Date: Mon, 8 Jan 2018 15:45:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180108144527.GG8052@localhost.localdomain>
References: <20171226065300.9890-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171226065300.9890-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] osdep: Retry SETLK upon EINTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-block@nongnu.org

Am 26.12.2017 um 07:53 hat Fam Zheng geschrieben:
> We could hit lock failure if there is a signal that makes fcntl return
> -1 and errno set to EINTR. In this case we should retry.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin
