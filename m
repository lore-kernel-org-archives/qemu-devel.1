Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F448C10F13
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 02:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D864F213F2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 02:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4qQPz+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D864F213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33931 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDgPR-0003Bv-1w
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 22:22:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDgOa-0002qz-Tk
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDgOX-00059f-GM
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:21:55 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hDgOT-000562-L3
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:21:51 -0400
Received: by mail-oi1-x244.google.com with SMTP id i21so12218574oib.11
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 19:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=lzy1CCdZCja4m90v9OXoUDYkW5iqWI3vHaEjs2PpHls=;
	b=c4qQPz+JKsoeOLgM3AafrvyoOcS9/sDEb+BqcBdp/Y26l6RKNgGCzs+OrUVV58Hn9f
	flIYQflDyV8z52+ujjmyC22wWHJJ3D2HpyRCVKIkF5ZPW2EXn1owYgpeWwMbocvpsijl
	ZlHQobnS5s/Rq15JPgvL8omrtVjkiEmDDEdYJaJ5giUxEJ75suCuP+6hvSaSKn2DxmTT
	gPhokmEyJ3VyVkGJMhw0lUjZcL9JFVLG8O/HnfDWIA89P6Vl+8QVhWmGXh+cbq6KxYKE
	ustcLwVHl6e8PRY1OfcegBQQg52ke2qIGkaVQRzjV6uRF38/XxiHoMv+3zoXR5HUbuZW
	C8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=lzy1CCdZCja4m90v9OXoUDYkW5iqWI3vHaEjs2PpHls=;
	b=n0vweJS5L/Zj/Ch9CdMguAHdkgqX0Ux7VC8S8EbQ9D3+M1xq5dkf4ukhQRbi0pKOp8
	QWuknIjEeVG+FlgJh2jz/bVAd5Vw7RjmRXhcMHqb/yyhszXRgmWxE8xhqoJMgwikkT4m
	qdFkxCQu6RS5pWQHd44XZR9CsJGkMPZ1QBuAyHBdV0dkdCONEnCT5NA5n5myPJbH49FL
	5NYZ0f+oX7Jm0eVcXakUXNwO436I21jjBMrMiw67J5jIkGGGTzgGImTSKTEhtl+5oG1y
	vtZPKxezi1Dnpej8s+OomjPUp+loSbm5Sp6zYxPJzmS6t7ezh724d7disvlrRHeOcljv
	iqBg==
X-Gm-Message-State: APjAAAXw3A7WRoWS+C5qRaVHwppbHYFfyFHVEo2UMriVwY/xooGnFRSm
	fvfv9pJ4CFvh1TIQhsnU6S6N3Z/IeuSETzxL95A=
X-Google-Smtp-Source: APXvYqwjplsliTu4oNKttMloA4fKulkojhEMlsv4cfYh60v4q6f17oR2hxZy9sSWbAQBWSxsg4OzpXt5SJxbgNRN5Qg=
X-Received: by 2002:aca:3f84:: with SMTP id
	m126mr17039876oia.164.1554776507986; 
	Mon, 08 Apr 2019 19:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <1554689945-18619-1-git-send-email-catherine.hecx@gmail.com>
	<20190408123542.1a4de426@redhat.com>
In-Reply-To: <20190408123542.1a4de426@redhat.com>
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Tue, 9 Apr 2019 10:21:36 +0800
Message-ID:
 <CAEn6zmGHg_Tb1jsvurfrovQNB0R5WZT3mLT7r8R+BEt_4bPbhA@mail.gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] hostmem-file: warn when
 memory-backend-file, share=on and in incoming migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409022136.rBsCxHa3rkjR0nFJKucGpO7NSVJ5yoR2yWKnN2TP2lU@z>

Hi Igor


On Mon, 8 Apr 2019 at 18:35, Igor Mammedov <imammedo@redhat.com> wrote:

> On Sun,  7 Apr 2019 22:19:05 -0400
> Catherine Ho <catherine.hecx@gmail.com> wrote:
>
> > Currently it is not forbidden to use "-object
> memory-backend-file,share=on"
> > and together with "-incoming". But after incoming migration is finished,
> > the memory-backend-file will be definitely written if share=on. So the
> > memory-backend-file can only be used once, but failed in the 2nd time
> > incoming.
> >
> > Thus it gives a warning and the users can run the qemu if they really
> > want to do it.
>
> Shouldn't we add a migration blocker in such a case instead of warning
> and letting qemu run wild?
>

IMO, it doesn't need to block this. With share=on and -incoming, the user
can
still save the device memory state into memory-backend file again if
ignore-shared
capability is on.

If we block this, the user can't use the ignore-shared capability in
incoming
migration.

B.R.
Catherine

>
>
> > Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
> > ---
> >  backends/hostmem-file.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> > index 37ac6445d2..59429ee0b4 100644
> > --- a/backends/hostmem-file.c
> > +++ b/backends/hostmem-file.c
> > @@ -16,6 +16,7 @@
> >  #include "sysemu/hostmem.h"
> >  #include "sysemu/sysemu.h"
> >  #include "qom/object_interfaces.h"
> > +#include "migration/migration.h"
> >
> >  /* hostmem-file.c */
> >  /**
> > @@ -79,6 +80,16 @@ file_backend_memory_alloc(HostMemoryBackend *backend,
> Error **errp)
> >          }
> >      }
> >
> > +    /*
> > +     * In ignore shared case, if share=on for host memory backend file,
> > +     * the ram might be written after incoming process is finished. Thus
> > +     * the memory backend can't be reused for 2nd/3rd... incoming
> > +     */
> > +    if (backend->share && migrate_ignore_shared()
> > +                       && runstate_check(RUN_STATE_INMIGRATE))
> > +        warn_report("share=on for memory backend file might be "
> > +                        "conflicted with incoming in ignore shared
> case");
> > +
> >      backend->force_prealloc = mem_prealloc;
> >      name = host_memory_backend_get_name(backend);
> >      memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
>
>
