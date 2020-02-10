Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6C6C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 10:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57BE20733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 10:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUCEFFyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57BE20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j16lF-0002G2-2e
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 05:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j16kW-0001ZA-Kd
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:57:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j16kV-0004Pq-Kh
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:57:08 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f]:42667)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j16kV-0004Og-Gt
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:57:07 -0500
Received: by mail-qt1-x82f.google.com with SMTP id r5so3417915qtt.9
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 02:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sCBoZrjsDxvcMLY8BrFG4JWo3Le+w9ZwgCCCPix0NKU=;
 b=ZUCEFFyv0CXz1cUNfGPCDVh4EnTY+tEjJpiGezbw2UlKJFbcvHU/NX6vK/ROwWKa/J
 +sIsR/dGdcQ1g5Jog02IHN24/NEmy2Xb+FgiP9cFYjTcTjqQfpW4uJHIQslSwQ5S6Rmh
 UxI6ZTv1M+H9DmqxbsTEjE0zKU9iUEdjpyFencCjUZ+GBVldvqzHCekFdtkZ5c53NF70
 1NzbOejWfSTuAdzJaAh1AMDdfnAefOvPm/H1GYQybYySZLnKawPho9mXzOEZC4kvxO0y
 JsmIOrvU9+9dIpxSeCuSJ+HzLF4d4h2kDSpABUatG0jPGQVyJVVojtZXacdE0ksoZDRM
 LIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sCBoZrjsDxvcMLY8BrFG4JWo3Le+w9ZwgCCCPix0NKU=;
 b=AoZoLovVe2uVAu8q1mm9e9ai/Qspz93VkXVrhZjYl7SRMeHsoxTIZryPJyfAXOo9yE
 0uyqdv1i00rVjQfj/fhwuMgS49u4s2zTSUvvPlDtaVEyUeQsZv7vu2dsf6uSsH6Fw3pY
 4YrkVBkc3bkklock6yj1eG7x6uyRCKdPy9Xjk6rhQ2DoweTuG2QFhZNsdBcLSALpbq10
 WJI6TBah06HX7TXEvTRZlW0UsdbcZMxdRMJY1hkZUiswNDCWqDEOVh5HOSZWBt1Wv5qU
 UJnrjqsQoBAnpS5Xcbi9+xvtZNuyYr3zyodp5HrnUYJ7aR7L19voaUT1X1O378VWM2rR
 1MMw==
X-Gm-Message-State: APjAAAUvqCFo1/Z2pdPyk5hpt6p2OzgLfCTrq6kcQqIOBlOO2hSOuus1
 UvWCP0iRFWvcKekQIKoA9MZZBuj/kI13KrHkgCY=
X-Google-Smtp-Source: APXvYqxGlOS0B98eOWNUhoEQpX8l8HCfm0+ESCcA2RW75XvU6jvAHvxo3BfjZhRZBQ7CmVkfsnGSTwBsGqFEnLx79+w=
X-Received: by 2002:ac8:6605:: with SMTP id c5mr8932460qtp.316.1581332226596; 
 Mon, 10 Feb 2020 02:57:06 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <875zgm2vqv.fsf@dusky.pond.sub.org>
In-Reply-To: <875zgm2vqv.fsf@dusky.pond.sub.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 10 Feb 2020 10:56:55 +0000
Message-ID: <CAJSP0QWCn_vv2Vs-UWc9nPHjdBQq9KMkiQ7D91+RwHM_okTzZw@mail.gmail.com>
Subject: Re: Summary of Re: Making QEMU easier for management tools and
 applications
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82f
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 4, 2020 at 3:54 PM Markus Armbruster <armbru@redhat.com> wrote:
> = Ways to provide machine-friendly initial configuration =
>
> Two ways to provide machine-friendly initial configuration on par with
> QMP have been proposed:
>
> 1. Extend QMP
>
>    Machines use the CLI only to configure a QMP socket.  The remainder
>    of the CLI becomes human-only, with much relaxed compatibility rules.
>
> 2. QAPIfy the CLI
>
>    Provide a machine-friendly CLI based on QAPI and JSON.  The current
>    CLI becomes human-only, with much relaxed compatibility rules.

Do we keep the existing CLI around in both cases?  I'm concerned that
we're still following the HMP/QMP approach, which has left QEMU with
the legacy HMP monitor that we still haven't removed.

I'm in favor of simplifying QEMU at the expense of an incompatible CLI
change in QEMU 6.0.

A project like this could prototype incompatible CLI changes in a
separate git tree.  If it achieves the desired unification (CLI, QMP,
configuration file) and simplification (less code, legacy removal)
then it can be merged for an upcoming QEMU major release.

Stefan

