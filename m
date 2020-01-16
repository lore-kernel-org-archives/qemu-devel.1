Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2C0C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 07:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8410E20748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 07:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8410E20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irzI7-0006yu-KZ
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 02:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1irzHU-0006UC-HT
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 02:09:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1irzHO-00085Y-EQ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 02:09:27 -0500
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:10793)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1irzHN-00082V-7m
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 02:09:22 -0500
Received: from kw-mxoi2.gw.nic.fujitsu.com (unknown [192.168.231.133]) by
 mgwkm02.jp.fujitsu.com with smtp
 id 5e68_9d73_25288407_c419_4ff0_a347_9c13f1eb39b8;
 Thu, 16 Jan 2020 16:09:14 +0900
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local
 (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
 by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 53051AC0104
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 16:09:09 +0900 (JST)
Received: from G01JPEXCHKW13.g01.fujitsu.local
 (G01JPEXCHKW13.g01.fujitsu.local [10.0.194.52])
 by g01jpfmpwkw02.exch.g01.fujitsu.local (Postfix) with ESMTP id 57B2A3286FD;
 Thu, 16 Jan 2020 16:09:08 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 G01JPEXCHKW13.g01.fujitsu.local (10.0.194.52) with Microsoft SMTP Server id
 14.3.439.0; Thu, 16 Jan 2020 16:09:09 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <dgilbert@redhat.com>
Subject: Re: [PATCH 070/104] virtiofsd: fail when parent inode isn't known in
 lo_do_lookup()
Date: Thu, 16 Jan 2020 16:17:29 +0900
Message-ID: <20200116071729.27180-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20191212163904.159893-71-dgilbert@redhat.com>
References: <20191212163904.159893-71-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.219.69.169
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
Cc: misono.tomohiro@jp.fujitsu.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looks good to me.
 Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

> ---
>  tools/virtiofsd/passthrough_ll.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 1618db5a92..ef8b88e3d1 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -778,6 +778,15 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
>      struct lo_data *lo = lo_data(req);
>      struct lo_inode *inode, *dir = lo_inode(req, parent);
>  
> +    /*
> +     * name_to_handle_at() and open_by_handle_at() can reach here with fuse
> +     * mount point in guest, but we don't have its inode info in the
> +     * ino_map.
> +     */
> +    if (!dir) {
> +        return ENOENT;
> +    }
> +
>      memset(e, 0, sizeof(*e));
>      e->attr_timeout = lo->timeout;
>      e->entry_timeout = lo->timeout;
> @@ -787,7 +796,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
>          name = ".";
>      }
>  
> -    newfd = openat(lo_fd(req, parent), name, O_PATH | O_NOFOLLOW);
> +    newfd = openat(dir->fd, name, O_PATH | O_NOFOLLOW);
>      if (newfd == -1) {
>          goto out_err;
>      }
> @@ -797,7 +806,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
>          goto out_err;
>      }
>  
> -    inode = lo_find(lo_data(req), &e->attr);
> +    inode = lo_find(lo, &e->attr);
>      if (inode) {
>          close(newfd);
>          newfd = -1;
> @@ -813,6 +822,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
>          inode->is_symlink = S_ISLNK(e->attr.st_mode);
>          inode->refcount = 1;
>          inode->fd = newfd;
> +        newfd = -1;
>          inode->ino = e->attr.st_ino;
>          inode->dev = e->attr.st_dev;

