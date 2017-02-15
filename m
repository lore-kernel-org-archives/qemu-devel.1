Received: from eggs.gnu.org ([2001:4830:134:3::10]:57964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwfS-0002kp-2e
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:18:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwfO-0006es-6F
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:18:34 -0500
References: <20170208170533.28822-1-jsnow@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <88ae6630-7524-fc3c-0e78-4cf95ea8bfcf@msgid.tls.msk.ru>
Date: Wed, 15 Feb 2017 13:18:29 +0300
MIME-Version: 1.0
In-Reply-To: <20170208170533.28822-1-jsnow@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ide: remove undefined behavior in ide-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-trivial@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

08.02.2017 20:05, John Snow wrote:
> trivial: initialize the dirty buffer with a random-ish byte.
> Stops valgrind from whining about uninitialized buffers.

Applied to -trivial, thanks!

/mjt
