Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78335C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:00:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437842089E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzeVpYmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437842089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0rNe-0006Av-Bq
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 14:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0rMd-0005m4-Rp
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0rMb-0004aN-CO
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:59:11 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33974)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i0rMb-0004Zt-5E
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:59:09 -0400
Received: by mail-oi1-x241.google.com with SMTP id g128so5060739oib.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=auHWgjJeCtop6GGtyshBCKmJ0h9gfb9lVolcIb4uZg4=;
 b=XzeVpYmYZAZsYsNzeqDvTIDj+l03/CTTbO1Vw0Zcoxd7OVaNg6hEa2FL+zIj9/Lngf
 JX2nhZHP0gzYTrgs3GSeMtfZg5N8VEleelrRo5b0WJrQiXQUc0B8AsSV9CQEqAcnC9hZ
 QoLUm/0hXOXYTeqr/CPqELmm0PimXejoWBGG8M2bavbCLNIEtkluut19xve4LzMt3gLP
 F+riqTsSsNjlCoOgIfYhgLxmq3uxkT+uvcNb9W8W7aC54ke+Cye8CuZio40Wl3a7ffNi
 LokUVVeePAzXqnqu2b9FXpJYGuikXU1I+nvmWkmJREcWf/Pp8uXEqJWBqG64loloxK6O
 rjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=auHWgjJeCtop6GGtyshBCKmJ0h9gfb9lVolcIb4uZg4=;
 b=KqN+8oz57ZB3g7NKI5U8Qd2ORzTjogxsa4hg9saSO86kb4HkSsBUo+aGVhmTp+oxFa
 S82DYzTCGonbHuqAEDIdde7BWDUGyppJTKNYkw4gWamv7wnN7Zwl3xmVq5D1sWqfRoUV
 gdzMVtSYGi4G3W3KN1ZqtO/4ql8b/kzGIeUdOq1XhJXHn2wxjNiN6UKJMGP3yfTcrAg/
 lX0rpzn+CfAAwT+WE+AMqUOy/pMgea0iFjFhzX4mzkSweZwvO2YzeSM0CBaF0SQNBGOS
 s/xt8xoED2jf/HjN6241KsDcZKawWft/3sQhggacFdEIgJZRkocZlh/btceBZpvHHCzz
 0MMg==
X-Gm-Message-State: APjAAAWASruSAZg2tsl9OpFO4OOt2JGW6OUmbNZJYzsGMNYRYroJ7xA+
 DXHGIrDiuLFRFJBbexXXm+QaLQkILZzQ6d5VUQ4=
X-Google-Smtp-Source: APXvYqx4mIii5EL3QWEqs3dWtMgNkfob8TD4Nms2LcpUoM8rNoaFzBOqHgLu0PN1M1hAHrNY+ZhXq2s+cTURlG1T6Oc=
X-Received: by 2002:a05:6808:8cd:: with SMTP id
 k13mr277345oij.136.1566496748318; 
 Thu, 22 Aug 2019 10:59:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 22 Aug 2019 10:59:07
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 22 Aug 2019 10:59:07
 -0700 (PDT)
In-Reply-To: <CAL1e-=iZziwdyjJeaE-ZC2Rbjdmr_enYGBdK5zs4Lh0kN1DQOg@mail.gmail.com>
References: <1564760158-27536-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=hWc6G7Ob+LU7EWoY3LVBvABY2ky=RT28dSzqM=9O=OEA@mail.gmail.com>
 <20190821210030.GH7077@habkost.net>
 <CAL1e-=iZziwdyjJeaE-ZC2Rbjdmr_enYGBdK5zs4Lh0kN1DQOg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 22 Aug 2019 19:59:07 +0200
Message-ID: <CAL1e-=gf-DOrdfN__Bxbx+B5NKu71ZTCypGEekoFc05WDaQjbw@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

22.08.2019. 05.15, "Aleksandar Markovic" <aleksandar.m.mail@gmail.com> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
> 21.08.2019. 23.00, "Eduardo Habkost" <ehabkost@redhat.com> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > On Wed, Aug 21, 2019 at 10:27:11PM +0200, Aleksandar Markovic wrote:
> > > 02.08.2019. 17.37, "Aleksandar Markovic" <
aleksandar.markovic@rt-rk.com> =D1=98=D0=B5
> > > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > > >
> > > > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> > > >
> > > > This little series improves linux_ssh_mips_malta.py, both in the
sense
> > > > of code organization and in the sense of quantity of executed tests=
.
> > > >
> > >
> > > Hello, all.
> > >
> > > I am going to send a new version in few days, and I have a question
for
> > > test team:
> > >
> > > Currently, the outcome of the script execition is either PASS:1
FAIL:0 or
> > > PASS:0 FAIL:1. But the test actually consists of several subtests. Is
there
> > > any way that this single Python script considers these subtests as
separate
> > > tests (test cases), reporting something like PASS:12 FAIL:7? If yes,
what
> > > would be the best way to achieve that?
> >
> > If you are talking about each test_*() method, they are already
> > treated like separate tests.  If you mean treating each
> > ssh_command_output_contains() call as a separate test, this might
> > be difficult.
> >
>
> Yes, I meant the latter one, individual code segments involving an
invocation of ssh_command_output_contains() instance being treated as
separate tests.
>

Hello, Cleber,

I am willing to rewamp python file structure if needed.

The only thing I feel a little unconfortable is if I need to reboot the
virtual machine for each case of ssh_command_output_contains().

Grateful in advance,
Aleksandar

> > Cleber, is there something already available in the Avocado API
> > that would help us report more fine-grained results inside each
> > test case?
> >
>
> Thanks, that would be a better way of expressing my question.
>
> >
> > >
> > > Thanks in advance,
> > > Aleksandar
> > >
> > > > Aleksandar Markovic (2):
> > > >   tests/acceptance: Refactor and improve reporting in
> > > >     linux_ssh_mips_malta.py
> > > >   tests/acceptance: Add new test cases in linux_ssh_mips_malta.py
> > > >
> > > >  tests/acceptance/linux_ssh_mips_malta.py | 81
> > > ++++++++++++++++++++++++++------
> > > >  1 file changed, 66 insertions(+), 15 deletions(-)
> > > >
> > > > --
> > > > 2.7.4
> > > >
> > > >
> >
> > --
> > Eduardo
