Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5C5FC6194
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F8F21D7F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryBkmpy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F8F21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2cU-0004lL-61
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iT2bk-0004Gs-HL
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iT2bj-0007TH-Bo
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:39:16 -0500
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:36418)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iT2bj-0007Sv-8B
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:39:15 -0500
Received: by mail-qv1-xf42.google.com with SMTP id f12so2063659qvu.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 03:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3/u9uKFOo6nKSeTC0Qc8SlldVIziaDkN1sEcEVyf2rw=;
 b=ryBkmpy6kg8FsdWhQscKFhX7aOyFilL1Ngn+B/r/ieib3jkV3GtIBZddR5aw8Gag0p
 GlC6YrGamONyMpv8HmVqfla/SA7OOL5DeqxiVIVBd1yxdBoEtFkRzjof0j2Os8wP/hEq
 HnJtx+UxwSnyxHSaRHZd3+EhcLbDVrzTGqIAQ6iULdVVpZ6q2thbq4GV+k5QCyXSD8oW
 491ytJbn4HNqG97wiqnAxQgY/CTQ47YX6Dg5mS3fb35Kzfv9N80DdoBg4bMSw9cnbT0y
 3uUGp387+phFtMd2OfNstMMxozviv2NWz05MX/g6ktBjkuG1MXvKikLR0Kg9vxoMlt9b
 U/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3/u9uKFOo6nKSeTC0Qc8SlldVIziaDkN1sEcEVyf2rw=;
 b=Wem/3nV0jfKnoh9l/PQqioc601l9hmU+soPx+ODds6RutmCObxzMRCCsJS3YaWeT7K
 Q/lJaYJUrM5nJ5IhZ4/2pzbLPOURJk9GYcE9gmWeX1aoHHV2akDPYGaIoNT7y6qjk5jF
 ssiYfgbb5kvCut2D9Jd/vjsBQ+AFG3ymLu3eCzfeJsNtoYDwDFucQZVoGRqbi9S+JXXV
 dOErLgg0lFygp998k4rLL4rS6NmtIJDRHPo7Qs/kgSPMEFoCK+JcCBG5+8PpPxB0MYyi
 /9yRQY2yVJDAGuSOM8mTgT8HvQ5AbXzE/tBt2hFM5mOMD9Mzu7pW6C4C5gRS0Dcpus7w
 qnQg==
X-Gm-Message-State: APjAAAUdnRcu8Q3xF/KIDn0wycu6Uu1IlS1tRNQELK8VuPtkM3Qx5Oh3
 MVCNvQADDywEDL+dJWXA1JnTt/hzadK+yhFrvBY=
X-Google-Smtp-Source: APXvYqxcD0PkzErDLslrA/q1KkciWWpWiuJPrAN9szTQcb8nXkJ9kwV5BTbiuxSQWQu/A5tlRsHM4DoOJaAeOLyRg3w=
X-Received: by 2002:a0c:87b5:: with SMTP id 50mr8950415qvj.143.1573213154395; 
 Fri, 08 Nov 2019 03:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20191108095942.401225-1-stefanha@redhat.com>
 <20191108095942.401225-3-stefanha@redhat.com>
 <CAFEAcA8b_POWyCWERMaT2mKZxrYA+RDoaLCHtO=pS28f-SCZ3w@mail.gmail.com>
In-Reply-To: <CAFEAcA8b_POWyCWERMaT2mKZxrYA+RDoaLCHtO=pS28f-SCZ3w@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 8 Nov 2019 12:39:02 +0100
Message-ID: <CAJSP0QWoSNk7NmC+AjgWQenyKLw6H5wqHay8C-1evQ8QTrSJ6Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] docs: build a global index page
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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
Cc: Daniel Berrange <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 8, 2019 at 11:52 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> On Fri, 8 Nov 2019 at 09:59, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > Build docs/ in a single sphinx invocation instead of treating
> > docs/{devel,interop,specs} separately.  This allows us to build a global
> > index page that links to documentation across the different manuals.
> >
> > Some documentation is built outside of sphinx and is not formatted as
> > reStructuredText.  Link directly to the .html files for the time being.
> > If they are converted to .rst files in the future they can be included
> > more elegantly.
> >
> > Sphinx wants to build all .rst files and complains if they are not
> > listed in the table of contents.  We have not yet reviewed and
> > categorized some of our .rst files.  Hide these files so they are always
> > built (and syntax-checked from now on!) but not visible in the table of
> > contents.
>
> So the reason I went for the odd "run sphinx multiple times"
> approach was because we don't want to ship 'devel' to users,
> and as far as I could tell there was no way to have a
> single-invocation build of the docs not include it in
> eg the index/search (which would then be broken when
> we don't install devel/ as part of 'make install').
> Does this patchset result in a set of installed docs
> that don't have dangling references ?

You are right:
 * The hidden documents are included in the navigation bar (different
from the table of contents).
 * The search index (which install-doc omits!) includes content from
the hidden documents.

I have asked on #sphinx-doc.  Let's see if there is a solution.

It might be possible to hack docs/config.py to exclude devel/ when run
from make install-sphinxdocs
(https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-exclude_patterns).
This requires building the docs again at install time but the
advantage is we get a single searchable set of documentation.

Stefan

