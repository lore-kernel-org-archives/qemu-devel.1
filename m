Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D41C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E710222BF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="OopAjc8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E710222BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDPH7-000549-BY
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 04:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iDP69-0003Xp-2u
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iDP68-0006zC-6V
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:26:01 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iDP66-0006uR-4F; Thu, 26 Sep 2019 04:25:58 -0400
Received: by mail-qk1-f193.google.com with SMTP id p10so1030193qkg.8;
 Thu, 26 Sep 2019 01:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=L7fqkc3Q+12wPkMnK9I1sL/Gy08sBIgsOmd6e4m3LjY=;
 b=OopAjc8H+PJxLu8iFVjVNv1YCNwkqRY6vYSfYOvLoqHOs5quu8KjkaQG+8gyeJDZ9Q
 dSG+LqzoXB5Tp+hhCQX6hMiO7nlXfYYke+WJ6y23OjqfPLQS8zF2KIV2lGQyB6HSJ3Hw
 Ox/X+83U20dIgxaWnnubJr0xs7krVByfThiIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=L7fqkc3Q+12wPkMnK9I1sL/Gy08sBIgsOmd6e4m3LjY=;
 b=sHv06Q+2Sd7FGZIAWlrG4OR+/ydn/eiQacpOYVsn3ufaC37tpg9k10GLiMJMpFdgJi
 RG9noGX7/qWVg3x+JhzSWGsq/BgHe6+coZO0vzAOhEuMdm+Unk0gWbqU3lqCcFBo9qC1
 0XOXmeBKCdDE42SdlC6ihNPiTqycykU/y/0ijuE4+DriIOhFzrfVkTbACp3HttjmoFA0
 vIcersj4Ov1wcPh4f5KgbdEZwIvePLQU1Af5IURnq0PB5Nt9wdnCdmey/myHoh8Z9Amg
 lvoFGgiaAq14z25vEXw2AEG0kBlqR5z+B+lrvz7/DEYi0qoQF5XPYbk4541CxI02Xkjy
 4CKw==
X-Gm-Message-State: APjAAAV7pxINhOMCFXCEuVMe8FM07Kv9TKv5epmpwjl0GLSuZLXUJmrL
 nFLCzXPcxkMk7IWOLmJ7Fqayv8j3YUUY+tK2JWQ=
X-Google-Smtp-Source: APXvYqxIcNgD+qOj3X9sPfUY2BblhMQQeQ1/3mELLd8/uYN8KWwavEmLi4K8NVVmKkuwVOP1EuYcbQL9llGlOdKRE4c=
X-Received: by 2002:a37:4f4c:: with SMTP id d73mr2013396qkb.171.1569486297438; 
 Thu, 26 Sep 2019 01:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190925143248.10000-1-clg@kaod.org>
 <20190925143248.10000-15-clg@kaod.org>
In-Reply-To: <20190925143248.10000-15-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 26 Sep 2019 08:24:46 +0000
Message-ID: <CACPK8Xd2EP5bt22OK=zfsbXUe7azMYtey9Ud5JBL9CaSOpR7vA@mail.gmail.com>
Subject: Re: [PATCH v2 14/23] hw/gpio: Add in AST2600 specific implementation
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.193
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
 Rashmica Gupta <rashmica.g@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 at 14:34, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> From: Rashmica Gupta <rashmica.g@gmail.com>
>
> The AST2600 has the same sets of 3.6v gpios as the AST2400 plus an
> addtional two sets of 1.8V gpios.
>
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Acked-by: Joel Stanley <joel@jms.id.au>

