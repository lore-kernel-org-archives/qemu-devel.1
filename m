Received: from eggs.gnu.org ([2001:4830:134:3::10]:46177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUcKk-0005mb-9A
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUcKf-0005GI-Lq
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:46:38 -0500
Date: Sat, 21 Jan 2017 00:46:23 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170120164623.GA26754@lemon.Home>
References: <20170120072310.8009-1-famz@redhat.com>
	<148492434786.28.11007437642214567106@b042e9bf0dd0>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148492434786.28.11007437642214567106@b042e9bf0dd0>
Subject: Re: [Qemu-devel] [PATCH v11 00/16] block: Image locking series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, rjones@redhat.com, mreitz@redhat.com

On Fri, 01/20 06:59, no-reply@patchew.org wrote:
> Hi,
> ERROR:/tmp/qemu-test/src/tests/test-image-lock.c:109:do_test_compat_one: 'blk2' should not be NULL

Failed because centos 6 doesn't support F_OFD_SETLK. Will respin to ignore
locking in this case.
