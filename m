Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF2CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 22:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86FA52088E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 22:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r28w/dlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FA52088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdi1k-0007K8-Lp
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 18:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jdi1D-0006oE-N2; Tue, 26 May 2020 18:25:55 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:46751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jdi1C-0000ao-Tn; Tue, 26 May 2020 18:25:55 -0400
Received: by mail-ed1-x541.google.com with SMTP id m21so2468820eds.13;
 Tue, 26 May 2020 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=Mc/EJD8EAO84GIr8ydCzqGkSxsnybC6HXt0SYil3CIk=;
 b=r28w/dloRmYKvuo7X7edP9LLC4EWvRjq22X38MuXw4ZlydMT/V6vtwtXi7sqH6NF5c
 GEROFJNcdiTxLpZ3MloBETCyNmS9BB4nBWCc2sw2d2BbG7HT3+UK5yVInf2QAjWK/SC3
 kHDcgssGYAcyfBdCAaH+n5KxMUuEblWBbzUC0SjdrqlneMYn7gjAXagwwamQxhEjgU7V
 07rxwKENZxVsLwhBRQsS4+CdcxDdU5lxrH2Ec15vl8XFCEn088HIFkXq2u1BraSeyxhP
 XVgRp95JcE18gxVSGsnM6jGDZ+IeMvpPPh1S8CiCypm979WQNZ7PwprHi+wwWjB85K+L
 8nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=Mc/EJD8EAO84GIr8ydCzqGkSxsnybC6HXt0SYil3CIk=;
 b=IWwS1ILAyQ228Vid70BjeyWBxn3Fizqv/RKI/lnlkz+Zd4z9TTJ953KJTgA+A/LbSd
 ykf7arHyz0vjfLRv0ZBJdWdQwMOUVg+/8I0JNZSuupOx+C1IxJ1mlbM5elT5dN0a+onM
 bCvu4th6/FJUoIcAHvTA8dOV2xMgXV8CcA4bVGgKS8IBqmjtUgM5w3JweBvsydU9xfdu
 SPWcIJ32tD90w3hg7BTS/J/kCBwJtHx+grc8Pp1W9WIuMlJqpOT1scq2TmcDo6tGTg3E
 bZys8QG32gu3c2oPQgWaWKfA3XeF/cMg4FDV4pagV2j5+RYptFjqrDxi76IUHcVjwhtO
 CIhg==
X-Gm-Message-State: AOAM530K7uiRo0skFf0pGM9+ILXQqUS7Jr9li9BYmBzC37XrTGEolyxj
 gXMijGeUrw2DlKrVlMAkhnViv+TAnJWzob2eoUu0pcEL+Ko=
X-Google-Smtp-Source: ABdhPJy3uBLe5dV1RsFwOAM71Oet7r9/HAE4Ve7qnPoYx5c/P0KVlp/pGnypgcgAtlxOYoy8qc2ebm6BOnJFjJWkjoQ=
X-Received: by 2002:aa7:c38f:: with SMTP id k15mr22166851edq.7.1590531952654; 
 Tue, 26 May 2020 15:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqwH6btbKFD0Ei47e+QHN2eBPG5H2PTS92MAje2Tij4Y=A@mail.gmail.com>
In-Reply-To: <CA+XhMqwH6btbKFD0Ei47e+QHN2eBPG5H2PTS92MAje2Tij4Y=A@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 26 May 2020 23:25:41 +0100
Message-ID: <CA+XhMqwZ_AkyiMKRNTiyi14DDfXybXHSn_=LsjoDzk_nr3K7rA@mail.gmail.com>
Subject: Re: [PATCH] util/oslib-posix : qemu_init_exec_dir implementation for
 MacOS
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

From ce857629697e8b6a2149fd3a1e16b7eea26aafca Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Tue, 26 May 2020 21:35:27 +0100
Subject: [PATCH] util/oslib: current process full path resolution on MacOS

Using existing libproc to fill the path.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 util/oslib-posix.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 062236a1ab..445af2f9be 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -55,6 +55,10 @@
 #include <sys/sysctl.h>
 #endif

+#ifdef __APPLE__
+#include <libproc.h>
+#endif
+
 #include "qemu/mmap-alloc.h"

 #ifdef CONFIG_DEBUG_STACK_USAGE
@@ -366,6 +370,15 @@ void qemu_init_exec_dir(const char *argv0)
             p = buf;
         }
     }
+#elif defined(__APPLE__)
+    {
+        int len;
+        len = proc_pidpath(getpid(), buf, sizeof(buf) - 1);
+        if (len > 0) {
+            buf[len] = 0;
+            p = buf;
+        }
+    }
 #endif
     /* If we don't have any way of figuring out the actual executable
        location then try argv[0].  */
-- 
2.26.2

On Tue, 26 May 2020 at 21:40, David CARLIER <devnexen@gmail.com> wrote:
>
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

