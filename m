Received: from eggs.gnu.org ([209.51.188.92]:34621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3MMs-0004j8-35
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3MEM-0006Yy-1V
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:48:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h3MEL-0006Yo-NW
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:48:41 -0400
References: <20190311141457.109436-1-liq3ea@163.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <13910509-a036-7e30-63cb-849db2f6f9cd@redhat.com>
Date: Mon, 11 Mar 2019 15:48:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190311141457.109436-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] tests: test-announce-self: fix memory
 leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, vyasevic@redhat.com, dgilbert@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc: qemu-devel@nongnu.org, philmd@redhat.com, liq3ea@gmail.com

On 11/03/2019 15.14, Li Qiang wrote:
> Spotted by ASAN while running 'make check'.
> 
> Fixes: 4b9b7000(tests: Add a test for qemu
> self announcements)
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
> Changes since v1: Use Thomas's patch
>  tests/test-announce-self.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)

Thanks, applied to the qtest-next branch:

https://gitlab.com/huth/qemu/commits/qtest-next

 Thomas
