Received: from eggs.gnu.org ([2001:4830:134:3::10]:42454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drJCc-0000Lb-SZ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drJCZ-0005xV-Pf
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:32:18 -0400
Date: Mon, 11 Sep 2017 09:32:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170911093207.4375c534.cohuck@redhat.com>
In-Reply-To: <1504030416-18618-1-git-send-email-thuth@redhat.com>
References: <1504030416-18618-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] tests: Fix broken
 ivshmem-server-msi/-irq tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Tue, 29 Aug 2017 20:13:36 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Broken with commit b4ba67d9a7025 ("libqos: Change PCI accessors to take
> opaque BAR handle") a while ago, but nobody noticed since the tests are
> only run in SPEED=slow mode: The msix_pba_bar is not correctly initialized
> anymore if bir_pba has the same value as bir_table. With this fix,
> "make check SPEED=slow" should work fine again.
> 
> Fixes: b4ba67d9a702507793c2724e56f98e9b0f7be02b
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/libqos/pci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

There really should be a better tree for that than my s390 tree, but
the other ivshmem patch was feeling a bit lonely, so I queued this as
well. Better than having the patch languish on the list.
