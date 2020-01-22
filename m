Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA66C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E804E20704
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL6hvIhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E804E20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGB0-0003N9-Uq
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 08:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iuG80-0000UZ-7s
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iuG7y-0007L7-Vo
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:33:04 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:36750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iuG7x-0007K7-OF
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:33:02 -0500
Received: by mail-wr1-x42a.google.com with SMTP id z3so7312465wru.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 05:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jN2vido7RVcdsuXC6Q0jrNKP6lf2qgX3krbtnMY9Dac=;
 b=DL6hvIhQO75gVTasrgXfNpsaH9HVS91nsRkDUDDDJe8Cp6DIsYXVf3kaqn0LFEM64V
 BBavYfHaK2oez7Re0METXc+i9GbElijw+uJ0iohQftRG2EeymtNzn+42A6vEidX8G1f2
 MvNeGD0ZBXFtjKNSsfYkztFBoN4x7ewdkig3FWO2WGqKgmP3+TFI+3hpramNpyYQV0WX
 MIEJtLIBegHDNKU1hHLVFFnHTeyvgQi40QoGK3gl3VVn/hxJsn0v6xOfGSHnVJ1zZAW/
 b2SEa441fZ5JzO94VOBgsy9GtHinwwt14V9wOnDSvHM/9glgGLCnp7vwZKUCkfBE2gxd
 PGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jN2vido7RVcdsuXC6Q0jrNKP6lf2qgX3krbtnMY9Dac=;
 b=J9jwZpHkPBCC45cjSDcx+VmNrDhfub8ZJECl7mKyzzrCHJRy95Fb7nJfRZ7iv7Wndj
 MFHWAfkmS+eEQoJ9XHnNaPHjA5HRugUREaoDc4an1slIZkXKlidND/YIm9SQlZLKeyXv
 ZhNBAN58OMkCYKaygVMeWIG7UGlwaXt61n1jufHvLEqFGe14L1yxi47nZeZs6/cEV90Z
 MPojdJ6Pd+vOmUMW6TD6OZNjp2HSCCQPMVlrxhieRqcq1DkRdVBx0NGHV/XCFYCRdS0s
 KGUYv098uAN+GVGO6KdL65qBzOz7NRo9gKYya+qkcLAuxO2P3NtZM1AJ+JK96DVurAxK
 5/sg==
X-Gm-Message-State: APjAAAXB4JiW5ZTnYbzGoeqwRy1MuI1TevnuyLZieOSNei6ck2VqUpjC
 kg+B0Jx/5Lgf+TldUuTmBrUFsNlsVKtCzIpoD0opF6jt
X-Google-Smtp-Source: APXvYqxnQGtRnZB401gqA85CdaJCiXPIygvPLViufZg5hp5whafRAdR3R6GCM7epL3KNVEULU5/caGoPrXZf3jYV/ZY=
X-Received: by 2002:a5d:438c:: with SMTP id i12mr11142627wrq.196.1579699980059; 
 Wed, 22 Jan 2020 05:33:00 -0800 (PST)
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
 <CAFEAcA8az0CWubXqm5i+HhAukg1GYwaiazLw97d5tKGzjKjqwg@mail.gmail.com>
In-Reply-To: <CAFEAcA8az0CWubXqm5i+HhAukg1GYwaiazLw97d5tKGzjKjqwg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Jan 2020 17:32:47 +0400
Message-ID: <CAJ+F1C+kD0fUZDuU0uS-ri42NBXKoqOdg6CZr0czoXFE1aQLrQ@mail.gmail.com>
Subject: Re: Integrating QOM into QAPI
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
 John Snow <jsnow@redhat.com>, Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Jan 22, 2020 at 5:28 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Wed, 22 Jan 2020 at 12:42, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> > From the top of my mind, this is the pain point when trying to use GObj=
ect:
> > - static/inlined object, not supported by GObject, unlikely to ever be
> > - few users in qemu, transition possible.
>
> Isn't there lots of use of this in the device emulation, or am I
> misunderstanding what the restriction is?

There are a bunch, from what I remember. Yes, that's a bit painful,
but spatch managed to rewrite most of dev.subdev.foo to
dev.subdev->foo iirc.


--=20
Marc-Andr=C3=A9 Lureau

