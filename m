Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C25EC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175032133F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175032133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgrb6-0006sq-68
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48801)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hgqbA-0006r9-W8
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hgqb8-00076S-0h
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:07:28 -0400
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:38646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hgqb7-00074G-Mp
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:07:25 -0400
Received: from player795.ha.ovh.net (unknown [10.108.54.108])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 67C681D4289
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 13:50:21 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 8F4C974B3352;
 Fri, 28 Jun 2019 11:50:17 +0000 (UTC)
Date: Fri, 28 Jun 2019 13:50:15 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Message-ID: <20190628135015.2d1618cf@bahia.lan>
In-Reply-To: <fea3c051eb7ac3e2c5cbccb89d279a84d9b2c91d.1561575449.git.qemu_oss@crudebyte.com>
References: <cover.1561575449.git.qemu_oss@crudebyte.com>
 <fea3c051eb7ac3e2c5cbccb89d279a84d9b2c91d.1561575449.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 18373842057013860672
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvddtgdegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.125.228
Subject: Re: [Qemu-devel] [PATCH v4 5/5] 9p: Use variable length suffixes
 for inode remapping
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Jun 2019 20:52:09 +0200
Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org> wrote:

> Use variable length suffixes for inode remapping instead of the fixed 16
> bit size prefixes before. With this change the inode numbers on guest will
> typically be much smaller (e.g. around >2^1 .. >2^7 instead of >2^48 with
> the previous fixed size inode remapping.
>=20
> Additionally this solution should be more efficient, since inode numbers =
in
> practice can take almost their entire 64 bit range on guest as well. Which
> might also be beneficial for nested virtualization.
>=20
> The "Exponential Golomb" algorithm is used as basis for generating the
> variable length suffixes. The algorithm has a paramter k which controls t=
he
> distribution of bits on increasing indeces (minimum bits at low index vs.
> maximum bits at high index). With k=3D0 the generated suffixes look like:
>=20
> Index Dec/Bin -> Generated Suffix Bin
> 1 [1] -> [1] (1 bits)
> 2 [10] -> [010] (3 bits)
> 3 [11] -> [110] (3 bits)
> 4 [100] -> [00100] (5 bits)
> 5 [101] -> [10100] (5 bits)
> 6 [110] -> [01100] (5 bits)
> 7 [111] -> [11100] (5 bits)
> 8 [1000] -> [0001000] (7 bits)
> 9 [1001] -> [1001000] (7 bits)
> 10 [1010] -> [0101000] (7 bits)
> 11 [1011] -> [1101000] (7 bits)
> 12 [1100] -> [0011000] (7 bits)
> ...
> 65533 [1111111111111101] ->  [1011111111111111000000000000000] (31 bits)
> 65534 [1111111111111110] ->  [0111111111111111000000000000000] (31 bits)
> 65535 [1111111111111111] ->  [1111111111111111000000000000000] (31 bits)
> Hence minBits=3D1 maxBits=3D31
>=20
> And with k=3D5 they would look like:
>=20
> Index Dec/Bin -> Generated Suffix Bin
> 1 [1] -> [000001] (6 bits)
> 2 [10] -> [100001] (6 bits)
> 3 [11] -> [010001] (6 bits)
> 4 [100] -> [110001] (6 bits)
> 5 [101] -> [001001] (6 bits)
> 6 [110] -> [101001] (6 bits)
> 7 [111] -> [011001] (6 bits)
> 8 [1000] -> [111001] (6 bits)
> 9 [1001] -> [000101] (6 bits)
> 10 [1010] -> [100101] (6 bits)
> 11 [1011] -> [010101] (6 bits)
> 12 [1100] -> [110101] (6 bits)
> ...
> 65533 [1111111111111101] -> [0011100000000000100000000000] (28 bits)
> 65534 [1111111111111110] -> [1011100000000000100000000000] (28 bits)
> 65535 [1111111111111111] -> [0111100000000000100000000000] (28 bits)
> Hence minBits=3D6 maxBits=3D28
>=20

IIUC, this k control parameter should be constant for the
lifetime of QIDs. So it all boils down to choose a _good_
value that would cover most scenarios, right ?

For now, I just have some _cosmetic_ remarks.

> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/9p.c | 267 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  hw/9pfs/9p.h |  67 ++++++++++++++-
>  2 files changed, 312 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index e6e410972f..46c9f11384 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -26,6 +26,7 @@
>  #include "migration/blocker.h"
>  #include "sysemu/qtest.h"
>  #include "qemu/xxhash.h"
> +#include <math.h>
> =20
>  int open_fd_hw;
>  int total_open_fd;
> @@ -572,6 +573,123 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
>                                  P9_STAT_MODE_NAMED_PIPE |   \
>                                  P9_STAT_MODE_SOCKET)
> =20
> +#if P9_VARI_LENGTH_INODE_SUFFIXES

The numerous locations guarded by P9_VARI_LENGTH_INODE_SUFFIXES
really obfuscate the code, and don't ease review (for me at least).
And anyway, if we go for variable length suffixes, we won't keep
the fixed length prefix code.

> +
> +/* Mirrors all bits of a byte. So e.g. binary 10100000 would become 0000=
0101. */
> +static inline uint8_t mirror8bit(uint8_t byte) {

=46rom CODING_STYLE:

4. Block structure

[...]

for reasons of tradition and clarity it comes on a line by itself:

    void a_function(void)
    {
        do_something();
    }

> +    return (byte * 0x0202020202ULL & 0x010884422010ULL) % 1023;
> +}
> +
> +/* Same as mirror8bit() just for a 64 bit data type instead for a byte. =
*/
> +static inline uint64_t mirror64bit(uint64_t value) {

Ditto.

> +    return ((uint64_t)mirror8bit( value        & 0xff) << 56) |
> +           ((uint64_t)mirror8bit((value >> 8)  & 0xff) << 48) |
> +           ((uint64_t)mirror8bit((value >> 16) & 0xff) << 40) |
> +           ((uint64_t)mirror8bit((value >> 24) & 0xff) << 32) |
> +           ((uint64_t)mirror8bit((value >> 32) & 0xff) << 24) |
> +           ((uint64_t)mirror8bit((value >> 40) & 0xff) << 16) |
> +           ((uint64_t)mirror8bit((value >> 48) & 0xff) << 8 ) |
> +           ((uint64_t)mirror8bit((value >> 56) & 0xff)      ) ;
> +}
> +
> +/* Parameter k for the Exponential Golomb algorihm to be used.
> + *
> + * The smaller this value, the smaller the minimum bit count for the Exp.
> + * Golomb generated affixes will be (at lowest index) however for the
> + * price of having higher maximum bit count of generated affixes (at hig=
hest
> + * index). Likewise increasing this parameter yields in smaller maximum =
bit
> + * count for the price of having higher minimum bit count.

Forgive my laziness but what are the benefits of a smaller or larger
value, in term of user experience ?

> + */
> +#define EXP_GOLOMB_K    0
> +
> +# if !EXP_GOLOMB_K
> +
> +/** @brief Exponential Golomb algorithm limited to the case k=3D0.
> + *

This doesn't really help to have a special implementation for k=3D0. The
resulting function is nearly identical to the general case. It is likely
that the compiler can optimize it and generate the same code.

> + * See expGolombEncode() below for details.
> + *
> + * @param n - natural number (or index) of the prefix to be generated
> + *            (1, 2, 3, ...)
> + */
> +static VariLenAffix expGolombEncodeK0(uint64_t n) {
> +    const int bits =3D (int) log2(n) + 1;
> +    return (VariLenAffix) {
> +        .type =3D AffixType_Prefix,
> +        .value =3D n,
> +        .bits =3D bits + bits - 1
> +    };
> +}
> +
> +# else
> +
> +/** @brief Exponential Golomb algorithm for arbitrary k (including k=3D0=
).
> + *
> + * The Exponential Golomb algorithm generates @b prefixes (@b not suffix=
es!)
> + * with growing length and with the mathematical property of being
> + * "prefix-free". The latter means the generated prefixes can be prepend=
ed
> + * in front of arbitrary numbers and the resulting concatenated numbers =
are
> + * guaranteed to be always unique.
> + *
> + * This is a minor adjustment to the original Exp. Golomb algorithm in t=
he
> + * sense that lowest allowed index (@param n) starts with 1, not with ze=
ro.
> + *
> + * @param n - natural number (or index) of the prefix to be generated
> + *            (1, 2, 3, ...)
> + * @param k - parameter k of Exp. Golomb algorithm to be used
> + *            (see comment on EXP_GOLOMB_K macro for details about k)
> + */
> +static VariLenAffix expGolombEncode(uint64_t n, int k) {

Function.

> +    const uint64_t value =3D n + (1 << k) - 1;
> +    const int bits =3D (int) log2(value) + 1;
> +    return (VariLenAffix) {
> +        .type =3D AffixType_Prefix,
> +        .value =3D value,
> +        .bits =3D bits + MAX((bits - 1 - k), 0)
> +    };
> +}
> +
> +# endif /* !EXP_GOLOMB_K */
> +
> +/** @brief Converts a suffix into a prefix, or a prefix into a suffix.
> + *
> + * What this function does is actually mirroring all bits of the affix v=
alue,

Drop the "What this function does..." wording and use an imperative style
instead, ie. "Mirror all bits of..."

> + * with the purpose to preserve respectively the mathematical "prefix-fr=
ee"
> + * or "suffix-free" property after the conversion.
> + *
> + * In other words: if a passed prefix is suitable to create unique numbe=
rs,
> + * then the returned suffix is suitable to create unique numbers as well
> + * (and vice versa).
> + */
> +static VariLenAffix invertAffix(const VariLenAffix* affix) {

Function.

> +    return (VariLenAffix) {
> +        .type =3D (affix->type =3D=3D AffixType_Suffix) ? AffixType_Pref=
ix : AffixType_Suffix,
> +        .value =3D  mirror64bit(affix->value) >> ((sizeof(affix->value) =
* 8) - affix->bits),
> +        .bits =3D affix->bits
> +    };
> +}
> +
> +/** @brief Generates suffix numbers with "suffix-free" property.
> + *
> + * This is just a wrapper function on top of the Exp. Golomb algorithm.
> + *
> + * Since the Exp. Golomb algorithm generates prefixes, but we need suffi=
xes,
> + * this function converts the Exp. Golomb prefixes into appropriate suff=
ixes
> + * which are still suitable for generating unique numbers.
> + *
> + * @param n - natural number (or index) of the suffix to be generated
> + *            (1, 2, 3, ...)
> + */
> +static VariLenAffix affixForIndex(uint64_t index) {

Function.

> +    VariLenAffix prefix;
> +    #if EXP_GOLOMB_K
> +    prefix =3D expGolombEncode(index, EXP_GOLOMB_K);
> +    #else
> +    prefix =3D expGolombEncodeK0(index);
> +    #endif
> +    return invertAffix(&prefix); /* convert prefix to suffix */
> +}
> +
> +#endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
> =20
>  /* creative abuse of tb_hash_func7, which is based on xxhash */
>  static uint32_t qpp_hash(QppEntry e)
> @@ -584,13 +702,23 @@ static uint32_t qpf_hash(QpfEntry e)
>      return qemu_xxhash7(e.ino, e.dev, 0, 0, 0);
>  }
> =20
> -static bool qpp_lookup_func(const void *obj, const void *userp)
> +#if P9_VARI_LENGTH_INODE_SUFFIXES
> +
> +static bool qpd_cmp_func(const void *obj, const void *userp)
> +{
> +    const QpdEntry *e1 =3D obj, *e2 =3D userp;
> +    return e1->dev =3D=3D e2->dev;
> +}
> +
> +#endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
> +
> +static bool qpp_cmp_func(const void *obj, const void *userp)
>  {
>      const QppEntry *e1 =3D obj, *e2 =3D userp;
>      return e1->dev =3D=3D e2->dev && e1->ino_prefix =3D=3D e2->ino_prefi=
x;
>  }
> =20
> -static bool qpf_lookup_func(const void *obj, const void *userp)
> +static bool qpf_cmp_func(const void *obj, const void *userp)
>  {
>      const QpfEntry *e1 =3D obj, *e2 =3D userp;
>      return e1->dev =3D=3D e2->dev && e1->ino =3D=3D e2->ino;
> @@ -607,6 +735,58 @@ static void qp_table_destroy(struct qht *ht)
>      qht_destroy(ht);
>  }
> =20
> +#if P9_VARI_LENGTH_INODE_SUFFIXES
> +
> +/*
> + * Returns how many (high end) bits of inode numbers of the passed fs
> + * device shall be used (in combination with the device number) to
> + * generate hash values for qpp_table entries.
> + *
> + * This function is required if variable length suffixes are used for in=
ode
> + * number mapping on guest level. Since a device may end up having multi=
ple
> + * entries in qpp_table, each entry most probably with a different suffix
> + * length, we thus need this function in conjunction with qpd_table to
> + * "agree" about a fix amount of bits (per device) to be always used for
> + * generating hash values for the purpose of accessing qpp_table in order
> + * get consistent behaviour when accessing qpp_table.
> + */
> +static int qid_inode_prefix_hash_bits(V9fsPDU *pdu, dev_t dev)
> +{
> +    QpdEntry lookup =3D {
> +        .dev =3D dev
> +    }, *val;
> +    uint32_t hash =3D dev;
> +    VariLenAffix affix;
> +
> +    val =3D qht_lookup(&pdu->s->qpd_table, &lookup, hash);
> +    if (!val) {
> +        val =3D g_malloc0(sizeof(QpdEntry));
> +        *val =3D lookup;
> +        affix =3D affixForIndex(pdu->s->qp_affix_next);
> +        val->prefix_bits =3D affix.bits;
> +        qht_insert(&pdu->s->qpd_table, val, hash, NULL);
> +        pdu->s->qp_ndevices++;
> +    }
> +    return val->prefix_bits;
> +}
> +
> +#endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
> +
> +/** @brief Slow / full mapping host inode nr -> guest inode nr.
> + *
> + * This function performs a slower and much more costly remapping of an
> + * original file inode number on host to an appropriate different inode
> + * number on guest. For every (dev, inode) combination on host a new
> + * sequential number is generated, cached and exposed as inode number on
> + * guest.
> + *
> + * This is just a "last resort" fallback solution if the much faster/che=
aper
> + * qid_path_prefixmap() failed. In practice this slow / full mapping is =
not
> + * expected ever to be used at all though.
> + *
> + * @see qid_path_prefixmap() for details
> + *
> + */
>  static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
>                              uint64_t *path)
>  {
> @@ -615,11 +795,9 @@ static int qid_path_fullmap(V9fsPDU *pdu, const stru=
ct stat *stbuf,
>          .ino =3D stbuf->st_ino
>      }, *val;
>      uint32_t hash =3D qpf_hash(lookup);
> -
> -    /* most users won't need the fullmap, so init the table lazily */
> -    if (!pdu->s->qpf_table.map) {
> -        qht_init(&pdu->s->qpf_table, qpf_lookup_func, 1 << 16, QHT_MODE_=
AUTO_RESIZE);
> -    }
> +#if P9_VARI_LENGTH_INODE_SUFFIXES
> +    VariLenAffix affix;
> +#endif
> =20

Move this declaration to the beginning of the block.

>      val =3D qht_lookup(&pdu->s->qpf_table, &lookup, hash);
> =20
> @@ -633,8 +811,16 @@ static int qid_path_fullmap(V9fsPDU *pdu, const stru=
ct stat *stbuf,
>          *val =3D lookup;
> =20
>          /* new unique inode and device combo */
> +#if P9_VARI_LENGTH_INODE_SUFFIXES
> +        affix =3D affixForIndex(
> +            1ULL << (sizeof(pdu->s->qp_affix_next) * 8)
> +        );
> +        val->path =3D (pdu->s->qp_fullpath_next++ << affix.bits) | affix=
.value;
> +        pdu->s->qp_fullpath_next &=3D ((1ULL << (64 - affix.bits)) - 1);
> +#else
>          val->path =3D pdu->s->qp_fullpath_next++;
>          pdu->s->qp_fullpath_next &=3D QPATH_INO_MASK;
> +#endif
>          qht_insert(&pdu->s->qpf_table, val, hash, NULL);
>      }
> =20
> @@ -642,42 +828,71 @@ static int qid_path_fullmap(V9fsPDU *pdu, const str=
uct stat *stbuf,
>      return 0;
>  }
> =20
> -/* stat_to_qid needs to map inode number (64 bits) and device id (32 bit=
s)
> +/** @brief Quick mapping host inode nr -> guest inode nr.
> + *
> + * This function performs quick remapping of an original file inode numb=
er
> + * on host to an appropriate different inode number on guest. This remap=
ping
> + * of inodes is required to avoid inode nr collisions on guest which wou=
ld
> + * happen if the 9p export contains more than 1 exported file system (or
> + * more than 1 file system data set), because unlike on host level where=
 the
> + * files would have different device nrs, all files exported by 9p would
> + * share the same device nr on guest (the device nr of the virtual 9p de=
vice
> + * that is).
> + *
> + * if P9_VARI_LENGTH_INODE_SUFFIXES =3D=3D 0 :
> + * stat_to_qid needs to map inode number (64 bits) and device id (32 bit=
s)
>   * to a unique QID path (64 bits). To avoid having to map and keep track
>   * of up to 2^64 objects, we map only the 16 highest bits of the inode p=
lus
>   * the device id to the 16 highest bits of the QID path. The 48 lowest b=
its
>   * of the QID path equal to the lowest bits of the inode number.
>   *
> - * This takes advantage of the fact that inode number are usually not
> - * random but allocated sequentially, so we have fewer items to keep
> - * track of.

Hmm... why dropping this comment ?

> + * if P9_VARI_LENGTH_INODE_SUFFIXES =3D=3D 1 :
> + * Instead of fixed size (16 bit) generated prefix, we use variable size
> + * suffixes instead. See comment on P9_VARI_LENGTH_INODE_SUFFIXES for
> + * details.
>   */
>  static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
>                                  uint64_t *path)
>  {
> +#if P9_VARI_LENGTH_INODE_SUFFIXES

Starting from here, the patch has too many P9_VARI_LENGTH_INODE_SUFFIXES
guards for my laziness and available time... I'll rather wait for the next
round where both approaches don't coexist.

Cheers,

--
Greg


> +    const int ino_hash_bits =3D qid_inode_prefix_hash_bits(pdu, stbuf->s=
t_dev);
> +#endif
>      QppEntry lookup =3D {
>          .dev =3D stbuf->st_dev,
> +#if P9_VARI_LENGTH_INODE_SUFFIXES
> +        .ino_prefix =3D (uint16_t) (stbuf->st_ino >> (64-ino_hash_bits))
> +#else
>          .ino_prefix =3D (uint16_t) (stbuf->st_ino >> 48)
> +#endif
>      }, *val;
>      uint32_t hash =3D qpp_hash(lookup);
> =20
>      val =3D qht_lookup(&pdu->s->qpp_table, &lookup, hash);
> =20
>      if (!val) {
> -        if (pdu->s->qp_prefix_next =3D=3D 0) {
> -            /* we ran out of prefixes */
> +        if (pdu->s->qp_affix_next =3D=3D 0) {
> +            /* we ran out of affixes */
>              return -ENFILE;
>          }
> =20
>          val =3D g_malloc0(sizeof(QppEntry));
>          *val =3D lookup;
> =20
> -        /* new unique inode prefix and device combo */
> -        val->qp_prefix =3D pdu->s->qp_prefix_next++;
> +        /* new unique inode affix and device combo */
> +#if P9_VARI_LENGTH_INODE_SUFFIXES
> +        val->qp_affix_index =3D pdu->s->qp_affix_next++;
> +        val->qp_affix =3D affixForIndex(val->qp_affix_index);
> +#else
> +        val->qp_affix =3D pdu->s->qp_affix_next++;
> +#endif
>          qht_insert(&pdu->s->qpp_table, val, hash, NULL);
>      }
> -
> -    *path =3D ((uint64_t)val->qp_prefix << 48) | (stbuf->st_ino & QPATH_=
INO_MASK);
> +#if P9_VARI_LENGTH_INODE_SUFFIXES
> +    /* assuming generated affix to be suffix type, not prefix */
> +    *path =3D (stbuf->st_ino << val->qp_affix.bits) | val->qp_affix.valu=
e;
> +#else
> +    *path =3D ((uint64_t)val->qp_affix << 48) | (stbuf->st_ino & QPATH_I=
NO_MASK);
> +#endif
>      return 0;
>  }
> =20
> @@ -3799,9 +4014,17 @@ int v9fs_device_realize_common(V9fsState *s, const=
 V9fsTransport *t,
> =20
>      s->dev_id =3D 0;
> =20
> +#if P9_VARI_LENGTH_INODE_SUFFIXES
> +    qht_init(&s->qpd_table, qpd_cmp_func, 1, QHT_MODE_AUTO_RESIZE);
> +#endif
> +    /* most users won't need the fullmap, so init the table lazily */
> +    qht_init(&s->qpf_table, qpf_cmp_func, 1 << 16, QHT_MODE_AUTO_RESIZE);
>      /* QID path hash table. 1 entry ought to be enough for anybody ;) */
> -    qht_init(&s->qpp_table, qpp_lookup_func, 1, QHT_MODE_AUTO_RESIZE);
> -    s->qp_prefix_next =3D 1; /* reserve 0 to detect overflow */
> +    qht_init(&s->qpp_table, qpp_cmp_func, 1, QHT_MODE_AUTO_RESIZE);
> +#if P9_VARI_LENGTH_INODE_SUFFIXES
> +    s->qp_ndevices =3D 0;
> +#endif
> +    s->qp_affix_next =3D 1; /* reserve 0 to detect overflow */
>      s->qp_fullpath_next =3D 1;
> =20
>      s->ctx.fst =3D &fse->fst;
> @@ -3817,6 +4040,9 @@ out:
>          }
>          g_free(s->tag);
>          g_free(s->ctx.fs_root);
> +#if P9_VARI_LENGTH_INODE_SUFFIXES
> +        qp_table_destroy(&s->qpd_table);
> +#endif
>          qp_table_destroy(&s->qpp_table);
>          qp_table_destroy(&s->qpf_table);
>          v9fs_path_free(&path);
> @@ -3831,6 +4057,9 @@ void v9fs_device_unrealize_common(V9fsState *s, Err=
or **errp)
>      }
>      fsdev_throttle_cleanup(s->ctx.fst);
>      g_free(s->tag);
> +#if P9_VARI_LENGTH_INODE_SUFFIXES
> +    qp_table_destroy(&s->qpd_table);
> +#endif
>      qp_table_destroy(&s->qpp_table);
>      qp_table_destroy(&s->qpf_table);
>      g_free(s->ctx.fs_root);
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 2b74561030..a94272a504 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -236,13 +236,68 @@ struct V9fsFidState
>      V9fsFidState *rclm_lst;
>  };
> =20
> -#define QPATH_INO_MASK        (((unsigned long)1 << 48) - 1)
> +/*
> + * Defines how inode numbers from host shall be remapped on guest.
> + *
> + * When this compile time option is disabled then fixed length (16 bit)
> + * prefix values are used for all inode numbers on guest level. Accordin=
gly
> + * guest's inode numbers will be quite large (>2^48).
> + *
> + * If this option is enabled then variable length suffixes will be used =
for
> + * guest's inode numbers instead which usually yields in much smaller in=
ode
> + * numbers on guest level (typically around >2^1 .. >2^7).
> + */
> +#define P9_VARI_LENGTH_INODE_SUFFIXES 1
> +
> +#if P9_VARI_LENGTH_INODE_SUFFIXES
> +
> +typedef enum AffixType_t {
> +    AffixType_Prefix,
> +    AffixType_Suffix, /* A.k.a. postfix. */
> +} AffixType_t;
> +
> +/** @brief Unique affix of variable length.
> + *
> + * An affix is (currently) either a suffix or a prefix, which is either
> + * going to be prepended (prefix) or appended (suffix) with some other
> + * number for the goal to generate unique numbers. Accordingly the
> + * suffixes (or prefixes) we generate @b must all have the mathematical
> + * property of being suffix-free (or prefix-free in case of prefixes)
> + * so that no matter what number we concatenate the affix with, that we
> + * always reliably get unique numbers as result after concatenation.
> + */
> +typedef struct VariLenAffix {
> +    AffixType_t type; /* Whether this affix is a suffix or a prefix. */
> +    uint64_t value; /* Actual numerical value of this affix. */
> +    int bits; /* Lenght of the affix, that is how many (of the lowest) b=
its of @c value must be used for appending/prepending this affix to its fin=
al resulting, unique number. */
> +} VariLenAffix;
> +
> +#endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
> +
> +#if !P9_VARI_LENGTH_INODE_SUFFIXES
> +# define QPATH_INO_MASK        (((unsigned long)1 << 48) - 1)
> +#endif
> +
> +#if P9_VARI_LENGTH_INODE_SUFFIXES
> +
> +/* See qid_inode_prefix_hash_bits(). */
> +typedef struct {
> +    dev_t dev; /* FS device on host. */
> +    int prefix_bits; /* How many (high) bits of the original inode numbe=
r shall be used for hashing. */
> +} QpdEntry;
> +
> +#endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
> =20
>  /* QID path prefix entry, see stat_to_qid */
>  typedef struct {
>      dev_t dev;
>      uint16_t ino_prefix;
> -    uint16_t qp_prefix;
> +    #if P9_VARI_LENGTH_INODE_SUFFIXES
> +    uint32_t qp_affix_index;
> +    VariLenAffix qp_affix;
> +    #else
> +    uint16_t qp_affix;
> +    #endif
>  } QppEntry;
> =20
>  /* QID path full entry, as above */
> @@ -274,9 +329,15 @@ struct V9fsState
>      V9fsConf fsconf;
>      V9fsQID root_qid;
>      dev_t dev_id;
> +#if P9_VARI_LENGTH_INODE_SUFFIXES
> +    struct qht qpd_table;
> +#endif
>      struct qht qpp_table;
>      struct qht qpf_table;
> -    uint16_t qp_prefix_next;
> +#if P9_VARI_LENGTH_INODE_SUFFIXES
> +    uint64_t qp_ndevices; /* Amount of entries in qpd_table. */
> +#endif
> +    uint16_t qp_affix_next;
>      uint64_t qp_fullpath_next;
>  };
> =20


