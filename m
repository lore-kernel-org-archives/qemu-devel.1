Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1773CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD0420679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMzv+WPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD0420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUIy-0007cL-4a
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jgUHv-00070W-Vy; Wed, 03 Jun 2020 10:22:40 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:38645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jgUHv-00021M-10; Wed, 03 Jun 2020 10:22:39 -0400
Received: by mail-ej1-x644.google.com with SMTP id a25so2374528ejg.5;
 Wed, 03 Jun 2020 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vZs6T4gKUdpKHq6e98AQK4tjpLsS5bx0e3ffjLhxytY=;
 b=MMzv+WPK3kdonkrk4iqO3JqbStvij8qAU1p6vUEjS52Yv6iqZAKYDMbDw+2K6FvbhM
 po6etBd2RpxytewfLAQyjQgvCScHoFHWyCgrEKAQK7aTLFQNGJAZT2pg4PEqTLe+TQFf
 PP8pqMSyGKcs2cw+ON5iyS/WyWNkBVMBT0U+sSph9q2rdczl9Z9OnV9n53893VhWdVVD
 926lamcJQ+JMieAUl9VsK3ZAQfudmeoGu442ucXZGRNTiQ29L0JQIe/GgTpRiptHL2HL
 duSozj+/GevwpCdES/fp1mEBs1gCv5jy1bK8MjkUEjRGCHiXwXBL3dqfTbXrSWRNPGXO
 c9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vZs6T4gKUdpKHq6e98AQK4tjpLsS5bx0e3ffjLhxytY=;
 b=KIASkk3aGOoLPDfFi+S3YRLcJIOlCiRYMizafyiYnuxuFWHndmoUwZpwuDq4Gtt1KI
 ZuCne9VwOxbgPktCx3y25TUqrqVU6ZhdgYvF26rNyC112KKgdRwN3qdsyUXXZHBlrPDh
 McFLQSmm0nWh3xr9lhj7qUkDZ4iYs0cha9PFCD7UL5dYTu3GxphF2yU6UoVxaPBbZ4/E
 at2h0YJVNimFXvpz60JN5hgxPRUBwcHMcs1ouoR8ZRM9ML6HKhvutsvwHx2saW3/FQSx
 OcjRHX59t1w6RXvAHpjsGRZQx5b+Ml9ND0kDjbRQ5/Pbcz6Cc+Ir7KLbCymgn5deu/qz
 Mc5Q==
X-Gm-Message-State: AOAM5300DhqY11bTSafpYM4jG0TNzJfqsiZEjtanfOABEJELnp7QNvO2
 XeAT3VBS/yii6f1yaa2rbAppYlL4ToC6kPRlc4Q=
X-Google-Smtp-Source: ABdhPJwYK2YZMy91WaPELAHZmL9qJ0sM3gbx2wfU8rNAonF48uoJIUgZg0WGPaOOYF5SCocxV/mYjWoWsXNYfh+6+B4=
X-Received: by 2002:a17:906:ac3:: with SMTP id
 z3mr21074842ejf.311.1591194157007; 
 Wed, 03 Jun 2020 07:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqwH6btbKFD0Ei47e+QHN2eBPG5H2PTS92MAje2Tij4Y=A@mail.gmail.com>
 <76587685-fa03-6dd6-5ca3-caeaf3c7504b@redhat.com>
 <20200603090921.64351a28@titan.knownspace>
In-Reply-To: <20200603090921.64351a28@titan.knownspace>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 3 Jun 2020 15:22:26 +0100
Message-ID: <CA+XhMqw2ORNvkN=C+LdvMxDvrX2i25FW-9wXias6Mbu0wGjBrg@mail.gmail.com>
Subject: Re: [PATCH] util/oslib-posix : qemu_init_exec_dir implementation for
 MacOS
To: Justin Hibbits <chmeeedalf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x644.google.com
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
Cc: qemu-trivial@nongnu.org, Mikhail Gusarov <dottedmag@dottedmag.net>,
 qemu-devel@nongnu.org, John Arbuckle <programmingkidx@gmail.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Izik Eidus <izik@veertu.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Good point even tough the libproc api is here in this form since quite a ti=
me.

From d23bf60961ee036f8298794f879d1b8b9bd717dc Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Tue, 26 May 2020 21:35:27 +0100
Subject: [PATCH] util/oslib: current process full path resolution on MacOS

Using existing libproc to fill the path.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 util/oslib-posix.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 062236a1ab..9dd1e1a18b 100644
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
+        if (len <=3D 0) {
+            return;
+        }
+        p =3D buf;
+    }
 #endif
     /* If we don't have any way of figuring out the actual executable
        location then try argv[0].  */
--=20
2.26.2

On Wed, 3 Jun 2020 at 15:09, Justin Hibbits <chmeeedalf@gmail.com> wrote:
>
> On Wed, 3 Jun 2020 08:08:42 +0200
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>
> > Cc'ing more developers.
> >
> > On 5/26/20 10:40 PM, David CARLIER wrote:
> > > From b24a6702beb2a4e2a9c1c03b69c6d1dd07d4cf08 Mon Sep 17 00:00:00
> > > 2001 From: David Carlier <devnexen@gmail.com>
> > > Date: Tue, 26 May 2020 21:35:27 +0100
> > > Subject: [PATCH] util/oslib: current process full path resolution
> > > on MacOS
> > >
> > > Using existing libproc to fill the path.
> > >
> > > Signed-off-by: David Carlier <devnexen@gmail.com>
> > > ---
> > >  util/oslib-posix.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > >
> > > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > > index 062236a1ab..96f0405ee6 100644
> > > --- a/util/oslib-posix.c
> > > +++ b/util/oslib-posix.c
> > > @@ -55,6 +55,10 @@
> > >  #include <sys/sysctl.h>
> > >  #endif
> > >
> > > +#ifdef __APPLE__
> > > +#include <libproc.h>
> > > +#endif
> > > +
> > >  #include "qemu/mmap-alloc.h"
> > >
> > >  #ifdef CONFIG_DEBUG_STACK_USAGE
> > > @@ -366,6 +370,15 @@ void qemu_init_exec_dir(const char *argv0)
> > >              p =3D buf;
> > >          }
> > >      }
> > > +#elif defined(__APPLE__)
> > > +    {
> > > +        uint32_t len;
> > > +        len =3D proc_pidpath(getpid(), buf, sizeof(buf) - 1);
> > > +        if (len > 0) {
> > > +            buf[len] =3D 0;
> > > +            p =3D buf;
> > > +        }
> > > +    }
> > >  #endif
> > >      /* If we don't have any way of figuring out the actual
> > > executable location then try argv[0].  */
> > >
> >
>
> Apologies, I don't have context for this.  Why was I CC'd on this?
>
> Does proc_pidpath() not NUL-terminate its written string?  And, given
> from my quick google search, it looks like this function is private and
> subject to change, so can you guarantee that the returned length is the
> *written* length, not the full string length?  If not, you could be
> overwriting other arbitrary data.
>
> - Justin

