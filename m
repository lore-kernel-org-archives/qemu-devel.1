Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7206C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767322184D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9D3cGBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767322184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57275 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2L30-0001dI-NE
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 15:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i2L2E-000160-9P
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i2L2C-00061T-FM
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:52:14 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i2L2C-00061A-9s
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:52:12 -0400
Received: by mail-ot1-x342.google.com with SMTP id c34so16391998otb.7
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=/FrBueZ97fqEdcSuHjL6ZAlO+OJARCeFd+EGMB+mQ2U=;
 b=g9D3cGBtRzuqyJVTqh3pKEUxIlBBc8JaiADh6x5QGMPa9KRjCA8ktx2SSzpumBE7Lw
 DTgfTB7Gy+puvO5rNzH5QJKjp/Qb7d7urUa2Ss3Qv2xGCsiglN7zwanqFsE9Tnqziyb3
 hPeRxn+4XaXjgad8rLbijWp9fwTDKimJFru0FBKUFlUevgm5JSHPc6RTlmKolnfcjMdA
 P0vJ+oYO/gvmTjAR2l4ms6wAXsb4Szi2f6t+9hhCe9rzmBRGO1Ted9oZd60OSRDhomES
 o/QqctGU0qYmUoDzcIOPmN6FQGoZV/zJueMVuPzf/7+ZzEQFFuuHCTU5C2lCyHaRMJdT
 zVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=/FrBueZ97fqEdcSuHjL6ZAlO+OJARCeFd+EGMB+mQ2U=;
 b=IIoflVd9QQBKx4r1I40fKgq3QLa11TsBZV4mZuV/S9EGRAst7Wee9aSv4RPfq5Ol+4
 2m22tZQMPCRQ6DMuw/wVNGVR8MxOFN7GHV6KO9lixrPCxcMmKO/q95c2G+AGrnpnWft9
 IDM7F/xFLqOwIAKlDhNZKBkKBBLY9zigAawJYHWaX3oGx4BNtrsKfXXx46zizDdqjH66
 xc0usKzDpzp56pIzlBLOMS1PbInVPK3Cnf6U4zLNl52Oyysmeb0XQQzN4k3Jl+xbegDJ
 kt15uZEvLJ1m1oWXp3fA3BzTQzBLeS5S0WvtLO7IiFVmRxbCLH5Med0G9vQr9wxuKZeM
 Z/5w==
X-Gm-Message-State: APjAAAU3etfqrRdOawomXnI9ZpO6tHSTR1jgc1RzwH4mdiC8lljTRS2N
 1co5l+retcdgCrUPhdBPkp5IOaT0d/edOV3lFuE=
X-Google-Smtp-Source: APXvYqyzW8F08yvzBskcbSw0RghIIi2kv7EtFsOoyA7KvXkugynbZ230kLcoVB1iXjVXnehFOy6W5tpwx5u9bjYpyNg=
X-Received: by 2002:a05:6830:4d6:: with SMTP id
 s22mr283142otd.295.1566849131223; 
 Mon, 26 Aug 2019 12:52:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Mon, 26 Aug 2019 12:52:10
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Mon, 26 Aug 2019 12:52:10
 -0700 (PDT)
In-Reply-To: <CAL1e-=gf-DOrdfN__Bxbx+B5NKu71ZTCypGEekoFc05WDaQjbw@mail.gmail.com>
References: <1564760158-27536-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=hWc6G7Ob+LU7EWoY3LVBvABY2ky=RT28dSzqM=9O=OEA@mail.gmail.com>
 <20190821210030.GH7077@habkost.net>
 <CAL1e-=iZziwdyjJeaE-ZC2Rbjdmr_enYGBdK5zs4Lh0kN1DQOg@mail.gmail.com>
 <CAL1e-=gf-DOrdfN__Bxbx+B5NKu71ZTCypGEekoFc05WDaQjbw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 26 Aug 2019 21:52:10 +0200
Message-ID: <CAL1e-=g_KkfW8tvWoyTSfFJYaq7XbUMHUZ9D4PmiPYfEaHQ0fQ@mail.gmail.com>
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

ping

22.08.2019. 19.59, "Aleksandar Markovic" <aleksandar.m.mail@gmail.com> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
> 22.08.2019. 05.15, "Aleksandar Markovic" <aleksandar.m.mail@gmail.com> =
=D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> >
> > 21.08.2019. 23.00, "Eduardo Habkost" <ehabkost@redhat.com> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > >
> > > On Wed, Aug 21, 2019 at 10:27:11PM +0200, Aleksandar Markovic wrote:
> > > > 02.08.2019. 17.37, "Aleksandar Markovic" <
aleksandar.markovic@rt-rk.com> =D1=98=D0=B5
> > > > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > > > >
> > > > > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> > > > >
> > > > > This little series improves linux_ssh_mips_malta.py, both in the
sense
> > > > > of code organization and in the sense of quantity of executed
tests.
> > > > >
> > > >
> > > > Hello, all.
> > > >
> > > > I am going to send a new version in few days, and I have a question
for
> > > > test team:
> > > >
> > > > Currently, the outcome of the script execition is either PASS:1
FAIL:0 or
> > > > PASS:0 FAIL:1. But the test actually consists of several subtests.
Is there
> > > > any way that this single Python script considers these subtests as
separate
> > > > tests (test cases), reporting something like PASS:12 FAIL:7? If
yes, what
> > > > would be the best way to achieve that?
> > >
> > > If you are talking about each test_*() method, they are already
> > > treated like separate tests.  If you mean treating each
> > > ssh_command_output_contains() call as a separate test, this might
> > > be difficult.
> > >
> >
> > Yes, I meant the latter one, individual code segments involving an
invocation of ssh_command_output_contains() instance being treated as
separate tests.
> >
>
> Hello, Cleber,
>
> I am willing to rewamp python file structure if needed.
>
> The only thing I feel a little unconfortable is if I need to reboot the
virtual machine for each case of ssh_command_output_contains().
>
> Grateful in advance,
> Aleksandar
>
> > > Cleber, is there something already available in the Avocado API
> > > that would help us report more fine-grained results inside each
> > > test case?
> > >
> >
> > Thanks, that would be a better way of expressing my question.
> >
> > >
> > > >
> > > > Thanks in advance,
> > > > Aleksandar
> > > >
> > > > > Aleksandar Markovic (2):
> > > > >   tests/acceptance: Refactor and improve reporting in
> > > > >     linux_ssh_mips_malta.py
> > > > >   tests/acceptance: Add new test cases in linux_ssh_mips_malta.py
> > > > >
> > > > >  tests/acceptance/linux_ssh_mips_malta.py | 81
> > > > ++++++++++++++++++++++++++------
> > > > >  1 file changed, 66 insertions(+), 15 deletions(-)
> > > > >
> > > > > --
> > > > > 2.7.4
> > > > >
> > > > >
> > >
> > > --
> > > Eduardo
