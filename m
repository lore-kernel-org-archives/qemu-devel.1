Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34ADC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BEA20716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfOHmrY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BEA20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvLU-0000FI-6P
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihuzR-0002J9-Ui
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:33:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihuzQ-00013q-Gg
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:33:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41063
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihuzQ-00010w-9w
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3KOa2XTXVRlSAsERIWkgiX4MrdDD42cwBSnXuKHt5M8=;
 b=QfOHmrY8jCsIVDrrFIrtou2n7m7Vsg8278KLLnrMC8urPla3GnWL0EQWCxH7jskPRRqOr2
 4TSgfVvSX+35+I82FSw57EmYFtx1EiWjx9ftqj8Y3N0ghINl9DAjHuMVwyTYyrz76tUHC7
 5qMUtm2NqffVdEi5eVx2lElDiCQhkLw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-PFV1H6rdNIa4XjpaCUbj4w-1; Thu, 19 Dec 2019 07:33:10 -0500
Received: by mail-ed1-f70.google.com with SMTP id n12so3393275edq.13
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 04:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=upKWOzNNrEB3S0RtKLHv+faSq1Ux6fBUnfepTkmCF1s=;
 b=ZjAeg/d6e6JsXzlQg96i52YZrUOT58rLNWPl8vSyhBOUBklc/HKiNK82/umcgShLfH
 ffwFpstqaIulss9mIlytAJ2SNFbJ3lpf731ObmrmZrwHITscW/7+2eafOTMCO24lOVxl
 yk/PLb8WIw1/mZQwocap924GWXe3zxf3IyPVdQCvObhpFLcnLoNlHwjf/xmwAgryFmBw
 XSh5/WabQLNiSncjuV2WBQD6AXJmBbJDii4t0ZH49S+nNGcPgBTc1U0mnZ38iMyWlkKJ
 2p6O/mewRnVnZ/khDepW8b56Gl5wP/xDmAGWgROpdPaFxQQiC6nnDdHTLjv4r7f917BV
 wcrQ==
X-Gm-Message-State: APjAAAVlR1TCeVyN42qvrnyVOlItgEosx44nCyFITTc9qMbccNsSD7lX
 PWaT10K94n+lFqTuHirJuWMYD+8nDhFLg0yWRivI6QAny2PNM/Vw/1TmDwxgRuUyJ+3EiQH1Tm2
 yEPGelkPIhzjnbWd/0nENVs9AnUgHwGs=
X-Received: by 2002:a50:ed18:: with SMTP id j24mr8658400eds.124.1576758789194; 
 Thu, 19 Dec 2019 04:33:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqwnUUR6BRHuEBwfWEEJxlxPf2xKwJN9jreNSZRzyFB+PCVPGYL76qO7xChWsN5LOs+gVLXBfhFeeRB+bLT6kwg=
X-Received: by 2002:a50:ed18:: with SMTP id j24mr8658386eds.124.1576758789031; 
 Thu, 19 Dec 2019 04:33:09 -0800 (PST)
MIME-Version: 1.0
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
 <87pngku68f.fsf@dusky.pond.sub.org>
In-Reply-To: <87pngku68f.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 19 Dec 2019 13:32:58 +0100
Message-ID: <CABgObfbAFJxW+OWGMbaFH+_q7H5RjF9=D6KqwWPXfpzt6Mocug@mail.gmail.com>
Subject: Re: [RFC PATCH v3 000/132] Proof of concept for Meson integration
To: Markus Armbruster <armbru@redhat.com>
X-MC-Unique: PFV1H6rdNIa4XjpaCUbj4w-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative; boundary="000000000000845a2f059a0dc39f"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "Maydell, Peter" <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000845a2f059a0dc39f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 8:25 AM Markus Armbruster <armbru@redhat.com> wrote=
:

> I (mercifully?) haven't received PATCH 094-132, and the list archive
> doesn't have them, either.
>

Sent now, hopefully with correct threading.

FWIW, the interesting patches are:
- 1-6, integrating meson in the build system (but similar to previous RFCs)
- 9-10, converting QAPI and tracing (also similar to previous RFC)
- 20, converting qemu-ga
- 30, converting hxtool files
- 33, a hack for the current build system, and 34 for an example of using i=
t
- 38, 40 and 112, the remaining big part of the build rules
- 47 and 48 as they use modules (but note that I have ideas on making
modules nicer)
- 116-118, building docs
- 115 and 132 if you like negative diffstats :) (as mentioned in the cover
letter,
the biggest negative diffstat will come from converting tests though).

Everything else is just moving lists of files from Makefiles to meson.build
files.

Paolo

--000000000000845a2f059a0dc39f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace,monospace;font-size:x-small"><br></div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 19, 2=
019 at 8:25 AM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">a=
rmbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">I (mercifully?) haven&#39;t received PATCH 094-132, and the=
 list archive<br>
doesn&#39;t have them, either.<br></blockquote><div><br></div><div style=3D=
"font-family:monospace,monospace;font-size:x-small" class=3D"gmail_default"=
>Sent now, hopefully with correct threading.</div><div style=3D"font-family=
:monospace,monospace;font-size:x-small" class=3D"gmail_default"><br></div><=
div style=3D"font-family:monospace,monospace;font-size:x-small" class=3D"gm=
ail_default">FWIW, the interesting patches are:</div><div style=3D"font-fam=
ily:monospace,monospace;font-size:x-small" class=3D"gmail_default">- 1-6, i=
ntegrating meson in the build system (but similar to previous RFCs)<br></di=
v><div style=3D"font-family:monospace,monospace;font-size:x-small" class=3D=
"gmail_default">- 9-10, converting QAPI and tracing (also similar to previo=
us RFC)<br></div><div style=3D"font-family:monospace,monospace;font-size:x-=
small" class=3D"gmail_default">- 20, converting qemu-ga<br></div><div style=
=3D"font-family:monospace,monospace;font-size:x-small" class=3D"gmail_defau=
lt">- 30, converting hxtool files</div><div style=3D"font-family:monospace,=
monospace;font-size:x-small" class=3D"gmail_default">- 33, a hack for the c=
urrent build system, and 34 for an example of using it</div><div style=3D"f=
ont-family:monospace,monospace;font-size:x-small" class=3D"gmail_default">-=
 38, 40 and 112, the remaining big part of the build rules<br></div><div st=
yle=3D"font-family:monospace,monospace;font-size:x-small" class=3D"gmail_de=
fault">- 47 and 48 as they use modules (but note that I have ideas on makin=
g modules nicer)<br></div><div style=3D"font-family:monospace,monospace;fon=
t-size:x-small" class=3D"gmail_default">- 116-118, building docs<br></div><=
div style=3D"font-family:monospace,monospace;font-size:x-small" class=3D"gm=
ail_default">- 115 and 132 if you like negative diffstats :) (as mentioned =
in the cover letter,</div><div style=3D"font-family:monospace,monospace;fon=
t-size:x-small" class=3D"gmail_default">the biggest negative diffstat will =
come from converting tests though).<br></div><div style=3D"font-family:mono=
space,monospace;font-size:x-small" class=3D"gmail_default"><br></div><div s=
tyle=3D"font-family:monospace,monospace;font-size:x-small" class=3D"gmail_d=
efault">Everything else is just moving lists of files from Makefiles to mes=
on.build files.</div><div style=3D"font-family:monospace,monospace;font-siz=
e:x-small" class=3D"gmail_default"><br></div><div style=3D"font-family:mono=
space,monospace;font-size:x-small" class=3D"gmail_default">Paolo</div></div=
></div>

--000000000000845a2f059a0dc39f--


