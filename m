Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C268FC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 11:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96CB7222C3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 11:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CB7222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irgbU-0006d2-RI
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 06:12:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1irgau-00069s-8j
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1irgas-0002DK-FR
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:12:15 -0500
Received: from mgwym03.jp.fujitsu.com ([211.128.242.42]:60045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1irgar-00029F-Vv
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:12:14 -0500
Received: from yt-mxoi1.gw.nic.fujitsu.com (unknown [192.168.229.67]) by
 mgwym03.jp.fujitsu.com with smtp
 id 3fd9_037f_5bc14c58_1585_4c9a_97f6_6f713c9c9017;
 Wed, 15 Jan 2020 20:12:03 +0900
Received: from g01jpfmpwyt01.exch.g01.fujitsu.local
 (g01jpfmpwyt01.exch.g01.fujitsu.local [10.128.193.38])
 by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id C6BA8AC0141
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 20:12:02 +0900 (JST)
Received: from G01JPEXCHYT14.g01.fujitsu.local
 (G01JPEXCHYT14.g01.fujitsu.local [10.128.194.53])
 by g01jpfmpwyt01.exch.g01.fujitsu.local (Postfix) with ESMTP id C4E4C6D674B;
 Wed, 15 Jan 2020 20:12:01 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 G01JPEXCHYT14.g01.fujitsu.local (10.128.194.53) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 20:12:00 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <dgilbert@redhat.com>
Subject: Re: [PATCH 084/104] Virtiofsd: fix memory leak on fuse queueinfo
Date: Wed, 15 Jan 2020 20:20:06 +0900
Message-ID: <20200115112006.32659-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20191212163904.159893-85-dgilbert@redhat.com>
References: <20191212163904.159893-85-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 211.128.242.42
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

> From: Liu Bo <bo.liu@linux.alibaba.com>
> 
> For fuse's queueinfo, both queueinfo array and queueinfos are allocated in
> fv_queue_set_started() but not cleaned up when the daemon process quits.
> 
> This fixes the leak in proper places.
> 
> Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> Signed-off-by: Eric Ren <renzhen@linux.alibaba.com>
> ---
>  tools/virtiofsd/fuse_virtio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
> index 7b22ae8d4f..a364f23d5d 100644
> --- a/tools/virtiofsd/fuse_virtio.c
> +++ b/tools/virtiofsd/fuse_virtio.c
> @@ -671,6 +671,8 @@ static void fv_queue_set_started(VuDev *dev, int qidx, bool started)
>          }
>          close(ourqi->kill_fd);
>          ourqi->kick_fd = -1;
> +        free(vud->qi[qidx]);
> +        vud->qi[qidx] = NULL;
>      }
>  }
>  
> @@ -878,6 +880,13 @@ int virtio_session_mount(struct fuse_session *se)
>  void virtio_session_close(struct fuse_session *se)
>  {
>      close(se->vu_socketfd);

I beleve above close() should be removed as it is called 6 line below.

> +
> +    if (!se->virtio_dev) {
> +        return;
> +    }
> +
> +    close(se->vu_socketfd);
> +    free(se->virtio_dev->qi);
>      free(se->virtio_dev);
>      se->virtio_dev = NULL;
>  }
> -- 
> 2.23.0

