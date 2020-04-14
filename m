Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F84C352BE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4109520767
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a25EJJ/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4109520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOP7a-00088k-BH
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 13:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOP0U-0006My-U5
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOP0T-0006AR-Oj
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:05:54 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35317)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jONwd-0006dy-2B
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 11:57:52 -0400
Received: by mail-oi1-x243.google.com with SMTP id b7so8253932oic.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=L8FR74iMrVNmAQJ041jH/wKttuH5XlivU6A83idZbXM=;
 b=a25EJJ/e+cr0CtuOgm9emVAHTSBvgzs4I1BQgbBzn0UkPRdwQuREMLrryfpZSYIa7R
 muXV5EIUqdDQEW4Iih1xc7ipBAG/q3LwP9akl1UfXTNj7O7ekhYx72yj2YMijtZrmKe5
 cwqCAjRxgmwzYZOPjbAy71Ho656aClE5Tq+TWhS4uGj7KLIRchKj7BcSAknzYNwvAL9R
 pBz+kt9zObiYtpoSJW8hoB9eqKgxGPM95ml6jpScTV5QOEb8w3fw0MLwKo2t4wAO7ZPx
 CEIWLwF473kScQxEwDXCgNwFtYZCmJhROIlLoDx1vN0/IrxS2Ei5fyQVVPzqFsXVDIy/
 34Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=L8FR74iMrVNmAQJ041jH/wKttuH5XlivU6A83idZbXM=;
 b=KOv82QzwOu8Hs/nV/ZEwzDyc/96eIbB6lrHI1oMC8P2Crt6rp37emYuvrSs0Tlh12D
 H9xVdLRuaWeGeow+z7ePgKh281VdABRuxoz+ZEBmQLpWsLq2kF51ALqfxOtDNGwkiQUt
 FfQOjyNecAWUr71In8d/fxWnaF27WmKo9YGLm8PUrGcTyIvZUY5zTsk2HZLQPq3qUmbe
 tQCP98l17Iz9RVC9BkcWogSEfv3slTTJVJAYo/0kRL6HAI2U2QQt3D1bCCkQ/MswmQ/k
 i+dGFR2xDq7HPKKHocX+v74MvI/PwO28a+B1xABo3pAO6fbGM4UqRlr/JvYiCA/M7Jmi
 RIeQ==
X-Gm-Message-State: AGi0PuYSl3K/y1qWjs7q1MD2O4x/B04iIEKzFjOhseOJTyWhte51lTx4
 /Z5NfpNckdhHfMwbCj5YnrjzQdhH0vjO7QRYdpa/Cw==
X-Google-Smtp-Source: APiQypK2Nwh/0pRC13UrnKBEBWv9WeabLbHZANGRvl4gHbQ5pqTRFwO+g40gkr6Jun0URTtsJCakrZnj5lLIaiGPGhU=
X-Received: by 2002:aca:f3c2:: with SMTP id r185mr5031317oih.163.1586879870030; 
 Tue, 14 Apr 2020 08:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200411182934.28678-1-peter.maydell@linaro.org>
 <20200411182934.28678-4-peter.maydell@linaro.org> <871roq9i7k.fsf@linaro.org>
In-Reply-To: <871roq9i7k.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Apr 2020 16:57:38 +0100
Message-ID: <CAFEAcA-RuNNOKSKSvWi-uWfPosbqUyipX7fx-_JviFzh+da4+w@mail.gmail.com>
Subject: Re: [PATCH for-5.0? 3/3] kernel-doc: Use c:struct for Sphinx 3.0 and
 later
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Apr 2020 at 16:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Looks reasonable although I don't have a way of testing it on my system.
> Any idea what systems have the latest sphinx 3 on them? I tried fedora
> but that still has 1.8.4 so it's not that bleeding edge.

I tested using a sphinx 3 install in a python virtualenv:

 cd
 python3 -m venv python-env
 . ~/python-env/bin/activate
 pip install sphinx
 deactivate

and then tell configure to use ~/python-env/bin/sphinx-build
(or don't deactivate, and then that will be the first
sphinx-build on the PATH.)

thanks
-- PMM

