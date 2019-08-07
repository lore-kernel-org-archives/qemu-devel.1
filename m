Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFC9C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B5422297
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAGKc/29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B5422297
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvOsA-0007dl-W1
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 12:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43325)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvOrU-0007Bv-Bt
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvOrT-0006gL-8J
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:32:28 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvOrS-0006O7-Ho
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:32:27 -0400
Received: by mail-wm1-x344.google.com with SMTP id e8so1731375wme.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EMr0I8P1bAShqO+oEgbUcO+ZDjq7bsVzt+i0FOlXkQc=;
 b=JAGKc/296EpzVoY8sZLV/o4h7WopZyIrQbJKZ9jRdkDZsW7x5fbzcKpYLI6cuM4BeO
 LW+nqbmbVDbgLMGVwyiZkKM3iviwoaPETFyR5Avi6A4OAaROeOLyPvKt2dodLyA5Wpp0
 MbjHl3CVzS1wwEUDX24WK8cW917+O9IinMLdaSTOxMIJODFBUqyx/KONz828w7Abjf7/
 kSbzASpe2kGDZOBGnrRGDbxi2D5bIQeCpCJtabomPKJVAJTdnFGCTvExDsf4kQACHTqC
 IRGLcPmCsJ83cAnVFdMK1dHrsbbpYwRIIbUI2810VAc4ku0RFSQHwnBkHMz4rzGSCVlo
 GGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EMr0I8P1bAShqO+oEgbUcO+ZDjq7bsVzt+i0FOlXkQc=;
 b=g53a0A9DR3SumsZdmS+91o05TX5kd5Yd2YvQgaW2jLFGjagAmPwSUf4ehcYKfAhI4S
 znIz8cpZno+oX+Nh1isvZiqsLWd1YpC+GlFFG8VS9qFpsz5zcIczWrrSBs3Us3BDVMhr
 0lXlr6Md2Yg7IBFCLsqoNoNkTgcXolAd4MOZ/Ey6yj/5omHBGFxfBuH45QRV5zPlH9zN
 UDaGeS/na4/qKqsXhZswn78BgdilYNWqoWejVuyzFIUN0jejIakDGuH/BPDRRZQBmqwI
 4hXXAjjQFbV24O+34MZqp4fgVM86Mp/HAXCeyC76W7Pf8LPue0Fjx1ZOuWqsefO7KMBw
 v9bQ==
X-Gm-Message-State: APjAAAWLufDaQ6uhc2Nt8Z5bFeiSJ8A0WD91QrvKnV6Wba0a5llZt/P6
 8iaoN/x1ib/RZO0l/g3gTBjLN3gu68k=
X-Google-Smtp-Source: APXvYqxO9sZfT6pNpfy0VIcVuBiq6fmSPj7HfPQMoFtf9r5O3t9Kwg3W8BGbEAr13GJf8hHz+Q5mIw==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr775144wmi.142.1565195532456;
 Wed, 07 Aug 2019 09:32:12 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v23sm716722wmj.32.2019.08.07.09.32.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 09:32:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 68F4E1FF87;
 Wed,  7 Aug 2019 17:32:11 +0100 (BST)
References: <20190806151435.10740-1-armbru@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190806151435.10740-1-armbru@redhat.com>
Date: Wed, 07 Aug 2019 17:32:11 +0100
Message-ID: <87blx1hr78.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 00/29] Tame a few "touch this,
 recompile the world" headers
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> We have quite a few "touch this, recompile the world" headers.  My
> "build everything" tree has some 6600 objects (not counting tests and
> objects that don't depend on qemu/osdep.h).  Touching any of 54
> headers triggers a recompile of more than half of them.
>
> This series reduces them to 46.

I think this series is going the right way but there seems to be quite a
lot of breakage introduced to the cross compiles:

  https://app.shippable.com/github/stsquad/qemu/runs/939/summary/console

I guess there is more subtlety involved when host !=3D target. I'd
recommend setting up a shippable account:

  https://wiki.qemu.org/Testing/CI/Shippable

You can of course just run:

  make docker-test-build J=3Dn

And watch your machine slowly grind through all the options.

--
Alex Benn=C3=A9e

