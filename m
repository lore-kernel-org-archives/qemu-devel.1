Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39B7C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 20:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA69A22DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 20:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anCiP+DQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA69A22DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0XD1-0005AU-Vc
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 16:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0XCN-0004kc-7w
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0XCL-0004fU-5B
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:27:15 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44210)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i0XCL-0004f2-0U
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:27:13 -0400
Received: by mail-ot1-x344.google.com with SMTP id w4so3297835ote.11
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 13:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=JDCc7gULav1TTulhVx4N0uvNHX96QLHd6afN0FRmvXo=;
 b=anCiP+DQtX3Opfg98AmESJe68RHB3V7v1eAS3kiNwGNiRRRM+fPepPMdQGJ1Wy01qu
 XeBbaAXL2+cs7mLVUG4GU0+gOjtu+aaDOI6FO2580hjLKcz4dflNx3E1a31oPbw/fLkP
 z2WOaFgIq7m52Je5joK8cFehc8n6zYUXYqCkz7u+WNsuEHXxmaQkZiD658PXKcjOK0EL
 sZlNKI+dXYh/UAX8L0CscFmZ9NIyEmBJKLhSGi1Bk04wNzj0KotZaEkWW7BJtd39CoNv
 Dt/MG+GXzZeLcSkXIBaFb1mpNaNeOClqnb0maeRjOkAKHDbDmvCEgH1j+qSYTQxHJahp
 x7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=JDCc7gULav1TTulhVx4N0uvNHX96QLHd6afN0FRmvXo=;
 b=ubE7OD4Mfw8TiKYLWiW1vzRJpWJOmop0P+ZJI+WZ41XxK8eVDwI6d2y0UNzwtimMWu
 QtUwJydagGIxtfR5daAc9vIbMiYzZLZq3hSlSafv5Mw00q88lPL8DEn2AiHTa2t6j2VM
 v5ZwRnYrA3c0+PUnfUH/0LDmRlZJahfUksvy9uWYCMJpz4HD3/3B2vxjitVqdcEAQxvi
 pY7exsTHfO9VGI0Yw+1U7RnCVEf3Hz47FvqChyHjqxzD3xDElN50q6mvRtQlIih2FEm4
 xwGQO0MrPh4MG7+zvWaHVE3KUX+/J/2XiaNkXzmItF78V0O5zR/AixRiS/STSj6+gjqG
 gTpQ==
X-Gm-Message-State: APjAAAXN88eZ8pfGxXILlSNodfidxAybnrLuPGe/K3w/BSurFooPN6D4
 kXgjsPEzkT8KfcDy1+Ct6pL2R4j0jTZy6LE4EOw=
X-Google-Smtp-Source: APXvYqxIct9RZ9bnKRLBt69hSqGRbQ2IjfP3/nup1eSxpLQ4s06mp2FpB4jOUVQXJYZT/I9ijBgoqMkECaz9KODwIP8=
X-Received: by 2002:a9d:1288:: with SMTP id g8mr303986otg.306.1566419231978;
 Wed, 21 Aug 2019 13:27:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Wed, 21 Aug 2019 13:27:11
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Wed, 21 Aug 2019 13:27:11
 -0700 (PDT)
In-Reply-To: <1564760158-27536-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1564760158-27536-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 21 Aug 2019 22:27:11 +0200
Message-ID: <CAL1e-=hWc6G7Ob+LU7EWoY3LVBvABY2ky=RT28dSzqM=9O=OEA@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: ehabkost@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 f4bug@amsat.org, crosa@redhat.com, amarkovic@wavecomp.com, ccarrara@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.08.2019. 17.37, "Aleksandar Markovic" <aleksandar.markovic@rt-rk.com> =
=D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> This little series improves linux_ssh_mips_malta.py, both in the sense
> of code organization and in the sense of quantity of executed tests.
>

Hello, all.

I am going to send a new version in few days, and I have a question for
test team:

Currently, the outcome of the script execition is either PASS:1 FAIL:0 or
PASS:0 FAIL:1. But the test actually consists of several subtests. Is there
any way that this single Python script considers these subtests as separate
tests (test cases), reporting something like PASS:12 FAIL:7? If yes, what
would be the best way to achieve that?

Thanks in advance,
Aleksandar

> Aleksandar Markovic (2):
>   tests/acceptance: Refactor and improve reporting in
>     linux_ssh_mips_malta.py
>   tests/acceptance: Add new test cases in linux_ssh_mips_malta.py
>
>  tests/acceptance/linux_ssh_mips_malta.py | 81
++++++++++++++++++++++++++------
>  1 file changed, 66 insertions(+), 15 deletions(-)
>
> --
> 2.7.4
>
>
