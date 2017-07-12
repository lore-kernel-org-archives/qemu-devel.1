Received: from eggs.gnu.org ([2001:4830:134:3::10]:60571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVInf-0000jz-1O
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVInb-0004o1-1G
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:39:35 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVIna-0004ng-Ra
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:39:30 -0400
Received: by mail-wr0-f177.google.com with SMTP id 77so36462189wrb.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 07:39:30 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-7-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1499586614-20507-7-git-send-email-cota@braap.org>
Date: Wed, 12 Jul 2017 15:38:28 +0100
Message-ID: <87lgnt90uz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/22] translate-all: make have_tb_lock
 static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> It is only used by this object, and it's not exported to any other.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

I was almost caught out by the name re-use in cpu-exec.c ;-)

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  accel/tcg/translate-all.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 72ce445..2fa9f65 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -133,7 +133,7 @@ TCGContext tcg_ctx;
>  bool parallel_cpus;
>
>  /* translation block context */
> -__thread int have_tb_lock;
> +static __thread int have_tb_lock;
>
>  static void page_table_config_init(void)
>  {


--
Alex Bennée
