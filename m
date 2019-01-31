Received: from eggs.gnu.org ([209.51.188.92]:51646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpGaO-0006ls-Al
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpGa0-0005Kz-Pm
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:49 -0500
Date: Thu, 31 Jan 2019 18:56:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190131185621.28815291.cohuck@redhat.com>
In-Reply-To: <1548956828-10210-1-git-send-email-thuth@redhat.com>
References: <1548956828-10210-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x: Fix the function arguments in
 the pci stub file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 31 Jan 2019 18:47:08 +0100
Thomas Huth <thuth@redhat.com> wrote:

> The arguments of the stub functions to not match the real implementation

s/to/do/

> (and the prototypes in the header) anymore, so if you try to compile s390x
> without CONFIG_PCI, the build currently fails.
> 

Fixes: 468a93898a97 ("s390x/pci: pass the retaddr to all PCI instructions")

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/s390-pci-stub.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

This file seems to be in danger of bitrot. Do you think it'll be easier
to test rarely used configs like that after we switch to Kconfig?
