Received: from eggs.gnu.org ([2001:4830:134:3::10]:42950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fkrBU-0001A0-4y
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fkrBT-0005k9-6d
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:29:00 -0400
MIME-Version: 1.0
In-Reply-To: <20180801123111.3595-5-richard.henderson@linaro.org>
References: <20180801123111.3595-1-richard.henderson@linaro.org>
	<20180801123111.3595-5-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Wed, 1 Aug 2018 15:28:57 +0200
Message-ID: <CABoDooOD9Z2u=QPt58Lhv5yB=aAYEufNmbPn0Uxo=zf_WLb0ig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/4] target/arm: Fix typo in
 helper_sve_movz_d
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On Wed, Aug 1, 2018 at 2:31 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>


Laurent

> ---
>  target/arm/sve_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 87594a8adb..c3cbec9cf5 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -1042,7 +1042,7 @@ void HELPER(sve_movz_d)(void *vd, void *vn, void *vg, uint32_t desc)
>      uint64_t *d = vd, *n = vn;
>      uint8_t *pg = vg;
>      for (i = 0; i < opr_sz; i += 1) {
> -        d[i] = n[1] & -(uint64_t)(pg[H1(i)] & 1);
> +        d[i] = n[i] & -(uint64_t)(pg[H1(i)] & 1);
>      }
>  }
>
> --
> 2.17.1
>
