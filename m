Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41070C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B64E206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmnYlZyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B64E206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDqQc-0004aX-92
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 10:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDqPm-00046C-NQ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 10:40:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45300
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDqPk-0000vP-IJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 10:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599144031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPyZ0K9KWXVHQxk3tStrUiGpoqxyDMNmbiN7HX3eo2Q=;
 b=SmnYlZyWaFH6l8WX8iwWTfQbsh575LelETXb3m1rrMO4tCmyUyUNVK3CEuH59gWUF/CXU+
 U9xNfcPtmWIdTXU0QiF261CDcmAiXAChAnXFCp4KPIBo1v/LlUipNLNfbLGKmX+zdxwXOC
 G/GJuyiCktbKNLO6ItR41+HyQj9FArw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-O3MsSn70PuG0AFnoiR-wZg-1; Thu, 03 Sep 2020 10:40:29 -0400
X-MC-Unique: O3MsSn70PuG0AFnoiR-wZg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B09411084D65;
 Thu,  3 Sep 2020 14:40:27 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-10.ams2.redhat.com [10.36.114.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1550010013D7;
 Thu,  3 Sep 2020 14:40:25 +0000 (UTC)
Subject: Re: [PATCH v4 06/12] block: Fixes nfs on msys2/mingw
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200903083147.707-1-luoyonggang@gmail.com>
 <20200903083147.707-7-luoyonggang@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <75fef7ab-6c42-02b9-8c94-f633ae614ad9@redhat.com>
Date: Thu, 3 Sep 2020 16:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200903083147.707-7-luoyonggang@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


CC: NFS maintainer + qemu-block

On 03/09/2020 10.31, Yonggang Luo wrote:
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  block/nfs.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/block/nfs.c b/block/nfs.c
> index 61a249a9fc..34b2cd5708 100644
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
> @@ -51,6 +53,12 @@
>  #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
>  #define QEMU_NFS_MAX_DEBUG_LEVEL 2
>  
> +#if defined (_WIN32)
> +#define nfs_stat __stat64
> +#else
> +#define nfs_stat stat
> +#endif
> +
>  typedef struct NFSClient {
>      struct nfs_context *context;
>      struct nfsfh *fh;
> @@ -58,7 +66,7 @@ typedef struct NFSClient {
>      bool has_zero_init;
>      AioContext *aio_context;
>      QemuMutex mutex;
> -    blkcnt_t st_blocks;
> +    int64_t st_size;
>      bool cache_used;
>      NFSServer *server;
>      char *path;
> @@ -70,7 +78,7 @@ typedef struct NFSRPC {
>      int ret;
>      int complete;
>      QEMUIOVector *iov;
> -    struct stat *st;
> +    struct nfs_stat *st;
>      Coroutine *co;
>      NFSClient *client;
>  } NFSRPC;
> @@ -419,7 +427,7 @@ static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
>                                 int flags, int open_flags, Error **errp)
>  {
>      int64_t ret = -EINVAL;
> -    struct stat st;
> +    struct nfs_stat st;
>      char *file = NULL, *strp = NULL;
>  
>      qemu_mutex_init(&client->mutex);
> @@ -545,7 +553,7 @@ static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
>      }
>  
>      ret = DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
> -    client->st_blocks = st.st_blocks;
> +    client->st_size = st.st_size;
>      client->has_zero_init = S_ISREG(st.st_mode);
>      *strp = '/';
>      goto out;
> @@ -729,11 +737,11 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
>  {
>      NFSClient *client = bs->opaque;
>      NFSRPC task = {0};
> -    struct stat st;
> +    struct nfs_stat st;
>  
>      if (bdrv_is_read_only(bs) &&
>          !(bs->open_flags & BDRV_O_NOCACHE)) {
> -        return client->st_blocks * 512;
> +        return client->st_size;
>      }
>  
>      task.bs = bs;
> @@ -746,7 +754,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
>      nfs_set_events(client);
>      BDRV_POLL_WHILE(bs, !task.complete);
>  
> -    return (task.ret < 0 ? task.ret : st.st_blocks * 512);
> +    return (task.ret < 0 ? task.ret : st.st_size);
>  }
>  
>  static int coroutine_fn
> @@ -778,7 +786,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
>                                BlockReopenQueue *queue, Error **errp)
>  {
>      NFSClient *client = state->bs->opaque;
> -    struct stat st;
> +    struct nfs_stat st;
>      int ret = 0;
>  
>      if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {
> @@ -800,7 +808,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
>                         nfs_get_error(client->context));
>              return ret;
>          }
> -        client->st_blocks = st.st_blocks;
> +        client->st_size = st.st_size;
>      }
>  
>      return 0;
> 


