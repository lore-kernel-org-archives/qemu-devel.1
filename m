Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330E2ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 11:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02A74206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 11:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oaKg9YOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A74206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHRg3-0005yy-6P
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 07:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHRfA-0005Tg-JG
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 07:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHRf9-0005F5-6r
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 07:58:52 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHRf9-0005Dy-1S
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 07:58:51 -0400
Received: by mail-oi1-x243.google.com with SMTP id i185so11350646oif.9
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6ibJ6xIfITUijxdCpVyZ0aDEMsFBcRDEoFQpGw8p9rQ=;
 b=oaKg9YOOkWSE3yIyLyPdM87U557Lg12KKKra1a3oUJ/2Kx0ejWDor5DvWE4UeteGtA
 19FKFxQyyAmqyGmw8lG4ouUYQpWZ0jSshgduUdlbD9cJ+/wAr1zxeIR9k8wFXTOsSmf7
 3EVgkvaI87QI25Ei8LsJ5lHqs4CR7tZqWock5YxPMtzASWYIIZoD9arGSemD0vAYnhJ7
 Sj8Coxc14MVx4saStuRxvv4KQGDwH79JM/pTsd8M/5QjmdwXTNPU+um3A9YkF8DoRP+J
 iZevOPFWouiU7KL9vPi+/yML5Chv1i6lBAt8ZT5jPTF5uenvBwkonOHaJs9JtQSTJiND
 59SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6ibJ6xIfITUijxdCpVyZ0aDEMsFBcRDEoFQpGw8p9rQ=;
 b=QTaEGpHvYT44be4ltu0rzF46Sdlr33PIb2SuJDe9Fl59SResjhuD00pxlMfSlWFWoG
 bqEPk1XuVxMd5z1PgUydRW05WtVrv1yRioAyUiCZnrM/R2Vd1107eSsUIT2Rlq4n/D9m
 YJEC5wMncELyBXyXI3BfeGHwWJ6chti7df9JLBt7DcbZKN8O0jxRLU8WKb93chuAHSJR
 QxgKdakw1Oxp80F+7txBmubcmAdvCoFPlFpIVMlQ7QBI/MKCYXSzZYoAQysqPsK0hAEx
 diZEjAQyZc+i8rLN81XxU1TyVI3m08oYyPeC50wz7rXjmhA8rgBlJdUXCVI0RVCK2Iho
 owxg==
X-Gm-Message-State: APjAAAUhfhdCVSfy/7Nlg27rmYZoZ+bo50Q6vUU7Nikq5Yb4jLQaV2g+
 5KEAMsu13IGBccX03JQY6UVAjB3iRMFi3URDWunZfg==
X-Google-Smtp-Source: APXvYqxzs3HVNIEraywnuWCAmV+KgNGRdxtnjWirB1EvZPimKNo27haFNAT6757P6jYsrK62WVIQN0dJLZ8r9juKlV8=
X-Received: by 2002:aca:b646:: with SMTP id g67mr18188422oif.163.1570449529703; 
 Mon, 07 Oct 2019 04:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <874l13qmvb.fsf@dusky.pond.sub.org>
 <20191004130242.27267-1-g.lettieri@iet.unipi.it>
 <CAFEAcA8ut__ruS4yEMT7-qCKu+BFihFwhaNoq7L1cdoqxpXx6g@mail.gmail.com>
 <87pnj8ltih.fsf@dusky.pond.sub.org>
In-Reply-To: <87pnj8ltih.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Oct 2019 12:58:38 +0100
Message-ID: <CAFEAcA9KLDruPS6o85H5XJnQjoSXV2+-d=dnNGPvc80jiBthiQ@mail.gmail.com>
Subject: Re: [PATCH] netmap: support git-submodule build otption
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 7 Oct 2019 at 11:50, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Basically new submodules are a pain so we seek to minimize
> > the use of them.
>
> I suggested making it a submodule upthread[*].  Let me try to distill
> the conversation into a rationale.  Giuseppe, please correct mistakes.
>
> To make use of QEMU's netmap backend (CONFIG_NETMAP), you have to build
> and install netmap software from sources[**].  Which pretty much ensures
> developers compile with CONFIG_NETMAP off, and the code rots.
>
> For other dependencies that aren't readily available on common
> development hosts (slirp, capstone), we use submodules to avoid such
> rot.  If the system provides, we use that, and if it doesn't, we fall
> back to the submodule.  This has served us well.

I would put this differently. We don't use submodules to avoid
code-rot. We use submodules where a dependency is needed for us
to provide QEMU features that are sufficiently important that we
want to provide them to users even if those users don't have the
dependency available to them as a system library.

There are lots of features of QEMU that only compile with sufficiently
recent versions of dependencies, and we don't try to submodule-ize
them because the features aren't really that important for the bulk
of our users. For instance, we provided pixman as a submodule for
a while because the features that require it (our graphics layer
code) are important to almost all users. But we didn't provide
spice as a module even when you pretty much needed to be
running bleeding-edge redhat to satisfy the version dependency
we had, because most users don't care about spice support.
Shipping our dependencies as submodules imposes real costs
on the project (for instance we then need to track the upstream
to see when we should be updating, including checking whether
we need to update to fix security issues). Submodules should be
the exception, not the rule.

> For netmap, falling back to the submodule when the host doesn't provide
> tends not to be useful beyond compile-testing.  Because of that, we fall
> back only when the user explicitly asks for it by passing
> --enable-netmap=git to configure.  CI should do that.

This sounds like netmap is in the same position as most of our
dependencies: OK to compile if the system provides the library,
but if the system doesn't then almost all users won't care
that the feature isn't present. If CI of the QEMU code is useful,
get the library supported by and shipped in distros. If you can't
get anybody in a distro (Linux or BSD) to care enough to ship the
library, this is a really niche feature, and up for consideration
for deprecate-and-drop from QEMU, I think.

thanks
-- PMM

