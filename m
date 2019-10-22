Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B9DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CCD2184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CCD2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMyPU-0006ww-Ad
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iMyOK-0006CW-59
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iMyOH-0003ea-6t
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:56:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44894)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iMyOG-0003dS-UI
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:56:17 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 35F8981F07
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 17:56:15 +0000 (UTC)
Received: by mail-ot1-f70.google.com with SMTP id t7so8973145otm.4
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 10:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oWIQEzr1TvvMozekqdp+qXRuGS68XFytA0A8deVY8T8=;
 b=Cf/3wlw96lS2kHwdb+Q8woNxMicNoWCyrvd7iUoxBhuE9oinuTH3jcAE5pOL5iaDzt
 quxOHO9amCz+Ituz2d4+GT3DrotWkht2wrZBGri5T5Vfg2+6DIvwQTvABajky5SR4YSb
 kwJj21zACyKeD7Wy3f4B9DdYKzrLnM83ekq7XM/5HAViq+GaZ9Ynx/bfOxMQcHO07hKG
 WX8N8q5ch+K7MYCL9LtEdrKHe54tPPW2zvCa4LCoIOGEJUQZB1w+cfQA5QuPfVXkAgTH
 5eRA3b5usJWcZaaoNRfolzn//vZ1R15+0yGzdqV4DRjBZsRQwhyuCvg0Lp813r6EsABB
 X6lQ==
X-Gm-Message-State: APjAAAWP2hai8W6WIyjmiU3UaiKcPkyCZtRG8lM65GoHtg+B0QiK/lZk
 9BWvMpO/LdUPT77tcl2EDCuVgFvintFOZv9pDo3P3ARJIlyv+rmPqptV1NanCboxa0131DBqxRw
 A2YVfHcPJ1AIRAZ86bCy4E2OQqe9rxaU=
X-Received: by 2002:a9d:7d16:: with SMTP id v22mr3440093otn.331.1571766974688; 
 Tue, 22 Oct 2019 10:56:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyYF3mcHT6mhzPOcDIayuAI5CneTmIOM4WjSxa1aKEpJhJpuLo1IZSAv+Dw/bbopeA9lQV+bDlMpSFAUIpd72Y=
X-Received: by 2002:a9d:7d16:: with SMTP id v22mr3440079otn.331.1571766974507; 
 Tue, 22 Oct 2019 10:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191022162137.27161-1-marcandre.lureau@redhat.com>
 <20191022162137.27161-24-marcandre.lureau@redhat.com>
 <CAFEAcA8A4-wEy3ueq+Tz3oN3Fpyy_vXdQ4k_mmOXYiVwjDEe_w@mail.gmail.com>
In-Reply-To: <CAFEAcA8A4-wEy3ueq+Tz3oN3Fpyy_vXdQ4k_mmOXYiVwjDEe_w@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Oct 2019 19:56:03 +0200
Message-ID: <CAMxuvawXOgauQJoSuJ+3Vbk1OkSh3rUgUkwp8QdxZ7Cra-THrw@mail.gmail.com>
Subject: Re: [PATCH v2 23/28] smbus-eeprom: remove PROP_PTR
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

Hi

On Tue, Oct 22, 2019 at 7:19 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Tue, 22 Oct 2019 at 17:24, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Instead, set the initial data field directly.
> >
> > (the initial data is an array of 256 bytes. As I don't know if it may
> > change over time, I keep the pointer to original buffer as is, but it
> > might be worth to consider to copy it instead)
>
> All the callers to smbus_eeprom_init_one() allocate the
> memory for the initial data, populate it, pass the pointer
> to smbus_eeprom_init_one() and do not save the pointer
> anyway. So we effectively "own" the data -- we could choose
> to copy the data and make the callers free the memory instead.
>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> I'd still like to know what the right QOM way to pass
> 256 bytes of constant data to a device as a property is.
>

A property with a uint list visitor is the closest thing we have I
guess. We can probably have a specialized QObject to hold a fixed
array, but string form will probably remain a list, I guess.

I can try that, but this is quite complicated to pass 256 bytes internally.=
.

