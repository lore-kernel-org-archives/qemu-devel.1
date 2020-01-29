Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E16C35240
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 13:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3935207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 13:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFWc1DN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3935207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwnYo-0006I8-NF
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 08:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwnY7-0005s7-7Y
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwnY6-0007sG-9o
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:38:31 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45545)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iwnY5-0007pb-3n
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:38:30 -0500
Received: by mail-ot1-x344.google.com with SMTP id 59so15504110otp.12
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 05:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lLbbPm0WPAc9yF1jLa0/NxLnyXRP5r9IjG0bl4y2fQw=;
 b=FFWc1DN6nLUoDixkH2Kqu5Ey/Ym72UlNpgaaDOvCDZirKjM/HofOaEQubjZQsxnehu
 9MXginxwMAyBghq1xaeKZO13Lf0GO/2b4yg55wdfWuIGASkskyxFGpz5tL5STGgDSvnT
 pnjrjVxE4TKtET2LcRScCsj7WjmUC1z1YFOLyt0bGecw0IJrV6BrLWB2DlTo5C+jiS7s
 kl3ivjGHIhoSbcsZtFZYKm05UVsWG2iboQ6ElrYd0dWd0z4MQC7cZYQMRrMmIY9MBiml
 WPK2QQoTFEPtJzU0Bdy7G3A/Ef3enETSTSDQKbRJmQULcpsdJGqBjoLe/GWrFSW400v5
 d93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lLbbPm0WPAc9yF1jLa0/NxLnyXRP5r9IjG0bl4y2fQw=;
 b=dAFJW6XN3YYmZ3PItC/z1dj/eupW9cHohTKIFon1hWTcgdVpvV2fCpnhh+PpXeQKXg
 wdb7BoW06zTBVFi0moN5n58mGw+pquHeuo2jWdsdyesWlK5HAVOKvR1TsJD9skNw/LJI
 EDoCI7QZH2Elwjrf+TZ658Uwor9mjfCuWFZ1sKNG97rxZD7zTbPxGypol6ZpPl9414X4
 iI8g4VX3hOcBfPMkmgRd+r/boeabRuJeoDw4UlPceKAJc33RJY92VnftrlLVqerO3cFU
 Ryx5WTSMMe4NL9PhH6ZBKFiBZ4RV8Vp2Rt6zVPaXRJ0qimUaL1GSH8EOV+EATmGQSQUa
 hiEw==
X-Gm-Message-State: APjAAAUJM0DyLJZylVNQzN9mVA76M0As4qr4kODMf2j/YGi1VTcPF/PY
 Zq53A1Qin25ewHjZphqrYGz4WuedhesseE24Xs0=
X-Google-Smtp-Source: APXvYqytv+vowuBagvEoUgGoGX5116IBvoI9z9GysMNlz1atJKsSC7+8Ivt9WYcfPF5DmjYIxqqMSBtY+lI5C8A0tVQ=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr20284032otp.306.1580305107635; 
 Wed, 29 Jan 2020 05:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20200128175342.9066-1-pbonzini@redhat.com>
 <20200128175342.9066-120-pbonzini@redhat.com>
 <c6464834-4dba-2ed2-fe67-2a28d128ba21@redhat.com>
In-Reply-To: <c6464834-4dba-2ed2-fe67-2a28d128ba21@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 29 Jan 2020 14:38:16 +0100
Message-ID: <CAL1e-=gD0zkKVvs3ve0Q-45vTGNCNSp-cxRBoYT0KyCsaiiw+g@mail.gmail.com>
Subject: Re: [PATCH 119/142] Aaaaallelujah!
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 1:26 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 28/01/2020 18.53, Paolo Bonzini wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
>
> Well, even for an RFC series, you could choose a better patch subject.
> And please add a short description what this patch is all about.
>

Speaking seriously, I agree with Thomas absolutely 100%, but in case
this patch is merged as is, I suggest that we establish "QEMU award
for the most original patch subject 2020", and nominate this patch for
it. ;) It would have had tremendous chances to be a winner. :)

Aleksandar


>  Thanks,
>   Thomas
>
>

