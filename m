Received: from eggs.gnu.org ([2001:4830:134:3::10]:36940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyHyU-0003Kf-Fn
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 10:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyHyR-0003sk-Be
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 10:43:06 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:52904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fyHyR-0003ro-3B
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 10:43:03 -0400
Received: by mail-wm0-x244.google.com with SMTP id y139-v6so14882212wmc.2
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 07:43:02 -0700 (PDT)
References: <20180817232923.28899-1-cota@braap.org>
	<20180817232923.28899-2-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180817232923.28899-2-cota@braap.org>
Date: Fri, 07 Sep 2018 15:43:00 +0100
Message-ID: <87k1nxz7uz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/6] qht: remove unused map param from
 qht_remove__locked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  util/qht.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/util/qht.c b/util/qht.c
> index c138777a9c..7b57b50a24 100644
> --- a/util/qht.c
> +++ b/util/qht.c
> @@ -665,8 +665,7 @@ static inline void qht_bucket_remove_entry(struct qht=
_bucket *orig, int pos)
>
>  /* call with b->lock held */
>  static inline
> -bool qht_remove__locked(struct qht_map *map, struct qht_bucket *head,
> -                        const void *p, uint32_t hash)
> +bool qht_remove__locked(struct qht_bucket *head, const void *p, uint32_t=
 hash)
>  {
>      struct qht_bucket *b =3D head;
>      int i;
> @@ -701,7 +700,7 @@ bool qht_remove(struct qht *ht, const void *p, uint32=
_t hash)
>      qht_debug_assert(p);
>
>      b =3D qht_bucket_lock__no_stale(ht, hash, &map);
> -    ret =3D qht_remove__locked(map, b, p, hash);
> +    ret =3D qht_remove__locked(b, p, hash);
>      qht_bucket_debug__locked(b);
>      qemu_spin_unlock(&b->lock);
>      return ret;


--
Alex Benn=C3=A9e
