Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE09C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4FA20873
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKTB+Ig2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4FA20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2grO-0007zF-R7
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 14:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j2gqp-0007ZY-6A
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:42:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j2gqo-0006Vo-4s
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:42:11 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232]:40596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j2gqn-0006Qa-Ro
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:42:10 -0500
Received: by mail-lj1-x232.google.com with SMTP id n18so11982051ljo.7
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 11:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GGTKqS/xS5Mxn+8PaEFwzNVUAx7Bg2gmWFKAnPfPbko=;
 b=QKTB+Ig2wXGNvFTZnJ77+K5C0x/VObnH8x8I8OH/6gQT8tab25RJ+k0EjDwT7C64n6
 asw5XLFVHSn06LwF7LosuI1LSJq6wsSRL6RBOGjyNaWTWzuuL+qcjxlVOOWaJY2xp9d0
 oLrp+WnDmn/jGA5EsoGJqD3qIDiAK/dk7nhh5kK4Gm+ALPq68mjNNALC9Td7hR1jLHxr
 UTFmkLZu5py9Y482Z47fRrdD3vMKZaPh28dB+DZ9hlxd+HuloM+1HBFrGjSqgUAsxbTK
 BAwx9tCiq7nLbWkPtGZ6j2MtUtDNSUlF4YLIYwJEnyFAiguTPd1VeiWFfW/AD4cbURQc
 zlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GGTKqS/xS5Mxn+8PaEFwzNVUAx7Bg2gmWFKAnPfPbko=;
 b=e7C1zx5yb4fncWOAaCUgvrpUj+Bz6TP2q8EbTa3E45WJuyLa5W/8whk0k+m48c9fxV
 i4o/itujTggByUmuKT9pLtIZiGerm2vbiUC3iztIHL6x7FNvwPoIP/GS9Jt0A8lfFCBN
 rVMfVJ1Lsm5wJlenwgZ4bIbxGVvJr5xXL+kllCAK5vx0K9lgITg8TB/ivd/FtRrlK7ZX
 pKjoAXjmgHolcX/5QW1HBrOj84dQxYSFwPLNZ94fUN+ZDsEbWGZGjkYzIrpoRtSy5s7I
 hVFUh3XEiASfnoyTt54JqarIGX4qsmF4qfc1yXsA8EEg/7b/kGAw72LKSAThpQMoTQad
 zBxQ==
X-Gm-Message-State: APjAAAVNtXcS9dY0Yu/WZ9WM1h+yvC+uKjjruN9N1Q8WvI5XIX+XdsEG
 R8urTtUZ6Fb2d96AEekWI+XfNBPmROTOHj15WvUbHA==
X-Google-Smtp-Source: APXvYqzDV0T0h92cdH6Ps3TRQXP998I3zk7aSYyuYWF8WcwcCRRrCn0+MDAlelFWkRurirYe0e1rQrsjVtcRwKg7hwA=
X-Received: by 2002:a2e:9955:: with SMTP id r21mr2953139ljj.283.1581709328252; 
 Fri, 14 Feb 2020 11:42:08 -0800 (PST)
MIME-Version: 1.0
References: <20200213225109.13120-1-alex.bennee@linaro.org>
 <20200213225109.13120-2-alex.bennee@linaro.org>
In-Reply-To: <20200213225109.13120-2-alex.bennee@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 14 Feb 2020 14:41:33 -0500
Message-ID: <CAEyhzFuhCG0F+GOmQsAVb8USyTPTtF6me4vMALRYpMhS-8t7tQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] tests/tcg: include a skip runner for pauth3 with
 plugins
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::232
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
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 robhenry@microsoft.com, f4bug@amsat.org, marcandre.lureau@redhat.com,
 aaron@os.amperecomputing.com, cota@braap.org, stefanha@redhat.com,
 kuhn.chenqun@huawei.com, Peter Puhov <peter.puhov@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Feb 2020 at 17:51, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> If we have plugins enabled we still need to have built the test to be
> able to run it.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Robert Foley <robert.foley@linaro.org>

