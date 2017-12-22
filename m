Received: from eggs.gnu.org ([2001:4830:134:3::10]:46345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eSPvs-0006xV-Nm
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eSPvp-0004P7-C9
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:12:24 -0500
Received: from mail-ve1eur01hn0203.outbound.protection.outlook.com
	([104.47.1.203]:43360
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eSPvo-0004NH-Pf
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:12:21 -0500
Date: Fri, 22 Dec 2017 19:12:04 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20171222161204.GA10643@rkaganb.sw.ru>
References: <20171222155522.17868-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171222155522.17868-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi: fix scsi_convert_sense crash when
 in_buf == NULL && in_len == 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Dec 22, 2017 at 04:55:22PM +0100, Paolo Bonzini wrote:
> scsi_disk_emulate_command passes in_buf == NULL when sent a REQUEST
> SENSE command.  Check for in_len == 0 before dereferencing in_buf.
> 
> Fixes: f68d98b21fa74155dc7c1fd212474379ac3c7531
> Reported-by: Roman Kagan <rkagan@virtuozzo.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scsi/utils.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Tested-by: Roman Kagan <rkagan@virtuozzo.com>
