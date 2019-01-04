Received: from eggs.gnu.org ([208.118.235.92]:34070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gfQ1d-0007mI-0v
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:00:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gfQ1Z-0007Ed-Rk
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:00:36 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1gfQ1Z-000737-JC
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:00:33 -0500
Received: by mail-lf1-x142.google.com with SMTP id v5so25456248lfe.7
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 06:00:20 -0800 (PST)
Date: Fri, 4 Jan 2019 15:00:18 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20190104140018.GS1148@toto>
References: <20181210152829.29271-1-alex.bennee@linaro.org>
	<20181210152829.29271-12-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181210152829.29271-12-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH 11/13] tests/tcg/cris: comment out the
 ccs test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, michael@walle.cc, aurelien@aurel32.net, amarkovic@wavecomp.com, shorne@gmail.com, jcmvbkbc@gmail.com

On Mon, Dec 10, 2018 at 03:28:27PM +0000, Alex Bennée wrote:
> Evidently upstream gcc doesn't like this opcode.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>


Hi Alex, this is probably an example of missmatching CRISv10 vs CRISv32 versions in toolchain usage.

Cheers,
Edgar


> ---
>  tests/tcg/cris/system/check_btst.s | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/tcg/cris/system/check_btst.s b/tests/tcg/cris/system/check_btst.s
> index e39fc8f4d6..485deb2006 100644
> --- a/tests/tcg/cris/system/check_btst.s
> +++ b/tests/tcg/cris/system/check_btst.s
> @@ -85,12 +85,12 @@
>   checkr3 1111
>  
>   ; check that X gets cleared and that only the NZ flags are touched.
> - move.d	0xff, $r0
> - move $r0, $ccs
> - btst r3,r3
> - move $ccs, $r0
> - and.d 0xff, $r0
> - cmp.d	0xe3, $r0
> - test_cc 0 1 0 0
> + ;; move.d	0xff, $r0
> + ;; move $r0, $ccs
> + ;; btst r3,r3
> + ;; move $ccs, $r0
> + ;; and.d 0xff, $r0
> + ;; cmp.d	0xe3, $r0
> + ;; test_cc 0 1 0 0
>  
>   quit
> -- 
> 2.17.1
> 
