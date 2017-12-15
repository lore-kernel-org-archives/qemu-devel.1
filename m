Received: from eggs.gnu.org ([2001:4830:134:3::10]:46905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePndT-000851-9J
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:54:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePndP-0006zX-9g
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:54:35 -0500
References: <20171215101651.13911-1-david@gibson.dropbear.id.au>
	<20171215101651.13911-2-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d17e16a4-3262-2105-eb4f-f2d378cd7676@redhat.com>
Date: Fri, 15 Dec 2017 11:54:25 +0100
MIME-Version: 1.0
In-Reply-To: <20171215101651.13911-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] tests/pxe-test: Remove unnecessary
 special case test functions
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
> All of the x86 and some of the other test cases here use a common test
> function, test_pxe_ipv4(), but one ppc and one s390 test use different
> functions.
> 
> In the s390 case, this is completely pointless, the right parameter to
> test_pxe_ipv4() will already do exactly the right thing.  For the
> spapr-vlan case there's a slight difference - it will use IPv6 instead of
> IPv4.
> 
> But testing just one case with IPv6 (and NOT IPv4) is rather haphazard.
> Change everything to use the common test function, until we have a better
> way of testing IPv6 across the board.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  tests/pxe-test.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
