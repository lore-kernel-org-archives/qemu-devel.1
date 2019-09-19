Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14A9C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 19:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A6F2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 19:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A6F2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB25c-0007Hx-N8
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 15:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1iB24e-0006ha-B2
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1iB24c-00072o-VX
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:26:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1iB24c-00071t-P2
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:26:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so6007909wme.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 12:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sR33xypWFAJrc/1sDmmW8H7QVGk/EHXCS0qJS6br6lw=;
 b=UBDsU+7bsdAMEDpvTYlkG9TeQqpBZ7KbiWUQt5qVT2Ukq+TbcuHhBihwBMmqMbWFyq
 V/QC1P8Hp2rpMQj6qrfAKBIrT54T3VcDOS/DRa9eML2Z7Ctf8IztTV/4FulrgI1Rx2Y0
 5daqDiXRlgHUV7Pm7cz0zdh/EhW+J8Ir/jo+1lq5nNrgmSpFvsa2Q6jMCHzHaik1IuXI
 iTIsIMx0nIz3DZkxs5hSsrcb9NYJBbY/9p97rLNQMTUA9Z/aNK1NBjQfTzGnUOYM09ND
 VVM9IADW3/YM+5wKk1v/T0bQtLpsDJoJH+mZMezLnCzLUfb+2NHsI0466CcEAM6e8LlU
 Fo1g==
X-Gm-Message-State: APjAAAXxapV2n+y+gNg6wGht7oj0Nx8UipcRWcW5/tziCTTsE6EdLa5z
 4+N+1oPNISVblUbtUZ0diaE=
X-Google-Smtp-Source: APXvYqyV4BgqhWxsQod2IkTo+5eHPQkGTt1s0IVpR/MW+ckmde71lY0V1Oa1xcPB+mvO5KG/FNhnGQ==
X-Received: by 2002:a1c:c14a:: with SMTP id r71mr4333870wmf.46.1568921197092; 
 Thu, 19 Sep 2019 12:26:37 -0700 (PDT)
Received: from thl530.multi.box (p5791D5C6.dip0.t-ipconnect.de.
 [87.145.213.198])
 by smtp.gmail.com with ESMTPSA id y186sm11602029wmd.26.2019.09.19.12.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 12:26:36 -0700 (PDT)
Date: Thu, 19 Sep 2019 21:26:35 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] Acceptance test machine_m68k_nextcube.py: relax the
 error code pattern
Message-ID: <20190919212635.03b79d37@thl530.multi.box>
In-Reply-To: <8a087ca1-cdae-20ee-d939-a47be4f25235@redhat.com>
References: <20190919161400.26399-1-crosa@redhat.com>
 <8a087ca1-cdae-20ee-d939-a47be4f25235@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
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
Cc: Willian Rampazzo <wrampazz@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Thu, 19 Sep 2019 18:19:40 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:

> Cc'ing Thomas
>=20
> On 9/19/19 6:14 PM, Cleber Rosa wrote:
> > Instead of looking for a specific error, let's relax the pattern
> > because different errors have been seen (I'm consistenly getting 52)
> > and the real goal of this test is to validate the framebuffer
> > operation, and not to reproduce one specific error. =20
>=20
> This might be because I wrote this test before Thomas added the serial
> controller (commit b17bed5b1727e3aa9e37fc8e8c3222130ceab22f).

That's strange, the travis job worked fine for me ... but sure, let's
drop the error number, we don't need it here.=20

> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  tests/acceptance/machine_m68k_nextcube.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tests/acceptance/machine_m68k_nextcube.py
> > b/tests/acceptance/machine_m68k_nextcube.py index
> > e09cab9f20..fcd2c58ee7 100644 ---
> > a/tests/acceptance/machine_m68k_nextcube.py +++
> > b/tests/acceptance/machine_m68k_nextcube.py @@ -116,6 +116,6 @@
> > class NextCubeMachine(Test): if len(line):
> >                  console_logger.debug(line)
> >          self.assertIn('Testing the FPU, SCC', text)
> > -        self.assertIn('System test failed. Error code 51', text)
> > +        self.assertIn('System test failed. Error code', text)
> >          self.assertIn('Boot command', text) =20
> >          self.assertIn('Next>', text) =20
> >  =20
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

