Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2EDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 21:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26190206D5
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 21:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMGM7+Rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26190206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivSwX-0001HT-BX
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 16:26:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ivSvq-0000ir-PY
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 16:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ivSvo-0007Ju-5n
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 16:25:30 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:33178)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ivSvm-00078o-Jn
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 16:25:26 -0500
Received: by mail-oi1-x22a.google.com with SMTP id q81so3158239oig.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2020 13:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RuFWejYXotQsT+q7MCZaXsnBvXTwuhEZN0H3e8LZnAQ=;
 b=JMGM7+RbaKFjy/W4oKzaBlo9jYppfsXn1z8nz1VNgse3AoCo0JgHel18jN+jsQ6oKI
 HybaZlErCQ7PNbq4w8FM4XCUcTJ/w1Cgt9RChoyJ0P35gMmkJnPbITpYqJxwWC68VqVE
 5sH+fmDVVwLD3DX4nBOhuzz9cfISKRXQ0APZDlkwobgINtHQ66dJkLSk7xbfKfzlfp8w
 nFyCDq79DBgBsaTQ7iVNRNXF3+ZQRdkl32XuSsODhuS54xyykAIaLyUJzIXbnnTJVuG7
 5xzgdC0mWNzY7Nn+eSLqsvL8RYMwZyTFZECYhCYAspC8oAb//3LoaDvslkrGdMNAz/c5
 4nfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RuFWejYXotQsT+q7MCZaXsnBvXTwuhEZN0H3e8LZnAQ=;
 b=IjF+JLXt1TS+UAfKan4LJSOBuwKrM8clx3Yl5vHBdRFHog2WG+DVs40rc5nmQcRD7c
 wro2Ux1SDpe0swLB5940NP3HR645Xkz2ufNsRgz8KBXVhFUK/ALkD79AnwpqoVL/jIL3
 HCo076J9BA+jgYiOLK1JmFqPOpmBITRV/vCpmBs3BDNkcpIJxOhwZ+XdgqRI0ZPzR55S
 tqHlrZkt1ek0yNPwmrhx5/y1Ff9BV/sXdMjSVmrb8kVPAH49sqNChATKdPrdW9Qi/jtX
 5cFKJM395ikZNYTpXCreth1UcDqkmw2CsiwtDmNIh1meXlJpDY8HL+WNCzZCUhgwIvH7
 vWAA==
X-Gm-Message-State: APjAAAVxoLFDdWjMQEPaCr5NmrGK92JhQ65e4qRyUzAVwaa3GkCxv0Cg
 SO4PykDblJG0EqgHRHryeiC3RgQKr/14omV39xXStA==
X-Google-Smtp-Source: APXvYqwIelYSYsAmhd60SDcUwLcApPttORp50xpovsO/RJ9dMQn82MT+zmjht5F/Exg567GXpKHMFN6tJ+QmT7NBvbI=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr3395353oid.98.1579987524190;
 Sat, 25 Jan 2020 13:25:24 -0800 (PST)
MIME-Version: 1.0
References: <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org> <20200121143658.GB597037@redhat.com>
 <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
 <87y2tzzrwo.fsf@linaro.org> <87wo9ju19n.fsf@dusky.pond.sub.org>
 <CAJ+F1CLu6xNJ834qWpJ6Bx1PHhv5QutdK2-Nzp+J2q80YV5tzA@mail.gmail.com>
 <c68f8ffd-dc8a-f282-3195-aa9e8760de7a@redhat.com>
 <CAJ+F1CKukvqb+=q922Eh1HHHFe6nOkLsnCwWamc0303F14QFqQ@mail.gmail.com>
 <e2da6836-87f3-5d91-b969-198e00317a62@redhat.com>
In-Reply-To: <e2da6836-87f3-5d91-b969-198e00317a62@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Jan 2020 21:25:13 +0000
Message-ID: <CAFEAcA-Q=bMF77MLBZToAadQUBfmOysetNKreT8q6YQU8TOepA@mail.gmail.com>
Subject: Re: Integrating QOM into QAPI
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 25 Jan 2020 at 09:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 25/01/20 05:44, Marc-Andr=C3=A9 Lureau wrote:
> > I try to find a good reason qom was chosen over gobject, and I can't
> > find it.
>
> The main reasons were integration with QAPI, and the object tree.
> Though everything I say here is a kind of reverse engineering of
> Anthony's brain because there aren't really any design documents besides
> what's in include/qom/object.h (and he overlooked some aspects, for
> example "unparent" was introduced a few months later).

I vagely recall that back at that time we were a lot less heavy
in our usage of glib also, so "just use the glib version of whatever"
would not have been quite as easy a sell as it might be today.
Anthony's original RFC email lists some "key differences" between
QOM and GObject, which presumably seemed to him at the time
to be sufficient to justify not using GObject:
https://lists.gnu.org/archive/html/qemu-devel/2011-07/msg01673.html

thanks
-- PMM

