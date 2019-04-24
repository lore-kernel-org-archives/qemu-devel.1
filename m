Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B77C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 13:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C75B2077C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 13:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DI8VshD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C75B2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41757 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJHug-0000Ry-Al
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 09:26:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJHnP-0002HG-7n
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJHeQ-0003CH-M1
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:09:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJHeQ-00038a-CK
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:09:26 -0400
Received: by mail-wr1-x441.google.com with SMTP id b1so13738412wru.3
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=yHyuOGarEIg48bCWJCsmeHVAQSQgS6q6g1jbjGnvd44=;
	b=DI8VshD9HdknAAE3muvUSpYU4JaB33OSavrTJ9I+sXCQg0J1moj6UR3vInon1xubzn
	Lqh+WKtQ5BmGgOQbx7IdrTbhbvI8c/nhmWuJtgPg+/1+S2DFXO2L2hsExiPFnIJtAPmO
	NJLHHwZ+iN5tNztf89g6OCZi8jqRbJ4YVFrhAOCTq+zs951uoG55hX2Ki3nOEwE7m5Wg
	jWiGgFcdIhYHqTdFnQ3mpPKH04XPZHeJH6EDWq4J2+CGFgHYIgG6fssK8U87AjJ7FSeH
	IX5fQjeQvX+UaMr8JVsL4Iltrkt5UwmQkwhdH2h8NULcFoUKzqhJFY4ML3rtR0vpVUBJ
	Rdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=yHyuOGarEIg48bCWJCsmeHVAQSQgS6q6g1jbjGnvd44=;
	b=au6obhVjRqrCFh6JNyAxJz9kXWGUJHVJugPriZ6En71oJ/CUncJarySaJLDGzt4jQ1
	5esD9H57POP3KqyVF8PGsIdUsyqIO7KwLl2PRraXqoErt4oM+tkXbYVSB785v5kVSNbQ
	H9RD55S2FrqOclxrwn7buW4coZyFJKOuEmkoNexYi5++TQXiiMXiuFnYfDZW6yp1YeVG
	F1bga4SgxQ8r2vvagWOMnMmR1MGIVmuZpYbkawP87t6VwxER87pDwYegcLCc16dLJatk
	tTreNoazRifvM3YlOsP2/TCAqaXeZl9auPf7GxNzJ5BUXNd7Ub2DSqwJUTC6OYlph4iy
	seHA==
X-Gm-Message-State: APjAAAVlSP7WSrLM36m8MHiIUk5/JFCuDbYetj1Zsbv4ax/VC3rbLGqR
	3JHP4lGfG/V3ElR2WpSuHibaMQ==
X-Google-Smtp-Source: APXvYqxckjk6iZ0JUkzkyCo4GjinSBmkeYAtb5k5JyN9tDXMXqK+7V3UrrtmWcDxbBQp1jmUrkTWEQ==
X-Received: by 2002:adf:d851:: with SMTP id k17mr2046065wrl.64.1556111363374; 
	Wed, 24 Apr 2019 06:09:23 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id m6sm6112595wro.4.2019.04.24.06.09.22
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 06:09:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 498811FF87;
	Wed, 24 Apr 2019 13:09:22 +0000 (UTC)
References: <20190424124414.17775-1-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190424124414.17775-1-arilou@gmail.com>
Date: Wed, 24 Apr 2019 13:09:22 +0000
Message-ID: <87ftq7wnwd.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v1] gdbstub: Refactor gdb packets handler
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424130922.c0_q5AGMns6-G3G0-jbaHmyuAkRnqiNVAqGR9X25EGI@z>


Jon Doron <arilou@gmail.com> writes:

> Refactor the command packet handling code to ease the work of
> adding and extending commands that are currently not implemented.
>
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  gdbstub.c | 1577 +++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 1092 insertions(+), 485 deletions(-)

This is worthwhile but the patch is huge compared to recent changes to
this currently orphaned file. Could you please consider splitting your
patch up into more discreet parts. I would suggest:

  - introduce infrastructure
  - one patch per converted command

this way when something breaks bisect stands a better chance of locating
a minimal failing chunk of code.

Out of interest what additional commands are you planning to implement?

--
Alex Benn=C3=A9e

