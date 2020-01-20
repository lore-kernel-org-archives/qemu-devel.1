Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA03C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EDD20684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EDD20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQjj-0001Ig-CL
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 01:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1itQia-0000eY-Un
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 01:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1itQiY-0004ON-Sa
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 01:39:23 -0500
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40]:13674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1itQiY-0004LQ-D2
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 01:39:22 -0500
Received: from yt-mxoi2.gw.nic.fujitsu.com (unknown [192.168.229.69]) by
 mgwym01.jp.fujitsu.com with smtp
 id 5e66_514a_0b9244e7_7fc1_439b_940b_58dbf6b6a29b;
 Mon, 20 Jan 2020 15:39:12 +0900
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local
 (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
 by yt-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3CA2BAC00A7
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 15:39:12 +0900 (JST)
Received: from G01JPEXCHKW13.g01.fujitsu.local
 (G01JPEXCHKW13.g01.fujitsu.local [10.0.194.52])
 by g01jpfmpwkw01.exch.g01.fujitsu.local (Postfix) with ESMTP id 24F886923E3;
 Mon, 20 Jan 2020 15:39:11 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 G01JPEXCHKW13.g01.fujitsu.local (10.0.194.52) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 Jan 2020 15:39:11 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <dgilbert@redhat.com>
Subject: Re: [PATCH 062/104] virtiofsd: Handle hard reboot
Date: Mon, 20 Jan 2020 15:46:56 +0900
Message-ID: <20200120064656.12828-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20191212163904.159893-63-dgilbert@redhat.com>
References: <20191212163904.159893-63-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 211.128.242.40
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

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Handle a
>   mount
>   hard reboot (without unmount)
>   mount
> 
> we get another 'init' which FUSE doesn't normally expect.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tools/virtiofsd/fuse_lowlevel.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
> index 2d1d1a2e59..45125ef66a 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -2436,7 +2436,21 @@ void fuse_session_process_buf_int(struct fuse_session *se,
>              goto reply_err;
>          }
>      } else if (in->opcode == FUSE_INIT || in->opcode == CUSE_INIT) {
> -        goto reply_err;
> +        if (fuse_lowlevel_is_virtio(se)) {

> +            /*
> +             * TODO: This is after a hard reboot typically, we need to do
> +             * a destroy, but we can't reply to this request yet so
> +             * we can't use do_destroy
> +             */

Hi,

I wonder what is the TODO actually. Is this just to provide a common
function for both here and do_destroy() or more than that?

Thanks
Misono

> +            fuse_log(FUSE_LOG_DEBUG, "%s: reinit\n", __func__);
> +            se->got_destroy = 1;
> +            se->got_init = 0;
> +            if (se->op.destroy) {
> +                se->op.destroy(se->userdata);
> +            }
> +        } else {
> +            goto reply_err;
> +        }
>      }
>  
>      err = EACCES;
> -- 
> 2.23.0

