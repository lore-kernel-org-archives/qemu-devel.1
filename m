Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442BCCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114F520679
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAjKDe9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114F520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxpl-0005KI-4o
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMxom-00045x-2F
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMxok-0001vB-Kq
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:19:35 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMxok-0001uj-G1
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:19:34 -0400
Received: by mail-ot1-x342.google.com with SMTP id b16so4083837otk.9
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ne/hWEhyLPh9P2iF1f90rmFstvnIDJwvxB4L5jsXSuo=;
 b=kAjKDe9ts8LLutdSWhimO3rnDoZSVaFLD8hXo4uggeLRx9cQ6lMwvAZxX/sjTaz1Ex
 wilD7EjhJcwtlumoFu4f8CQDoExbuMAFA6FTMb2ylhLSXkjhPt85ja/OtEzpnlnM19cy
 POdCLMl30scf4SlBHroOqgKcWgz3uiKv5kwRwSKDUSXEl+7UyvIrlBT8hRdFaPBOblk5
 QKYtWD5tp5lonBcX689hhiDG7l2RMlvRRcUjgIwwYU18mpjYdCXI9HfBi+/6VBSXaiLQ
 y2eukzOKlmkxivbBj0yE5U1kfUiH8DcvDNxX8HKxOJXwAaMphQqAOJgZARZgY7G2QX+o
 GuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ne/hWEhyLPh9P2iF1f90rmFstvnIDJwvxB4L5jsXSuo=;
 b=JKuVVmoj30IzXQPaEiiv2V36V5AVYi+fuAkraIUXmM9/RU+n71Bd+6Vtx6bH0S/s1o
 iFmgW2R+rmLwPEWDFKuouTKgibYxl3m6Kh4ZQwUbK4vWoUio2eIb1gMZVgXkfrHusu7b
 lgbbkVEytDwhubhLa0gvK0INPnZOhgXZofhwIkL3XxBs+OStir/sp9gs5gwHoH0Pozh9
 hcM164waGAOKUdZ5PuGrjoXj0JpeDHn/8HcVdupN1jPRZiQ6/s1nbPCo7iRgKwWOYqJE
 nU6vIEFyV4brukStA+C83C5dnCnQOS3BpQF7eSWAhIMIc4GSxRVXumCRg3yXPZF/frE4
 cVjg==
X-Gm-Message-State: APjAAAUdpUBiprFDO3fEBRkTu+5KQWXIvQ7VirbUGikOFLHT5jAtSooD
 PjI8qeH3Q6MqobGPu/XOcTPJWF+5FQex2p5Z+9p4CQ==
X-Google-Smtp-Source: APXvYqwPDJ8a7SDxn28pcfe8LPi1wUlcUwbQaSokc8T8BEfjFK0fQwnK1Qbht46ymkl889JNdDTTT7W8S5K4ZYNuvEU=
X-Received: by 2002:a9d:398a:: with SMTP id y10mr3443749otb.97.1571764773451; 
 Tue, 22 Oct 2019 10:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191022162137.27161-1-marcandre.lureau@redhat.com>
 <20191022162137.27161-24-marcandre.lureau@redhat.com>
In-Reply-To: <20191022162137.27161-24-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 18:19:21 +0100
Message-ID: <CAFEAcA8A4-wEy3ueq+Tz3oN3Fpyy_vXdQ4k_mmOXYiVwjDEe_w@mail.gmail.com>
Subject: Re: [PATCH v2 23/28] smbus-eeprom: remove PROP_PTR
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
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

On Tue, 22 Oct 2019 at 17:24, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Instead, set the initial data field directly.
>
> (the initial data is an array of 256 bytes. As I don't know if it may
> change over time, I keep the pointer to original buffer as is, but it
> might be worth to consider to copy it instead)

All the callers to smbus_eeprom_init_one() allocate the
memory for the initial data, populate it, pass the pointer
to smbus_eeprom_init_one() and do not save the pointer
anyway. So we effectively "own" the data -- we could choose
to copy the data and make the callers free the memory instead.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I'd still like to know what the right QOM way to pass
256 bytes of constant data to a device as a property is.


thanks
-- PMM

