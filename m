Received: from eggs.gnu.org ([2001:4830:134:3::10]:49480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cGm06-00080m-3T
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cGm01-0008PR-Rm
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:16:06 -0500
Received: from 2.mo1.mail-out.ovh.net ([178.32.119.250]:58069)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cGm01-0008NM-M3
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:16:01 -0500
Received: from player795.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id DE46128142
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 13:15:55 +0100 (CET)
Date: Tue, 13 Dec 2016 13:15:49 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20161213131549.2546a695@bahia.lan>
In-Reply-To: <1481585316-31612-2-git-send-email-lvivier@redhat.com>
References: <1481585316-31612-1-git-send-email-lvivier@redhat.com>
	<1481585316-31612-2-git-send-email-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] qtest: add netfilter tests for ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org

On Tue, 13 Dec 2016 00:28:33 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

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
>  

Reviewed-by: Greg Kurz <groug@kaod.org>

And this what I get on x86, x86_64, pp64 and ppc64le hosts:

TEST: tests/test-netfilter... (pid=1433)
  /ppc64/netfilter/addremove_one:                                      OK
  /ppc64/netfilter/remove_netdev_one:                                  OK
  /ppc64/netfilter/addremove_multi:                                    OK
  /ppc64/netfilter/remove_netdev_multi:                                OK
PASS: tests/test-netfilter
TEST: tests/test-filter-mirror... (pid=1441)
  /ppc64/netfilter/mirror:                                             OK
PASS: tests/test-filter-mirror

so

Tested-by: Greg Kurz <groug@kaod.org>
