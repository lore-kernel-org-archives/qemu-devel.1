Received: from eggs.gnu.org ([2001:4830:134:3::10]:34257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cfekP-0003Rb-Vt
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 22:34:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cfekM-0007rH-Sk
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 22:34:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cfekM-0007qw-Nh
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 22:34:42 -0500
References: <1487299994-98348-1-git-send-email-zhang.zhanghailiang@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cc504369-ca7c-f654-1110-5f64ee0a4fb4@redhat.com>
Date: Mon, 20 Feb 2017 11:34:35 +0800
MIME-Version: 1.0
In-Reply-To: <1487299994-98348-1-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/4] colo-compare: fix some bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, xuquan8@huawei.com, pss.wulizhen@huawei.com



On 2017=E5=B9=B402=E6=9C=8817=E6=97=A5 10:53, zhanghailiang wrote:
> This series includes two parts: codes optimization and bug fix.
> patch 1 tries to move timer process into colo compare thread as
> a new coroutine.
> patch 2 ~ 4 fixe some bugs of colo compare.
>
> v2->v3:
>   - change the definition of remove_fd_in_watch() instead of
>     introducing a function (Marc-Andr=C3=A9 Lureau's suggestion)
> v1->v2:
>   - Squash patch 3 of last version into patch 2. (ZhangChen's suggestio=
n)
>
> zhanghailiang (4):
>    colo-compare: use g_timeout_source_new() to process the stale packet=
s
>    colo-compare: kick compare thread to exit after some cleanup in
>      finalization
>    char: remove the right fd been watched in qemu_chr_fe_set_handlers()
>    colo-compare: Fix removing fds been watched incorrectly in
>      finalization
>
>   chardev/char-fd.c     |   6 +--
>   chardev/char-io.c     |   8 ++--
>   chardev/char-io.h     |   2 +-
>   chardev/char-pty.c    |   2 +-
>   chardev/char-socket.c |   4 +-
>   chardev/char-udp.c    |   6 +--
>   chardev/char.c        |   2 +-
>   net/colo-compare.c    | 115 ++++++++++++++++++++++++++---------------=
---------
>   8 files changed, 74 insertions(+), 71 deletions(-)
>

Applied, thanks.
