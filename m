Received: from eggs.gnu.org ([2001:4830:134:3::10]:43706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ei4GJ-0001qD-VD
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ei4GF-0000Qu-0r
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:18:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ei4GE-0000Py-PL
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:18:06 -0500
References: <20180202183731.29990-1-armbru@redhat.com>
	<20180202183731.29990-4-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8ac91ae4-49ea-3c9f-c7ce-299743df5b0b@redhat.com>
Date: Sat, 3 Feb 2018 21:18:03 +0100
MIME-Version: 1.0
In-Reply-To: <20180202183731.29990-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 03/15] hw/dma: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com

On 02.02.2018 19:37, Markus Armbruster wrote:
> From: Alistair Francis <alistair.francis@xilinx.com>
> 
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
[...]
> Some lines where then manually tweaked to pass checkpatch.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> 
> Conversions that aren't followed by exit() dropped, because they might
> be inappropriate.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/dma/soc_dma.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
