Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202D3C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 19:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB57022DA7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 19:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB57022DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i09pe-0007mA-4X
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 15:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1i09nB-0005um-Sk
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 15:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1i09nA-0006Nr-Du
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 15:27:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36358)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1i09n7-0006MM-76; Tue, 20 Aug 2019 15:27:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2DF113090FDF;
 Tue, 20 Aug 2019 19:27:36 +0000 (UTC)
Received: from [10.18.17.187] (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EABA10016F3;
 Tue, 20 Aug 2019 19:27:29 +0000 (UTC)
To: Nir Soffer <nirsof@gmail.com>, qemu-block@nongnu.org
References: <20190817175346.12518-1-nsoffer@redhat.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1624c705-aa27-b840-ea6a-26886ba52b8e@redhat.com>
Date: Tue, 20 Aug 2019 15:27:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190817175346.12518-1-nsoffer@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 20 Aug 2019 19:27:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Use QEMU_IS_ALIGNED
 instead of reinventing it
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/17/19 1:53 PM, Nir Soffer wrote:
> Replace instances of:
> 
>     (n & (BDRV_SECTOR_SIZE - 1)) == 0)
> 
> With:
> 
>     QEMU_IS_ALIGNED(n, BDRV_SECTOR_SIZE)
> 

Do you have a magical incantation you used to find these?

> Which reveals the intent of the code better, and makes it easier to
> locate the code checking alignment.
> 
> QEMU_IS_ALIGNED is implemented using %, which may be less efficient but
> it is used only in assert() except one instance, so it should not
> matter.
> 

There is virtually no way these aren't optimized by the compiler.

> Signed-off-by: Nir Soffer <nsoffer@redhat.com>

Therefore:

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  block/bochs.c | 4 ++--
>  block/cloop.c | 4 ++--
>  block/dmg.c   | 4 ++--
>  block/io.c    | 8 ++++----
>  block/qcow2.c | 4 ++--
>  block/vvfat.c | 8 ++++----
>  qemu-img.c    | 2 +-
>  7 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/block/bochs.c b/block/bochs.c
> index 962f18592d..32bb83b268 100644
> --- a/block/bochs.c
> +++ b/block/bochs.c
> @@ -248,8 +248,8 @@ bochs_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
>      QEMUIOVector local_qiov;
>      int ret;
>  
> -    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> -    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> +    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
>  
>      qemu_iovec_init(&local_qiov, qiov->niov);
>      qemu_co_mutex_lock(&s->lock);
> diff --git a/block/cloop.c b/block/cloop.c
> index 384c9735bb..4de94876d4 100644
> --- a/block/cloop.c
> +++ b/block/cloop.c
> @@ -253,8 +253,8 @@ cloop_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
>      int nb_sectors = bytes >> BDRV_SECTOR_BITS;
>      int ret, i;
>  
> -    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> -    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> +    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
>  
>      qemu_co_mutex_lock(&s->lock);
>  
> diff --git a/block/dmg.c b/block/dmg.c
> index 45f6b28f17..4a045f2b3e 100644
> --- a/block/dmg.c
> +++ b/block/dmg.c
> @@ -697,8 +697,8 @@ dmg_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
>      int nb_sectors = bytes >> BDRV_SECTOR_BITS;
>      int ret, i;
>  
> -    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> -    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> +    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
>  
>      qemu_co_mutex_lock(&s->lock);
>  
> diff --git a/block/io.c b/block/io.c
> index 56bbf195bb..7508703ecd 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1080,8 +1080,8 @@ static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
>      sector_num = offset >> BDRV_SECTOR_BITS;
>      nb_sectors = bytes >> BDRV_SECTOR_BITS;
>  
> -    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> -    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> +    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
>      assert(bytes <= BDRV_REQUEST_MAX_BYTES);
>      assert(drv->bdrv_co_readv);
>  
> @@ -1133,8 +1133,8 @@ static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
>      sector_num = offset >> BDRV_SECTOR_BITS;
>      nb_sectors = bytes >> BDRV_SECTOR_BITS;
>  
> -    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> -    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> +    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
>      assert(bytes <= BDRV_REQUEST_MAX_BYTES);
>  
>      assert(drv->bdrv_co_writev);
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 59cff1d4cb..41cab70e1d 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2072,8 +2072,8 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
>              }
>              if (bs->encrypted) {
>                  assert(s->crypto);
> -                assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> -                assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> +                assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> +                assert(QEMU_IS_ALIGNED(cur_bytes, BDRV_SECTOR_SIZE));
>                  if (qcow2_co_decrypt(bs, cluster_offset, offset,
>                                       cluster_data, cur_bytes) < 0) {
>                      ret = -EIO;
> diff --git a/block/vvfat.c b/block/vvfat.c
> index f6c28805dd..019b8f1341 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1547,8 +1547,8 @@ vvfat_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
>      int nb_sectors = bytes >> BDRV_SECTOR_BITS;
>      void *buf;
>  
> -    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> -    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> +    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
>  
>      buf = g_try_malloc(bytes);
>      if (bytes && buf == NULL) {
> @@ -3082,8 +3082,8 @@ vvfat_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
>      int nb_sectors = bytes >> BDRV_SECTOR_BITS;
>      void *buf;
>  
> -    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> -    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> +    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
>  
>      buf = g_try_malloc(bytes);
>      if (bytes && buf == NULL) {
> diff --git a/qemu-img.c b/qemu-img.c
> index c920e3564c..ca3af0c549 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -2138,7 +2138,7 @@ static int img_convert(int argc, char **argv)
>              int64_t sval;
>  
>              sval = cvtnum(optarg);
> -            if (sval < 0 || sval & (BDRV_SECTOR_SIZE - 1) ||
> +            if (sval < 0 || !QEMU_IS_ALIGNED(sval, BDRV_SECTOR_SIZE) ||
>                  sval / BDRV_SECTOR_SIZE > MAX_BUF_SECTORS) {
>                  error_report("Invalid buffer size for sparse output specified. "
>                      "Valid sizes are multiples of %llu up to %llu. Select "
> 


