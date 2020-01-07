Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F55C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90EB52073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYEFKJh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EB52073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iot40-0004iZ-E5
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 12:54:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iot2r-00033C-5i
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iot2p-0005aV-Ud
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:53:32 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:44153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iot2p-0005Zs-PK
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:53:31 -0500
Received: by mail-ot1-x335.google.com with SMTP id h9so764512otj.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 09:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yRBzQzbz+mb07/PAwmjxnccumlBqLY525MRl1LqBn9c=;
 b=NYEFKJh7tGt9au0QIF2XCM5ObpvozzJ+JZuhQlkTKVRREym5OT73Yyf8rYetqvQQp2
 yXp99GepW5kBtg5LNxTZpsYqrPyAHBAiGTVh2/FRpINCvvY1sdzk/H60muLFaoqSdjSa
 +lTnpCI0f2c8YiKlOYpiMiLiM7KALQ6z3M4dluPC5FQ05RlF/6RXKlHJe7+CdZm3bflX
 gTI/Op4T+X/e67xiF5swqjShZ52X4QL220nSzm0rEaUyqX98bu3Y0ONKLIqckhvV1s7/
 dUcDltqqM+PVumOtobU9kJBYVzw+o+ga5dIFUX5nZhrWaMidJ4vdXj+GiraHOCgFzSpN
 L+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yRBzQzbz+mb07/PAwmjxnccumlBqLY525MRl1LqBn9c=;
 b=miLalazsFIzdU6vFbPv0trfK47/Cwd0JvD5WuNH5QhM0OsGOyOQDIREBihPKa2Hhvr
 Jfd50y7Tmuu4jNWcAlXmh63eS0CRLXAPZ5fCkVMdTjGduLNQTBlcRUdf5VHDdLjOqTK+
 PWpNWdMUTkbMnU7B+M13Rc2wJJXBbKkZXcxA7Uk3MyeTe4Ai5hk4rQ7ZvlZfTLIYnhRE
 ZFZAI76Ut+Mq6WdM+BYvan74ua14VtdvLaqxyuKzPw0pONn6GHRcIN9hkuWk34HGfEUq
 IHSFtMm0StjvMWF5Z05ja68va7Rr542YtqLAtEXo7pU5ahXCnzq/8ABBV5HpS0dzHNwf
 Cm5A==
X-Gm-Message-State: APjAAAXDKE/djnef/PDkA7vXYWPsznxoBie3FJLTB5Yh+gOfM+yCEv5D
 TiYAEaJr2kGcn36P/JwsQVB1XGO81yWen8kY0tCoMA==
X-Google-Smtp-Source: APXvYqziN+ffHQWP7jFljzyRjUSeE/7ar4tI3qQRX5/2DSRFbPvI3smgfKr1O/S47asb/Xy14uLQjNAvFOywFn9tpSQ=
X-Received: by 2002:a9d:8cb:: with SMTP id 69mr916021otf.221.1578419610926;
 Tue, 07 Jan 2020 09:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <1A5859EA-4403-4921-B527-DFD07C59C702@redhat.com>
 <360fa010-ba80-b02b-3a35-19c2b48a462d@redhat.com>
 <5FB9F11E-77DC-4FD6-B780-AB508DD42B42@redhat.com>
In-Reply-To: <5FB9F11E-77DC-4FD6-B780-AB508DD42B42@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jan 2020 17:53:20 +0000
Message-ID: <CAFEAcA-ot4VTdC8X8cH2kfkieyu0OsW9F-X2SBQxtYtUBjWmKg@mail.gmail.com>
Subject: Re: Priority of -accel (was: [PATCH] tests/qemu-iotests: Update tests
 to recent desugarized -accel option)
To: Christophe de Dinechin <dinechin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel Berrange <berrange@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jan 2020 at 17:44, Christophe de Dinechin <dinechin@redhat.com> wrote:
> > On 7 Jan 2020, at 15:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > It would break backwards compatibility for "-machine accel=tcg:kvm",
> > which so far meant "use TCG if compiled in, otherwise use KVM".  This is
> > not something I would have a problem with... except that "tcg:kvm" is
> > the default if no -accel option is provided!
>
> What is the rationale for picking tcg over kvm?

Command line compatibility. QEMU existed before KVM support
was ever merged into it, and so the default has always been
"emulate the CPU". Defaulting to KVM would be a change of
behaviour for existing working command lines. The reason
for using "tcg:kvm" rather than just "tcg" may be that
this way a --disable-tcg QEMU does something useful, but that's
just a guess.

QEMU tends to prioritize "don't change behaviour for users"
to a degree that is arguably counterproductive. But it's a
nice easy rule to follow :-)

thanks
-- PMM

