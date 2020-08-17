Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B01C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165E820789
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GU3d8obT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165E820789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7eak-0006Dc-91
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 08:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1k7ea3-0005iE-J8
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:49:39 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1k7ea2-000192-0t
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:49:39 -0400
Received: by mail-pl1-x642.google.com with SMTP id g7so6339609plq.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 05:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=H29v8Chzv+qTSMTdjsiCsBORtWSKN0eHav86WfATubU=;
 b=GU3d8obT0jImh2Aoeu9vSramVYKB1vAP5G6GoNRVdfLccCPQLZoMzzEu8YYjJglobU
 z6iWmOt5TJTMnKyS7UFg7UIVTtVrj+GSbFYFRjWJLz+fUB+VrsdCDqrydKodBID1ERA1
 1BkI9VoHB5gg97MUFa9bgwhiFpjC2UXLIArLvZAyfisOTiIVlWxIIh8r/S03HaCA4gxl
 Km+OJDQte3CF2/S/s8xxCSOlPaUEpC00UGLM5p949grsh7900qEZGfGjNWmoQVj+drEv
 BRcbW0JrLgLvXXCrSh5CTGMUbqBVEU/ixhZod6L3iWvZi1JyDPSbCkULK0R89W98oqpf
 G0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=H29v8Chzv+qTSMTdjsiCsBORtWSKN0eHav86WfATubU=;
 b=H8ENruXqxpPTHRJvrspxp4FklaiO9wQKK8cSYbD5c5Er7LFoNrmmD0a+kTwnC0PeUH
 4I0I8Vrw47F16USr6eRewJ/varhaTN8AUEqv3AD2VHANz1kaMzPrU/lggdosrUn8AOle
 BWPY8mfpjFXSPDQFR8Xc0Pq1rCSY5loPxTRZCPrDG0GvBajCr8NynC9qPSgbOtEWtTHM
 2Ac/jV7EQ6LjusvUYM9+a9enqEDjtsojLL7dSamjpAV2zvMWnwpqOTIgasE+ETyoboBg
 WSB+q8nQB3QvcoSsZUdI02hy9mVRiK82U0M6LtS0bC4zURXtwZO1faabgpTXEVSWgH6a
 jq+w==
X-Gm-Message-State: AOAM533uN6ZjsR8GS7MeYQ/ieSqZABRKeLdK5defMvxzdiaxJqDMyPRA
 NqgjSis9iXw6cKgSkMEqBD8=
X-Google-Smtp-Source: ABdhPJyBnVjW0W0BzH9F/xh7Bp0Ci5ws7AZVFIpVqitHzraJi6NHNt04tCNj7sZ/91DF2ZEBW3PcWg==
X-Received: by 2002:a17:902:8347:: with SMTP id
 z7mr7910819pln.20.1597668576605; 
 Mon, 17 Aug 2020 05:49:36 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id o15sm20417195pfu.167.2020.08.17.05.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 05:49:35 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Mon, 17 Aug 2020 20:49:27 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/6] vhost-user-server: drop unused #include <eventfd.h>
Message-ID: <20200817124927.72rtan4menitqdop@Rk>
References: <20200614183907.514282-3-coiby.xu@gmail.com>
 <20200619120046.2422205-1-stefanha@redhat.com>
 <20200619120046.2422205-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200619120046.2422205-2-stefanha@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=coiby.xu@gmail.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 01:00:42PM +0100, Stefan Hajnoczi wrote:
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> util/vhost-user-server.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
>index e94a8d8a83..49ada8bc78 100644
>--- a/util/vhost-user-server.c
>+++ b/util/vhost-user-server.c
>@@ -7,7 +7,6 @@
>  * later.  See the COPYING file in the top-level directory.
>  */
> #include "qemu/osdep.h"
>-#include <sys/eventfd.h>
> #include "qemu/main-loop.h"
> #include "vhost-user-server.h"
>
>--
>2.26.2
>

All the patches have been applied to v10. I'm curious how do you find
this issue. Is there a tool to detect this issue or simply you are so
familiar with the QEMU code that you can spot it very easily?

--
Best regards,
Coiby

