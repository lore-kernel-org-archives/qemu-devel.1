Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977AAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E4E206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAdqOMkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E4E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgMiu-0000Wc-LM
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 02:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jgMi5-00081d-Oq; Wed, 03 Jun 2020 02:17:09 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:35178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jgMi5-0003VR-1E; Wed, 03 Jun 2020 02:17:09 -0400
Received: by mail-ed1-x544.google.com with SMTP id e12so741166eds.2;
 Tue, 02 Jun 2020 23:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ms7e5TlI2lWajG5qATNB/+gm5+nkW5sjZg3MlT/lfIs=;
 b=QAdqOMkHKKYLkk+W3+LthfVVdKfTqQskiKAK3YFlstxmEuQrNJjBIsAe70hYs8YcOh
 Y46BTSLMlRHyeViXrzJ5RqFAw7LYmp1OcW/ETGgEEpGTML5nhIt7FJzLEZ52O/RzJnTu
 DofrKK+nyOyYt8ymDChT8k44MxTwFp2p4m8WbIbTPfFywJAlkG7S2D7CXqF8X/IjELhY
 w1XfgJ5EzJQnQ9ANXO3eeva8/7Fmzhf9r1WXwLh+xPE3pDnK5X/BpzB/gPfJZsFfM2GD
 bAtShqa/2F6T7CCcFU1eZ3P4dJZm7YQqdMKUxzDGtQWxr9XFehAIs1L35HJjSGyJj4Xe
 C6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ms7e5TlI2lWajG5qATNB/+gm5+nkW5sjZg3MlT/lfIs=;
 b=BvDSPgvRw7NiNOeHRyodGsiAHM6hlZJkD6IMfKPukPk6eSc1mzZrSgn+nugX+z8Ony
 bR6QM6xIAe6N3b5LgJMVl319O09jygqDdoEMsGrohnoWVYVAr/elUqcRS9vzOsipvAwH
 k0j56VI56OXBCntnx06Ey8jo1KmAJcPI7mQbVz1as79hRDas307JJkh32EkSTCBkrd8B
 5rhBe0ze8jYKzGnAbpck/5yjk9L068OlXltvxnccZESnG13OYXHoT6OsuhOa7nBzlFJq
 TUtvrGsTvsU0bHg6o7QO56Dpa+AYOWSVXcMH7FO/pMGhzYE41cl3vAJxGNE3GGUR8tdM
 ptPQ==
X-Gm-Message-State: AOAM532K42n0+W47P0C09PSg/YvBE+9+xO9z8VwHy8/a3oyDpDpyqdbA
 zCqRaWs7SNPA1/dH29eJwXWZiPR3xuljXSkgeOw=
X-Google-Smtp-Source: ABdhPJyhgx+R1Gr+qIF3uj1c6rcE/N+62Z8Rew7ifh6dtgReCuqJc7+30+IK+S/uLW9Tj4PKEYIOZoL1PJ7rarEk8Qg=
X-Received: by 2002:a50:9b16:: with SMTP id o22mr22303579edi.130.1591165027214; 
 Tue, 02 Jun 2020 23:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqwH6btbKFD0Ei47e+QHN2eBPG5H2PTS92MAje2Tij4Y=A@mail.gmail.com>
 <76587685-fa03-6dd6-5ca3-caeaf3c7504b@redhat.com>
In-Reply-To: <76587685-fa03-6dd6-5ca3-caeaf3c7504b@redhat.com>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 3 Jun 2020 07:16:56 +0100
Message-ID: <CA+XhMqx=Y7Ep3jwJgLJMxysVGGvDE8BAe8VA5MKvFzuiTdrmww@mail.gmail.com>
Subject: Re: [PATCH] util/oslib-posix : qemu_init_exec_dir implementation for
 MacOS
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x544.google.com
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
Cc: Justin Hibbits <chmeeedalf@gmail.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, John Arbuckle <programmingkidx@gmail.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Izik Eidus <izik@veertu.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mikhail Gusarov <dottedmag@dottedmag.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Little bit better the second version of the patch, difficult to sort
out things with mailing list :-)
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
             p =3D buf;
         }
     }
+#elif defined(__APPLE__)
+    {
+        int len;

+        len =3D proc_pidpath(getpid(), buf, sizeof(buf) - 1);
+        if (len > 0) {
+            buf[len] =3D 0;
+            p =3D buf;
+        }
+    }
 #endif
     /* If we don't have any way of figuring out the actual executable
        location then try argv[0].  */
--
2.26.2

On Wed, 3 Jun 2020 at 07:08, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Cc'ing more developers.
>
> On 5/26/20 10:40 PM, David CARLIER wrote:
> > From b24a6702beb2a4e2a9c1c03b69c6d1dd07d4cf08 Mon Sep 17 00:00:00 2001
> > From: David Carlier <devnexen@gmail.com>
> > Date: Tue, 26 May 2020 21:35:27 +0100
> > Subject: [PATCH] util/oslib: current process full path resolution on Ma=
cOS
> >
> > Using existing libproc to fill the path.
> >
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  util/oslib-posix.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > index 062236a1ab..96f0405ee6 100644
> > --- a/util/oslib-posix.c
> > +++ b/util/oslib-posix.c
> > @@ -55,6 +55,10 @@
> >  #include <sys/sysctl.h>
> >  #endif
> >
> > +#ifdef __APPLE__
> > +#include <libproc.h>
> > +#endif
> > +
> >  #include "qemu/mmap-alloc.h"
> >
> >  #ifdef CONFIG_DEBUG_STACK_USAGE
> > @@ -366,6 +370,15 @@ void qemu_init_exec_dir(const char *argv0)
> >              p =3D buf;
> >          }
> >      }
> > +#elif defined(__APPLE__)
> > +    {
> > +        uint32_t len;
> > +        len =3D proc_pidpath(getpid(), buf, sizeof(buf) - 1);
> > +        if (len > 0) {
> > +            buf[len] =3D 0;
> > +            p =3D buf;
> > +        }
> > +    }
> >  #endif
> >      /* If we don't have any way of figuring out the actual executable
> >         location then try argv[0].  */
> >
>

