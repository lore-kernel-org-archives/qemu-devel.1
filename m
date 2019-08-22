Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6207DC3A59E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 03:16:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB3721848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 03:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoCgtAw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB3721848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0dae-0004lD-9Z
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 23:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0dZf-00042N-OS
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 23:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0dZc-0004zJ-UQ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 23:15:43 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33742)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i0dZc-0004wx-OW
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 23:15:40 -0400
Received: by mail-ot1-x342.google.com with SMTP id q20so4162716otl.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 20:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=3FaEz41VHrCv4ggKON+AaigUXpTek1upl5TMe1IE8mE=;
 b=VoCgtAw+S5HOw+wIPfxOqfINqLHmvdI8l2tD7uZjgV433ArWQppqdufKSskckU2lVR
 L9FLEgLUSlMlvokT5pkbmPcBPh66Ea5L0DuEhijPVclbwRh0VLy53cSQEuZfodYUBgzk
 +4ne8/QHaKNazAhh1TMofYY1hsC1ee7dt2ML7MAstXa434QbzHns19klY6JyAHYBkccp
 Cw9U776U5Xcq2vY7zIVOC4r2v4eVsCiDrIQu6DuKz2uRed2cNLrbUjfptkIezHnG4Yl3
 dsgmAbLe1PLUSD2Sggp99O44YzHHO8azyYyShXG2ECrVXqDVKVOFnsKDiOCJkwKHJDc1
 Pdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=3FaEz41VHrCv4ggKON+AaigUXpTek1upl5TMe1IE8mE=;
 b=msq+tQgcWSEl/52GLqmjk/SYhcwGLSEOC/MQbzYOpt00bcuUNL1JYqaM+f3OZSbPWf
 yHJ7gfN2M/zaRqBTOUAupci8Q0aq6crxHBAmhSc162NUyN4PEdCX7RoQOB8Lgk+yxsVB
 rY5BbzmqWg7w1+i/xWwWatHMHXh7C7Z/SAMea/Lxv+LfI0N71ULS5E/Cf4ErpQJhk2ac
 LfPoMtPToMHYD3DntMccPavcAVAeHnkStz2ibXf1MqSBJiMOJtuDHUOTFBsND1xPa8rH
 lBvl2zHMibDDwSUwtslLEzCn56X+0o+KCLWHtnWauU632u3DN69Y0h0PiFUJfmHjVf6k
 qZqA==
X-Gm-Message-State: APjAAAW952nZ9lKF7Co5mWmEpavlBL8zdS32yK5mI3q/TRWFaOCAvapA
 3M5GvC9yme5nuqvNl5r+/JAMI/GH6G+hp1tX218=
X-Google-Smtp-Source: APXvYqyCZWLMebH0QAiLLc50G4MFc8aFU1SaXZPpwYgx+36LlmAu/3RENDgddWJ1HYHCFbFYvSCAUUqIFUnIHeWTub0=
X-Received: by 2002:a05:6830:1d75:: with SMTP id
 l21mr27704727oti.121.1566443739933; 
 Wed, 21 Aug 2019 20:15:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Wed, 21 Aug 2019 20:15:39
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Wed, 21 Aug 2019 20:15:39
 -0700 (PDT)
In-Reply-To: <20190821210030.GH7077@habkost.net>
References: <1564760158-27536-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=hWc6G7Ob+LU7EWoY3LVBvABY2ky=RT28dSzqM=9O=OEA@mail.gmail.com>
 <20190821210030.GH7077@habkost.net>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 22 Aug 2019 05:15:39 +0200
Message-ID: <CAL1e-=iZziwdyjJeaE-ZC2Rbjdmr_enYGBdK5zs4Lh0kN1DQOg@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 0/2] tests/acceptance: Update MIPS Malta
 ssh test
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
Cc: cohuck@redhat.com, f4bug@amsat.org, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, amarkovic@wavecomp.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.08.2019. 23.00, "Eduardo Habkost" <ehabkost@redhat.com> =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Wed, Aug 21, 2019 at 10:27:11PM +0200, Aleksandar Markovic wrote:
> > 02.08.2019. 17.37, "Aleksandar Markovic" <aleksandar.markovic@rt-rk.com=
>
=D1=98=D0=B5
> > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > >
> > > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> > >
> > > This little series improves linux_ssh_mips_malta.py, both in the sens=
e
> > > of code organization and in the sense of quantity of executed tests.
> > >
> >
> > Hello, all.
> >
> > I am going to send a new version in few days, and I have a question for
> > test team:
> >
> > Currently, the outcome of the script execition is either PASS:1 FAIL:0
or
> > PASS:0 FAIL:1. But the test actually consists of several subtests. Is
there
> > any way that this single Python script considers these subtests as
separate
> > tests (test cases), reporting something like PASS:12 FAIL:7? If yes,
what
> > would be the best way to achieve that?
>
> If you are talking about each test_*() method, they are already
> treated like separate tests.  If you mean treating each
> ssh_command_output_contains() call as a separate test, this might
> be difficult.
>

Yes, I meant the latter one, individual code segments involving an
invocation of ssh_command_output_contains() instance being treated as
separate tests.

> Cleber, is there something already available in the Avocado API
> that would help us report more fine-grained results inside each
> test case?
>

Thanks, that would be a better way of expressing my question.

>
> >
> > Thanks in advance,
> > Aleksandar
> >
> > > Aleksandar Markovic (2):
> > >   tests/acceptance: Refactor and improve reporting in
> > >     linux_ssh_mips_malta.py
> > >   tests/acceptance: Add new test cases in linux_ssh_mips_malta.py
> > >
> > >  tests/acceptance/linux_ssh_mips_malta.py | 81
> > ++++++++++++++++++++++++++------
> > >  1 file changed, 66 insertions(+), 15 deletions(-)
> > >
> > > --
> > > 2.7.4
> > >
> > >
>
> --
> Eduardo
