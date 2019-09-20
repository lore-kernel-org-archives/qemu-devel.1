Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193C1C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CE22080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="jUudKmR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CE22080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBBBk-0008HB-79
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 01:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iBAws-0006vr-F2
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iBAkn-0005Nc-DI
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:42:47 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:40215)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iBAkm-0005Mf-9A; Fri, 20 Sep 2019 00:42:44 -0400
Received: by mail-qt1-x843.google.com with SMTP id x5so7205179qtr.7;
 Thu, 19 Sep 2019 21:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=16E9XY1Je0+M3EncPvD8SSMu399WMgB+yu3owhNoMTA=;
 b=jUudKmR2U7x33CAsmYSSn//XAUW+5hrSm5GvBgfh4hP36P9NFq+Ad81QJGK6V56bFC
 WtMesD1mzA2X+Hsenj9PBWUk0g+E4wbHfTOE1NwSFwzxUVzDkQAHODdhgyVrTkb+uIuc
 gP8gjDnn+uIVkV1deCV11NH7MVeqRygD8desg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=16E9XY1Je0+M3EncPvD8SSMu399WMgB+yu3owhNoMTA=;
 b=TVaqR94K1vAnFWSEUDg2ak9Mi2PWG20DjwimvOPj6KY0B753YcDKc0/0YtwmUvxq6K
 xgjxlhJKfW+FUpGxnnvZhMNDzmQStiNJL5IuJLjX0WS5e45BYgVgwWsbzGH7y2vmoPby
 +tqiXAO5nA8SlYKGpQ7P4RrUkGvhkvGzKAezjqt0q3e+8sBrrkLuXQHg2xCIQR5CwqlU
 R3IvXQqPycCS0gKSgYY873HqAJt2CrNRsLvnb9XeCFlLCm+p1iZBtDufoHO7kFECd0Tg
 u6bgqWxjt5OCGWqhySoHoTk8QEWm+OnAoGIAUu9aVyMceJKkqACG54pW1siLGrEgA8wp
 qfwA==
X-Gm-Message-State: APjAAAVlqNli1c7+iUCH2+kSgQWtfb8fjtyXJrDv7eLEXzBmtKfc2uXi
 IZPYo0F6l1lC7XG5dHPEZxb46GW276DvlTss5F4=
X-Google-Smtp-Source: APXvYqzgxjROs2XaNoYzu0SkYs6Bzn3RcJ/watQp7lIS8Ii8teO4iuP0emFOBDsGwRTL4sSLywS1VVscx3vfUDz9Zf0=
X-Received: by 2002:ac8:2f81:: with SMTP id l1mr1214120qta.269.1568954563721; 
 Thu, 19 Sep 2019 21:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190919055002.6729-1-clg@kaod.org>
 <20190919055002.6729-7-clg@kaod.org>
In-Reply-To: <20190919055002.6729-7-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 20 Sep 2019 04:42:32 +0000
Message-ID: <CACPK8XdsgVS49gKYZb-hGwAUa5cheaTRmdv3htTsCz5qZHseHQ@mail.gmail.com>
Subject: Re: [PATCH 06/21] aspeed/timer: Add AST2600 support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Sep 2019 at 05:50, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The AST2600 timer has a third control register that is used to
> implement a set-to-clear feature for the main control register.
>
> On the AST2600, it is not configurable via 0x38 (control register 3)
> as it is on the AST2500.
>
> Based on previous work from Joel Stanley.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

