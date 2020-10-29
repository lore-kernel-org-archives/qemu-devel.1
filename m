Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EFBC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 15:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259B52076E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 15:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259B52076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY9Uw-0001qA-41
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 11:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kY9Tw-0000Ut-Jj; Thu, 29 Oct 2020 11:04:52 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:35245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kY9Tu-0002gU-Aw; Thu, 29 Oct 2020 11:04:52 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.118])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id BE12E6FAE2F0;
 Thu, 29 Oct 2020 16:04:46 +0100 (CET)
Received: from kaod.org (37.59.142.104) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 29 Oct
 2020 16:04:46 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005d8c8a92c-bed4-48f7-bc82-cd24f4e669c8,
 E5CD8EB7A660BD10DDB00AFD0F9198C3FA657B0B) smtp.auth=groug@kaod.org
Date: Thu, 29 Oct 2020 16:04:44 +0100
From: Greg Kurz <groug@kaod.org>
To: jokenzhang <zhangxinhao1@huawei.com>
Subject: Re: [PATCH v2 1/3] hw/9pfs : add spaces around operator
Message-ID: <20201029160444.0d2068f4@bahia.lan>
In-Reply-To: <20201029142619.1309649-1-zhangxinhao1@huawei.com>
References: <20201029142619.1309649-1-zhangxinhao1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 56680943-3b48-4745-ab7a-5d1628b86e89
X-Ovh-Tracer-Id: 15712496152762489126
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrleefgdejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdhtrhhivhhirghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 11:04:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: alex.chen@huawei.com, qemu-trivial@nongnu.org, qemu_oss@crudebyte.com,
 qemu-devel@nongnu.org, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 22:26:17 +0800
jokenzhang <zhangxinhao1@huawei.com> wrote:

> Fix code style. Operator needs spaces both sides.
> 
> Signed-off-by: jokenzhang <zhangxinhao1@huawei.com>

jokenzhang really looks like a computer username or nick, which isn't an
appropriate way to sign one's work.

Quoting a comment from Eric Blake on a recent patch that had a similar flaw:

It's preferred to have Signed-off-by tags use a rendering of a legal
name rather than a mere computer username.  Whether that is just a
westernized form of your name, or you use native characters, or even
both spellings side-by-side, is up to you (see commit d7d26226b for an
example of the latter).

With that fixed, you can add my r-b for all three patches.

Reviewed-by: Greg Kurz <groug@kaod.org>

> Signed-off-by: Kai Deng <dengkai1@huawei.com>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> ---
>  hw/9pfs/9p-local.c | 10 +++++-----
>  hw/9pfs/9p.c       | 16 ++++++++--------
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 3107637209..af52c1daac 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -162,13 +162,13 @@ static void local_mapped_file_attr(int dirfd, const char *name,
>      memset(buf, 0, ATTR_MAX);
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
> @@ -823,7 +823,7 @@ static int local_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
>          if (fd == -1) {
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
> @@ -1091,7 +1091,7 @@ static mode_t v9mode_to_mode(uint32_t mode, V9fsString *extension)
>          }
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
>          if (err < 0) {
>              goto out;
>          }
> @@ -3428,7 +3428,7 @@ static int v9fs_fill_statfs(V9fsState *s, V9fsPDU *pdu, struct statfs *stbuf)
>       * compute bsize factor based on host file system block size
>       * and client msize
>       */
> -    bsize_factor = (s->msize - P9_IOHDRSZ)/stbuf->f_bsize;
> +    bsize_factor = (s->msize - P9_IOHDRSZ) / stbuf->f_bsize;
>      if (!bsize_factor) {
>          bsize_factor = 1;
>      }
> @@ -3440,9 +3440,9 @@ static int v9fs_fill_statfs(V9fsState *s, V9fsPDU *pdu, struct statfs *stbuf)
>       * adjust(divide) the number of blocks, free blocks and available
>       * blocks by bsize factor
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
> @@ -4185,6 +4185,6 @@ static void __attribute__((__constructor__)) v9fs_set_fd_limit(void)
>          error_report("Failed to get the resource limit");
>          exit(1);
>      }
> -    open_fd_hw = rlim.rlim_cur - MIN(400, rlim.rlim_cur/3);
> -    open_fd_rc = rlim.rlim_cur/2;
> +    open_fd_hw = rlim.rlim_cur - MIN(400, rlim.rlim_cur / 3);
> +    open_fd_rc = rlim.rlim_cur / 2;
>  }


