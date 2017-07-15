Received: from eggs.gnu.org ([2001:4830:134:3::10]:58245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWIJF-0007Uv-7o
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 04:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWIJE-00089I-BV
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 04:20:17 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:44334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dWIJE-00089A-4l
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 04:20:16 -0400
Date: Sat, 15 Jul 2017 10:20:12 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170715082012.yp7c4qmidl3ce4d2@aurel32.net>
References: <fc0ca76b-ecee-1f38-166b-4dcd8d7dcd00@redhat.com>
	<20170711182351.22956-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170711182351.22956-1-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3.5 2/8] target/s390x: Implement CONVERT
 UNICODE insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On 2017-07-11 08:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
> v3.5: Added even register checks in the translator [thuth].
> ---
>  target/s390x/helper.h      |   6 +
>  target/s390x/mem_helper.c  | 310 +++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/translate.c   |  51 ++++++++
>  target/s390x/insn-data.def |  13 ++
>  4 files changed, 380 insertions(+)
> 

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
