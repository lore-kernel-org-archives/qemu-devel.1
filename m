Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E497FC47423
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5263420BED
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ew6xGuZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5263420BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNBvb-00085c-DO
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNBua-0007ZE-Ux
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:27:04 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:46448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNBuZ-0004Xq-1V
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:27:04 -0400
Received: by mail-ej1-x641.google.com with SMTP id z23so13930646ejr.13
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 02:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XattBnYa9G6YTb8cakK0m1pA3S126ENIJkxRQUekSso=;
 b=Ew6xGuZVxGQoecSkrmO6bkpkkNWvDy9gH4lGGUmr2qOWiK7v4MX+WIKW8twmnjhwpv
 Yyr5L9k9cuxUNbzMXN23Cv2DFzu0XoWfzssoLrXGueyJImh8F/IJABbi/Ch0HZ8jwJUO
 vsJ5oqP2qoo6EISPCr4Kuliy6pUMhg/FHS+fVEy68V9l8zZh/GeUJTq3d44tYcVSlbAT
 DTbczpdegEOM2l9xroDtBwXOO8GcLeYVjS+4z5uqBzfS074x7AwFC2D14yNBNOtXfygx
 w7ZyK4SbfB9GNN98allbBzvAJRi4zus9cqYgXwH0qUGZk8gwBpZox1jnxJdWnXGSIHGo
 leoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XattBnYa9G6YTb8cakK0m1pA3S126ENIJkxRQUekSso=;
 b=Kn7eIw+GZoTJy229nkwR15OXwbirr2jr8jW+blVMGYK3QJQRW/l6XeKqmm7v5QyKns
 2PwEhRJzvC4fb7HU97PO/tLh5Pk7lHEeZhIVpsh4eATHpy8cjFD9RkkDUU2TCEufqAP0
 9/X30QsERIQCVLxkai8elqjPedpV4QSgn7hsJ2Tul8Hm3oA5QdgNYgXWVRMEgno6VlAQ
 YFYAyvjX0LNcZp1b5hKBZsLqrDt170MXTZ0h87Ah+J1X1Lw6bRR00o8zcevRJD2hXdvq
 IHQu0u2JyUd1j1LUYFvcnEW9JoyuKejUzuUg+mwcBuBGzFFfbFWnxIaItdw7v2mjSCVi
 VNAQ==
X-Gm-Message-State: AOAM531T+vkaL5lPXuLzCj5pktIsBdM88MjU+CB+gn8KvLTsn402o8Qe
 md5vJEBJYzUrXff8LGzGc4peyxJDDpPDmZSSc94xFw==
X-Google-Smtp-Source: ABdhPJwZf+/dLqp6fZOjxWthVTyUJPrzNBCw6Q6YGveh0wrsxilAkVYPq0rY1a/XuDPVui64+kVTCizPlBofkV3NBtY=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr3051168ejv.56.1601371621139; 
 Tue, 29 Sep 2020 02:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-9-peter.maydell@linaro.org>
 <87tuvh0zaf.fsf@dusky.pond.sub.org>
In-Reply-To: <87tuvh0zaf.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 10:26:50 +0100
Message-ID: <CAFEAcA90L2YEOU70S_B-o+ZQNz+NJKtRd4UU48RBcqe=Z=eSAw@mail.gmail.com>
Subject: Re: [PATCH v6 08/21] docs/interop: Convert qemu-ga-ref to rST
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Sep 2020 at 09:20, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Convert qemu-ga-ref to rST format. This includes dropping
> > the plain-text, pdf and info format outputs for this document;
> > as with all our other Sphinx-based documentation, we provide
> > HTML and manpage only.
> >

> > --- a/docs/interop/conf.py
> > +++ b/docs/interop/conf.py
> > @@ -19,4 +19,6 @@ html_theme_options['description'] = u'System Emulation Management and Interopera
> >  man_pages = [
> >      ('qemu-ga', 'qemu-ga', u'QEMU Guest Agent',
> >       ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8),
> > +    ('qemu-ga-ref', 'qemu-ga-ref', u'QEMU Guest Agent Protocol Reference',
> > +     [], 7),
> >  ]
>
> Why do you make the description a unicode legacy literal?  I see it
> matches existing entries.  I'd like to know regardless :)

I was probably just copying some other example of how to
write the man_pages[] definition. This also all used to have
to work with Python 2.7, which might or might not be relevant here.

> > -@titlepage
> > -@title Guest Agent Protocol Reference Manual
> > -@subtitle QEMU version @value{VERSION}
>
> There is no obvious equivalent to @value{VERSION} in
> docs/interop/qemu-ga-ref.rst.
>
> The manual page generated from it has the version in the footer.  Good.
>
> I can't find it in the generated HTML.  Not so good, but it wasn't there
> before the patch, either.
>
> The generated PDF had it on the title page.
>
> Suggest to add a TODO comment like the one about the licensing
> information.

So the version is in the manual page, as it was before the conversion,
and it's not in the HTML version, which it wasn't before the
conversion. That doesn't sound to me like there's anything here
to do... You can add a TODO if you want one, of course.

thanks
-- PMM

