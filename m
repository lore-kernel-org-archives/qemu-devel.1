Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA17C46460
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 21:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D6721880
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 21:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn/J4gL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D6721880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52102 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZGA-0002gY-OA
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 17:58:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTZFJ-0002Nv-UE
	for qemu-devel@nongnu.org; Wed, 22 May 2019 17:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTZFD-0002DH-CW
	for qemu-devel@nongnu.org; Wed, 22 May 2019 17:57:58 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hTZFC-00028L-6x
	for qemu-devel@nongnu.org; Wed, 22 May 2019 17:57:54 -0400
Received: by mail-ot1-x341.google.com with SMTP id s19so3555404otq.5
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=Nxu3nM6JQATsXenbo28ILo5w2+/YToahHApGltRjDJQ=;
	b=Cn/J4gL6Ro27U7u6WlPvBeENH3hE35hTJw4Rcsteg71CzBHYwmxH6nj413uHA9spYw
	iqKuvJZKUHK8+vhQ0YtV4tlDzfl33ZDHmmogUGEz/jOag+3UhjX102Lq478sXvtYP++g
	TPx6QZ3+AFiJTwW9iqldBgpRI9VNgbfXg6r04QJJvYEnJ3KKNE0I3JfHIb+Bx2wzCmHm
	wWqZ4oZU3g87xi+3vXlhwMj+VtsUgm6XjibTA+T4PZ9atnQoRmu5WrfapCXo5jR2wPi8
	lG+B5NmXnemS9yA28eiFexX+SiudPkPopfUFxkg0hesy5dIUVBrFwAQaD3ssalGPNhXy
	I5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=Nxu3nM6JQATsXenbo28ILo5w2+/YToahHApGltRjDJQ=;
	b=Xkftg1kNAMWP4dwEVO4w7/HOomPbDAD9pxJ4qokg1xcYnaFE2hbUfj3yUjUBKYsYKR
	ri1pv3P40ezL1YLhM7RZPqrYS2LeJGcRLZGbDU5Hgj2yOV9VAMwZJ6iSHHYfQNvFm6TE
	9rDzwU8N/1wZxNHQkOJf9i/4ETzJ3kQI59GNN9tq8djYWzyiBWgMUT5wngMDSShXA3KU
	+uPLnwsKfExwDOW8vZnUPxv/WQmDMjSUMJ+qSENTTp2oSMZAXb7verxUXOXYG7LrdTAS
	WbfPSW5JgApGUNrk0klxrhPljyPS7thdJjHh87QLwEfZAWYUJRAAouVjZgWAZVxm62zT
	uhGQ==
X-Gm-Message-State: APjAAAVpUc3BpYgKMhaHiNdyFJ/t8NXgPh42RLeWljlACIYkdJXPCr9c
	HK1YwfNz2nG03IPIrlPIZIpfqctF26okLGtrKpM=
X-Google-Smtp-Source: APXvYqwocv3JTgJT+SW4GsN2eSNVt1xxX6BTLmyPzcJU/rNQns/sphI0kmds2mbhuuyZx66N2WjYe5hQP8B0MDQDOzY=
X-Received: by 2002:a9d:61d5:: with SMTP id h21mr22854769otk.306.1558562269572;
	Wed, 22 May 2019 14:57:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Wed, 22 May 2019 14:57:48
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Wed, 22 May 2019 14:57:48
	-0700 (PDT)
In-Reply-To: <1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190522211230.GA10764@habkost.net>
	<1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 22 May 2019 23:57:48 +0200
Message-ID: <CAL1e-=hD20ZwJgmD3M9YhOvq30Lgn33T3m+yaULw7+wrLQT9kg@mail.gmail.com>
To: Cleber Rosa <crosa@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

As far as integrating the patch into my queue, I did it just an hour or so
prior the objections of others, but will inform Peter to put the pull
request on hold, so it will not go to the main tree.

We in Wave Computing (MIPS) are very happy with this test, even in its
current state, and understand it as an initial version that will be subject
to improvement and expansion. We consider this test seriously and think it
is vital for QEMU for MIPS.

We would like to put it in the =E2=80=9Cslow=E2=80=9D group for the simple =
reason that, we
gather, this would give us more freedom in future versions.

Yours,
Aleksandar

> Regards,
> - Cleber.
>
> [1] - https://travis-ci.org/clebergnu/qemu/jobs/535967210#L3518
>
> > --
> > Eduardo
> >
