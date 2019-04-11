Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6524C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC34217D4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/CRXf19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC34217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44860 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEVpV-0005ct-Mh
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 05:17:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEVnP-0003zE-Ca
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEVnO-0001Z6-3V
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:14:59 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:40046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEVnN-0001YH-97
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:14:58 -0400
Received: by mail-ot1-x32d.google.com with SMTP id t8so4585661otp.7
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=wJjs4LCJqv7DdanGHJBnXCZVPSq+EIC9Fc329UCVuA8=;
	b=O/CRXf19/d2HoGXQC5USvo0O2WuhJTbHo7WRZZC+7yZ2wVS8dFIUoStfl8LXaOoA0M
	c+4SVCpW4zQjei4DKE31r6jLWNrvlpXiYB+JLpTHnW/Ls5X6Ko8tGpIqNaqxHqCbDoEq
	MhCWJTe+VmOsyrCH8Ac7al5fH3Gewd8sY6ZJZbprL6hCx1J9jFqsSY2NHk25rTxE1sVi
	SxHOQcch5hDGl7cdaqG/aE+NKLQkh2Mzr43QrUcyUUHbqDWlBWxCyELv7f9rf6XPgzyf
	cSt+Z9BkKmcdXfJkb6c0RjNVqjRBzqhniubismK7lAD2N1VKDU9q/ZMaSVJvAl32me1y
	0yPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=wJjs4LCJqv7DdanGHJBnXCZVPSq+EIC9Fc329UCVuA8=;
	b=BTOjrMTPjSowY45PQ3TUqmq1zOll/tJ7X3LBF5N8agxlpX8t//+9yaGEHwmZWJIcmX
	WbDMPfG/TaIUlnSJwY+QwuV6Y3Ex3VvQrwEfblGkeWKDZqGP2ypchcAWvo42QBz1ykfA
	985flHWupC1cyzqZyz9GDWnFkXWea80YqLpzFEAa/lL12uFPMiBNuP0T8JTpboeCGlyV
	3/S32cN3z7EBt1xBZCxkntvgOg0HTxrcRbQUe0M4/vnUVA/T+hC7X1STxqUlPVB3Tgpk
	0Ns/rFgi2DU4c3L9YTnFLMrpYpO2O/IOhsOTnbVCts2NaPI1Qz/+vh2HWIVPeZw5kdcZ
	XNLw==
X-Gm-Message-State: APjAAAVYdjmAbcSk4sJDUOJzryEJjPSed/929GoiP+5ZyiKGZhjCttgo
	UrpzvZg/Iq62OraDx186DdZp6P9fbOFnNDKnfK7vWw==
X-Google-Smtp-Source: APXvYqwIqF4qTdjIf7SfFAJnOtP8Jfl0jRXmno9GXritXRvXvSCWYRrc8stX/1e02bLzdjDv6mSPkE7YHYXnk0f8cfU=
X-Received: by 2002:a05:6830:1cb:: with SMTP id
	r11mr26522257ota.302.1554974096267; 
	Thu, 11 Apr 2019 02:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <201904110044.38853.randrianasulu@gmail.com>
In-Reply-To: <201904110044.38853.randrianasulu@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2019 10:14:45 +0100
Message-ID:
 <CAFEAcA9NN=wyVz5t+See_1dgvDM1xJ=_OPd1QWwiFMUASzoLaA@mail.gmail.com>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32d
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 4.0.0-rc3 is now available
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411091445.zHNk-8VVxDHmQnTKISAgZgnLJIAdcbzTXVY81Ei36v8@z>

On Wed, 10 Apr 2019 at 22:51, Andrew Randrianasulu
<randrianasulu@gmail.com> wrote:
>
> Please also include this patch in next -rc or final, it fixes 32-bit compilation:
>
> https://patchew.org/QEMU/20190402073018.17747-1-kraxel%40redhat.com/
> ([Qemu-devel] [PATCH] curses: fix wchar_t printf warning)
>
> without it I get
>
> ui/curses.c: In function 'get_ucs':
> ui/curses.c:456:25: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'wchar_t {aka long int}' [-Werror=format=]
>          fprintf(stderr, "Could not convert 0x%02x from WCHAR_T to UCS-2: %s\n",
>

Rats, I'd forgotten about that one. What platform does it fail
to compile on, though? I test on 32-bit Linux and Windows compiles,
and they work OK.

Also, this will be only a warning, not a compile error, in the
release build, so we could get away with releasing without
the patch applied. We'll see if any other rc4 issues come up.

thanks
-- PMM

