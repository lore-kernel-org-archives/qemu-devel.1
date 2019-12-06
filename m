Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C0DC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F7120706
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m59a6Dr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F7120706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHJW-0004xc-77
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idGCx-0005ed-Ev
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idGCv-0001e8-Mt
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:11:54 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idGCv-0001cN-BN
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:11:53 -0500
Received: by mail-oi1-x243.google.com with SMTP id a124so181086oii.13
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 08:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=G70GXJRH9IYcgly8XkY/1mlfa+Td4zqKElgcMaaqYnE=;
 b=m59a6Dr7UXfGdZ0aIIaideRrOlCgaTN5rcleLCv6CQZayRt4vNqoHpwKE+9YevW/1L
 hemLJmZGE5gshqLh0jmU5TvI2k4Sa6Zek0n3z706c0bE2EI7mV5LWBAuOOhYtHSFlRkE
 lRg5q0c02LjvYwfUs45GWLPJAhpTD1jGTfmxJqCe2zV0Jn4QiJTqmeKJrLNAKZwz469U
 KzP606ulQmKamoLNZb5cNCc57yw2nvbfQPDDIaz7G++4kzD4c38RPLx4qizrr3ikuArs
 cfQ7lWZv3R2lTC81+e1ajYZb0lTsqbGLzn+NyeYmZRK7WuvHwcrIlP91ytZNRxtnyQcW
 QB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=G70GXJRH9IYcgly8XkY/1mlfa+Td4zqKElgcMaaqYnE=;
 b=ojzTLGah7Wl1axI6ZDdMXWhsIDeJFYaHl//qOlB+yLAYGQrAVN+3MN8ZuM2o7KhIj1
 liRNJDtfnB5GIljGVavtHJS40L0ZCHeAGh/AI9MBpmZss5BGCsPjCQrLJ2Ilkf4pmuLD
 2YVKGIlyr/yg9p19nB/49UgBLztVTHVL+g2wPcxsIeSKF910QQUgtcYxbYDLBRrDstOQ
 NyKFUeaTxvryv8bzJRggrWLzZDqZVispuIlV2UYPIb0h6xpII3CtpDsr7aF9chjuSNoh
 dTOJyudARASA+Ui+iUQ0cFI6Yxy6bmU0MdADyhwttW6qCScGMMgmLSRKQ1gDw4DCEWuz
 X80g==
X-Gm-Message-State: APjAAAVccHUiy8Fg7drapJxJhYr0AtvJf6msBjCP68lJhokMRxCso35O
 qBV7Y+55gXgKMP1P3pNl7JSiQHYkByX0Y35+piAvZQ==
X-Google-Smtp-Source: APXvYqxEL1RPcjcTNJnsQrvKmRHCvTDO8CYvHHEj5IDVWBgCYHQ0AmxEa9lDHfEoyb6q5f4YR0x6hg9u8V1cezdMmuE=
X-Received: by 2002:aca:f5cc:: with SMTP id
 t195mr13077104oih.163.1575648712558; 
 Fri, 06 Dec 2019 08:11:52 -0800 (PST)
MIME-Version: 1.0
References: <20191206150844.20124-1-crosa@redhat.com>
 <CAFEAcA8ekevaZnwOg5bwJmkFkDFaC_qkrLLESLbSJs=L80viHA@mail.gmail.com>
 <20191206152543.GA20588@dhcp-17-72.bos.redhat.com>
 <CAFEAcA_SmR_QnrSzDGpsckh_hatNthVbx_0Z9=qM3BQSwVyhKg@mail.gmail.com>
 <20191206154558.GA23522@dhcp-17-72.bos.redhat.com>
In-Reply-To: <20191206154558.GA23522@dhcp-17-72.bos.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 16:11:41 +0000
Message-ID: <CAFEAcA8HHSL=VyUQqLpKGjzHOCsOj0ua5YwOszSMStOgjMGfcg@mail.gmail.com>
Subject: Re: [PULL 0/1] Fix for m68k/q800 acceptance test for QEMU 4.2-rc
To: Cleber Rosa <crosa@redhat.com>
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
Cc: Beraldo Leal <bleal@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Dec 2019 at 15:46, Cleber Rosa <crosa@redhat.com> wrote:
>
> On Fri, Dec 06, 2019 at 03:37:19PM +0000, Peter Maydell wrote:
> > On Fri, 6 Dec 2019 at 15:25, Cleber Rosa <crosa@redhat.com> wrote:
> > >
> > > On Fri, Dec 06, 2019 at 03:12:31PM +0000, Peter Maydell wrote:
> > > > On Fri, 6 Dec 2019 at 15:09, Cleber Rosa <crosa@redhat.com> wrote:
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > Fix for m68k/q800 acceptance test (Philippe Mathieu-Daud=C3=A9)
> > > >
> > > > Any pullreq after about rc2 needs to clearly say
> > > > what it's fixing and why it's justifiable for it to
> > > > go in rather than waiting for the next release.
> > > > Otherwise you get the default response:
> > > >   nope, not at this point in the release cycle.
> >
> > > This is fixing the URL from which a kernel package is fetched from,
> > > updating it to an archival (thus stable) location.  The current
> > > location is transient, and Debian removes packages from those
> > > locations after a given amount of time.  Without this patch, the test
> > > is never going to be executed.  The package itself is unchanged, as
> > > can be seen from the verification hash that was not changed.
> > >
> > > While this is far from critical, the main benefit of having this in
> > > 4.2, as opposed to in the next cycle, is to not "ship" a broken test
> > > in a release.  It would also help downstream packages running such
> > > tests.
> >
> > Thanks for the explanation. If at the moment the test is simply
> > being skipped (ie it is not actually failing) then I would
> > prefer to delay this to 5.0. Otherwise we'll start running
> > the test and may find that it is actually failing in some
> > of our CI or test environments. That wouldn't be a problem
> > a bit earlier in the release cycle, but given we've already
> > had rc4 and rc5 is going to have the minimum number of
> > absolutely critical fixes in it I think I'd prefer not to
> > take that risk.

> Yes, this is a very fair point.

OK, I'm going to drop this pullreq; please resubmit it once
the tree reopens for 5.0.

thanks
-- PMM

