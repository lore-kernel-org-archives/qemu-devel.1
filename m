Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FDCC4CEC9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE6C2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PtI93D64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE6C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBJq0-0007dU-Vz
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 10:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iBJmB-0004Db-Cq
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iBJmA-0000FA-DQ
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:20:47 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iBJmA-0000EQ-7d
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:20:46 -0400
Received: by mail-ot1-x344.google.com with SMTP id s22so6324940otr.6
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 07:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iMFLoESln03YhHdd7mSshoIuqzJ4tBEbRYnNYY2klVE=;
 b=PtI93D64jAMNEy9yRbXSZ67oe+bTIL9mDEndErSlkgfQhncsbpAP+A7Ka3F0Vp6kEr
 gbu6r3RjGwBM3c0WCvU55qx0amrCTOuzYre1UdgaJtKt6yyFh7NhEEoYbuqud+/jgg6R
 az/YKBL5UJbbaA3d7htKHN2mPMrmC2q3VRwYzcBX79bgU417m/dHxZdktWSsjhToirnh
 /fld8gbh6OtbH+9FgKdt3MTLpyg9ILeUPXq0VWN2D0qk8wypcFzW4uuJVYoMsY7OH8zT
 ZvJ/w8Xls9WxCQlgSCF7waKl5+d6i++4XBnLfmwvsk4WktghkwNUxP1dJjVFQjKiNlKk
 Nfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iMFLoESln03YhHdd7mSshoIuqzJ4tBEbRYnNYY2klVE=;
 b=Dt+wHj1/RZPcAo1lISUGHclW0hswWtxOslNhrs1UUg4hbKCFrnLTVZAqps+N0ZuZrr
 CrZPhULahJ4n+NN31KsY/yW6C01CLX47DCKrEI/1ZLZ17aXj09W4BhYWB1WPYooJtkPb
 q74Mumn4MUM3M04xbuIeqZBA17dlFkjRnOkFgXqp4HerqdRhpXSRDDZ7CED4/f7rV+9k
 Edv/9LANZbzB4Vj2Rec94g6x99d1vpcTwaUYxgYJlnHyKwPmEnOVMUNDTgNlt1iR1cwq
 Q29C0VCw4qU8Bos4bc75+qoVdCh8SyCSwoGLOaywwBz2ff3By/S4l1YfY65C0Je2kEqT
 JudA==
X-Gm-Message-State: APjAAAWzB0waPb5tZ46FpWTbVE9gXxfbrAiFtmV7CimYBgb/wabt06Z2
 mN0AUBu01CvHdskTi2YfQWmkaIpzkqkhjHCRjdR9MA==
X-Google-Smtp-Source: APXvYqwhZF4d2BjQ2mh9ToN1e65zT6Py9oRVu8NOXFaHtxA5dkrqD0OlthgLY8BkWp9C3P5TESPJkGzi6Wx6StAWLMU=
X-Received: by 2002:a9d:562:: with SMTP id 89mr12286001otw.232.1568989245380; 
 Fri, 20 Sep 2019 07:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190920141248.12887-1-philmd@redhat.com>
 <deb6f913-7d80-dacc-4fa4-07c848343e0c@redhat.com>
In-Reply-To: <deb6f913-7d80-dacc-4fa4-07c848343e0c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Sep 2019 15:20:34 +0100
Message-ID: <CAFEAcA-O6b5zc=Qp-49Fc9_tQ+a+Stk6DfnwwzDON+RZfSDSfA@mail.gmail.com>
Subject: Re: [PATCH] memory: Replace DEBUG_UNASSIGNED printf calls by trace
 events
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 at 15:17, Paolo Bonzini <pbonzini@redhat.com> wrote:
> I think it's simplest if all series (RISC-V, remove unassigned_access,
> this one) go through the RISC-V tree.

I don't inherently object but IME the risc-v tree tends to move
comparatively slowly. The initial risc-v conversion patchset
should definitely go via the risc-v tree, anyway.

thanks
-- PMM

