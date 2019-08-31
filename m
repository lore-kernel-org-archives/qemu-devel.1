Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742D7C3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 01:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3135323431
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 01:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="M+JzsVcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3135323431
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3sCT-0001tB-AX
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 21:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jkz@google.com>) id 1i3sAe-0001Is-VM
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 21:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jkz@google.com>) id 1i3sAa-000115-UT
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 21:27:16 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:36810)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jkz@google.com>) id 1i3sAa-0000qO-Ei
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 21:27:12 -0400
Received: by mail-lj1-x244.google.com with SMTP id u15so8055830ljl.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 18:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0bePa13kNaMutq5/z+1LHE8Cnf4z6IufvknZ2NESa8I=;
 b=M+JzsVcJwO0gXOEToBYJ100m4ztrxF2VJSOIOxDVYeenfttSmo6Z6PpEo5kF7zxKS2
 PyzcTFC64oP0dDlrew0dzwc2yxx7Ho7ziwDGQ02kp4KD4F7Q5kKkQ2oHU3nczyWwY/3R
 WFQyf/Z1zX8N1wpNXXa0T4d1wjQltSTwnsEEPN69S3Ps5gQG81KZ6kfHLUjlPvBUxokw
 N6axo06RjPRkYi09L9qWLVEmFf+FqH0purkWDZh0/T1nyZdAo+DxgR30+4mcXmwWZ0bq
 HgRkCaK+Q2+5ZweCOllNzvxv3byacrelhCjLIiC4lqzyJjsMKq8Lx1Tjh5OIqfkgIGcB
 rxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0bePa13kNaMutq5/z+1LHE8Cnf4z6IufvknZ2NESa8I=;
 b=oFRlbnE47CciX3cOCBKZVORcZjQkSEtSj23ZHQKW106SNi1hHa8G2FaqvqE5EKyTEL
 klkleWmZz7F8Keq+cK8113NneCZuc/iIHJdIoF5YmdSXsXyHx2NIoIJBqyc+7TIhNH7p
 ZIiaDkreMYvRjIBe5g0xPIi0Ac1rQUkyy/KYRSFwAafFGQXJFPTundT/gfU3tPH2Ggtb
 H5PBIolZ3a4BpZAJCKUiARVhk6r5EG3m0VKhDv/wO8iNdTgB5cWGvd2/8KSQna+sUMSL
 +EdUb+EQFI2hFLve0lM8Q0Bj+nScos/iKpvmT4BisqLKj6msddip+N3d5f3O2uyVCXer
 TJ9A==
X-Gm-Message-State: APjAAAWnqmfh0FthOBC7r5n8lPbBww1yNQWEV/EXo6GRYTBW1oB+c6Du
 omsMX3g4EsjW4YhqfeaMnapa/atbmP0h6RMlZcayIQ==
X-Google-Smtp-Source: APXvYqw47p5Tmw2t2f6mN77B0uEu8x2HgT4j9HTQ6FgvWAR0ueoxaU7zW6oWfEwix2eEgHhnqdBy7wzKfD83bL6NQng=
X-Received: by 2002:a2e:b16d:: with SMTP id a13mr9851410ljm.1.1567214827995;
 Fri, 30 Aug 2019 18:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <CADgy-2vznasvwaUwNSi96Sy=ucPC=-3e=O9irqc5DSpV_uhWUg@mail.gmail.com>
 <abf5f3b6-7c05-a85b-051f-9905b8f50041@vivier.eu>
 <CADgy-2va2xVmO_a1gDwg+zkpNcLJTW5D1j=2kk1TnRMxyPaLMg@mail.gmail.com>
 <6542ac57-6b06-1337-825b-dd1187accd15@vivier.eu>
 <BN6PR2201MB125123754144B7214725BF05C6A30@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB125123754144B7214725BF05C6A30@BN6PR2201MB1251.namprd22.prod.outlook.com>
Date: Fri, 30 Aug 2019 18:26:57 -0700
Message-ID: <CADgy-2vkeDa2kPsamm=K=uceqo30A2n53AUfND4Dx3CifQeJAw@mail.gmail.com>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [EXTERNAL]Re: patch to swap SIGRTMIN + 1 and
 SIGRTMAX - 1
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
From: Josh Kunz via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Josh Kunz <jkz@google.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "marlies.ruck@gmail.com" <marlies.ruck@gmail.com>,
 Petar Jovanovic <pjovanovic@wavecomp.com>,
 "milos.stojanovic@rt-rk.com" <milos.stojanovic@rt-rk.com>,
 Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I can take over the series. I'll rebase the patch set, and update it to
address the SIGRTMIN - 1 issue. I should have an update sometime next week.

On Wed, Aug 28, 2019 at 10:31 AM Aleksandar Markovic <amarkovic@wavecomp.co=
m>
wrote:

> > From: Laurent Vivier <laurent@vivier.eu>
> > Sent: Wednesday, August 28, 2019 10:51 AM
> > To: Josh Kunz; Aleksandar Markovic; milos.stojanovic@rt-rk.com
> > Cc: marlies.ruck@gmail.com; qemu-devel@nongnu.org; riku.voipio@iki.fi;
> > qemu-trivial@nongnu.org; Peter Maydell; Shu-Chun Weng; Aleksandar
> Markovic
> > Subject: [EXTERNAL]Re: [Qemu-devel] patch to swap SIGRTMIN + 1 and
> SIGRTMAX - 1
> >
> > Le 26/08/2019 =C3=A0 23:10, Josh Kunz a =C3=A9crit :
> > > On Wed, Aug 21, 2019 at 2:28 AM Laurent Vivier <laurent@vivier.eu
> > > <mailto:laurent@vivier.eu>> wrote:
> > >
> > >     Le 19/08/2019 =C3=A0 23:46, Josh Kunz via Qemu-devel a =C3=A9crit=
 :
> > >     > Hi all,
> > >     >
> > >     > I have also experienced issues with SIGRTMIN + 1, and am
> interested in
> > >     > moving this patch forwards. Anything I can do here to help?
> Would the
> > >     > maintainers prefer myself or Marli re-submit the patch?
> > >     >
> > >     > The Go issue here seems particularly sticky. Even if we update
> the Go
> > >     > runtime, users may try and run older binaries built with older
> > >     versions of
> > >     > Go for quite some time (months? years?). Would it be better to
> > >     hide this
> > >     > behind some kind of build-time flag
> > >     (`--enable-sigrtmin-plus-one-proxy` or
> > >     > something), so that some users can opt-in, but older binaries
> > >     still work as
> > >     > expected?
> > >     >
> > >     > Also, here is a link to the original thread this message is in
> > >     reply to
> > >     > in-case my mail-client doesn't set up the reply properly:
> > >     >
> https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg01303.html
> > >
> > >     The problem here is we break something to fix something else.
> > >
> > >     I'm wondering if the series from Aleksandar Markovic, "linux-user=
:
> > >     Support signal passing for targets having more signals than host"
> [1]
> > >     can fix the problem in a better way?
> > >
> > >
> > > That patch[1] (which I'll refer to as the MUX patch to avoid confusio=
n)
> > > does not directly fix the issue addressed by this patch (re-wiring
> > > SIGRTMIN+1), but since it basically implements generic signal
> > > multiplexing, it could be re-worked to address this case as well. The
> > > way it handles `si_code` spooks me a little bit. It could easily be
> > > broken by a kernel version change, and such a breakage could be hard =
to
> > > detect or lead to surprising results. Other than that, it looks like =
a
> > > reasonable implementation.
> > >
> > > That said, overall, fixing the SIGRTMIN+1 issue using a more-generic
> > > signal-multiplexing mechanism doesn't seem *that* much better to me. =
It
> > > adds a lot of complexity, and only saves a single signal (assuming
> glibc
> > > doesn't add more reserved signals). The "big win" is additional
> > > emulation features, like those introduced in MUX patch (being able to
> > > utilize signals outside of the host range). If having those features =
in
> > > QEMU warrants the additional complexity, then re-working this patch
> > > on-top of that infrastructure seems like a good idea.
> > >
> > > If the maintainers want to go down that route, then I would be happy =
to
> > > re-work this patch utilizing the infrastructure from the MUX patch.
> > > Unfortunately it will require non-trivial changes, so it may be best =
to
> > > wait until that patch is merged. I could also provide a patch "on top
> > > of" the MUX patch, if that's desired/more convenient.
> > >
> > > Just one last note, if you do decide to merge the MUX patch, then it
> > > would be best to use SIGRTMAX (instead of SIGRTMAX-1) as the
> > > multiplexing signal if possible, to avoid breaking go binaries.
> > >
> >
> > Personally, I prefer a solution that breaks nothing.
> >
> > Aleksandar, Milos,
> >
> > do you have an updated version of you series "Support signal passing fo=
r
> > targets having more signals than host"?
> >
>
> Milos is unfortunetely working on an entirely different project now, and
> can't spare enough time to finish the series. I am also busy with other
> issues, even though I would like very much this or equivalent solution to
> be integrated. Alternatively, someone in the team may have time later thi=
s
> year, but I do not know that yet  - perhaps somebody else (Josh) can take
> over the series?
>
> Sincerely,
> Aleksandar
>
>
> > Thanks,
> > Laurent
> >
