Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C69C4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52542145D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tj1RNUDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52542145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNF7d-0004f5-RZ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 08:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNEyk-0001hr-38
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:43:34 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:43740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNEye-0000sX-GX
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:43:33 -0400
Received: by mail-ej1-x641.google.com with SMTP id o8so14780828ejb.10
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 05:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jQwZitE3NWxYqsQw1EkR/CVEYZpFW7rfvBJ80+JOqFQ=;
 b=Tj1RNUDnEF2EAagtggnhGoF6B6wTf3mzN12D39Sbo/3PjtxLoMteYmSpsFWj9CpHnB
 v3IKVH2zQ/be7gAjsRcYfQjkvY1XES56DHpeVhcFcvR0g/J66WukL7gw0gHXE1+gNk1r
 VOnKaTj0yBcXxuVLqa4lMjOmg+yOBVxG4JYWawCjgpUBUilA23aMUfJJvamk/xLBfGT0
 Czi3xS976u8g1LWhLNQjIgfqv5MV3edMsgIs2jvCUthM97bgg3zCkBaLYM1+HqcVVY9T
 M+w/C4kx8kfi2G05aeGRV2MrblxdfP6hp1atvRObFJDhkUWGgoSntj2Hs2T1PdGjbK/+
 ps5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jQwZitE3NWxYqsQw1EkR/CVEYZpFW7rfvBJ80+JOqFQ=;
 b=F65OO/gvdai124jm/2qdNh98OTz6HC6E5X+klqCYVyUfZ3els/bnWC7C34eRDZ3FUV
 pcSmHKGl9A2c0YTrTbkm93SwYKdJjjNfde+d+5ayl/99Vmsvq71QYCUQaTUMCTofe6Y1
 O2FroLszM0Kepo84yzUpl6V9xoOZsx3YQQI3SERLp847eF6e+92521Fcps5Tu0G18AUA
 Rp+i9eexKfu3rGG2JYa88W5qhMGFTF2340cZx7uooqYcyZlIJ3cyllb7bvrblbIv1p0v
 XbE+XDqqQ2VzOUg2uU99Mfixk8lDEafIOA1qNXEeBk9coVWGws2jgF/gFxLVHNQZ3Rks
 OMKw==
X-Gm-Message-State: AOAM5315R0aw06oW41BBYIDok0FKfGlX0RVoh7G+6YKZd1KS2mbk0uCE
 uEkJ2FETMbkA0/ixnIqloMKPmqM9X1lMei4azqlxt+XeKN+EgQ==
X-Google-Smtp-Source: ABdhPJyNIy7W3fchnw2wbRUgdPxta9/pksGUmBtop9V2fOV42ap2lMvP1VcbhI0nkZ+Ma9XcHhjLoG90/6KmMWEQmlY=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr3540333ejb.85.1601383405251; 
 Tue, 29 Sep 2020 05:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-18-peter.maydell@linaro.org>
 <87wo0cu5es.fsf@dusky.pond.sub.org>
In-Reply-To: <87wo0cu5es.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 13:43:14 +0100
Message-ID: <CAFEAcA9024SOxuA-_=iUOtmtgZMxMQ8fvkuu8Wt9by83oJ0qsQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/21] docs/devel/qapi-code-gen.txt: Update to new rST
 backend conventions
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

On Tue, 29 Sep 2020 at 13:35, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Update the documentation of QAPI document comment syntax to match
> > the new rST backend requirements. The principal changes are:
> >  * whitespace is now significant,
>
> Well, differently significant :)  Anyway, close enough.
>
> >                                   and multiline definitions
> >    must have their second and subsequent lines indented to
> >    match the first line
> >  * general rST format markup is permitted, not just the small
> >    set of markup the old texinfo generator handled. For most
> >    things (notably bulleted and itemized lists) the old format
> >    is the same as rST was.
>
> "was the same as rST is"?

Yes :-)


> v5 had
>
>   @@ -899,6 +915,12 @@ commands and events), member (for structs and unions), branch (for
>    alternates), or value (for enums), and finally optional tagged
>    sections.
>
>   +Descriptions of arguments can span multiple lines; if they
>   +do then the second and subsequent lines must be indented
>   +to line up with the first character of the first line of the
>   +description. The parser will report a syntax error if there
>   +is insufficient indentation.
>   +
>    FIXME: the parser accepts these things in almost any order.
>    FIXME: union branches should be described, too.
>
> I questioned the value of the last sentence.  You dropped both.
> Intentional?

I moved the first sentence to patch 5 in v6 (ie to the patch
which updates parser.py to enforce those indentation restrictions),
so as to make patches 1..5 suitable for merging even if we needed
to respin the second half of the series.

> > @@ -937,6 +950,16 @@ multiline argument descriptions.
> >  A 'Since: x.y.z' tagged section lists the release that introduced the
> >  definition.
> >
> > +The text of a section can start on a new line, in
> > +which case it must not be indented at all.  It can also start
> > +on the same line as the 'Note:', 'Returns:', etc tag.  In this
> > +case if it spans multiple lines then second and subsequent
> > +lines must be indented to match the first.

I also moved this paragraph into patch 5 (where it appears just
above the "A 'Since:..." text you can see in the context here)
but forgot to delete the copy of it here, so at this point it is
duplicate text and should not be in this patch. Oops.

> > +
> > +An 'Example' or 'Examples' section is automatically rendered
> > +entirely as literal fixed-width text.  In other sections,
> > +the text is formatted, and rST markup can be used.

(This patch is the right place for this paragraph.)

thanks
-- PMM

