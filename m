Received: from eggs.gnu.org ([2001:4830:134:3::10]:47945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4S8y-0006C5-1d
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4S8w-0000Mb-Up
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:42:52 -0400
Date: Tue, 17 Oct 2017 09:42:36 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171017134236.GE5170@localhost.localdomain>
References: <cover.1508213452.git.jcody@redhat.com>
	<150821906704.362.13005411635358071895@b58463cdfd5f>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150821906704.362.13005411635358071895@b58463cdfd5f>
Subject: Re: [Qemu-devel] [PATCH v4 00/10] qemu-iotests improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

On Mon, Oct 16, 2017 at 10:44:27PM -0700, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
> 
> Type: series
> Message-id: cover.1508213452.git.jcody@redhat.com
> Subject: [Qemu-devel] [PATCH v4 00/10] qemu-iotests improvements
> 
> QEMU          -- "/tmp/qemu-test/build/x86_64-softmmu/qemu-system-x86_64" -nodefaults -machine accel=qtest
> QEMU_IMG      -- "/tmp/qemu-test/build/qemu-img" 
> QEMU_IO       -- "/tmp/qemu-test/build/qemu-io"  --cache writeback -f raw
> QEMU_NBD      -- "/tmp/qemu-test/build/qemu-nbd" 
> IMGFMT        -- raw
> IMGPROTO      -- file
> PLATFORM      -- Linux/x86_64 3046d9847e74 4.11.10-300.fc26.x86_64
> TEST_DIR      -- /tmp/qemu-test
> SOCKET_SCM_HELPER -- /tmp/qemu-test/build/tests/qemu-iotests/socket_scm_helper
> 
> 001        /tmp/qemu-test/src/tests/qemu-iotests/common.rc: line 44: ./common.config: No such file or directory
> ./check: failed to source common.config
> /tmp/qemu-test/src/tests/qemu-iotests/common.rc: line 44: ./common.config: No such file or directory
> ./check: failed to source common.config
>  - output mismatch (see 001.out.bad)mv: cannot stat '/tmp/qemu-test/001/001.out': No such file or directory
> diff: /tmp/qemu-test/build/tests/qemu-iotests/001.out.bad: No such file or directory
>  [failed, exit status 1]

Sigh.  Broken for out-of-tree builds, but it is an easy fix.  v11 incoming.

-Jeff
