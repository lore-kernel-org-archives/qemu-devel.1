Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2756DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E656C20692
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kp183EDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E656C20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWhwv-0004HZ-3h
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 09:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWhw3-00031d-0Z
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWhw2-000445-1i
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:23:22 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWhw1-00042t-Sv
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:23:21 -0500
Received: by mail-oi1-x243.google.com with SMTP id o12so5316335oic.9
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 06:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Bp+3hP5Zl6wCi1+CAAXr+qiE0ttrcm8MLdaglMgNy8A=;
 b=Kp183EDpZVMIaVBoE44RHOyYFcM4ORSVFoNkzJcbcUsQdRK2EbWGHgi48p8NSWN+xN
 6fJ35522iyQOjpGbkvKB17PQPya7PpmuaFQ+lnm9dNBjalRzls9FuHrwpWHVeEnJh5ZT
 QAuAG4my+Pe8EPAlRzVKnPcw6M0JgGmWKRwdts7WjUNUF8mLD91UsRiON2bTg3TatGVu
 K6msua0xOh49i06kFXoxUTE87OCPiky9pz7wGjEUQyNr5C3V0nvDMOEWC3VvsijCc/59
 WGvbOUjsgateHoxgG9weAu62TpwAWr8TsmlvL/bSyQteu5AEYPNhBX5af/Z9I5u770T5
 z9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Bp+3hP5Zl6wCi1+CAAXr+qiE0ttrcm8MLdaglMgNy8A=;
 b=DpsPOT6JkxfbFt50FtdEr5kakR0RnScH0swMO2Q8bwsSrAN47ucWS9fhMxivJkADbz
 KlbvcFxdLW87/6Z4by3+O9W0fhpBFmT0pXtd1VsVyfRiXPt+ZS6zGP/1koDR49DlQkzw
 x8qnFwMjdcYPu3QwHhn+zmJZtqjGXPwtzg2gXsfro1HfoFNruD/pj/1zLn8DmfhEx/lY
 BmxtchYCbCzAOvyPGLFWB9VA8ImgTxZ6gT7O48h49v7Pd+PUf4sirlX8tMaCQ2kmTN3j
 jv4sUMKiq/x4XiAXQa6hqSWesVATw44Xdc7xmEmQ/U2xKXt929YKUhxHcLnvS1IYDDSv
 /Lsg==
X-Gm-Message-State: APjAAAXFEPrwNOv0lsHcZ1nofH/3OmQT5ajogk5ryomdP4DGKsDv59q0
 +H7JNkM1irm+rClTW/fzaPYfHOeZHltJpW4mWsAIyw==
X-Google-Smtp-Source: APXvYqz51XPPMlIt16EJPVK01ebeXdgsKjWc8ZBqujrzLTFcDiK7i5g9LaZznWVC0jMKkYvB2Xf8yhVpkRABOISinXM=
X-Received: by 2002:a05:6808:b04:: with SMTP id
 s4mr20637552oij.163.1574087001110; 
 Mon, 18 Nov 2019 06:23:21 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-9-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-9-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 14:23:09 +0000
Message-ID: <CAFEAcA-xhXtFnOOzKjp3C_3YE12XqXSfakck5suyjzP+EiB_Gw@mail.gmail.com>
Subject: Re: [PATCH v3 08/33] serial: add "chardev" property
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Oct 2019 at 18:33, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> This is more QOM-friendly, callers may set/get the property themself.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/serial.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

