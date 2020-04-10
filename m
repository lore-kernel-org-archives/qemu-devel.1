Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ED6C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 16:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB4020857
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 16:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlOKGvHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB4020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMwJ8-0001Ol-TO
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 12:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jMwIA-0000xk-Lc
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 12:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jMwI9-0008QP-Gr
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 12:14:06 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:39722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jMwI9-0008PK-8g
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 12:14:05 -0400
Received: by mail-oi1-x235.google.com with SMTP id d63so1778381oig.6
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=70qNq4i2GsfpyCPylN86WvcllEE6tbW5Ef2byxSYEeE=;
 b=QlOKGvHuG3IxP0g47oKUUKrUh66WVD7UDaHblHV1GO49UsS9tpT7vtDidbd6mZiHOG
 +E1mJkT9JPdCJnd+G9PLVDIIPZ4n1ZNxb4/iF5HJEsDLoss+h/ifVgEzUl2imcJbIkQh
 GgtyyUQkyl2y03bZjL+sQR2cwbYbG0tXJQhJAcfk3BXZn9xgAfQhIEzUpq9XpYldzfFP
 lj7Amm0+jDvo0K6CL/HJxQld9DDHnVMftin5wTR/65a0HT69tNs5n3h0tm1GJf+0cdus
 0RXjOnhruz1ccYW1Th3Exw+bex1PW2KfHPiNhCfiE5pWSiIoMPSGKy7VwM7bgD1KnokW
 C1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=70qNq4i2GsfpyCPylN86WvcllEE6tbW5Ef2byxSYEeE=;
 b=q8gIA0LCMgLnLX98EBWsLoYBM52HAmTGcb4DBBbtoxaWqo1YlwTbzTvdMfQID1W1rZ
 nqzFp2RFmx0TzuLmLfO1YgN5fUYYhI2IDaIfH9Dc9yG+kT/Uk0QO37BZUmDaQ4ND7yAP
 +QF5lAmE3VYuOxRIWBbiIftnUxZoQvhQAfq3y6xrJZZQhLbsquOZwCxNHJEKxbSQxdkF
 FKg6Q35adEKg0DhJpDpn/pWSAETvzM2wAeev3Add7HcTH3S7NTbSYRcXr/kCgHVPK97p
 IvTPPJsIjdMYCs1psn5qs5b3vlnCNsM/EyWg0TEqA2mXgpzCnMQdHaE5XsFlBk+9M56E
 uIJw==
X-Gm-Message-State: AGi0PubdY7o1q/Y7p4GcA8kaBNKu4DR8GBZzC2/iEd3qzTlhv6kjtX3I
 3F/9RIeMmGmYfrr4lBBmhfiBcXgQoJjXPV8undxY0Q==
X-Google-Smtp-Source: APiQypLgoQor6u/sUbIdigs3B4RO4yojd8AdiV0nPG3xtBsybqqqzMj91CsymNIRXD7yoHT4VANqbDN98DDzWq1kbEM=
X-Received: by 2002:aca:b78a:: with SMTP id h132mr1677477oif.163.1586535244361; 
 Fri, 10 Apr 2020 09:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200407155118.20139-1-alex.bennee@linaro.org>
 <20200407155118.20139-9-alex.bennee@linaro.org>
 <CAHiYmc7Eu0XsCe_bkV=tP_S3wyWy4St1RR2AphE7Obko-18mNQ@mail.gmail.com>
 <45a7fe3b-cede-c8e9-fe98-99914bef0e97@linaro.org>
In-Reply-To: <45a7fe3b-cede-c8e9-fe98-99914bef0e97@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Apr 2020 17:13:53 +0100
Message-ID: <CAFEAcA_aE5uA9eaZWU9cr8tZR3x=dmqWBx5FO8QD8K3n+Fsv5w@mail.gmail.com>
Subject: Re: [PULL 08/13] softfloat: Fix BAD_SHIFT from
 normalizeFloatx80Subnormal
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Apr 2020 at 16:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Although why Alex didn't add his own R-b to my patch when merging it to his
> branch, I don't know.

I think this is one of those areas where different submaintainers
have different work practices. Personally I distinguish "did I
actually review this" from "did I just put this into my tree and
rely on others doing the review" and use r-by for the former
and not on the latter (although obviously everything I put in
my tree I will have at least very very briefly looked over).
But I think some submaintainers don't bother to add r-by tags
for things they review in the process of assembling their
tree because they see it as implicit in the process.

thanks
-- PMM

