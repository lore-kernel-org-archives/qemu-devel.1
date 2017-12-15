Received: from eggs.gnu.org ([2001:4830:134:3::10]:52908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePntT-0006UQ-Ba
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePntP-0001lO-74
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:11:07 -0500
References: <20171215101651.13911-1-david@gibson.dropbear.id.au>
	<20171215101651.13911-4-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e69f5264-9da3-2bbf-e0f9-3c1e989d7260@redhat.com>
Date: Fri, 15 Dec 2017 12:10:56 +0100
MIME-Version: 1.0
In-Reply-To: <20171215101651.13911-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] tests/pxe-test: Test net booting over
 IPv6 in some cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, mst@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 15.12.2017 11:16, David Gibson wrote:
> This adds IPv6 net boot testing (in addition to IPv4) when in slow test
> mode on ppc64 or s390.  IPv6 PXE doesn't seem to work on x86, I'm guessing
> out BIOS image doesn't support it.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  tests/pxe-test.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
[...]
>      } else if (strcmp(arch, "ppc64") == 0) {
> -        test_batch(ppc64_tests);
> +        test_batch(ppc64_tests, g_test_slow());
>          if (g_test_slow()) {
> -            test_batch(ppc64_tests_slow);
> +            test_batch(ppc64_tests_slow, true);
>          }

The NICs from ppc64_tests_slow are now never exercised with IPv4 ...
maybe it would be better to do both:

            test_batch(ppc64_tests_slow, false);
            test_batch(ppc64_tests_slow, true);

?

 Thomas
