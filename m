Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A940EC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 10:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B9372070A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 10:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hGaQLPMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9372070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j16SA-0005KU-Ir
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 05:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j16Ra-0004uC-Ac
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:37:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j16RZ-0007Lv-1V
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:37:34 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j16RY-0007Ki-Ri
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:37:32 -0500
Received: by mail-ot1-x343.google.com with SMTP id 59so5792673otp.12
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 02:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uzVWV3C/8LNNtAOE6wVRXtapr6EtAmKiHWsn6cUwA9Y=;
 b=hGaQLPMG7JEj8SrmE6nj8VbWErO5zNBnNlDfSPYyUdb2eHA+sMrLHIHZgyrJZ66gJI
 QwXpCLHzQeVBfi3wnOHgMnDR+FOuFFBXD9RwxlEyidN/F3rVeOhwhAOovJ2L9cKJxO63
 m/oAwjBPUdUC5N1gvDKHcCG7gW2iLcytzEezt9savoDZlBvd4T5prextQtHQfkqj12ai
 m3Ps2f+xqJVGUgbF+cVDzPV1SvszzAjdqqIPwFyg81gpeT8+c44R3LM+qzaM8cCoPIbu
 qR65SRY/bG6HayCdnhEtuLO9Up8OJYMcxwGAbQ1pwVPlpmPocXadfunpP6iK0FlxWbdL
 Tenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uzVWV3C/8LNNtAOE6wVRXtapr6EtAmKiHWsn6cUwA9Y=;
 b=L9wtUmdMpCIjsXJwlYlR8PNvIulA9TxJ43Y3L+MQBKrhbuFVZ1Y+sLI9HjNUtjI5LF
 5rQe2TiIyb/7sO94TPuqPzcuLcuGcChaXsPZEu4ipMAcieJoXvxARNFqi7DSekNqxG74
 GYJFWFhPjeg9lzUTB7y0qy51xpacDwaUPwd6WtG54x3EOWYA6hO0UR4Ydh0weif7+Z5U
 YN1c7p8eRmD00ouNtnN6YlNZrWtlD1jn03omka0QvRSsbDFRzFrY1CAizbu2DdO+gCCT
 UKP6C6Z6GXYOLug4506coM0vbfRWjrAneftRP78seCrtdYR1K0fp0MQABp1tiDKuJDmk
 oOOQ==
X-Gm-Message-State: APjAAAXl4UtM52NUagwh+J8eP71uWxa1LuBuRk0ozzJSO6sEu9LOPgZv
 IUmnr0EpdgLoTl1lN26L01i4lMBKi0EDPcN1HmzwFA==
X-Google-Smtp-Source: APXvYqxsbk92FMKsqrsqlVC4xvNTJxp2zmxDOPd32LlNMJp4G76tzq1JHdMuvAd5ADWyuJrkb+9uiJsuC1m3pFxBP+w=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr514876otq.97.1581331051464; 
 Mon, 10 Feb 2020 02:37:31 -0800 (PST)
MIME-Version: 1.0
References: <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
 <20200205060634.GI60221@umbus.fritz.box>
 <62d62fab-46a4-240b-037b-409ba859b93d@redhat.com>
 <47e6a49d-f1c7-aaf6-b9ef-7e81773cff6e@ozlabs.ru>
 <8993c6b4-2a2c-b7e5-8342-4db480d0af9d@redhat.com>
 <20200210073008.GE22584@umbus.fritz.box>
In-Reply-To: <20200210073008.GE22584@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2020 10:37:19 +0000
Message-ID: <CAFEAcA9uOT-M=yfPSv49mLSVoPOXDsp0MBCxXfAN=ctjKHv6XA@mail.gmail.com>
Subject: Re: VW ELF loader
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <conny@cornelia-huck.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Feb 2020 at 07:56, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Fri, Feb 07, 2020 at 12:45:20AM +0100, Paolo Bonzini wrote:
> > Every platform that QEMU supports is just using a firmware to do
> > firmware things; it can be U-Boot, EDK-2, SLOF, SeaBIOS, qboot, with
> > varying level of complexity.  Some are doing -kernel in QEMU rather than
> > firmware, but that's where things end.
>
> Well, yeah, but AIUI those platforms actually have a defined hardware
> environment on which the firmware is running.  For PAPR we don't, we
> *only* have a specification for the "hardware"+"firmware" environment
> as seen by the OS together.

(The below is not intended to be a prescription for what PPC should
do, just some background info about what we're doing with Arm currently.)

For Arm our 'virt' board is drifting a bit towards doing some 'firmware'
ABIs in QEMU -- currently this mostly means PSCI (for CPU power on/off,
system reset, etc), but there have been proposals for other firmware
ABIs that are hard to implement in guest firmware. I tend to agree with
Paolo in principle that where possible keeping QEMU to "we implement
some hardware emulation" and having firmware running in the guest
is a nicer separation of concerns, though, so for Arm I'd like
to avoid ending up with a lot of firmware-equivalent code in QEMU.

FWIW for the Arm 'virt' board there is no defined hardware spec
in the "handed down from elsewhere" sense -- so we defined our
own (and some mechanisms for passing the device tree description
of it into the guest firmware).

thanks
-- PMM

