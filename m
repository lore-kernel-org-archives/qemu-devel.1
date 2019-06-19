Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370D8C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 02:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79872147A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 02:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="i4rJwgdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79872147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdQBE-0005Q7-QD
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 22:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35282)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel.stan@gmail.com>) id 1hdQ8y-0003nq-1R
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 22:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1hdQ8x-0007CL-49
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 22:16:11 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:42551)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1hdQ8s-000796-Am; Tue, 18 Jun 2019 22:16:06 -0400
Received: by mail-qt1-x844.google.com with SMTP id s15so18025973qtk.9;
 Tue, 18 Jun 2019 19:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XDrO1MtUPggarGj30KvTtRIqNt/7BAaBcD8oaDktB7Y=;
 b=i4rJwgdD94omQBG0OHc5EgZNCd55JR8D1z9nQZGcJRSG34uKMkgDaVcOTCOLVj2Bbm
 z/GodDSbB/hJjYXClOOBPIDqnnqTF7jGi+4d3JniHsUbMrHdvq5LA2iLDO1tgrdOTnXM
 TvPzZpplwl6VHalLtY+XYFGexpGxrvp/ZqE2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XDrO1MtUPggarGj30KvTtRIqNt/7BAaBcD8oaDktB7Y=;
 b=XCcY1qbMm1kY2uKU2R4nZmsG2i/E+BelfEf+XnBfTe+TGo9SRWCqjJ8cmGzaZAjUFH
 H+OQZZq/rRoz9uuoZjH26+bpiUVWUd1zGKEEfjKgIl8RzS/sRHPanYlHdQ+MlrqJplBO
 ip3v4pGmG9Lp6yRvI+P5QfzA9KM8RmwSbqAYjA7fUF2TUFwe3c214YmO4j4n7qV9zaT8
 ZMV3Kb84R4jqUUJH1dcWpTz90Kc/3tvYf35TZ76dKym+OpQYX9HXGwzmatPNJK8zotIa
 +N8z/fRkJKMIoGGEoEv8w5/87Bj6nhaOdhedJawOPj1xo710yiIz8HW1CCgXf07bbepm
 ov4g==
X-Gm-Message-State: APjAAAX5VUFpF3HPf0eiNceh9AdwUohYfNi2g/npUNMumnuQfPmbwY2Q
 2cP0Ux7hdwrFgXtojLrtmwYh7/CGpijLwIwnz2A=
X-Google-Smtp-Source: APXvYqxjJo+7f5cfNaLAvjnX2J86tlIzykpvfoc0tR5Aya412NLM/hE+Z7sLp7gHYsB+g/F/tw+ykFFg3AJQvofr/+E=
X-Received: by 2002:aed:3e36:: with SMTP id
 l51mr102492320qtf.269.1560910565684; 
 Tue, 18 Jun 2019 19:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190618165311.27066-1-clg@kaod.org>
 <20190618165311.27066-12-clg@kaod.org>
In-Reply-To: <20190618165311.27066-12-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 19 Jun 2019 02:15:54 +0000
Message-ID: <CACPK8XeJymipv1BF0YcgAJWZAvh5awPY4WUL4fNoMR5CUGW87g@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: Re: [Qemu-devel] [PATCH v2 11/21] aspeed/timer: Ensure positive
 muldiv delta
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
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Christian Svensson <bluecmd@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Jun 2019 at 16:54, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> From: Christian Svensson <bluecmd@google.com>
>
> If the host decrements the counter register that results in a negative
> delta. This is then passed to muldiv64 which only handles unsigned
> numbers resulting in bogus results.
>
> This fix ensures the delta being operated on is positive.
>
> Test case: kexec a kernel using aspeed_timer and it will freeze on the
> second bootup when the kernel initializes the timer. With this patch
> that no longer happens and the timer appears to run OK.
>
> Signed-off-by: Christian Svensson <bluecmd@google.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

