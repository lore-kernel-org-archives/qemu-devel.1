Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DC3C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE802076A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="itmdwVtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE802076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNBb8-0000Ye-9Y
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNBZw-0008Il-DX
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:05:45 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:38740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNBZr-0001Z9-JJ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:05:42 -0400
Received: by mail-ej1-x644.google.com with SMTP id dd13so1172204ejb.5
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 02:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2AdiZrKpdZpwZHDa7XB73w669O5RGRFo5RlxL1ynl28=;
 b=itmdwVtFtqGGcbzI9/uWd2xx2Hy8xMvPm5cI43lABjy/OCLjtnL3wt9dCrDXnwydsG
 B/MSE0IrPoMtCVmEcu+UawJMqSYZvo6uchYHa7BbCksLBOOmKU2Rc49qTOYgBDuaFqFe
 cI243WAJUZktO/0ydoge5O+NKhitAFocQ88XY263671Eff5Ms+yMwt8pOfK/QHETknOW
 vBGzJnTCwNDExj0DIk3GHFd4EWdzUT7zlXb943pi4Y1+r5rQ5uoZql0Qs+XcOSqKXcbJ
 PBxS+XH7HnkoLdygGCSBWH/AIGQQxkC4QmOEbwialSDmBXQR3FPyOhtJDP+gbmqFtykH
 bSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2AdiZrKpdZpwZHDa7XB73w669O5RGRFo5RlxL1ynl28=;
 b=RxCkMWmVYDzy+qXugA5KGLrcdKYgkvDFKNJr6abpOJZ0GOSBwQq2vx4yQLoZnlim9P
 wYVED93jWilDHHIv7ZC6WjDL8RpX6xEmYv3QSNlypjyM2otRyj0pZ+z1yFQHZoCrkEVR
 sX8x+S6kZfYHXq8jsfsqpcXLGMMTTlOLxnOD6lv6CIHG8kvWhFwrobDPXcjJNJiYrLkd
 4JMSHDqIZprCAOrsoYHH/YIX8rapi4yLxqaFFei6nxHtIq+sbekg/zXuzsaKXsxtkHup
 wZqSn3v7GIHM/wVOq6TWxkdLLZ0hMa1vPCvosfXazfbKr0koqe00QmIohKVuKvpFRNPO
 /nIg==
X-Gm-Message-State: AOAM531iPRiNbYW53Bv9fKXqGnNvMqZQzfq/xOBTztNSQGROSGo0cfAe
 ii65ximC7WE2qY5jOLFciMgTDYAsiPNYyGHHtzHKzA==
X-Google-Smtp-Source: ABdhPJykFMyqkck6XUzuW6+0+rYWSm9kCxzH2ImOwcB8GigKxDf9tMcr3l0z7tNSVvuXgtlkOA5+BTxY0vksoDpwAHo=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr2976358ejv.56.1601370337320; 
 Tue, 29 Sep 2020 02:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-8-peter.maydell@linaro.org>
 <874knh6pkj.fsf@dusky.pond.sub.org>
In-Reply-To: <874knh6pkj.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 10:05:26 +0100
Message-ID: <CAFEAcA_Cz-Y5XAj6mZq2hVecGWrga4R61CxA-jjaAFuACw8yZg@mail.gmail.com>
Subject: Re: [PATCH v6 07/21] docs/sphinx: Add new qapi-doc Sphinx extension
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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

On Tue, 29 Sep 2020 at 07:54, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Some of our documentation is auto-generated from documentation
> > comments in the JSON schema.
> >
> > For Sphinx, rather than creating a file to include, the most natural
> > way to handle this is to have a small custom Sphinx extension which
> > processes the JSON file and inserts documentation into the rST
> > file being processed.
> >
> > This is the same approach that kerneldoc and hxtool use.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Down to a few trivial things, which I can tidy up in my tree.

Thanks, that would be great.


> > +    def _serror(self, msg):
> > +        """Raise an exception giving a user-friendly syntax error message"""
> > +        file = self._cur_doc.info.fname
> > +        line = self._cur_doc.info.line
> > +        raise ExtensionError(
> > +            '%s line %d: syntax error: %s' % (file, line, msg))
>
> Unused, let's drop.

Oops, yes. I refactored the error-handling code below and forgot
to delete this now-unused method.

> > +    def visit_enum_type(self, name, info, ifcond, features, members, prefix):
> > +        doc = self._cur_doc
> > +        self._add_doc('Enum',
> > +                      self._nodes_for_enum_values(doc) +
> > +                      self._nodes_for_features(doc) +
> > +                      self._nodes_for_sections(doc) +
> > +                      self._nodes_for_if_section(ifcond))
>
> PEP 8: In Python code, it is permissible to break before or after a
> binary operator, as long as the convention is consistent locally.  For
> new code Knuth's style is suggested.
>
> Mind switching to Knuth style, i.e. break before the operator?

Fine with me, I have no strong Python style preferences.
I'm unlikely to be able to reliably follow any particular
style rules in future code I write unless there's a linter
that complains about violations, though...

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5eed1e692b4..dbddb0a7635 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3149,6 +3149,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
> >  S: Maintained
> >  F: docs/conf.py
> >  F: docs/*/conf.py
> > +F: docs/sphinx/
> >
> >  Miscellaneous
> >  -------------
>
> Maintainers of scripts/qapi/ should help review patches to
> docs/sphinx/qapidoc.py.  Two options:
>
> * Add docs/sphinx/qapidoc.py to section QAPI.  The QAPI maintainers
>   become M: of this small part of "Sphinx documentation configuration
>   and build machinery".  R: would be more accurate.  The inaccuracy
>   feels harmless.
>
> * Do nothing.  scripts/get_maintainer.pl won't loop in the QAPI
>   maintainers.  The Sphinx documentation maintainers may have to do that
>   manually.
>
> What do you think?

No strong preference. I guess putting qapidoc.py in the QAPI
section means that the right people get cc'd so that's the
better approach.

> My review is of uneven value: the QAPI-facing parts are good, the
> Sphinx-related parts merely look good to ignorant me.  I guess that's
> good enough, since we also have "generated docs look sane".
>
> Preferably tidied up a bit more:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

thanks
-- PMM

