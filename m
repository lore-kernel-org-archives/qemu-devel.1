Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E682DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29E22186A
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmKIvf/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29E22186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOui-0003gj-1N
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOu6-0003Ag-FM
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:51:10 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOu2-0005Cn-5x
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:51:10 -0400
Received: by mail-oi1-x244.google.com with SMTP id t4so9143326oij.9
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2LmzC6bN6TRPuLILlxvA9/U2scMrArBZb+9KNgxoGTQ=;
 b=CmKIvf/KppfxeYwdg2cvxELjebKMYoTXlbae1+SVVzuwR0jvIRY20s8obEeP2bF4WA
 zHuK8tKTuvh+pzsVgsJMQuwMWBPx5f1bDDYw4teXc8LvOI+4iNouSjmAZF/vSsHNC8gz
 BeQgFzICCXO9nTyVCms9Wlf5lNl4vZ8A9h/9S6gZgquhMBqa1UKDhO3bQISOPnnjfZS2
 Viy3rttW2q6sGZ8jpHwi5AiKyd02ac89iJQnLV/xwezZf/vVaHoge/ClKeNlju8o7P0P
 c+GvyZV/weUcwQpmp3lMk2lkJH+lIZDFlWxgH9K25Xwe39n24f3PpXL9banbqJZ37hWD
 71xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2LmzC6bN6TRPuLILlxvA9/U2scMrArBZb+9KNgxoGTQ=;
 b=KgouwDEMqWjAgxZMNhcH9ZeXMoskGKZ/08lyCPQoMIfuVUsoMdYAzMkq+H4kLZDybP
 65q+rZhuDmtM6DbZARCtgOmzCJQYP/4I3gOtg/JbyMqgdEnw16KCOxZNGVwj8lcYAKuH
 SG0edhTyhGOLYRuNtLzUC59gr0DS34uqEJipUHjOTpcDHcGXWS+5nS2uEwhiCWBU3lCX
 qCn15O9hRTEbfhAY/VCi+D/SYIgGXJEa96BkrgPrGspINmm9WHG43aTqQ+2Cw8gwrOoX
 AhDK9lwmhHGAMq9aqNFDYJwL7hj+DEcod8l+Ep+wa3ea7rDOL90jngMYwOjTOpYWsa69
 wFww==
X-Gm-Message-State: AOAM532v/J6j2iYexkn2jQFPsoOBp26RxVJGeUCDHumaQujbnZEZpyt4
 im2POqwqByWHc3atgA5Yuaceqjz9NpUoGDQs2+kcnw==
X-Google-Smtp-Source: ABdhPJxd/r/pxLJGZu0g2ozT+lU7Ft61mQ0a59o42m2D2e1Ha3PBCanEozfWRN6tjYgBnrhTO9zl1WdXEL0AtYuWGPc=
X-Received: by 2002:aca:54c9:: with SMTP id
 i192mr22045948oib.163.1593795064877; 
 Fri, 03 Jul 2020 09:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200702143955.678-1-thuth@redhat.com>
 <5EFE07BC.6040407@mindspring.com>
 <1e699fdc-639e-ef8a-313f-7e665cad868c@redhat.com>
 <5EFE5291.6030300@mindspring.com>
 <975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com>
 <5EFF5DFC.2060006@mindspring.com>
In-Reply-To: <5EFF5DFC.2060006@mindspring.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 17:50:53 +0100
Message-ID: <CAFEAcA81y59yaOCW=QONy9EKv6Fdkkwb=XGJ786-N5du2+P9NQ@mail.gmail.com>
Subject: Re: [PATCH] configure / util: Auto-detect the availability of
 openpty()
To: Michele Denber <denber@mindspring.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Peter Tribble <peter.tribble@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 at 17:38, Michele Denber <denber@mindspring.com> wrote:
>
> Oops, I hit Send before I was done.  I tried  the Haiku patch:
>
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index cc5e37177a..faebc13fac 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -39,7 +39,7 @@ util-obj-y += qsp.o
>  util-obj-y += range.o
>  util-obj-y += stats64.o
>  util-obj-y += systemd.o
> -util-obj-$(CONFIG_POSIX) += drm.o
> +util-obj-$(CONFIG_LINUX) += drm.o
>  util-obj-y += guest-random.o
>  util-obj-$(CONFIG_GIO) += dbus.o
>  dbus.o-cflags = $(GIO_CFLAGS)
>
> but it didn't work:
>
> root@hemlock:~/qemu-5.0.0# gpatch -p1 < Makefile.objs.patch.diff
> patching file util/Makefile.objs
> Hunk #1 FAILED at 39.
> 1 out of 1 hunk FAILED -- saving rejects to file util/Makefile.objs.rej

This is because you're trying to apply the patch to the
5.0.0 release, but it was made against the current head-of-git,
and this file has changed a little between the two.
Generally we do all development against head-of-git, so
I would suggest that you try again with that.

As it happens, the current preferred fix for the drm.c issue
is this one:
https://patchew.org/QEMU/20200703145614.16684-1-peter.maydell@linaro.org/20200703145614.16684-10-peter.maydell@linaro.org/

thanks
-- PMM

