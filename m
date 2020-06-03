Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09622C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD20320738
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPO9qid2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD20320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgU5i-0005NJ-3o
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chmeeedalf@gmail.com>)
 id 1jgU58-0004mf-3m; Wed, 03 Jun 2020 10:09:26 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:42600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chmeeedalf@gmail.com>)
 id 1jgU57-0007og-9c; Wed, 03 Jun 2020 10:09:25 -0400
Received: by mail-il1-x142.google.com with SMTP id 18so2586119iln.9;
 Wed, 03 Jun 2020 07:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8ERd7pPWfhRkjffTKffryj1PaQqKf6favNu1AKnJBBY=;
 b=WPO9qid2wK/IbyEAGgx2GT5Kw6bx/2OkkBUH3Oih484IeirKH6zIHYEEHOEEP2sZvj
 6jzXC52VqxhiycW5/1W+rN2A8e0ijmXoIYs3dXtiwCnE+m0iS1zY+cUPGEAqJ6kDOB6Q
 6MBLCgiUu9z4Ux/WnH8Pz5RAmZ7Ap86ONMAR5D/trJIRSWuga1iTt4tSVsdclT21lwcp
 lYbGed5j6gL5GEFi5z2/rhnM26O3j0OlicpkwLqKdiJCp+u15xc9jtckd6sdw+g2BlOb
 7Ye5W7+TZCNSLi1cIsf6Elj0sQe5p71xcJHqT5JEiVlWsMaoFe1/KbWyuWgpMfVYOTJs
 1dRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8ERd7pPWfhRkjffTKffryj1PaQqKf6favNu1AKnJBBY=;
 b=ldPA/O2iF2SW/kqsGpXK0muH/SfiBdmUnQ8pOcx1/Y6/4V3HDM06YMmKfUr4XlfPAT
 eXGbeHWQ3UB7wrEVCoGJn2Iuq8OJTQd7fxoAgq8cYzG/q5a/09ZO3FqoNwfBDgKqmWCI
 KK2JlJH+iKftpzCkYh9wVO1ANXcyRma26eGuq7GaNb/Qz2P9JJwSG972Xb7itYR8ax5t
 cFWYHIWKsP7Ws8yQNu7ikcg5aBd9K83I3TejpSOjImy2Ok8Ix96k0AMwYyZNR9UIH0DC
 2EbQNzwXrrdeJhny7Mi2Q72LL+nSiBcqIiocLnJmwhuWj86PVEGcWfIkTUIGwuxb71Xl
 JM4g==
X-Gm-Message-State: AOAM531jBPGFP0IXS1RVz+u46m59Zq7V4aE+5HK1gswu2Cf+Hj3QK6uK
 IR66X4w5THcdWDzmwjmKERI=
X-Google-Smtp-Source: ABdhPJwsFDDhsB3kCmAQWrUMOYi2iDtFn2LFlJY7+FUUQSM4Yjolj3FudkorwzCEVGnrZnTASIdlQQ==
X-Received: by 2002:a92:de41:: with SMTP id e1mr3879238ilr.199.1591193362572; 
 Wed, 03 Jun 2020 07:09:22 -0700 (PDT)
Received: from titan.knownspace (173-19-125-130.client.mchsi.com.
 [173.19.125.130])
 by smtp.gmail.com with ESMTPSA id g21sm1026714ioc.14.2020.06.03.07.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 07:09:22 -0700 (PDT)
Date: Wed, 3 Jun 2020 09:09:21 -0500
From: Justin Hibbits <chmeeedalf@gmail.com>
To: Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] util/oslib-posix : qemu_init_exec_dir implementation
 for MacOS
Message-ID: <20200603090921.64351a28@titan.knownspace>
In-Reply-To: <76587685-fa03-6dd6-5ca3-caeaf3c7504b@redhat.com>
References: <CA+XhMqwH6btbKFD0Ei47e+QHN2eBPG5H2PTS92MAje2Tij4Y=A@mail.gmail.com>
 <76587685-fa03-6dd6-5ca3-caeaf3c7504b@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; powerpc64-portbld-freebsd13.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=chmeeedalf@gmail.com; helo=mail-il1-x142.google.com
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
Cc: qemu-trivial@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 qemu-devel@nongnu.org, John Arbuckle <programmingkidx@gmail.com>,
 David CARLIER <devnexen@gmail.com>, Izik Eidus <izik@veertu.com>,
 pbonzini@redhat.com, Mikhail Gusarov <dottedmag@dottedmag.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 08:08:42 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Cc'ing more developers.
>=20
> On 5/26/20 10:40 PM, David CARLIER wrote:
> > From b24a6702beb2a4e2a9c1c03b69c6d1dd07d4cf08 Mon Sep 17 00:00:00
> > 2001 From: David Carlier <devnexen@gmail.com>
> > Date: Tue, 26 May 2020 21:35:27 +0100
> > Subject: [PATCH] util/oslib: current process full path resolution
> > on MacOS
> >=20
> > Using existing libproc to fill the path.
> >=20
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  util/oslib-posix.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >=20
> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > index 062236a1ab..96f0405ee6 100644
> > --- a/util/oslib-posix.c
> > +++ b/util/oslib-posix.c
> > @@ -55,6 +55,10 @@
> >  #include <sys/sysctl.h>
> >  #endif
> >=20
> > +#ifdef __APPLE__
> > +#include <libproc.h>
> > +#endif
> > +
> >  #include "qemu/mmap-alloc.h"
> >=20
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
> >      /* If we don't have any way of figuring out the actual
> > executable location then try argv[0].  */
> >  =20
>=20

Apologies, I don't have context for this.  Why was I CC'd on this?

Does proc_pidpath() not NUL-terminate its written string?  And, given
from my quick google search, it looks like this function is private and
subject to change, so can you guarantee that the returned length is the
*written* length, not the full string length?  If not, you could be
overwriting other arbitrary data.

- Justin

