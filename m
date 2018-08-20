Received: from eggs.gnu.org ([2001:4830:134:3::10]:54917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fro1r-0002bG-9n
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fro1p-0006EO-2w
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:31:47 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:41181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fro1k-0006Bl-3B
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:31:43 -0400
Received: by mail-oi0-x244.google.com with SMTP id k12-v6so27192723oiw.8
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 10:31:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180820171557.7734-3-laurent@vivier.eu>
References: <20180820171557.7734-1-laurent@vivier.eu>
	<20180820171557.7734-3-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 18:31:16 +0100
Message-ID: <CAFEAcA9rXKxLYXdWCmpL6oJoHxwgPVtNm4Lj_=+SZpqnrDOsQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] linux-user: introduce QEMU_RTA_* to
 use with rtattr_type_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 20 August 2018 at 18:15, Laurent Vivier <laurent@vivier.eu> wrote:
> Following commit will introduce RTA_PREF that appears only with
> kernel v4.1. To avoid to manage a specific case for it, this patch
> introduces the full list of rtattr_type_t prefixed with QEMU_ (as we
> did for IFLA values)
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 53 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 11 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index a62cd15dc7..a2395eb1b6 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -539,6 +539,37 @@ enum {
>      QEMU___IFLA_XDP_MAX,
>  };
>
> +enum {
> +    QEMU_RTA_UNSPEC,
> +    QEMU_RTA_DST,
> +    QEMU_RTA_SRC,
> +    QEMU_RTA_IIF,
> +    QEMU_RTA_OIF,
> +    QEMU_RTA_GATEWAY,
> +    QEMU_RTA_PRIORITY,
> +    QEMU_RTA_PREFSRC,
> +    QEMU_RTA_METRICS,
> +    QEMU_RTA_MULTIPATH,
> +    QEMU_RTA_PROTOINFO, /* no longer used */
> +    QEMU_RTA_FLOW,
> +    QEMU_RTA_CACHEINFO,
> +    QEMU_RTA_SESSION, /* no longer used */
> +    QEMU_RTA_MP_ALGO, /* no longer used */
> +    QEMU_RTA_TABLE,
> +    QEMU_RTA_MARK,
> +    QEMU_RTA_MFC_STATS,
> +    QEMU_RTA_VIA,
> +    QEMU_RTA_NEWDST,
> +    QEMU_RTA_PREF,
> +    QEMU_RTA_ENCAP_TYPE,
> +    QEMU_RTA_ENCAP,
> +    QEMU_RTA_EXPIRES,
> +    QEMU_RTA_PAD,
> +    QEMU_RTA_UID,
> +    QEMU_RTA_TTL_PROPAGATE,

Upstream 4.18 kernel has also
        RTA_IP_PROTO,
        RTA_SPORT,
        RTA_DPORT,

> +    QEMU___RTA_MAX
> +};

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

with or without those 3 extras, as you prefer.

thanks
-- PMM
