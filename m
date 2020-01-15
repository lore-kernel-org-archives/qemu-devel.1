Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15927C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 11:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7B92187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 11:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7B92187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irhJz-00016H-Th
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 06:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1irhJM-0000Qd-MH
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1irhJI-00016I-85
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:58:11 -0500
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41]:29689)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1irhJH-0000z2-19
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:58:07 -0500
Received: from yt-mxoi2.gw.nic.fujitsu.com (unknown [192.168.229.69]) by
 mgwym02.jp.fujitsu.com with smtp
 id 1aca_0abf_86652398_8fcd_422b_a265_83d25c042966;
 Wed, 15 Jan 2020 20:57:55 +0900
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local
 (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
 by yt-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id B5D86AC00E0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 20:57:54 +0900 (JST)
Received: from G01JPEXCHYT13.g01.fujitsu.local
 (G01JPEXCHYT13.g01.fujitsu.local [10.128.194.52])
 by g01jpfmpwyt03.exch.g01.fujitsu.local (Postfix) with ESMTP id AD6206EA002;
 Wed, 15 Jan 2020 20:57:53 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 G01JPEXCHYT13.g01.fujitsu.local (10.128.194.52) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 20:57:53 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <dgilbert@redhat.com>
Subject: Re: [PATCH 051/104] virtiofsd: Parse flag FUSE_WRITE_KILL_PRIV
Date: Wed, 15 Jan 2020 21:06:03 +0900
Message-ID: <20200115120603.3191-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20191212163904.159893-52-dgilbert@redhat.com>
References: <20191212163904.159893-52-dgilbert@redhat.com>
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
Cc: misono.tomohiro@jp.fujitsu.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Vivek Goyal <vgoyal@redhat.com>
> 
> Caller can set FUSE_WRITE_KILL_PRIV in write_flags. Parse it and pass it
> to the filesystem.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  tools/virtiofsd/fuse_common.h   | 6 +++++-
>  tools/virtiofsd/fuse_lowlevel.c | 4 +++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/virtiofsd/fuse_common.h b/tools/virtiofsd/fuse_common.h
> index 147c043bd9..1e8191b7a6 100644
> --- a/tools/virtiofsd/fuse_common.h
> +++ b/tools/virtiofsd/fuse_common.h
> @@ -93,8 +93,12 @@ struct fuse_file_info {
>       */
>      unsigned int cache_readdir:1;
>  
> +    /* Indicates that suid/sgid bits should be removed upon write */
> +    unsigned int kill_priv:1;
> +
> +
>      /** Padding.  Reserved for future use*/
> -    unsigned int padding:25;
> +    unsigned int padding:24;
>      unsigned int padding2:32;
>  
>      /*
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
> index bd5ca2f157..c8a3b1597a 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -1144,6 +1144,7 @@ static void do_write(fuse_req_t req, fuse_ino_t nodeid,
>      memset(&fi, 0, sizeof(fi));
>      fi.fh = arg->fh;
>      fi.writepage = (arg->write_flags & FUSE_WRITE_CACHE) != 0;
> +    fi.kill_priv = !!(arg->write_flags & FUSE_WRITE_KILL_PRIV);
>  
>      fi.lock_owner = arg->lock_owner;
>      fi.flags = arg->flags;
> @@ -1179,7 +1180,8 @@ static void do_write_buf(fuse_req_t req, fuse_ino_t nodeid,
>      fi.lock_owner = arg->lock_owner;
>      fi.flags = arg->flags;
>      fi.fh = arg->fh;
> -    fi.writepage = arg->write_flags & FUSE_WRITE_CACHE;
> +    fi.writepage = !!(arg->write_flags & FUSE_WRITE_CACHE);
> +    fi.kill_priv = !!(arg->write_flags & FUSE_WRITE_KILL_PRIV);
>  
>      if (ibufv->count == 1) {
>          assert(!(tmpbufv.buf[0].flags & FUSE_BUF_IS_FD));
> -- 
> 2.23.0

Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

side-note: virtiofs uses write_buf() and therefore do_write() is never called.
How about cleanup the function?

