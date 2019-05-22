Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A7AC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD7A20881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+153EI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD7A20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52811 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZzf-0006bK-9R
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 18:45:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTZyA-0005Wh-Qf
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTZxl-0007aD-CY
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:43:59 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hTZxk-0007Z0-7C
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:43:57 -0400
Received: by mail-ot1-x344.google.com with SMTP id l25so3626779otp.8
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=OlOUouevvTvvJX8q6R7EhDyGPuQTGfA90JYlpsBmV/Q=;
	b=o+153EI5LzpUX6i+2b1z9/iFn//jIF4wfZCm8ggCJqeLmn7R/m9MABm2Rzn9cD3vyk
	DtyH47ziYCcQSESW0gfPoe+DvYYyPmZpTVNc9doL3yOM3wTmB80tgaZkmbku8/ijoj0W
	3Vy6ddjXItQf1H1jiA62ZhYG9Tz4wWNOB1zO+3llnFYrjPlV/06fmagpA3p6+fMnn+ye
	bqfR5nimlcKLBi+rZ67Y+bzxmEGYnvje6vAHRTuO+zoGGqHVn5cuB6KL3Rpb3pYNaReD
	bm2tWAQ+3lT7q/KCIDgQL5UJFJezil9HxbCqzXY9akEWuB1xObYiH4PuELL1KQt3R1Pc
	Gpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=OlOUouevvTvvJX8q6R7EhDyGPuQTGfA90JYlpsBmV/Q=;
	b=QKOEfJygNkpqmv9ky+O4AMelRHm928UVBxyoNelj/WsKyfprBBmACTAMhp/fs8+O01
	XJS9gNnm68J3ZHz502UsyMFK0MuMOYkKnii0tapYfixsUffGrSvmN9A0CwOOx4K5Ay/J
	n+ewI6mpwo8BTYDFq6U/b5HvLXj3eo+WASYz63p0Cvk/XSpe+fjd5iqL6r2wLxug96SO
	Qrhg/mnR7ZVX6VkOO2qaSM/MQGCAlq3ThyH7psVZNCmQvJtY8OcixXZW9fXU5WRWa2XB
	OnN1FWZRzWrSWKKVlGVoGWRAuvxwCwI7uhSZeI7Fis6clREt39Gwg/p2A1BQzByVZN86
	Bd9Q==
X-Gm-Message-State: APjAAAWETPZkt5brkaVz0JZPxy7SoukAP2n7ghlfYqqsftAb68okRIqt
	8m80XQTXtm1D7zO4arZOjhuEsG91OsKb35ejOBI=
X-Google-Smtp-Source: APXvYqw0SeljVDyaENJehbvdh2zk/OsyymZ/U/KtFY430eqwQRQyLZHdlCsJLic7xMLBqRbCPYhgMR9SYTcRKWra8dM=
X-Received: by 2002:a05:6830:160a:: with SMTP id
	g10mr89975otr.121.1558565034587; 
	Wed, 22 May 2019 15:43:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Wed, 22 May 2019 15:43:54
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Wed, 22 May 2019 15:43:54
	-0700 (PDT)
In-Reply-To: <1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190522211230.GA10764@habkost.net>
	<1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 23 May 2019 00:43:54 +0200
Message-ID: <CAL1e-=iW2honEgNfrsFoA0tU1wMq0mw5LuoRbWVmRDBMA22ELA@mail.gmail.com>
To: Cleber Rosa <crosa@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 0/4] mips: Add more Avocado tests
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 22, 2019 11:46 PM, "Cleber Rosa" <crosa@redhat.com> wrote:
>
>
>
> ----- Original Message -----
> > From: "Eduardo Habkost" <ehabkost@redhat.com>
> > To: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> > Cc: qemu-devel@nongnu.org, "Aleksandar Rikalo" <arikalo@wavecomp.com>,
"Aleksandar Markovic"
> > <aleksandar.m.mail@gmail.com>, "Aleksandar Markovic" <
amarkovic@wavecomp.com>, "Cleber Rosa" <crosa@redhat.com>,
> > "Aurelien Jarno" <aurelien@aurel32.net>, "Wainer dos Santos Moschetta" =
<
wainersm@redhat.com>
> > Sent: Wednesday, May 22, 2019 5:12:30 PM
> > Subject: Re: [Qemu-devel] [PATCH 0/4] mips: Add more Avocado tests
> >
> > On Tue, May 21, 2019 at 01:19:06AM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > > Hi,
> > >
> > > It was a rainy week-end here, so I invested it to automatize some
> > > of my MIPS tests.
> > >
> > > The BootLinuxSshTest is not Global warming friendly, it is not
> > > meant to run on a CI system but rather on a workstation previous
> > > to post a pull request.
> > > It can surely be improved, but it is a good starting point.
> >
> > Until we actually have a mechanism to exclude the test case on
> > travis-ci, I will remove patch 4/4 from the queue.  Aleksandar,
> > please don't merge patch 4/4 yet or it will break travis-ci.
> >
> > Cleber, Wainer, is it already possible to make "avocado run" skip
> > tests tagged with "slow"?
> >
>
> The mechanism exists, but we haven't tagged any test so far as slow.
>

Cleber,

For the test from patch 4/4, there is no dilemma - it should be in the
=E2=80=9Cslow=E2=80=9D group, as Philippe envisioned and said, so that it i=
s not humpered
with stricter requirements for =E2=80=9Cfast=E2=80=9D (default) group. Coul=
d you explain us
how to do it, so that we can hopefully finally proceed?

Gratefully,
Aleksandar

> Should we define/document a criteria for a test to be slow?  Given
> that this is highly subjective, we have to think of:
>
>  * Will we consider the average or maximum run time (the timeout
>    definition)?
>
>  * For a single test, what is "slow"? Some rough numbers from Travis
>    CI[1] to help us with guidelines:
>    - boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:  PASS (6.04 s=
)
>    - boot_linux_console.py:BootLinuxConsole.test_arm_virt:  PASS (2.91 s)
>    -
linux_initrd.py:LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_1=
6:
PASS (18.14 s)
>    - boot_linux.py:BootLinuxAarch64.test_virt:  PASS (396.88 s)
>
>  * Do we want to set a maximum job timeout?  This way we can skip
>    tests after a given amount of time has passed.  Currently we interrupt
>    the test running when the job timeout is reached, but it's possible
>    to add a option so that no new tests will be started, but currently
>    running ones will be waited on.
>
> Regards,
> - Cleber.
>
> [1] - https://travis-ci.org/clebergnu/qemu/jobs/535967210#L3518
>
> > --
> > Eduardo
> >
