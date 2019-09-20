Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE0C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 10:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D34207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 10:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mVDplTI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D34207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBGR1-0004xN-Gh
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 06:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iBGPs-0003Yi-FK
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iBGPq-00029D-J9
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:45:32 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iBGPq-00028H-5L
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:45:30 -0400
Received: by mail-oi1-x243.google.com with SMTP id t84so1333907oih.10
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 03:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MpGP/MGMc7Gt22e0zwHvKD2lDmh/PBDt4JbxxFHf5T0=;
 b=mVDplTI2PC8w8bFias+KnhemcdvTP7I7Iw+pskdU9eu4uLK/f+YgsF0rrwqQ6IFV6S
 qmuHy86VKrJOispmV9RlAlvTLvBhxJ+HUHOmEAMahWy3F5RASPqxZFi+gKemRpF74eDI
 7QbTtuJLepETgpkNFOK5nIHQ9OEeQYm0L0f6tl23TCKMvmnjzHmisTCfRvbUfoBI1Xzz
 hRT8+VDNT0hRQuR5CTAv8/b88fQ2Gmf9nfRg+yO6oHOMXIXq7hCdZc+mGSOsM0uD2jH7
 +OIky4YvcBWOKWQ255N0odAJ+Os2pzQADmQXmRtgEvVtiMmZoyuOEn3bP9EriWHUSI9q
 XtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MpGP/MGMc7Gt22e0zwHvKD2lDmh/PBDt4JbxxFHf5T0=;
 b=dhPiWX6xLKismZ8zcCIMQ1p3l2/1zlczLT3xmrz0JAledIuZ3jqw4NdAD19kqXKFLt
 W6RMLu5cteqPXBO7sCvKXFQPXlp4c1nNQf3zFaEpNUDjhY86yK+H2oSfIzxL6oAAxdk0
 JByFYLObtaAk+bb+0UmXoIOzxzeLo3yH8KQSZy8OMyaGOTu/CEHaOkqhe++i/wbnN1Xc
 IfkzdR9S4uCoJtCuTa4m+FzLxOvIgrKoajF4HWDW9xPmYigfu4s/wk3Bp+H8fGcB7DYh
 RvuWsX/IudM/5C44om9/Ax2hxLrvJqJFwiM4wsha9LXrvAx2GuauTuQQLeSAK8O23IIF
 qISw==
X-Gm-Message-State: APjAAAUsWwqKjvpxJIOBGu0VQ1pCL4khG2PxGbAFGQ5w5tXg7ikNaEgj
 FmaGpkoc3FRdVcFecNl+z8QKVyVEoiIeWeKRofZ+yw==
X-Google-Smtp-Source: APXvYqzwOQvL1uIiH2frKOZiNqz8aYhLjrlWqDTrvRkMrDZ5S1wnJcPONG0GM1cJ8BfKCOieSQLcVyiHB9ZZBPPl9oE=
X-Received: by 2002:aca:b646:: with SMTP id g67mr2304971oif.163.1568976328825; 
 Fri, 20 Sep 2019 03:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190919124115.11510-1-cohuck@redhat.com>
In-Reply-To: <20190919124115.11510-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Sep 2019 11:45:18 +0100
Message-ID: <CAFEAcA-WLayY+jL9mKV6zrstSZOynja7=k6Cjx4wR9g33jFPQA@mail.gmail.com>
Subject: Re: [PULL 00/34] s390x update
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Sep 2019 at 13:41, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit f8c3db33a5e863291182f8862ddf81618a7c6194:
>
>   target/sparc: Switch to do_transaction_failed() hook (2019-09-17 12:01:00 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190919
>
> for you to fetch changes up to 37105adebeb28e60da3cb1ef82231d7ed8d23589:
>
>   Merge tag 'tags/s390-ccw-bios-2019-09-18' into s390-next-staging (2019-09-19 12:04:01 +0200)
>
> ----------------------------------------------------------------
> - bugfixes in tcg and the ccw bios
> - gen15a is called z15
> - officially require a 3.15 kernel or later for kvm
>
> ----------------------------------------------------------------

Hi -- I'm afraid this pullreq results in new warnings from
the runtime-sanitizer build when 'make check' is run:
MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=s390x-softmmu/qemu-system-s390x
QTEST_QEMU_IMG=qemu-img tests
/boot-serial-test -m=quick -k --tap < /dev/null |
./scripts/tap-driver.pl --test-name="boot-serial-test"
/home/petmay01/linaro/qemu-for-merges/target/s390x/mem_helper.c:293:17:
runtime error: null pointer passed as argument 1, which is declared to
never be null
/usr/include/string.h:47:14: note: nonnull attribute specified here
/home/petmay01/linaro/qemu-for-merges/target/s390x/mem_helper.c:293:32:
runtime error: null pointer passed as argument 2, which is declared to
never be null

(and the same warnings for a few other tests).

Looks like you sometimes can pass NULL pointers to the source
and destination of memmove(). This isn't permitted by the
standard even in the case where the size argument is zero.

thanks
-- PMM

