Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC176C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC4C20704
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="jcvK/m26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC4C20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY5ET-000591-Jr
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 06:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kY5Dr-0004cU-Dx; Thu, 29 Oct 2020 06:31:59 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:51197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kY5Dp-0002LG-2Q; Thu, 29 Oct 2020 06:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=xIO64QxRVFR1CseVJzIeEb1lTilqXjjs6Or6ZgT+d0A=; b=jcvK/m26gNT57CYlDP+vRuGwOZ
 SYDHrZA49eMznSoJiCWLfbQsNYhm2vIVJIoLnXLzwH0W6Bqz11C4FO+SZRGAejR72mv1iq6uvjv22
 ZG3EzoXPM4tXtCDvs2rkDWfqlJMAaIy5O0oEmjnojxs8Jv30nBG8SSNsWSj8nMHptvd4aIP1Oimda
 o0HQnyOaZnL8X7s4fqtnNdnu3KsRxVX+/vcgTbuF3iGlq/juvy5jv+61ef5BDaGK01AGpEkYxCsXw
 WYLZ0h2aCmNmIdqEQ/gQ1PCX/+9FCfs/vpKrVzJM4eu/4Zbpy6pBwhoMFRMI2PBaCZFs3qHPlUrsD
 brzZodpA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: jokenzhang <zhangxinhao1@huawei.com>, alex.chen@huawei.com,
 qemu-trivial@nongnu.org, dengkai1@huawei.com, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/3] hw/9pfs : add spaces around operator
Date: Thu, 29 Oct 2020 11:29:38 +0100
Message-ID: <4360366.TziOZfpSdE@silver>
In-Reply-To: <20201028090540.1070935-1-zhangxinhao1@huawei.com>
References: <20201028090540.1070935-1-zhangxinhao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 06:31:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mittwoch, 28. Oktober 2020 10:05:38 CET jokenzhang wrote:
> Signed-off-by: jokenzhang <zhangxinhao1@huawei.com>
> Signed-off-by: Kai Deng <dengkai1@huawei.com>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> ---
>  hw/9pfs/9p-local.c | 10 +++++-----
>  hw/9pfs/9p.c       | 16 ++++++++--------
>  2 files changed, 13 insertions(+), 13 deletions(-)

It would make sense to mention the actual purpose of this patch: fix code 
style.

Same applies to the other 2 patches.

> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 3107637209..af52c1daac 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -162,13 +162,13 @@ static void local_mapped_file_attr(int dirfd, const
> char *name, memset(buf, 0, ATTR_MAX);
>      while (fgets(buf, ATTR_MAX, fp)) {
>          if (!strncmp(buf, "virtfs.uid", 10)) {
> -            stbuf->st_uid = atoi(buf+11);
> +            stbuf->st_uid = atoi(buf + 11);
>          } else if (!strncmp(buf, "virtfs.gid", 10)) {
> -            stbuf->st_gid = atoi(buf+11);
> +            stbuf->st_gid = atoi(buf + 11);
>          } else if (!strncmp(buf, "virtfs.mode", 11)) {
> -            stbuf->st_mode = atoi(buf+12);
> +            stbuf->st_mode = atoi(buf + 12);
>          } else if (!strncmp(buf, "virtfs.rdev", 11)) {
> -            stbuf->st_rdev = atoi(buf+12);
> +            stbuf->st_rdev = atoi(buf + 12);
>          }
>          memset(buf, 0, ATTR_MAX);
>      }
> @@ -823,7 +823,7 @@ static int local_open2(FsContext *fs_ctx, V9fsPath
> *dir_path, const char *name, if (fd == -1) {
>              goto out;
>          }
> -        credp->fc_mode = credp->fc_mode|S_IFREG;
> +        credp->fc_mode = credp->fc_mode | S_IFREG;
>          if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
>              /* Set cleint credentials in xattr */
>              err = local_set_xattrat(dirfd, name, credp);
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 741d222c3f..94df440fc7 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1091,7 +1091,7 @@ static mode_t v9mode_to_mode(uint32_t mode, V9fsString
> *extension) }
>      }
> 
> -    if (!(ret&~0777)) {
> +    if (!(ret & ~0777)) {
>          ret |= S_IFREG;
>      }
> 
> @@ -2776,7 +2776,7 @@ static void coroutine_fn v9fs_create(void *opaque)
>          v9fs_path_unlock(s);
>      } else {
>          err = v9fs_co_open2(pdu, fidp, &name, -1,
> -                            omode_to_uflags(mode)|O_CREAT, perm, &stbuf);
> +                            omode_to_uflags(mode) | O_CREAT, perm, &stbuf);
> if (err < 0) {
>              goto out;
>          }
> @@ -3428,7 +3428,7 @@ static int v9fs_fill_statfs(V9fsState *s, V9fsPDU
> *pdu, struct statfs *stbuf) * compute bsize factor based on host file
> system block size
>       * and client msize
>       */
> -    bsize_factor = (s->msize - P9_IOHDRSZ)/stbuf->f_bsize;
> +    bsize_factor = (s->msize - P9_IOHDRSZ) / stbuf->f_bsize;
>      if (!bsize_factor) {
>          bsize_factor = 1;
>      }
> @@ -3440,9 +3440,9 @@ static int v9fs_fill_statfs(V9fsState *s, V9fsPDU
> *pdu, struct statfs *stbuf) * adjust(divide) the number of blocks, free
> blocks and available * blocks by bsize factor
>       */
> -    f_blocks = stbuf->f_blocks/bsize_factor;
> -    f_bfree  = stbuf->f_bfree/bsize_factor;
> -    f_bavail = stbuf->f_bavail/bsize_factor;
> +    f_blocks = stbuf->f_blocks / bsize_factor;
> +    f_bfree  = stbuf->f_bfree / bsize_factor;
> +    f_bavail = stbuf->f_bavail / bsize_factor;
>      f_files  = stbuf->f_files;
>      f_ffree  = stbuf->f_ffree;
>      fsid_val = (unsigned int) stbuf->f_fsid.__val[0] |
> @@ -4185,6 +4185,6 @@ static void __attribute__((__constructor__))
> v9fs_set_fd_limit(void) error_report("Failed to get the resource limit");
>          exit(1);
>      }
> -    open_fd_hw = rlim.rlim_cur - MIN(400, rlim.rlim_cur/3);
> -    open_fd_rc = rlim.rlim_cur/2;
> +    open_fd_hw = rlim.rlim_cur - MIN(400, rlim.rlim_cur / 3);
> +    open_fd_rc = rlim.rlim_cur / 2;
>  }

Best regards,
Christian Schoenebeck



