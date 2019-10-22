Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC50CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB49B20679
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yhk6ETxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB49B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxr3-00074q-De
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMxpq-0005mP-2I
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMxpp-0002Us-3x
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:20:41 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMxpo-0002U2-Uj
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:20:41 -0400
Received: by mail-oi1-x243.google.com with SMTP id i185so14855682oif.9
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0La5A2pXgYdYZprUXZS7B3dH09V7aLZ8RTJlRKFlNoY=;
 b=Yhk6ETxrdaUM2oJ+DtchYQZhE3pWS71TXPp0pu4KdJQzXxHLxt47qxXFNobSG/XOZn
 lDV/bRQ0ZIUYyfZ/OSjc43OxtvlkOnYr6WAjrI6z5nD8+iHJsekiiHkxeKxBhC8Bbo8x
 augR3pitXD3WmUaFREDO9mVHDn5jlo4vjQRenR7t1ut+KmrWQSrWo4r9Qd+R7YhpF2Mg
 Fh3rgVFX2tMuYxOQ4w5kqb9vN60t5F50EP1/XmEnprbILtk9qTCJFMv+ybLQ16/SC07U
 Bq3eOxQTc0ya9boSk75NZjv05W7vqYWP85UiMwlow0Flhvx6KxZPR6Y+gBzEMPTMGyUk
 tJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0La5A2pXgYdYZprUXZS7B3dH09V7aLZ8RTJlRKFlNoY=;
 b=b/5Z7gM3eSMEM/XIJffbzvWKTl3pSMK+traX/8yWZ0iCOcuKSivX+UPPHhnYzeKkML
 P99LY1BIpxK3pP/mGcTw+kxw4MACfGKzW4eO0e874auprGRSMvy6zURuXG5jgVxpJfA/
 jHYjLjLydHAPI5j1cpmlRnez2cc147Zi2fwrKqlWyR5UANFcseLtWhdbMcF7+SzKhJdg
 noE1hoDNGk0VrQON0eJK0R/9fbFQ3AZJ5ZeIpMBdRVc+TGA2uYokgE0Cd3ooAxfCX7eA
 BCkz6fYf+ydulULX5aDFyt0BC6xVrhOyFOrkJEip7NT+cRdltrTgtBBDXKAegTo7tIDt
 RO6Q==
X-Gm-Message-State: APjAAAWVceXq5RB6T8OCRcxOe+fiL/v5Nh7bfop7k7/u3y4jwJOZYaol
 9SK93AM2yLM/3gQknL7CGONffAqCRLkTqhxSycoFlw==
X-Google-Smtp-Source: APXvYqxfACClC+BQM2b9C8yyLX8XftMPWXxeLdChl8HF8hLN7tpdtXoJUc4CJBjC5zsAMfg81Bl498W9yrqc+UspKzA=
X-Received: by 2002:aca:49c2:: with SMTP id w185mr3959708oia.163.1571764839900; 
 Tue, 22 Oct 2019 10:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191016090745.15334-1-clg@kaod.org>
 <CACPK8XdT0_JCxzfxd4dCafK0Ae9+18ZWcusuXV+d4eEmwwBnkA@mail.gmail.com>
 <CAFEAcA_6yxaanT2N6Twos_FxjJNgvVKShwgq=pR4fqmcZUsQFA@mail.gmail.com>
 <CAFEAcA8py1obBXc1o02wTRkXms9NwCnCT6Q9ZZ-4W=NzNocLrQ@mail.gmail.com>
 <a0b2779c-bcd5-0fe9-ff3f-d4254aba8805@kaod.org>
In-Reply-To: <a0b2779c-bcd5-0fe9-ff3f-d4254aba8805@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 18:20:28 +0100
Message-ID: <CAFEAcA9nymSxBkEm8GcJm9p4Y_obmK-fbojFEi+Et52H-mPFdA@mail.gmail.com>
Subject: Re: [PATCH] aspeed: Add an AST2600 eval board
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Oct 2019 at 18:16, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Is it time for me to install an OSX system for dev and tests or is there
> a way to reproduce the issue ? no errors spotted in valgrind.

I dunno. You could have a look to see if you can repro
it with the travis builds. I would investigate but I
don't have time this week given impending softfreeze
and KVM Forum next week.

thanks
-- PMM

