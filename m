Received: from eggs.gnu.org ([2001:4830:134:3::10]:47583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyFgt-0000dy-UL
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyFgq-0006AN-LT
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:16:47 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:40612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fyFgq-00066h-7K
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:16:44 -0400
Received: by mail-wm0-x22f.google.com with SMTP id 207-v6so14344821wme.5
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 05:16:44 -0700 (PDT)
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<152819516132.30857.1700667353240369481.stgit@pasha-ThinkPad-T60>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <152819516132.30857.1700667353240369481.stgit@pasha-ThinkPad-T60>
Date: Fri, 07 Sep 2018 13:16:41 +0100
Message-ID: <87y3cdzemu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/7] tcg: add headers for non-target
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pbonzini@redhat.com, vilanova@ac.upc.edu


Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:

> From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
>
> This patch adds functions and headers for adding the helpers from
> the modules other than the target translators.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  include/exec/helper-register.h |   53 ++++++++++++++++++++++++++++++++++=
++++++
>  tcg/tcg.c                      |   12 +++++++++
>  tcg/tcg.h                      |    3 ++
>  3 files changed, 68 insertions(+)
>  create mode 100644 include/exec/helper-register.h
>
> diff --git a/include/exec/helper-register.h b/include/exec/helper-registe=
r.h
> new file mode 100644
> index 0000000..aeface9
> --- /dev/null
> +++ b/include/exec/helper-register.h
> @@ -0,0 +1,53 @@
> +#ifndef HELPER_REGISTER_H
> +#define HELPER_REGISTER_H
> +
> +#include "exec/helper-head.h"
> +
> +/* Need one more level of indirection before stringification
> +   to get all the macros expanded first.  */
> +#define str(s) #s
> +
> +#define DEF_HELPER_FLAGS_0(NAME, FLAGS, ret) \
> +    tcg_register_helper(HELPER(NAME), str(NAME), FLAGS, dh_sizemask(ret,=
 0));
> +
> +#define DEF_HELPER_FLAGS_1(NAME, FLAGS, ret, t1) \
> +    tcg_register_helper(HELPER(NAME), str(NAME), FLAGS, \
> +        dh_sizemask(ret, 0) | dh_sizemask(t1, 1));
> +
> +#define DEF_HELPER_FLAGS_2(NAME, FLAGS, ret, t1, t2) \
> +    tcg_register_helper(HELPER(NAME), str(NAME), FLAGS, \
> +        dh_sizemask(ret, 0) | dh_sizemask(t1, 1) | dh_sizemask(t2, 2));
> +
> +#define DEF_HELPER_FLAGS_3(NAME, FLAGS, ret, t1, t2, t3) \
> +    tcg_register_helper(HELPER(NAME), str(NAME), FLAGS, \
> +        dh_sizemask(ret, 0) | dh_sizemask(t1, 1) | dh_sizemask(t2, 2) \
> +        | dh_sizemask(t3, 3));
> +
> +#define DEF_HELPER_FLAGS_4(NAME, FLAGS, ret, t1, t2, t3, t4) \
> +    tcg_register_helper(HELPER(NAME), str(NAME), FLAGS, \
> +        dh_sizemask(ret, 0) | dh_sizemask(t1, 1) | dh_sizemask(t2, 2) \
> +        | dh_sizemask(t3, 3) | dh_sizemask(t4, 4));
> +
> +#define DEF_HELPER_FLAGS_5(NAME, FLAGS, ret, t1, t2, t3, t4, t5) \
> +    tcg_register_helper(HELPER(NAME), str(NAME), FLAGS, \
> +        dh_sizemask(ret, 0) | dh_sizemask(t1, 1) | dh_sizemask(t2, 2) \
> +        | dh_sizemask(t3, 3) | dh_sizemask(t4, 4) | dh_sizemask(t5, 5));
> +
> +#define DEF_HELPER_FLAGS_6(NAME, FLAGS, ret, t1, t2, t3, t4, t5, t6) \
> +    tcg_register_helper(HELPER(NAME), str(NAME), FLAGS, \
> +        dh_sizemask(ret, 0) | dh_sizemask(t1, 1) | dh_sizemask(t2, 2) \
> +        | dh_sizemask(t3, 3) | dh_sizemask(t4, 4) | dh_sizemask(t5, 5) \
> +        | dh_sizemask(t6, 6));
> +
> +#include "helper.h"
> +
> +#undef str
> +#undef DEF_HELPER_FLAGS_0
> +#undef DEF_HELPER_FLAGS_1
> +#undef DEF_HELPER_FLAGS_2
> +#undef DEF_HELPER_FLAGS_3
> +#undef DEF_HELPER_FLAGS_4
> +#undef DEF_HELPER_FLAGS_5
> +#undef DEF_HELPER_FLAGS_6
> +
> +#endif /* HELPER_REGISTER_H */
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 6eeebe0..8191381 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1623,6 +1623,18 @@ static inline const char *tcg_find_helper(TCGConte=
xt *s, uintptr_t val)
>      return ret;
>  }
>
> +void tcg_register_helper(void *func, const char *name,
> +                         unsigned flags, unsigned sizemask)
> +{
> +    TCGHelperInfo *info =3D g_new0(TCGHelperInfo, 1);
> +    info->func =3D func;
> +    info->name =3D name;
> +    info->flags =3D flags;
> +    info->sizemask =3D sizemask;
> +
> +    g_hash_table_insert(helper_table, func, info);
> +}
> +
>  static const char * const cond_name[] =3D
>  {
>      [TCG_COND_NEVER] =3D "never",
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 08f8bbf..7a4b750 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -890,6 +890,9 @@ void tcg_register_thread(void);
>  void tcg_prologue_init(TCGContext *s);
>  void tcg_func_start(TCGContext *s);
>

A small comment might be worthwhile here, maybe something like:

/**
 * tcg_register_helper
 *
 * Used by the helper-register.h machinery to register non-core helpers
 * from plugins. Built-in helpers are installed via all_helpers[]
 */

> +void tcg_register_helper(void *func, const char *name,
> +                         unsigned flags, unsigned sizemask);
> +
>  int tcg_gen_code(TCGContext *s, TranslationBlock *tb);
>
>  void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t s=
ize);


--
Alex Benn=C3=A9e
