Received: from eggs.gnu.org ([2001:4830:134:3::10]:53178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CPE-0003HK-P6
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CPD-0008Qi-W5
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:10:52 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d8CPD-0008QW-RX
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:10:51 -0400
Received: by mail-qt0-x243.google.com with SMTP id l39so1649083qtb.1
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 14:10:51 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-13-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f5b32daf-94f3-ea19-95d1-885868e90eb3@twiddle.net>
Date: Tue, 9 May 2017 14:10:48 -0700
MIME-Version: 1.0
In-Reply-To: <20170506111431.12548-13-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/14] target/sh4: implement tas.b using
 atomic helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/06/2017 04:14 AM, Aurelien Jarno wrote:
> We only emulate UP SH4, however as the tas.b instruction is used in the GNU
> libc, this improve linux-user emulation.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/translate.c | 19 +++++++------------
>   1 file changed, 7 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
