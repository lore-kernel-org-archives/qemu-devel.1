Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D83C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 06:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9CA42076A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 06:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="N6bISJfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CA42076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiAt3-0002cT-Ut
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 02:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jiAs8-00023l-Cm; Mon, 08 Jun 2020 02:03:00 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:55064 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jiAs7-0002Qr-2C; Mon, 08 Jun 2020 02:02:59 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 7A1B54C819;
 Mon,  8 Jun 2020 06:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1591596173;
 x=1593410574; bh=fus+5Y5+j9E+AG0Bap3hrVEKnG3MTbAqxv5w5oXLGF4=; b=
 N6bISJfdqglVC1YY3RnEV5CzMiZ6nsFJKVC6/WR+z486nMjcBcCbehkr6M7+rZ2o
 j496G+NatgZxmn+sDv74hEAbdPNJ0Poc/HmG3W3jdWezNKVIUtqMi9fj/2jlrO+R
 5gZde1royXcGk0HMENp3zV6frtXNWgePfi6pPZJqB1w=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 62Pn6Rq0V6ri; Mon,  8 Jun 2020 09:02:53 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id D8BF3412CE;
 Mon,  8 Jun 2020 09:02:52 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 8 Jun
 2020 09:02:52 +0300
Date: Mon, 8 Jun 2020 09:02:52 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: David CARLIER <devnexen@gmail.com>
Subject: Re: [PATCH] util/oslib-posix : qemu_init_exec_dir implementation for
 MacOS
Message-ID: <20200608060252.GD27616@SPB-NB-133.local>
References: <CA+XhMqwH6btbKFD0Ei47e+QHN2eBPG5H2PTS92MAje2Tij4Y=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+XhMqwH6btbKFD0Ei47e+QHN2eBPG5H2PTS92MAje2Tij4Y=A@mail.gmail.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 02:02:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 26, 2020 at 09:40:27PM +0100, David CARLIER wrote:
> From b24a6702beb2a4e2a9c1c03b69c6d1dd07d4cf08 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Tue, 26 May 2020 21:35:27 +0100
> Subject: [PATCH] util/oslib: current process full path resolution on MacOS
> 
> Using existing libproc to fill the path.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  util/oslib-posix.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 062236a1ab..96f0405ee6 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -55,6 +55,10 @@
>  #include <sys/sysctl.h>
>  #endif
> 
> +#ifdef __APPLE__
> +#include <libproc.h>
> +#endif
> +
>  #include "qemu/mmap-alloc.h"
> 
>  #ifdef CONFIG_DEBUG_STACK_USAGE
> @@ -366,6 +370,15 @@ void qemu_init_exec_dir(const char *argv0)
>              p = buf;
>          }
>      }
> +#elif defined(__APPLE__)
> +    {
> +        uint32_t len;
> +        len = proc_pidpath(getpid(), buf, sizeof(buf) - 1);

Hi David,

proc_pidpath handler in the xnu kernel is indirectly calling
build_path_with_parent [1] and it includes NULL terminator into
buffersize, i.e. the patch seems to limit path length to one less
character than OS allows.

> +        if (len > 0) {
> +            buf[len] = 0;
> +            p = buf;
> +        }
> +    }
>  #endif
>      /* If we don't have any way of figuring out the actual executable
>         location then try argv[0].  */
> -- 
> 2.26.2
> 


The change looks okay but it's not clear why it is needed [2].

Also, libproc.h [3] has this comment:

/*
 * This header file contains private interfaces to obtain process information.  
 * These interfaces are subject to change in future releases.
 */

But iTerm2 [4] an Chromium [5] are using it. An alternative (if it works
and IMO less appealing) would be to retrieve process path using AppKit [6].

1. https://opensource.apple.com/source/xnu/xnu-6153.81.5/bsd/vfs/vfs_cache.c.auto.html
2. https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message
3. https://opensource.apple.com/source/xnu/xnu-6153.81.5/libsyscall/wrappers/libproc/libproc.h.auto.html
4. https://gitlab.com/gnachman/iterm2/blob/872e3d63fbcaf7b4235c4f3b7273e09a7ba4c1d1/sources/iTermLSOF.m#L31
5. https://github.com/chromium/chromium/blob/2ca8c5037021c9d2ecc00b787d58a31ed8fc8bcb/base/process/process_handle_mac.cc#L31
6. https://developer.apple.com/documentation/appkit/nsworkspace?language=objc

Regards,
Roman

