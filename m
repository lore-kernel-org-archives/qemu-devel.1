Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9FAC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7D52187F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OW5fFkAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7D52187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8kI6-0008EC-Dk
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8kHU-0007mY-LB
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8kHT-00083M-MU
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:34:44 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50716)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8kHT-00082P-GG
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:34:43 -0500
Received: by mail-wm1-x343.google.com with SMTP id a5so10994721wmb.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=x1IWVMPYuwoEXX9OSIxN0QrWz07oLSRrOnSfxYoHdJI=;
 b=OW5fFkATAwGzF71nTiDHPPdnRQpXKkAxw4qSaCZ9p0mpJwo60bVJMmEzGVIj8lThhI
 Y4pJVch+BB4OgvjmH8icFUpWtgc1n6x4lgi1RTy9AmPi5bt0G0bMyaxUWfdc5+EsxLcG
 zWd5SlI9yuE6SLCcCR7dBBY6PYJ8XeIdFnjGI6nFZDY9ngxz5IVM0g4GvhTsuEVdlzHz
 K1KhH+hv/HWmfHRpVFjNRiWCzwjNwZe49XwerBuK8y2uGctxcIMe1+dhbPbRVCLs70BR
 AYJPUy2F+0vMIo4pJ1DADSF0gl94fj+7sFBXwNjJEgGaXv4DlU1Gp+SprbUngQ7FJiPm
 fqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=x1IWVMPYuwoEXX9OSIxN0QrWz07oLSRrOnSfxYoHdJI=;
 b=iv/U8nPM5A8sN3qs0CiLuXQUZCsDTpGe3EUjsIySoltQxbrTRNphm6SEW8PLjO+aWF
 OHa/Y84O/2A27X+nDtNwpFyY53ce84DX5tY9kBkIITLzNlK+NSjBHjmSnmv/ZE80rNXs
 KOvX9DSMGwZKx+/cz5bHGZTKvWJmisEsO5tvbOxq6hJH+uXiGgdfeg27VEp6Q0cPE8PY
 JX8QPL+T6sD11Qpy6AIMMFhlN3bybI9swzhA8NN9ruQedRxDtuG+2ilmsKyRmu+GkCrp
 EM3iVYg6z9d8qQDzLG9f0JX7cJB3jxy61FqI6F9Bpq64mBOYoK1TARhd5wxe1KZbnG9Q
 vx8A==
X-Gm-Message-State: APjAAAWfRu7RqwVGnw/iHpVqK9WRgrvZMwldMZJubBXswR6aOwfzAbb7
 qkcu3dMYec93gv2iNpJCBIiIjA==
X-Google-Smtp-Source: APXvYqxJil1GFt4CWsXW9y82lw3hpM8ddrELzIJWzZ//SRQTD64x5MfW/HH4Fy8gEsjNcRSzF0rVzQ==
X-Received: by 2002:a7b:cd94:: with SMTP id y20mr19178282wmj.26.1583152481675; 
 Mon, 02 Mar 2020 04:34:41 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c14sm11712072wro.36.2020.03.02.04.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:34:40 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D65521FF87;
 Mon,  2 Mar 2020 12:34:39 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-33-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 32/33] docs: Remove old texinfo sources
In-reply-to: <20200228153619.9906-33-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 12:34:39 +0000
Message-ID: <87wo837x5s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> We can now delete the old .texi files, which we have been keeping in
> the tree as a parallel set of documentation to the new rST sources.
> The only remaining use of Texinfo is the autogenerated manuals
> and HTML documents created from the QAPI JSON doc comments.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

