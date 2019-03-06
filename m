Received: from eggs.gnu.org ([209.51.188.92]:33967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1Sf7-0000g2-3J
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1Sf5-0006uF-MZ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:16:28 -0500
References: <1551457277-884-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3b4ca6e3-f1dc-e99c-c0f9-866608e5da3b@vivier.eu>
Date: Wed, 6 Mar 2019 10:15:48 +0100
MIME-Version: 1.0
In-Reply-To: <1551457277-884-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] tests: Do not use "\n" in
 g_test_message() strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 01/03/2019 17:21, Thomas Huth wrote:
> g_test_message() takes care of the newline on its own, so we
> should not use \n in the strings here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/ivshmem-test.c         |  4 ++--
>  tests/m48t59-test.c          |  4 ++--
>  tests/migration-test.c       |  4 ++--
>  tests/rtc-test.c             |  4 ++--
>  tests/rtl8139-test.c         |  6 +++---
>  tests/test-aio-multithread.c |  8 ++++----
>  tests/test-coroutine.c       | 10 ++++------
>  tests/vhost-user-test.c      | 14 +++++++-------
>  8 files changed, 26 insertions(+), 28 deletions(-)

The tests/vhost-user-test.c part doesn't apply cleanly on top of master.
Could you resend?

Thanks,
Laurent
