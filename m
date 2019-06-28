Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF7DC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13E42064A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Vq9FoCuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13E42064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgspo-0005m9-8A
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47924)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <qemu_oss@crudebyte.com>) id 1hgsIY-000582-Re
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1hgsIW-0000DN-Qb
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:56:22 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:55873)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1hgsIV-0000BX-MO
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EBihbZxm5jPX3VA/xIZeothdbsbOobFa6KgdRvZm8tU=; b=Vq9FoCuR11U2PxgK+jYnZvnapH
 LHVV6g+s1jWwbDKwXs2yd5aa2ZfctnMDoG/7KynZeXFwpC8t+eXfG6KBcpOLK7Q+YY/bIjrNMkaVS
 SUxkWKT+5lWreslR93qisI/mGFrSqpWNLZ51xLhy5CfH/ihB1BGzj4HJQSdoqWIrTjyfuz3/JpQUO
 ZagchoGxO1+pgVQwuYo6Busk3SDBEdjgBgqeKkDZjxFMw11P/BXP4uAV1aYBBmPkKt4ZfspgLV3eT
 2zisSku0qRdkiLElpsdikDr0J844TQtCNYx7xJFexkF+hlPYFGnKP4Q1FP1McsJbCv18RxNxBVVPy
 6qK3jQNTFb9drv97c4Tseddy7gLEb7uPdz84XGM5ylmQyg7WOSzTDge+rVmYbbzal+vOufBnFyd/x
 FQOJl3hGSOelZ7et62FPS0jTKWt4SHxo4byZC5nfR6MG7rN720/PqA717GUjtwlTOGQ7mqT6USihA
 ZmLuz1GZ+076ahkq/ggLSseNAokgHv8u33IC9xWTbc9Qzlb2auNTQYpA5eCNOfN0GyDHA/qEVyUpZ
 Fh0Dgai1YvXgWPHP5L5m9yeecOWoi0+g0Nr1BdMVahpQVWD7f0GgdRPEAQuIKte86h+o6SjssJAqG
 uwcvqaZ8nOKfHwf14EfBdWLr1rmpqtEV/z2LCukmE=;
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 16:56:15 +0200
Message-ID: <3262111.WzMCRFa3dF@silver>
In-Reply-To: <20190628135015.2d1618cf@bahia.lan>
References: <cover.1561575449.git.qemu_oss@crudebyte.com>
 <fea3c051eb7ac3e2c5cbccb89d279a84d9b2c91d.1561575449.git.qemu_oss@crudebyte.com>
 <20190628135015.2d1618cf@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Freitag, 28. Juni 2019 13:50:15 CEST Greg Kurz wrote:
> > And with k=5 they would look like:
> > 
> > Index Dec/Bin -> Generated Suffix Bin
> > 1 [1] -> [000001] (6 bits)
> > 2 [10] -> [100001] (6 bits)
> > 3 [11] -> [010001] (6 bits)
> > 4 [100] -> [110001] (6 bits)
> > 5 [101] -> [001001] (6 bits)
> > 6 [110] -> [101001] (6 bits)
> > 7 [111] -> [011001] (6 bits)
> > 8 [1000] -> [111001] (6 bits)
> > 9 [1001] -> [000101] (6 bits)
> > 10 [1010] -> [100101] (6 bits)
> > 11 [1011] -> [010101] (6 bits)
> > 12 [1100] -> [110101] (6 bits)
> > ...
> > 65533 [1111111111111101] -> [0011100000000000100000000000] (28 bits)
> > 65534 [1111111111111110] -> [1011100000000000100000000000] (28 bits)
> > 65535 [1111111111111111] -> [0111100000000000100000000000] (28 bits)
> > Hence minBits=6 maxBits=28
> 
> IIUC, this k control parameter should be constant for the
> lifetime of QIDs. So it all boils down to choose a _good_
> value that would cover most scenarios, right ?

That's correct. In the end it's just a matter of how many devices do you 
expect to be exposed with the same 9p export for choosing an appropriate value 
for k. That parameter k must be constant at least until guest is rebooted, 
otherwise you would end up with completely different inode numbers if you 
would change that parameter k while guest is still running.

Like I mentioned before, I can send a short C file if you want to play around 
with that parameter k to see how the generated suffixes would look like. The 
console output is actually like shown above. Additionally the C demo also 
checks and proofs that all generated suffixes really generate unique numbers for 
the entire possible 64 bit range, so that should take away the scare about 
what this algorithm does.

Since you said before that you find it already exotic to have more than 1 
device being exported by 9p, I hence did not even bother to make that 
parameter "k" a runtime parameter. I *think* k=0 should be fine in practice.

> For now, I just have some _cosmetic_ remarks.
> 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> > 
> >  hw/9pfs/9p.c | 267
> >  ++++++++++++++++++++++++++++++++++++++++++++++++++++++----- hw/9pfs/9p.h
> >  |  67 ++++++++++++++-
> >  2 files changed, 312 insertions(+), 22 deletions(-)
> > 
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index e6e410972f..46c9f11384 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -26,6 +26,7 @@
> > 
> >  #include "migration/blocker.h"
> >  #include "sysemu/qtest.h"
> >  #include "qemu/xxhash.h"
> > 
> > +#include <math.h>
> > 
> >  int open_fd_hw;
> >  int total_open_fd;
> > 
> > @@ -572,6 +573,123 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
> > 
> >                                  P9_STAT_MODE_NAMED_PIPE |   \
> >                                  P9_STAT_MODE_SOCKET)
> > 
> > +#if P9_VARI_LENGTH_INODE_SUFFIXES
> 
> The numerous locations guarded by P9_VARI_LENGTH_INODE_SUFFIXES
> really obfuscate the code, and don't ease review (for me at least).
> And anyway, if we go for variable length suffixes, we won't keep
> the fixed length prefix code.

I just did that to provide a direct comparison between the fixed size prefix vs. 
variable size suffix code, since the fixed size prefix code is easier to 
understand.

If you want I can add a 6th "cleanup" patch that would remove the fixed size 
prefix code and all the #ifs ?

> > +
> > +/* Mirrors all bits of a byte. So e.g. binary 10100000 would become
> > 00000101. */ +static inline uint8_t mirror8bit(uint8_t byte) {
> 
> From CODING_STYLE:
> 
> 4. Block structure
> 
> [...]
> 
> for reasons of tradition and clarity it comes on a line by itself:
> 
>     void a_function(void)
>     {
>         do_something();
>     }

Got it.

> > +/* Parameter k for the Exponential Golomb algorihm to be used.
> > + *
> > + * The smaller this value, the smaller the minimum bit count for the Exp.
> > + * Golomb generated affixes will be (at lowest index) however for the
> > + * price of having higher maximum bit count of generated affixes (at
> > highest + * index). Likewise increasing this parameter yields in smaller
> > maximum bit + * count for the price of having higher minimum bit count.
> 
> Forgive my laziness but what are the benefits of a smaller or larger
> value, in term of user experience ?

Well, the goal in general is too keep the generated suffix numbers (or their bit 
count actually) as small as possible, because you are cutting away the same 
amount of bits of the orginal inode number from host. So the smaller the 
generated suffix number is, the more bits you can simply directly use from the 
original inode number from host, and hence the cheaper this remap code becomes 
in practice. Because if you have e.g. a suffix number of just 3 bits, then in 
practice you will very likely only have exactly 1 entry in that hash table 
*ever*. So hash lookup will be very cheap, etc.

If you had a suffix number of 32 bit instead that would mean you would need to 
cut away 32 bits from the original inode numbers, and hence you would likely 
end up with multiple entries in the hash table and the remap code becomes more 
expensive due to the hash table lookups, and even worse, you might even end up 
getting into that "full map" code which generates a hash entry for every next 
inode.

In practice this issue becomes probably more relevant when nested 
virtualization becomes more popular OR if you are using a large number of 
devices on the same export.

> > + */
> > +#define EXP_GOLOMB_K    0
> > +
> > +# if !EXP_GOLOMB_K
> > +
> > +/** @brief Exponential Golomb algorithm limited to the case k=0.
> > + *
> 
> This doesn't really help to have a special implementation for k=0. The
> resulting function is nearly identical to the general case. It is likely
> that the compiler can optimize it and generate the same code.

I don't think the compiler's optimizer would really drop all the instructions 
automatically of the generalized variant of that particular function. Does it 
matter in practice? No, I actually just provided that optimized variant for 
the special case k=0 because I think k=0 will be the default value for that 
parameter and because you were already picky about a simple

	if (pdu->s->dev_id == 0)

to be optimized. In practice users won't feel the runtime difference either 
one of the two optimization scenarios.

> > +/** @brief Exponential Golomb algorithm for arbitrary k (including k=0).
> > + *
> > + * The Exponential Golomb algorithm generates @b prefixes (@b not
> > suffixes!) + * with growing length and with the mathematical property of
> > being + * "prefix-free". The latter means the generated prefixes can be
> > prepended + * in front of arbitrary numbers and the resulting
> > concatenated numbers are + * guaranteed to be always unique.
> > + *
> > + * This is a minor adjustment to the original Exp. Golomb algorithm in
> > the
> > + * sense that lowest allowed index (@param n) starts with 1, not with
> > zero. + *
> > + * @param n - natural number (or index) of the prefix to be generated
> > + *            (1, 2, 3, ...)
> > + * @param k - parameter k of Exp. Golomb algorithm to be used
> > + *            (see comment on EXP_GOLOMB_K macro for details about k)
> > + */
> > +static VariLenAffix expGolombEncode(uint64_t n, int k) {
> 
> Function.

ack_once();

> > +    const uint64_t value = n + (1 << k) - 1;
> > +    const int bits = (int) log2(value) + 1;
> > +    return (VariLenAffix) {
> > +        .type = AffixType_Prefix,
> > +        .value = value,
> > +        .bits = bits + MAX((bits - 1 - k), 0)
> > +    };
> > +}
> > +
> > +# endif /* !EXP_GOLOMB_K */
> > +
> > +/** @brief Converts a suffix into a prefix, or a prefix into a suffix.
> > + *
> > + * What this function does is actually mirroring all bits of the affix
> > value,
> Drop the "What this function does..." wording and use an imperative style
> instead, ie. "Mirror all bits of..."

Ok.

> >  static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
> >  
> >                              uint64_t *path)
> >  
> >  {
> > 
> > @@ -615,11 +795,9 @@ static int qid_path_fullmap(V9fsPDU *pdu, const
> > struct stat *stbuf,> 
> >          .ino = stbuf->st_ino
> >      
> >      }, *val;
> >      uint32_t hash = qpf_hash(lookup);
> > 
> > -
> > -    /* most users won't need the fullmap, so init the table lazily */
> > -    if (!pdu->s->qpf_table.map) {
> > -        qht_init(&pdu->s->qpf_table, qpf_lookup_func, 1 << 16,
> > QHT_MODE_AUTO_RESIZE); -    }
> > +#if P9_VARI_LENGTH_INODE_SUFFIXES
> > +    VariLenAffix affix;
> > +#endif
> 
> Move this declaration to the beginning of the block.

Ok.

> > -/* stat_to_qid needs to map inode number (64 bits) and device id (32
> > bits)
> > +/** @brief Quick mapping host inode nr -> guest inode nr.
> > + *
> > + * This function performs quick remapping of an original file inode
> > number
> > + * on host to an appropriate different inode number on guest. This
> > remapping + * of inodes is required to avoid inode nr collisions on guest
> > which would + * happen if the 9p export contains more than 1 exported
> > file system (or + * more than 1 file system data set), because unlike on
> > host level where the + * files would have different device nrs, all files
> > exported by 9p would + * share the same device nr on guest (the device nr
> > of the virtual 9p device + * that is).
> > + *
> > + * if P9_VARI_LENGTH_INODE_SUFFIXES == 0 :
> > + * stat_to_qid needs to map inode number (64 bits) and device id (32
> > bits)
> > 
> >   * to a unique QID path (64 bits). To avoid having to map and keep track
> >   * of up to 2^64 objects, we map only the 16 highest bits of the inode
> >   plus
> >   * the device id to the 16 highest bits of the QID path. The 48 lowest
> >   bits
> >   * of the QID path equal to the lowest bits of the inode number.
> >   *
> > 
> > - * This takes advantage of the fact that inode number are usually not
> > - * random but allocated sequentially, so we have fewer items to keep
> > - * track of.
> 
> Hmm... why dropping this comment ?

Because I found the entire function comment block became already too verbose 
and that particular sentence to be not relevant. At least IMO.

Best regards,
Christian Schoenebeck

