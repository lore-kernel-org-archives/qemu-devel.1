Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA37C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 414DD2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsvcedL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414DD2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUAS-0005o1-Hy
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jdU9q-0005D4-SV
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:37:54 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:38642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jdU9q-0007Pk-0q
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:37:54 -0400
Received: by mail-ej1-x644.google.com with SMTP id h21so22723049ejq.5
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 00:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xdS6nv3wN708Hq128T5oJd0bx1AhmeLiwG3F158YPFo=;
 b=lsvcedL8gKFiXugSi2+w9JDM9kDmIS2LHMs4wOXAdUU47LaI20KZ7SBb8aDYVK63MS
 1bWgmL9ijOG7N6V55nghes1sA5lu99pZSopJfEW28SDfls0+j/Qeix0IX8a4PocfjwNU
 gipXZOVYXw1p6PYpAzp0Ki9S+4itSG+qMRc8THokcoRATg2irzau2a6jYYABSNVzrMp9
 Zr+Jn6FtCrvU8GGaZuEcW2+XLUYdHyAsa6+LXdCOjQO769uJ4uxiSkHxktagb0vXe2RL
 vGFD1cnln/Vvxpvlv7WAWe+gq1yXWmfh/QAFoz9hITxoqoNa4W2kxWcIooLJZq7qlgHa
 mQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xdS6nv3wN708Hq128T5oJd0bx1AhmeLiwG3F158YPFo=;
 b=olgB4a4NYYkqYbuVeUYFizQTdQu/w4EkkJrljTWxRz1FzvRHc/kgRYMMWv0KFMK77b
 HzGxsEzoJObJFSoCefR5wQBY7BN8sumFodsZHmNvx8nS7ZKKj8aRmQ1cleAsFuWJlki6
 d1rI9U7bcRm5/Mjq4nPOac9qXNDZrb+74ceEDo83V3N1DEDirgREME36i2DOqF/+N+7f
 a0MhwsXSuVujoZpAdnQ0dXGUkkwyDy7pC9uD8Afx60/9V3C4lDQfU+mHJygdlbZMZ2k/
 zwpITDlmdpXh0apA68nwxBFEcuffJz5AWSi8Vn8BwKcIcXZ80a0UDm1DO44fv19RLDGr
 4TLA==
X-Gm-Message-State: AOAM532fhffDnnEKYcxMyGe0JGMKK6qwe65sni5fAngrhvW3kdQ5rpDN
 PbKsjbpcatjNbKrM7O4aqVxS2q9rZBF+tw8yXsg=
X-Google-Smtp-Source: ABdhPJy0Clq1FA50emy0mDBP0P9Fno6z35B7sacQuMst7o9ktroOqWJRCGWoNOh8TDQHj9i8r970s9xXGXypJ0n8g9s=
X-Received: by 2002:a17:906:474f:: with SMTP id j15mr25771ejs.58.1590478672250; 
 Tue, 26 May 2020 00:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqyZ9yZjckTcYinCOYqb4ybE6z9vmgcJzue1WEGuZ0NTWA@mail.gmail.com>
 <4e0f6d35-8aa0-b81d-0902-00b76f44b571@redhat.com>
In-Reply-To: <4e0f6d35-8aa0-b81d-0902-00b76f44b571@redhat.com>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 26 May 2020 08:37:41 +0100
Message-ID: <CA+XhMqx-Oz_OzyjEaRn0q6s8PiRvuTBQO=JF3WA_UP+0N-FW+Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] util/getauxval: Porting to FreeBSD getauxval feature
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 316cbdea0434a523c78d3f18fe7e6697577e4aae Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Tue, 26 May 2020 08:33:12 +0100
Subject: [PATCH] util/getauxval: Porting to FreeBSD the getauxval feature

FreeBSD has a similar API for auxiliary vector.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 configure        | 5 +++++
 util/getauxval.c | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/configure b/configure
index 2fc05c4465..2c93867080 100755
--- a/configure
+++ b/configure
@@ -5824,7 +5824,12 @@ getauxval=no
 cat > $TMPC << EOF
 #include <sys/auxv.h>
 int main(void) {
+#if defined(__FreeBSD__)
+  unsigned long a = 0;
+  return elf_aux_info(AT_HWCAP, &a, sizeof(a)) == 0;
+#else
   return getauxval(AT_HWCAP) == 0;
+#endif
 }
 EOF
 if compile_prog "" "" ; then
diff --git a/util/getauxval.c b/util/getauxval.c
index 36afdfb9e6..373ed3899f 100644
--- a/util/getauxval.c
+++ b/util/getauxval.c
@@ -33,7 +33,13 @@

 unsigned long qemu_getauxval(unsigned long key)
 {
+#if defined(__linux__)
     return getauxval(key);
+#elif defined(__FreeBSD__)
+    unsigned long aux = 0;
+    elf_aux_info(key, &aux, sizeof(aux));
+    return aux;
+#endif
 }
 #elif defined(__linux__)
 #include "elf.h"
-- 
2.27.0.rc0

On Tue, 26 May 2020 at 08:21, Thomas Huth <thuth@redhat.com> wrote:
>
> On 24/05/2020 14.09, David CARLIER wrote:
> > Hi here porting qemu_getauxval to FreeBSD. Thanks. Regards.
> >
> > From 5be5e56a59631b28ed7b738d251dda252ba9b03e Mon Sep 17 00:00:00 2001
> > From: David Carlier <devnexen@gmail.com>
> > Date: Sun, 24 May 2020 13:03:32 +0100
> > Subject: [PATCH] util/getauxval: FreeBSD has a similar auxilary vector API
> >
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  configure        | 6 ++++++
> >  util/getauxval.c | 6 ++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/configure b/configure
> > index 2fc05c4465..545fd2364f 100755
> > --- a/configure
> > +++ b/configure
> > @@ -5824,7 +5824,13 @@ getauxval=no
> >  cat > $TMPC << EOF
> >  #include <sys/auxv.h>
> >  int main(void) {
> > +#if defined(__linux__)
> >    return getauxval(AT_HWCAP) == 0;
> > +#elif defined(__FreeBSD__)
> > +  unsigned long a = 0;
> > +  return elf_aux_info(AT_HWCAP, &a, sizeof(a)) == 0;
> > +#endif
> > +  return 1;
> >  }
> >  EOF
> >  if compile_prog "" "" ; then
>
> That configure check looks wrong. On other systems (i.e. non-Linux and
> non-FreeBSD), this code snippet will now compile successfully and thus
> the configure script sets getauxval=yes. I'd suggest you change it this
> way instead:
>
>  int main(void) {
> +#if defined(__FreeBSD__)
> +  unsigned long a = 0;
> +  return elf_aux_info(AT_HWCAP, &a, sizeof(a)) == 0;
> +#else
>    return getauxval(AT_HWCAP) == 0;
> +#endif
>  }
>
> ... so that it still fails to compile by default on other systems.
>
>  Thomas
>

