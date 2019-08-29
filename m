Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCBEC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE0F21726
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4CQ3GrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE0F21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3P6A-0003PS-VJ
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 14:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i3P26-0008Mp-Ji
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i3P22-0000qS-Hj
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:20:30 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:46633)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i3P1y-0000na-Ok
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:20:24 -0400
Received: by mail-ot1-x332.google.com with SMTP id z17so4319353otk.13
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 11:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=j+d3yuyXe4/5R5NXiXJ69H+E32lgwoAq3r9uw55Ecos=;
 b=a4CQ3GrAhh2qBWeFKYSEHrXDrNrTJAnIWaDCODRAFi8tMnTHzP9UPlqWdzBNXN9XcU
 N+LR7x33qTJ/od25Lr2Br9hFOOeCQho4HgmjvCRBbe0DTGh6q7zazftw1FmUBUKL6py0
 1Uf+z29DaYLN5QArkDvDxN4nOgIPeS5nPsPyRgbb4TEmPWVGALN5toV6txuatZ3YfSyZ
 aKwerAA8pmbkRAr6/vj+IgMxhKuyhfLKonyG2KMo/jyZWDmiUEPDU3mgdYuvmGtzXdkI
 5V+CszYgI0r5GbpCr9q8qPCkv8drJRaFor4hqqPWbewoWhOoCKWYHchYDgKS1oBctlo5
 MO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=j+d3yuyXe4/5R5NXiXJ69H+E32lgwoAq3r9uw55Ecos=;
 b=oKPNzR5el25y3Xu3HoZSa7XgfpK3thyoGo4JWlVLfq0PDgHMbJdXZQmRhtQRoQDfOc
 guVTZgPBe6qhsNXddYoe17ekf59YQxSQ/AEyJmKDyxtmS1JQ/5jp8Md4WcmpwojDk5GV
 R/hfkqcToyWQXnH464INyr7PhCDHglG1PzwKKi2Z7Myoq4+OSdZOehH/nrIOmdXQag68
 7zdUUk5mPD4hYRtQWjPKnkSuSe17TfUJl4k4k3KP1MF/CbgppEWBNxDFjar0XdTJmgQ4
 zIP9IW28Yte3G6TNZ0VY5ntQ6/1glWC16o3nG+7ok9VydqYMp2xhovYNhdJRkT+WyOBi
 oMEw==
X-Gm-Message-State: APjAAAUKdhErssUCXyqzBmCwOhAwvEv2bI4590gj335T2hl/njGTFNgP
 fAFQhplKvbiBhMjNjCgzAD3T+EMVsFv5jzEl504=
X-Google-Smtp-Source: APXvYqx+6ub5zb9nXW38jxVALg6XlpLCkUlX2V5OypIYNBBzcmTtAUUFVHyoeZrSUsCXWZnuYqEdA0mO4f68jE9bL/I=
X-Received: by 2002:a05:6830:4d6:: with SMTP id
 s22mr9233821otd.295.1567102821511; 
 Thu, 29 Aug 2019 11:20:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 29 Aug 2019 11:20:20
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 29 Aug 2019 11:20:20
 -0700 (PDT)
In-Reply-To: <20190828212425.GB11512@localhost.localdomain>
References: <1564760158-27536-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=hWc6G7Ob+LU7EWoY3LVBvABY2ky=RT28dSzqM=9O=OEA@mail.gmail.com>
 <20190821210030.GH7077@habkost.net>
 <CAL1e-=iZziwdyjJeaE-ZC2Rbjdmr_enYGBdK5zs4Lh0kN1DQOg@mail.gmail.com>
 <CAL1e-=gf-DOrdfN__Bxbx+B5NKu71ZTCypGEekoFc05WDaQjbw@mail.gmail.com>
 <20190828212425.GB11512@localhost.localdomain>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 29 Aug 2019 20:20:20 +0200
Message-ID: <CAL1e-=h71qaPjD2teWBW4gwqX=1_tBqjwirWUEi-gcEK6=mS=w@mail.gmail.com>
To: Cleber Rosa <crosa@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, f4bug@amsat.org,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.08.2019. 23.24, "Cleber Rosa" <crosa@redhat.com> =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Thu, Aug 22, 2019 at 07:59:07PM +0200, Aleksandar Markovic wrote:
> > 22.08.2019. 05.15, "Aleksandar Markovic" <aleksandar.m.mail@gmail.com>
=D1=98=D0=B5
> > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > >
> > >
> > > 21.08.2019. 23.00, "Eduardo Habkost" <ehabkost@redhat.com> =D1=98=D0=
=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > > >
> > > > On Wed, Aug 21, 2019 at 10:27:11PM +0200, Aleksandar Markovic wrote=
:
> > > > > 02.08.2019. 17.37, "Aleksandar Markovic" <
> > aleksandar.markovic@rt-rk.com> =D1=98=D0=B5
> > > > > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > > > > >
> > > > > > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> > > > > >
> > > > > > This little series improves linux_ssh_mips_malta.py, both in th=
e
> > sense
> > > > > > of code organization and in the sense of quantity of executed
tests.
> > > > > >
> > > > >
> > > > > Hello, all.
> > > > >
> > > > > I am going to send a new version in few days, and I have a
question
> > for
> > > > > test team:
> > > > >
> > > > > Currently, the outcome of the script execition is either PASS:1
> > FAIL:0 or
> > > > > PASS:0 FAIL:1. But the test actually consists of several
subtests. Is
> > there
> > > > > any way that this single Python script considers these subtests a=
s
> > separate
> > > > > tests (test cases), reporting something like PASS:12 FAIL:7? If
yes,
> > what
> > > > > would be the best way to achieve that?
> > > >
> > > > If you are talking about each test_*() method, they are already
> > > > treated like separate tests.  If you mean treating each
> > > > ssh_command_output_contains() call as a separate test, this might
> > > > be difficult.
> > > >
> > >
> > > Yes, I meant the latter one, individual code segments involving an
> > invocation of ssh_command_output_contains() instance being treated as
> > separate tests.
> > >
> >
> > Hello, Cleber,
> >
> > I am willing to rewamp python file structure if needed.
> >
> > The only thing I feel a little unconfortable is if I need to reboot the
> > virtual machine for each case of ssh_command_output_contains().
> >
>
> Hi Aleksandar,
>
> The short answer is that Avocado provides no way to report "subtest"
> statuses (as a formal concept), neither does the current
> "avocado_qemu" infrastructure allow for management of VMs across
> tests.  The later is an Avocado-VT feature, and it to be honest it
> brings a good deal of problems in itself, which we decided to avoid
> here.
>
> About the lack of subtests, we (the autotest project, then the Avocado
> project) found that this concept, to be well applied, need more than
> we could deal with initially.  For instance, Avocado has the concept
> of "pre_test" and "post_test" hooks, with that, should those be
> applied to subtests as well?  Also, there's support for capturing
> system information (a feature called sysinfo) before and after the
> tests... again, should it be applied to subtests?  Avocado also stores
> a well defined results directory, and we'd have to deal with something
> like that for subtests.  With regards to the variants feature, should
> they also be applied to subtests?  The list of questions goes on and
> on.
>
> The fact that one test should not be able (as much as possible) to
> influence another test also comes into play in our initial decision
> to avoid subtests.
>
> IMO, the best way to handle this is to either keep a separate logger
> with the test progress:
>
>
https://avocado-framework.readthedocs.io/en/71.0/WritingTests.html#advanced=
-logging-capabilities
>
> With a change similar to:
>
> ---
> diff --git a/tests/acceptance/linux_ssh_mips_malta.py
b/tests/acceptance/linux_ssh_mips_malta.py
> index 509ff929cf..0683586c35 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -17,6 +17,7 @@ from avocado_qemu import Test
>  from avocado.utils import process
>  from avocado.utils import archive
>
> +progress_log =3D logging.getLogger("progress")
>
>  class LinuxSSH(Test):
>
> @@ -149,6 +150,7 @@ class LinuxSSH(Test):
>          stdout, _ =3D self.ssh_command(cmd)
>          for line in stdout:
>              if exp in line:
> +                progress_log.info('Check successful for "%s"', cmd)
>                  break
>          else:
>              self.fail('"%s" output does not contain "%s"' % (cmd, exp))
> ---
>
> You could run tests with:
>
>   $ ./tests/venv/bin/avocado --show=3Dconsole,progress run
--store-logging-stream progress -- tests/acceptance/linux_ssh_mips_malta.py
>
> And at the same time:
>
>   $ tail -f ~/avocado/job-results/latest/progress.INFO
>   17:20:44 INFO | Check successful for "uname -a"
>   17:20:44 INFO | Check successful for "cat /proc/cpuinfo"
>   ...
>
> I hope this helps somehow.
>
> Best regards,
> - Cleber.
>

Thanks, Cleber, for your detailed response. I'll use whatever is available,
along the lines you highligted. I will most likely gradually modify this
test until I find the sweet spot where I am satisfied with test behavior
and reporting, but also everything fits well into Avocado framework.

Thanks again, both to you and Eduardo,
Aleksandar

> > Grateful in advance,
> > Aleksandar
> >
> > > > Cleber, is there something already available in the Avocado API
> > > > that would help us report more fine-grained results inside each
> > > > test case?
> > > >
> > >
> > > Thanks, that would be a better way of expressing my question.
> > >
> > > >
> > > > >
> > > > > Thanks in advance,
> > > > > Aleksandar
> > > > >
> > > > > > Aleksandar Markovic (2):
> > > > > >   tests/acceptance: Refactor and improve reporting in
> > > > > >     linux_ssh_mips_malta.py
> > > > > >   tests/acceptance: Add new test cases in
linux_ssh_mips_malta.py
> > > > > >
> > > > > >  tests/acceptance/linux_ssh_mips_malta.py | 81
> > > > > ++++++++++++++++++++++++++------
> > > > > >  1 file changed, 66 insertions(+), 15 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.7.4
> > > > > >
> > > > > >
> > > >
> > > > --
> > > > Eduardo
