Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62143C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A42521532
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2tyO2xQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A42521532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlajr-000275-F9
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jlajC-0001VI-Ss
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:15:54 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:45801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jlajA-0000uo-37
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:15:54 -0400
Received: by mail-lj1-x243.google.com with SMTP id i27so3533495ljb.12
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 09:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aNXYVevqpno0rZgaFhW0H9vgubYCkuw25VgOHyKz9Dg=;
 b=A2tyO2xQVl/CW2CyHDFgQp3XYziWAqFKKINOUVUWc8euzXWAACUvROD1Q14bzeQgnC
 a+aPWJkimIW+dcpLGHYtEcm5CFM2sJuhl9mCWVbRu9xGmFw4gERdpEfG+FPbn/7/MDZR
 3Ng68pAXJTVeVaUpjBbU8wHvwEV3NJRZrYYb7w6WSckQF+JMEqUCuuj4/pf4Q6uI3EiR
 4kUXYIxeMfxhcVoho744qLfQP0k8JAi40pN3+9u6HFeWkJTcEpW4VxfL86Ua8s+49OWR
 ozNdjmQvVq4cUewAo3Pz7dqkAM8SI2zq5h0bjKtYzsGvstUzW8ai29SWwwR+bl7V1C4o
 D+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aNXYVevqpno0rZgaFhW0H9vgubYCkuw25VgOHyKz9Dg=;
 b=tDh+J72veC6/Bhzu6li8BkpJFPsZYKMmT8/H1BHR3Ckwt6a6r8I65kebi1o9xo2/4y
 RqGMmRXp3k8adDcAXoCXev8TMTAExJk20ozO/mOac7FDMo8MMU/aL/Gvu2/taXE0pctV
 c2U/esVG/+uh9z28XD2SKW75saTsdP1sMAdF461/s9jG0zf9DfnUgUpw85fjpBrtWrh6
 /utGmAXPKiuWEb9PDmK5cYgKpz6PwWm4Z+XDWsrj30RoO6xhe0CNmfpnOgqRUYGVV1x+
 9316RsJmRlB4hy1D/Odnq0XgEkHUdV4UBmpzfbLxmGtN62g17OSbnaTUrLymCIaIs3n4
 TnXQ==
X-Gm-Message-State: AOAM530yA/filxkslN8tGsfuAY/J2FrESTtQJdVjr2J0bTs69ghfnW0a
 f9HYUmncIs2oxfCNlHXZcY14Y5KdeIavM+V+rPc=
X-Google-Smtp-Source: ABdhPJyzDtxP6eEQsUp6ZInYnleL3emSrsWekMAFro4MB9he0IVj7K5NBZIhPoJLPSZeh7ZmG0PeXfgmLZ4Eq0psNog=
X-Received: by 2002:a2e:5c47:: with SMTP id q68mr41778ljb.30.1592410548379;
 Wed, 17 Jun 2020 09:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
 <20200616231204.8850-4-ahmedkhaledkaraman@gmail.com>
 <871rmdyjbh.fsf@linaro.org>
In-Reply-To: <871rmdyjbh.fsf@linaro.org>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Wed, 17 Jun 2020 18:15:12 +0200
Message-ID: <CALTWKrVovkoQvNFxYac2eOV7Cf+K_RA+1-Gn=3AnL8dJLemTyQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] scripts/performance: Add perf_top_25.py script
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, ehabkost@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, crosa@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 2:21 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

> > +
> > +# Run perf repcord and report
> > +os.system('sudo perf record {} {} 2> /dev/null \
> > +            && sudo perf report --stdio > tmp.perf.data'
> > +          .format(qemu_path, executable))
>
> Why sudo?

This is the default requirement by perf. You can modify the
kernel.perf_event_paranoid setting to run without root privileges.

> Also redirecting just stderr? why?

Perf, as well as Valgrind, print their output on stderr not stdout.

> I think you could separate the steps (as well as use the subprocess
> api).

Noted!

> Again os.unlink()

Noted!

