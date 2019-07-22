Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082CEC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D902190D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iP6+dqTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D902190D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpWgr-0004EW-2X
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 07:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52410)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpWgf-0003jn-6n
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpWgd-0003Ex-6D
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:41:01 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40239)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpWgc-0003EC-VQ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:40:59 -0400
Received: by mail-ot1-x342.google.com with SMTP id 60so308106otr.7
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=J3+CHRfzUWzSxeSeXN6LqlMbpNkcEYHGCmOl1Kk4RaY=;
 b=iP6+dqTqweTEdtjFhyONrDzxGMJe6LFhuUo8hf0b8qzvDvho1Za7pi1+seM4ap4q10
 WYAta+QS2GnNyfXAUoloc0lrWshjNPkVyU73VoSGXq+CxxAWLntXJGCDOJzMJe/HS9kY
 JHmk7SianPZ9i+tbIWmEB2f7CebJEF48yqixpNedE1O+tXD4om+PBneWhvqW+3Kt8LZg
 vE5U2GOGm88a6pKxYoKQs6k9enHgbxpJ7DOORdjgdQw9mdI+j7lOBG/01iyyB3ZllHe7
 lixN5GHi8U8cgGD6jPJZC4ODmTGPPO3TUgFn/y+OUJdarFG2GCNxVJQ1puZRmdf598Ec
 oVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=J3+CHRfzUWzSxeSeXN6LqlMbpNkcEYHGCmOl1Kk4RaY=;
 b=EU2xrk72nY+US977SpD3Q7Q8F+0Z+QygyyQWvWqW8SU9IOMyi3Pg4xu6L86P1dhpyc
 8FCVgZlKiMpo+o17Hh7IvYfM5qlCKgPd9ltG7NpPfheUbUF63A+KXUF6iN+zqfASrdMs
 jSg2rC+mwHBZIv1SywNpu7ZfqTlHqyHuJ11v4XqhM9Q7YIxP7aAjy6uxZGI5UjxlVYe/
 HXrMhzfDHEJt0C/grlK4+Hur7mZtV7Ilpn+OlHMSgtgpsau7k/Nis4t9BMNw2qV1X85L
 CzFBzdo0ENeYFwMoaHtr6WRKk4PWLu6DdKQ52jPG+Dbx+Dp7B5JCUOHfDocfKAFwMcJ6
 RwcQ==
X-Gm-Message-State: APjAAAWMH4ird3T8rt9AKKT6PAm2CDt0muJY6IMlkyQY7LB5W7s29ybD
 JGM36Jo/lSFzVfHsY+OBhlXjC+rxQtIit7dcZW6qXg==
X-Google-Smtp-Source: APXvYqz1ZCUm+8WMx6gdtIM0WW5UWg+lZBP6ngbrXeYE4D2/yWo9fLOcV30LstoIUA2vZtRYw8p7a2WTGZ6RqYo+7h8=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr15263597oti.91.1563795657642; 
 Mon, 22 Jul 2019 04:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190722111914.28574-1-alex.bennee@linaro.org>
In-Reply-To: <20190722111914.28574-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2019 12:40:46 +0100
Message-ID: <CAFEAcA_uOX9qkrwRASAaxOfTms9SsQMEyhJ0XwYFiFPVtEnqkw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [RFC PATCH for 4.2] target/arm: generate a custom
 MIDR for -cpu max
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jul 2019 at 12:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> While most features are now detected by probing the ID_* registers
> kernels can (and do) use MIDR_EL1 for working out of they have to
> apply errata. This can trip up warnings in the kernel as it tries to
> work out if it should apply workarounds to features that don't
> actually exist in the reported CPU type.
>
> Avoid this problem by synthesising our own MIDR value using the
> reserved value of 0 for the implementer and encoding the moving feast
> that is the QEMU version string into the other fields.

Exposing the QEMU_VERSION_* information to the guest is
usually not a good plan. For instance it means that the
MIDR will mysteriously change if you save a VM on one
version of QEMU and restore it on another. We went through
a while back carefully removing places where we'd exposed
the version number to the guest (have a look at the
qemu_hw_version() stuff which has to jump through hoops
so that old versioned machines like pc-1.5 report the
old "1.5" version number, and any QEMU 2.5 and above
now reports "2.5+"...)

thanks
-- PMM

