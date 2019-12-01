Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8509C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 17:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0C82082E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 17:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="haU7X2tA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0C82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibSsW-0000Tw-Rt
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 12:19:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibSrt-0008OJ-1B
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 12:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibSrr-0001JA-RB
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 12:18:44 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibSrr-0001J1-LD
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 12:18:43 -0500
Received: by mail-oi1-x243.google.com with SMTP id 6so5074672oix.7
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 09:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LKU+Ph58svXNTOkz3yK11qj745RX1MWMMTANfHpRlVE=;
 b=haU7X2tAQU0JIZcJs7TSAY/bNnAeXxkIcxOuCtAq+tnNCZIaJJ5bOlLjJ1e7HkWSI+
 q3v9tCfzkaSovaOCuIOyg8AEpCadNV2TMZYwjDjSVfTLkMeRfClMAI7twSqY4CQCdZQ6
 T71FRVd5aYCLNtmnhbuno68n9KAlFAIbnbkFKEjG3aEDPtyLQxzIzTFN7So3dQ4Nliyz
 7QUt04+Hyy9GXtDYWCCnMGI3FLfwq6mXqxNZ5ANXyrHLWQ1RcM/GjKoESJlpcevOXlxd
 EcPH1s5wFzvpm2SawedcRkq6VGOsB0wT/mZfG6L2yhiji+qmrezAysfYiTeLPh5xgPqI
 4LBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LKU+Ph58svXNTOkz3yK11qj745RX1MWMMTANfHpRlVE=;
 b=ikSImn0/UADpM2L6La461n+TjdJCzAT8wnzlgD0+Cam4Np1WWsD6xSj3rJTj941aRB
 2K3C2chIc5fubivhs4Fp27MdEcX/NzJnqFtB+VR2LUNC3J+290+rIL0LNFlNBRUbFrKP
 YUVz3ErcQPpzznoFNWb8VzSBu7zQhrFm9ZBbxjItb7higgB7Qfy+iLnPfzC2TxOGMmQH
 rkNGRjADAWFQ4JlytItfD2dNaUblJmexM5d/6Ih0atY0135V7KKBdX2JWEX5vHj96QSw
 uiSUrDBvTyiV3eRHkgaJ9flkNPnAKyISCL1b2mFMqkggQOn9nAjWuaEwEjb0MUJOlNiU
 +yXQ==
X-Gm-Message-State: APjAAAVrc0SZWZF+ETWQRNYpilp6E+d3KKKdTRO2NAitpVt8IAqnUmM2
 AB7kZ0RdApxeU+jINpS5v/3z3XAJDxHJRMNW2+0yQA==
X-Google-Smtp-Source: APXvYqww4I5Oq+Rz1PNlLFSoa4c2h9PbycGitzpfhYMYNKDFvPQNuBoPVrHfNkBMdE1ljsC4VlzLE4cm4AUvDwtsMSk=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr9261896oih.98.1575220722115; 
 Sun, 01 Dec 2019 09:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <CAJ+F1CLV_JRhXX=tB7ZXYxa1En4LzYgJr+7egKzVRNBOLY2nSA@mail.gmail.com>
In-Reply-To: <CAJ+F1CLV_JRhXX=tB7ZXYxa1En4LzYgJr+7egKzVRNBOLY2nSA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Dec 2019 17:18:31 +0000
Message-ID: <CAFEAcA82wRy0U-DzPr64s5QiKo6XmZM96O88c4-AY4zP926GPw@mail.gmail.com>
Subject: Re: [PATCH v4 00/37] Clean-ups: qom-ify serial and remove
 QDEV_PROP_PTR
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 1 Dec 2019 at 10:19, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> - "serial: register vmsd with DeviceClass"
>
> This is standard qdev-ification, however it breaks backward migration,
> but that's just how qdev_set_legacy_instance_id() works.

I don't understand this part. Surely the whole point
of setting a legacy instance ID is exactly to preserve
migration compatibility? If it doesn't do that then what
does setting legacy ID value do?

thanks
-- PMM

