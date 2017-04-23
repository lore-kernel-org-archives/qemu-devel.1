Received: from eggs.gnu.org ([2001:4830:134:3::10]:35413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2LFs-0002I4-9p
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 13:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2LFp-0005J7-7v
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 13:25:00 -0400
References: <20170314165953.18506-1-andreas@grapentin.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <0d151b9a-46db-b97d-37c8-ccd208190114@msgid.tls.msk.ru>
Date: Sun, 23 Apr 2017 20:24:55 +0300
MIME-Version: 1.0
In-Reply-To: <20170314165953.18506-1-andreas@grapentin.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] use _Static_assert in QEMU_BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Grapentin <andreas@grapentin.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, eblake@redhat.com

14.03.2017 19:59, Andreas Grapentin wrote:
> QEMU_BUILD_BUG_ON should use C11's _Static_assert, if the compiler supports it,
> to provide more readable messages on failure.
...

Applied to -trivial, with trivial commit comment fix.  Thanks!

/mjt
