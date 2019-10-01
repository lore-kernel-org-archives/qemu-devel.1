Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1308C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 12:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D4D21920
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 12:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwRDaFpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D4D21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFH3y-0006un-LN
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 08:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iFH26-0005lf-5n
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iFH24-0000Xc-SI
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:13:34 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44611)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iFH24-0000XC-MD
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:13:32 -0400
Received: by mail-oi1-x242.google.com with SMTP id w6so14131821oie.11
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 05:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EqPJvGfvde5raidNpo+Iag6DTCRENREzMrRH18wNc6Q=;
 b=EwRDaFpZVQYRCaz9/ibU4DBMJ6HhOLNpbZ3q74GLy7eteeMX8SkKfWOeBDDFBMpf2x
 btY4HVumcqWYQbyHAB1I62WFYEj7+390YX+Pw6xhgDHrgqVxgAcuxrbVdk8LlMh+4Px8
 ylp/fnrnqESjJkXPZ5kAYFyOGytXyTF1Yg3VHH4BXSzuOpSKsWkarU3hvNjSNoWF1y/v
 +/mWRnV8PBBsg2LseF+QsUiNI7V3LvYqB4TOnSuODte16Hj/EHCWeyIDfEjolzTHtPuB
 2Tw36OF3qioJGdatVfCDhr5JoN5eqjVRXfxmOLIK8VSzCeuuiG9nP/+wDyrdR56Vx6MY
 AOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EqPJvGfvde5raidNpo+Iag6DTCRENREzMrRH18wNc6Q=;
 b=gZSJh0b+5lZ6yT3323wN/h53oNSHsn8D85WhVvqS65yU8ilnPBrVyhm4d4tPXXr2j/
 JX2GaqIEYVvjQmvvNcHj+ww2xoCjXRMFHKapmZg50ds7B4P+72msyFbDoML7UQcEUlgg
 aQ99HJVtNUSlkC7Eg9uPETHDjNvY5Jndxw5hsi69A8KhdxjijQ3MS5w0zcEK6Gq5swEe
 bEG6XcGu/wLQUHWrmJSmVZ2BdLNS/vGVJ9fOh3W0d1KlK7FYYW4Opmtn+HqettubH/IH
 vSGSxwgltna+/4lX4BpdPJZeAE7kCD7dVvmVAVm49WSiAqoBMIIJRlp76bi3xyTR//zg
 RGAg==
X-Gm-Message-State: APjAAAV7OE8q52Ok3dwyd63H+KtsEVArOnUleQVN0bG6ETE7oOsRijci
 5ndjaO3s81+1brPgf0gfr3q7sPvcGEippmirx/+TAQ==
X-Google-Smtp-Source: APXvYqx+8Wn6LPWgKTVqP1BBjicRLX+uyofGNEg4OGLip2uszqPHU+sLs7vPwuKQX8qNeQ55EOSCmK2ZEpD4i1tApuQ=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr3284565oib.48.1569932011855; 
 Tue, 01 Oct 2019 05:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190928183934.12459-1-armbru@redhat.com>
 <CAFEAcA8tQde=o0FaezJuRb+fw_gt-7sq5pQSr_3RNjqc9jenaQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8tQde=o0FaezJuRb+fw_gt-7sq5pQSr_3RNjqc9jenaQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Oct 2019 13:13:20 +0100
Message-ID: <CAFEAcA9+0XFTEZ=SV_N9h=+V+yyiVgNjLVqBfX=GZm2_Pg+vCQ@mail.gmail.com>
Subject: Re: [PULL 00/27] QAPI patches for 2019-09-28
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Sep 2019 at 11:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sat, 28 Sep 2019 at 19:45, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > The following changes since commit c6f5012ba5fa834cbd5274b1b8369e2c5d2f5933:
> >
> >   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-260919-1' into staging (2019-09-27 15:43:41 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-09-28
> >
> > for you to fetch changes up to c615550df306a7b16e75d21f65ee38898c756bac:
> >
> >   qapi: Improve source file read error handling (2019-09-28 17:17:48 +0200)
> >
> > ----------------------------------------------------------------
> > QAPI patches for 2019-09-28
> >
>
> Just a note that repo.or.cz seems to be down currently;
> I'll retry this pullreq later in the week.

Today it seems to be back, so applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

