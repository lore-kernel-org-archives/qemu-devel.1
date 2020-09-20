Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56F4C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 19:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF2A207D3
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 19:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF2A207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK4dy-0005g0-Oj
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 15:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@kamp.de>) id 1kK4cb-00058t-9Q
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 15:03:37 -0400
Received: from kerio.kamp.de ([195.62.97.192]:37039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@kamp.de>) id 1kK4cY-0002AF-5J
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 15:03:36 -0400
X-Footer: a2FtcC5kZQ==
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 21:03:20 +0200
Received: (qmail 60911 invoked from network); 20 Sep 2020 19:03:24 -0000
Received: from ac34.vpn.kamp-intra.net (HELO ?172.20.250.34?)
 (pl@kamp.de@::ffff:172.20.250.34)
 by submission.kamp.de with ESMTPS (AES128-SHA encrypted) ESMTPA;
 20 Sep 2020 19:03:24 -0000
Subject: Re: [PATCH v10 25/26] block: Fixes nfs compiling error on msys2/mingw
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200915171234.236-1-luoyonggang@gmail.com>
 <20200915171234.236-26-luoyonggang@gmail.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <847c146b-a3e4-640b-9bad-52a35019c0d6@kamp.de>
Date: Sun, 20 Sep 2020 21:03:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200915171234.236-26-luoyonggang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=195.62.97.192; envelope-from=pl@kamp.de;
 helo=kerio.kamp.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 15:03:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 15.09.20 um 19:12 schrieb Yonggang Luo:
> These compiling errors are fixed:
> ../block/nfs.c:27:10: fatal error: poll.h: No such file or directory
>    27 | #include <poll.h>
>       |          ^~~~~~~~
> compilation terminated.
>
> ../block/nfs.c:63:5: error: unknown type name 'blkcnt_t'
>    63 |     blkcnt_t st_blocks;
>       |     ^~~~~~~~
> ../block/nfs.c: In function 'nfs_client_open':
> ../block/nfs.c:550:27: error: 'struct _stat64' has no member named 'st_blocks'
>   550 |     client->st_blocks = st.st_blocks;
>       |                           ^
> ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> ../block/nfs.c:751:41: error: 'struct _stat64' has no member named 'st_blocks'
>   751 |     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
>       |                                         ^
> ../block/nfs.c: In function 'nfs_reopen_prepare':
> ../block/nfs.c:805:31: error: 'struct _stat64' has no member named 'st_blocks'
>   805 |         client->st_blocks = st.st_blocks;
>       |                               ^
> ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> ../block/nfs.c:752:1: error: control reaches end of non-void function [-Werror=return-type]
>   752 | }
>       | ^
>
> On msys2/mingw, there is no st_blocks in struct _stat64 yet, we disable the usage of it
> on msys2/mingw, and create a typedef long long blkcnt_t; for further implementation
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  block/nfs.c | 37 ++++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/block/nfs.c b/block/nfs.c
> index 61a249a9fc..5f83dbe407 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -24,7 +24,9 @@
>  
>  #include "qemu/osdep.h"
>  
> +#if !defined(_WIN32)
>  #include <poll.h>
> +#endif
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> @@ -51,6 +53,13 @@
>  #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
>  #define QEMU_NFS_MAX_DEBUG_LEVEL 2
>  
> +#if defined(_WIN32)
> +#define nfs_stat __stat64
> +typedef long long blkcnt_t;
> +#else
> +#define nfs_stat stat
> +#endif
> +
>  typedef struct NFSClient {
>      struct nfs_context *context;
>      struct nfsfh *fh;
> @@ -70,7 +79,7 @@ typedef struct NFSRPC {
>      int ret;
>      int complete;
>      QEMUIOVector *iov;
> -    struct stat *st;
> +    struct nfs_stat *st;
>      Coroutine *co;
>      NFSClient *client;
>  } NFSRPC;
> @@ -415,11 +424,21 @@ static void nfs_file_close(BlockDriverState *bs)
>      nfs_client_close(client);
>  }


I would still remove the st struct from NFSClient on WIN32 completely.


>  
> +static blkcnt_t nfs_get_st_blocks(const struct nfs_stat *st)
> +{
> +#if defined(_WIN32)
> +    /* TODO: Not be possible implement on win32 yet */
> +    return 0;
> +#else
> +    return st->st_blocks;
> +#endif
> +}
> +
>  static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
>                                 int flags, int open_flags, Error **errp)
>  {
>      int64_t ret = -EINVAL;
> -    struct stat st;
> +    struct nfs_stat st;
>      char *file = NULL, *strp = NULL;
>  
>      qemu_mutex_init(&client->mutex);
> @@ -545,7 +564,7 @@ static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
>      }
>  
>      ret = DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
> -    client->st_blocks = st.st_blocks;
> +    client->st_blocks = nfs_get_st_blocks(&st);


And put an ifndef _WIN32 arount this.


>      client->has_zero_init = S_ISREG(st.st_mode);
>      *strp = '/';
>      goto out;
> @@ -706,6 +725,7 @@ static int nfs_has_zero_init(BlockDriverState *bs)
>      return client->has_zero_init;
>  }
>  
> +#if !defined(_WIN32)
>  /* Called (via nfs_service) with QemuMutex held.  */
>  static void
>  nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
> @@ -729,7 +749,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
>  {
>      NFSClient *client = bs->opaque;
>      NFSRPC task = {0};
> -    struct stat st;
> +    struct nfs_stat st;
>  
>      if (bdrv_is_read_only(bs) &&
>          !(bs->open_flags & BDRV_O_NOCACHE)) {
> @@ -746,8 +766,9 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
>      nfs_set_events(client);
>      BDRV_POLL_WHILE(bs, !task.complete);
>  
> -    return (task.ret < 0 ? task.ret : st.st_blocks * 512);
> +    return (task.ret < 0 ? task.ret : nfs_get_st_blocks(&st) * 512);
>  }
> +#endif
>  
>  static int coroutine_fn
>  nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
> @@ -778,7 +799,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
>                                BlockReopenQueue *queue, Error **errp)
>  {
>      NFSClient *client = state->bs->opaque;
> -    struct stat st;
> +    struct nfs_stat st;
>      int ret = 0;
>  
>      if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {
> @@ -800,7 +821,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
>                         nfs_get_error(client->context));
>              return ret;
>          }
> -        client->st_blocks = st.st_blocks;
> +        client->st_blocks = nfs_get_st_blocks(&st);


and this.


>      }
>  
>      return 0;
> @@ -869,7 +890,9 @@ static BlockDriver bdrv_nfs = {
>      .create_opts                    = &nfs_create_opts,
>  
>      .bdrv_has_zero_init             = nfs_has_zero_init,
> +#if !defined(_WIN32)
>      .bdrv_get_allocated_file_size   = nfs_get_allocated_file_size,
> +#endif
>      .bdrv_co_truncate               = nfs_file_co_truncate,
>  
>      .bdrv_file_open                 = nfs_file_open,


And add a comment that the _WIN32 implementation of libnfs does not provide the allocated filesize of a file.


Peter



