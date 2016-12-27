Received: from eggs.gnu.org ([2001:4830:134:3::10]:40414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cLu47-0002yM-JM
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:53:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cLu46-0004qJ-Vt
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:53:27 -0500
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:34902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cLu46-0004q4-Rp
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:53:26 -0500
Received: by mail-ua0-x22a.google.com with SMTP id v2so10956626uac.2
	for <qemu-devel@nongnu.org>; Tue, 27 Dec 2016 07:53:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <148285304262.12721.17599380934779528989.stgit@fimbulvetr.bsc.es>
References: <148285303159.12721.5833400768046299304.stgit@fimbulvetr.bsc.es>
	<148285304262.12721.17599380934779528989.stgit@fimbulvetr.bsc.es>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:53:05 +0000
Message-ID: <CAFEAcA9QHXR2obCYytP0RD9e=Tgzq_MaEhKK1nBfO0FveS+J6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/6] queue: Add macro for incremental
 traversal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On 27 December 2016 at 15:37, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wro=
te:
> Adds macro QTAILQ_FOREACH_CONTINUE to support incremental list
> traversal.
>
> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
> ---
>  include/qemu/queue.h |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/qemu/queue.h b/include/qemu/queue.h
> index 342073fb4d..0d709016f4 100644
> --- a/include/qemu/queue.h
> +++ b/include/qemu/queue.h
> @@ -415,6 +415,11 @@ struct {                                            =
                    \
>                  (var);                                                  =
\
>                  (var) =3D ((var)->field.tqe_next))
>
> +#define QTAILQ_FOREACH_CONTINUE(var, field)                             =
\
> +        for ((var) =3D ((var)->field.tqe_next);                         =
  \
> +                (var);                                                  =
\
> +                (var) =3D ((var)->field.tqe_next))
> +
>  #define QTAILQ_FOREACH_SAFE(var, head, field, next_var)                 =
\
>          for ((var) =3D ((head)->tqh_first);                             =
  \
>                  (var) && ((next_var) =3D ((var)->field.tqe_next), 1);   =
  \

Could we have some documentation for the new macro, please?

thanks
-- PMM
