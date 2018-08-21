Received: from eggs.gnu.org ([2001:4830:134:3::10]:34243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1frv7J-0001Ln-Gi
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 21:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fruu8-0005Ub-JV
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 20:52:17 -0400
Date: Tue, 21 Aug 2018 08:52:09 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180821005209.GI10682@lemon.usersys.redhat.com>
References: <20180817054758.14515-1-famz@redhat.com>
	<153455250874.26120.13466077866433572221@502c9da6d61e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153455250874.26120.13466077866433572221@502c9da6d61e>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] file-posix: Simplifications on
 image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Fri, 08/17 17:35, no-reply@patchew.org wrote:
> ERROR:/tmp/qemu-test/src/tests/test-image-locking.c:69:check_locked_bytes: assertion failed (perm_expected == !!qemu_lock_fd_test(fd, 100 + i, 1, true)): (1 == 0)

This image doesn't have OFD locking support in its glibc. Will add a check in
the test code and skip.

Fam
