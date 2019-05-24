Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7F1C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B98217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B98217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52627 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU8I3-0002lf-28
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 07:23:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hU8GV-0001iI-NE
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hU8Cl-0002xC-4V
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:17:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hU8Cl-0002g0-0A
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:17:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id w9so6726381oic.9
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 04:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=ZfrKi+gh4KhAaxlTA/u6KGhePydrU5EGwwCIlpf4nlk=;
	b=ksJBkzNux6HX02W45+apb07xHWYJ5RORvNiuUab6FAHzfXAoGaLrNmisQPnT5DYWpm
	cziymMXBxGU+HJny/yolMq4kNtub8FMT7gpw0Oafxeic7cdrWbA+ISD992jmKjjLzfAQ
	RPoVfTIU8VUzg5HUi6sIs075a+xlLnL+8rpZXfDxHP/vGJTYWA50KZsSP4IoWzHBxCxh
	OopKskfZxV74Omp1+3owPYc9n5CHPQGRJ7OcioIyisgl9x7cGf157yEujYGbMfKFnwt5
	Ya5P4nmQO6RwkLf4+OVcxUF8nzJlhvUlWvwRovEYqY/AsqYwcl5J+3tFUEmlEf/ZbCmv
	YACQ==
X-Gm-Message-State: APjAAAXFlThVOLJUyuIxH7pyRD2cscZb0aQiMnrABtvjQZir52eRXhRZ
	T3oYrtyd5MVnlGiHIrt53wDrvMtAWz5NtngqiXonLQ==
X-Google-Smtp-Source: APXvYqxXepPxwPVw4EqgBIqoFz/ne6LrZBlbv0V61oRfF9+gQ15E4h0aM4J2mw61r0IgrAhrjxCnF9a8J2X8nYrGi4k=
X-Received: by 2002:aca:ed57:: with SMTP id l84mr395934oih.13.1558696649188;
	Fri, 24 May 2019 04:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190523234011.583-1-marcandre.lureau@redhat.com>
	<20190523234011.583-4-marcandre.lureau@redhat.com>
	<e0cf3112-62f6-aaff-0821-f472297dbb93@redhat.com>
In-Reply-To: <e0cf3112-62f6-aaff-0821-f472297dbb93@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 24 May 2019 13:17:17 +0200
Message-ID: <CAMxuvay+ZrdjhJg-juU0aTOtcy=cLshC+WGyPBQ6VysXZksa5w@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
	=?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.167.196
Subject: Re: [Qemu-devel] [PATCH 3/4] docker: update fedora to f30
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
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, May 24, 2019 at 9:41 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 5/24/19 1:40 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Released last month.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/docker/dockerfiles/fedora.docker | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dock=
erfiles/fedora.docker
> > index 69d4a7f5d7..1496b68ba1 100644
> > --- a/tests/docker/dockerfiles/fedora.docker
> > +++ b/tests/docker/dockerfiles/fedora.docker
> > @@ -1,4 +1,4 @@
> > -FROM fedora:29
> > +FROM fedora:30
>
> Hmm this patch is pending for review:
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00819.html

Oh I missed that. Maybe we should use "latest" to avoid bumping the
version every 6 months.

fwiw we have different versions:

tests/docker/dockerfiles/fedora-cris-cross.docker:FROM fedora:latest
tests/docker/dockerfiles/fedora-i386-cross.docker:FROM fedora:29
tests/docker/dockerfiles/fedora.docker:FROM fedora:29

In 62559b916 "tests: update Fedora i386 cross image to Fedora 29", Daniel s=
aid:

    Using the "latest" tag is not a good idea because this changes what
    release it points to every 6 months. Together with caching of docker
    builds this can cause confusion where CI has cached & built with Fedora
    N, while a developer tries to reproduce a CI problem with Fedora N + 1,
    or vica-verca.

But at the same time, Daniel bumped f28 to f29 in commit 19a9978db1.

It's confusing, do we need some stability or follow the latest?

>
> >  ENV PACKAGES \
> >      bc \
> >      bison \
> >

