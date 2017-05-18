Received: from eggs.gnu.org ([2001:4830:134:3::10]:42468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dBLPD-0005Du-74
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dBLPC-0004lQ-9J
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:23:51 -0400
Date: Thu, 18 May 2017 14:23:41 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170518132341.GP16511@redhat.com>
References: <20170515100059.15795-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170515100059.15795-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] curl: locking cleanups/fixes,
 coroutine conversion, remove aio_poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, qemu-block@nongnu.org

On Mon, May 15, 2017 at 12:00:52PM +0200, Paolo Bonzini wrote:
> Compared to v2, this silences checkpatch and correctly destroy the mutex on
> exiting from curl_open with an error.

FWIW I hit the curl bug again and tested the current patch
series, and it also fixes the bug (as expected).

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
