Received: from eggs.gnu.org ([2001:4830:134:3::10]:49807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cGi52-00087G-Va
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:04:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cGi4z-0001oi-SB
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:04:56 -0500
References: <1481585316-31612-1-git-send-email-lvivier@redhat.com>
	<1481585316-31612-2-git-send-email-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <577b81e6-1544-1fe5-e26b-3d7fa69cc7c7@redhat.com>
Date: Tue, 13 Dec 2016 09:04:48 +0100
MIME-Version: 1.0
In-Reply-To: <1481585316-31612-2-git-send-email-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/4] qtest: add netfilter tests
 for ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On 13.12.2016 00:28, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  tests/Makefile.include | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index e98d3b6..be6209d 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -283,6 +283,9 @@ gcov-files-ppc64-y += hw/usb/hcd-uhci.c
>  check-qtest-ppc64-y += tests/usb-hcd-xhci-test$(EXESUF)
>  gcov-files-ppc64-y += hw/usb/hcd-xhci.c
>  check-qtest-ppc64-y += $(check-qtest-virtio-y)
> +check-qtest-ppc64-y += tests/test-netfilter$(EXESUF)
> +check-qtest-ppc64-y += tests/test-filter-mirror$(EXESUF)
> +check-qtest-ppc64-y += tests/test-filter-redirector$(EXESUF)
>  
>  check-qtest-sh4-y = tests/endianness-test$(EXESUF)

Reviewed-by: Thomas Huth <thuth@redhat.com>
