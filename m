Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C28FC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C4720836
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bkhVwXnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C4720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiG51-0006Mi-Vf
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48015)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiG2f-0005lO-TQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiG2e-00047E-16
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:29:41 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:44545)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiG2c-00042h-Bi
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:29:39 -0400
Received: by mail-oi1-x22e.google.com with SMTP id e189so12565283oib.11
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 03:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vD88YUeiw7Mv2RroWIU1VhDeGJ9cVzE8rD8InPIx5P4=;
 b=bkhVwXnFCtojCK+R/fFnwxdARjJGm+q3choWEUnz4vODhY9xhX1qWI7kj0RdBMgQ+U
 pvO89aV2sIWZvI7BX+QFtXnj55kMcylh/DMqeDCxdq8XH/UQqRYqADT8r/m1XbON6Fh2
 EHYp09fFLtgwD+ue7pklgiMyEASuxTlnGnpkgZkeFSvc4UpNMm6rKR9YGcFvVQdr66wY
 IOeYNSPBWHjctnT5hXRrvI7Sddw5cDX3p/tWayPHd/kweFRaX6iSOqlhXGrjlrXdYphX
 ZCSvKICWAS4SRSeVM7VKe4NG0wR/yv0NwejUB95g5V+S7J66rVsvdac6k/10bP+5rk1l
 Yxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vD88YUeiw7Mv2RroWIU1VhDeGJ9cVzE8rD8InPIx5P4=;
 b=sxi+I0lRj7i+xg+0PypwrPUZ2OAIoBXiJMkPjBHZrSzm/n0qasohrQd0ZYjSfJ6hX9
 GIqWSeyBhcHswEpiyL1IUOFpv1gezVWBk2TdsqSXuN1SQrW9n11T8pI61VJgOyo/gP+U
 jcD9t/eUQX3DU3Ix98fbrthbxkmYM3jRZwG4gRu9fo0deI/si9gW1U9Kd3Ntac26LuYJ
 h2jAArTjaPJc4qnA02s+ZIZBWc1h7ZIYTs44ikL7OnXmSg1o6jbcY+JbGA5gaAs918Uk
 oks5dGUV5xXn77ZnlifWejKzSswHlO4uts9ExJ/toWNhIqdbyusgvo3/FpIdiicktGLT
 kITw==
X-Gm-Message-State: APjAAAXla90KeKR6JfgCdCH/HKN0IGvoGeStdy2hEWZQNo0e1ygWQv7n
 7kMvCGahpui9pYjZZlCM2bQyA+LvxCPNq5/vdXOD2w==
X-Google-Smtp-Source: APXvYqxfypOKZLXQqrH9HrFY81dncbNWKJN1krHPvedTbbtM/Qnd1NVouvE/LOr7YPTbYFIGHBf7xdEF9PB3oT3f7m8=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr2448481oij.98.1562063376076; 
 Tue, 02 Jul 2019 03:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190624134337.10532-1-alex.bennee@linaro.org>
 <CAFEAcA_VPcqxVjmSkRYoRRYS9TvM9KXU7e7pww9UofApp42O7Q@mail.gmail.com>
 <874l45sq55.fsf@zen.linaroharston>
 <c803aca4-aa53-845b-fc35-8d221df036a1@redhat.com>
 <87zhlwrarn.fsf@zen.linaroharston>
In-Reply-To: <87zhlwrarn.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 11:29:25 +0100
Message-ID: <CAFEAcA8FzoMmondmmGu2y3GFhwv5OHCxc5L=t5AQO_SuFbEDbg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Subject: Re: [Qemu-devel] [PULL 00/19] testing/next (tests/vm,
 Travis and hyperv build fix)
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 11:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> We could I guess. I'd prefer it if we could have the check for warnings
> script in the source tree and documented so it's easier to see when we
> trip up this stuff.

Well, it's part of my ad-hoc testing scripts. If we can move
to using gitlab runners or whatever it'll become obsolete.

thanks
-- PMM

