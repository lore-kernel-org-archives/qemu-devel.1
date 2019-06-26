Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E80C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9FDA20663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FDA20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgCzv-0002jK-Ol
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 14:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44974)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <th.huth@gmail.com>) id 1hgCiq-0003WZ-FN
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1hgCio-0002il-PW
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:32:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54758)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1hgCim-0002ek-V0
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:32:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so3124967wme.4
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 11:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1oHEDKYIMCYihBdWVJHGebM3VfCzoR7iu6iOOW0YV2g=;
 b=SOG7GrTnKO5kYVA76OloZTOAuYxD3S33Slkr/Rz5Nmz2rGva7we/V2Bqd+LDLi994x
 3I9MTOFUeHQamf/snIlsLpolTHmwRrv+aYcOs38qLWAp8xTb3iNMBosrSKGjHxTV4R6X
 v1km6WgJfegFrowmeF2OkdqvVDDbJyso3TpVdMOMvzwwk/ovzofKVE7ZBPyhFvsDJKmF
 Yy6GLGV7yTCceopSEnTSq3+ikUI5f6Ss4dXyaZjP6VpJYcFHkR7V/gMNVdwn40of6FFp
 76q9X4uKqIpGfUgHeLWBMMSvNvuYY+oyJio2aGxfTPqytvRjVPWfdDy3VmsQ1jeZO/fr
 TR8w==
X-Gm-Message-State: APjAAAUoSKTo6k31BV2z/+pZ9Q4cROdIEukFie3+qINyvi9rHFw/80JC
 5sXb+QS2NZ9zbD4ImVCP1DE=
X-Google-Smtp-Source: APXvYqw+YSDeBWCp1egrhcuDnMWgUaumOXSQYEYgk5xlc8ZBrQQxjeoL1SN6WTC3hjqA3zebawdsog==
X-Received: by 2002:a1c:5f09:: with SMTP id t9mr280343wmb.112.1561573956393;
 Wed, 26 Jun 2019 11:32:36 -0700 (PDT)
Received: from thl530.multi.box (p5791D55B.dip0.t-ipconnect.de.
 [87.145.213.91])
 by smtp.gmail.com with ESMTPSA id x3sm20088452wrp.78.2019.06.26.11.32.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 26 Jun 2019 11:32:35 -0700 (PDT)
Date: Wed, 26 Jun 2019 20:32:33 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Message-ID: <20190626203233.085e15c6@thl530.multi.box>
In-Reply-To: <a4e9bd43-6e5c-a893-d57f-2cff20df5589@redhat.com>
References: <20190619221933.1981-1-laurent@vivier.eu>
 <20190619221933.1981-11-laurent@vivier.eu>
 <20190625183019.3cb231d2@thl530.multi.box>
 <a4e9bd43-6e5c-a893-d57f-2cff20df5589@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v8 10/10] hw/m68k: define Macintosh Quadra
 800
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
Cc: =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Wed, 26 Jun 2019 19:51:12 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:

> On 6/25/19 6:30 PM, Thomas Huth wrote:
> > Am Thu, 20 Jun 2019 00:19:33 +0200
> > schrieb Laurent Vivier <laurent@vivier.eu>:
> >  =20
> >> If you want to test the machine, it doesn't yet boot a MacROM, but
> >> you can boot a linux kernel from the command line. =20
> >=20
> > I gave the patch series a quick try, and was indeed able to boot the
> > Debian installer with the q800 machine, so:
> >=20
> > Tested-by: Thomas Huth <huth@tuxfamily.org> =20
>=20
> While this reply is valid for this patch, was it meant for the series'
> cover?

No, I haven't tested each and every part of this series, so this was
indeed only meant for this patch here.

 Thomas

