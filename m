Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E448C2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 03:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5399924656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 03:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5399924656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu6K3-0005X0-A1
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 22:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iu6IX-0004P0-QZ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 22:03:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iu6IS-000206-4F
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 22:03:16 -0500
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41]:32059)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1iu6IR-0001yI-Kb
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 22:03:12 -0500
Received: from yt-mxauth.gw.nic.fujitsu.com (unknown [192.168.229.68]) by
 mgwym02.jp.fujitsu.com with smtp
 id 697f_6462_67b58087_9085_41db_8929_3d04f1f68b7e;
 Wed, 22 Jan 2020 12:02:59 +0900
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local
 (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
 by yt-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id F3FC2AC00A7
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 12:02:58 +0900 (JST)
Received: from g01jpexchyt33.g01.fujitsu.local (unknown [10.128.193.4])
 by g01jpfmpwyt03.exch.g01.fujitsu.local (Postfix) with ESMTP id CEDF346E73C;
 Wed, 22 Jan 2020 12:02:57 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 g01jpexchyt33.g01.fujitsu.local (10.128.193.36) with Microsoft SMTP Server id
 14.3.439.0; Wed, 22 Jan 2020 12:02:57 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <dgilbert@redhat.com>
Subject: Re: [PATCH v2 070/109] virtiofsd: passthrough_ll: control readdirplus
Date: Wed, 22 Jan 2020 12:11:40 +0900
Message-ID: <20200122031140.31529-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200121122433.50803-71-dgilbert@redhat.com>
References: <20200121122433.50803-71-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 211.128.242.41
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
Cc: m.mizuma@jp.fujitsu.com, berrange@redhat.com, slp@redhat.com,
 misono.tomohiro@jp.fujitsu.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 philmd@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Miklos Szeredi <mszeredi@redhat.com>
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  tools/virtiofsd/helper.c         | 3 +++
>  tools/virtiofsd/passthrough_ll.c | 7 ++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index c8cb88afdd..36eb273d8e 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -154,6 +154,9 @@ void fuse_cmdline_help(void)
>             "                               allowed (default: 10)\n"
>             "    -o norace                  disable racy fallback\n"
>             "                               default: false\n"
> +           "    -o readdirplus|no_readdirplus\n"
> +           "                               enable/disable readirplus\n"
> +           "                               default: readdirplus\n"

Actually, default behavior is
 1. no_readdirplus if cache=none
 2. readdirplus otherwise.
So help message should be fixed.

other than that
Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

>            );
>  }
>  
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index ae364a4825..b15633a044 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -117,6 +117,8 @@ struct lo_data {
>      double timeout;
>      int cache;
>      int timeout_set;
> +    int readdirplus_set;
> +    int readdirplus_clear;
>      struct lo_inode root; /* protected by lo->mutex */
>      struct lo_map ino_map; /* protected by lo->mutex */
>      struct lo_map dirp_map; /* protected by lo->mutex */
> @@ -140,6 +142,8 @@ static const struct fuse_opt lo_opts[] = {
>      { "cache=auto", offsetof(struct lo_data, cache), CACHE_NORMAL },
>      { "cache=always", offsetof(struct lo_data, cache), CACHE_ALWAYS },
>      { "norace", offsetof(struct lo_data, norace), 1 },
> +    { "readdirplus", offsetof(struct lo_data, readdirplus_set), 1 },
> +    { "no_readdirplus", offsetof(struct lo_data, readdirplus_clear), 1 },
>      FUSE_OPT_END
>  };
>  static bool use_syslog = false;
> @@ -478,7 +482,8 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
>          fuse_log(FUSE_LOG_DEBUG, "lo_init: activating flock locks\n");
>          conn->want |= FUSE_CAP_FLOCK_LOCKS;
>      }
> -    if (lo->cache == CACHE_NEVER) {
> +    if ((lo->cache == CACHE_NEVER && !lo->readdirplus_set) ||
> +        lo->readdirplus_clear) {
>          fuse_log(FUSE_LOG_DEBUG, "lo_init: disabling readdirplus\n");
>          conn->want &= ~FUSE_CAP_READDIRPLUS;
>      }
> -- 
> 2.24.1

