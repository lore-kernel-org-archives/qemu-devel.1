Received: from eggs.gnu.org ([2001:4830:134:3::10]:35660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8A1j-0008IK-EG
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8A1i-0002Vl-Ip
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:38:27 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:39932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d8A1i-0002Tp-CZ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:38:26 -0400
Date: Tue, 9 May 2017 20:38:15 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170509183815.ifukqa7s542km7fd@aurel32.net>
References: <20170509180715.22910-1-rth@twiddle.net>
	<20170509180715.22910-2-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170509180715.22910-2-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 1/6] target/s390x: Implement STORE
 FACILITIES LIST EXTENDED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On 2017-05-09 11:07, Richard Henderson wrote:
> At the same time, improve STORE FACILITIES LIST
> so that we don't hard-code the list for all cpus.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/helper.h      |  2 ++
>  target/s390x/insn-data.def |  2 ++
>  target/s390x/misc_helper.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/translate.c   | 17 ++++++-------
>  4 files changed, 72 insertions(+), 8 deletions(-)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
