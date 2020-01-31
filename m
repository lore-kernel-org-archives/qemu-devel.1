Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43338C35240
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 10:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F6F206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 10:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uGleLscP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F6F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixTfb-0001Tq-8j
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 05:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixTek-0000UD-HS
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 05:36:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixTei-0008Ep-LP
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 05:36:10 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:42547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixTeh-0008BW-2a
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 05:36:08 -0500
Received: by mail-oi1-x235.google.com with SMTP id j132so6748417oih.9
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 02:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l5vXESUBJRqSLIP637yjVnmEWLH7nOk1h0nwymGwox0=;
 b=uGleLscPb+iXLQXjH71G4wx/JFAXrReQZocAGDUIREURilCOCEg1LJLCCla1V2FkUL
 ZXG2YCUnoy7FcYLuEjHM1Z2XVPPORIzy6sJY0V5ETPGEflIjUF4tPYozUnJqWenU9RkE
 3aoUIBCS6ECX2K+IRVjU14njtW+4PH3JMdCb1qNWScyc9J38I2Q05sKYNSBaCxVDFQdX
 umHprQRN/cLDzJw1z6pMgnNgiFTf2E/knwQty3e/bg0+wvCxLX/9Evx7owu6OOP/r5nC
 LB/qiaGgREF1PFCZkcUr+Irb2vevf2AAiKct+N16Q5Bt6Kx0V6kOwk6DQgwMQG0AhweU
 X5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l5vXESUBJRqSLIP637yjVnmEWLH7nOk1h0nwymGwox0=;
 b=Xt/Q+uaHEyMc2EpL0L5MXp0JKlD0FnzsY/5GPKh+xuAKe2GIigXQtV+B1j4+0iPPN7
 4yBzSsAHlfcUqcGXW2WRbGv1/3z0eZ+f/gPFM/NHU6WifiRKLgetLyVvWP/JIIf9cUL8
 EQwUm5ssnMzMbGF8fO6veJeqaSunkMTHGY1kyYOvb7ebbDNUG1Ts4SODiW9vhvn0jyGF
 XmHJaTNRgYPMxoPchvrG1jCt7VErJ+9tVo3RyNAgHEoh5yLTAt74D96rhHfNP9W7Idmw
 5a83X2zWc4ypJ0Itk/DlEMGgAuFUYS2cXPVyswk7W3F8rIjXxhBXcKvDJfsLs8qsQM1+
 Yw4A==
X-Gm-Message-State: APjAAAWqzw+yC2/Td67B9+NjkGdsDMZubZzKmRTgNbBrTEfuDDJLckiR
 Ke1yJ1EWWJkbd/mrCAqXppnpHgtBnH7etl/2KXQY5Q==
X-Google-Smtp-Source: APXvYqwX26FuP8Pdd8qTFMnGmZo5OQrDNaTqUhs3CZ3pagckC59+Gle4FnuOoyVRQNY5XEmECfNJoq5QNNhYAEIOVb4=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr5674663oie.146.1580466965459; 
 Fri, 31 Jan 2020 02:36:05 -0800 (PST)
MIME-Version: 1.0
References: <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org> <20200115121953.GJ93923@redhat.com>
 <874kwwvmuv.fsf@dusky.pond.sub.org> <20200130210902.GA25927@paraplu>
 <87y2toi29o.fsf@dusky.pond.sub.org>
In-Reply-To: <87y2toi29o.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jan 2020 10:35:54 +0000
Message-ID: <CAFEAcA-545QS9mnM6hwa6TxUpw_pDQ3Pa8tkf4qtzWS1Zi_fxQ@mail.gmail.com>
Subject: Re: Improving QOM documentation [Was: Re: Making QEMU easier for
 management tools and applications]
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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
 "Denis V. Lunev" <den@virtuozzo.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 Jan 2020 at 06:11, Markus Armbruster <armbru@redhat.com> wrote:
> Beware, personal opinion.
>
> When you put documentation next to the code it documents (which you
> absolutely should, because it's your only realistic chance to keep the
> two in sync), then extracting API comments is useful, because it
> collects them in one place.
>
> It's of next to no use to me when the comments are all in the same place
> already, namely the header.

To throw in a personal opinion on the other side, API comments
should be in the header, not the .c file, because they're
your external interface and as an external consumer of that
interface I shouldn't have to go digging around in your
implementation source file to find the documentation.

Since Paolo put in the effort to upstream the kerneldoc
Sphinx plugin, it's now relatively simple to pull in
the doc comments into a rST file, so you might as well I
guess, though I agree that the cumulative benefit over
just reading the .h file is not enormous.

I definitely agree that the overview/introduction/conventions
side of things is where we'd benefit most if somebody wanted
to try to tackle that. We could roll
https://wiki.qemu.org/Documentation/QOMConventions
into that if we had a better place to put that info.

thanks
-- PMM

