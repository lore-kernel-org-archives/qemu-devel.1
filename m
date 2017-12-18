Received: from eggs.gnu.org ([2001:4830:134:3::10]:47073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQslz-0008Ni-4e
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQslu-0005su-Cq
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:35:51 -0500
References: <20171218100404.4427-1-david@gibson.dropbear.id.au>
	<20171218100404.4427-4-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bb6f42db-7fda-2c46-1e16-c9cb82594356@redhat.com>
Date: Mon, 18 Dec 2017 11:35:37 +0100
MIME-Version: 1.0
In-Reply-To: <20171218100404.4427-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 3/4] tests/pxe-test: Test net booting
 over IPv6 in some cases
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

On 18.12.2017 11:04, David Gibson wrote:
> This adds IPv6 net boot testing (in addition to IPv4) when in slow test
> mode on ppc64 or s390.  IPv6 PXE doesn't seem to work on x86, I'm guessing
> our BIOS image doesn't support it.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  tests/pxe-test.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
