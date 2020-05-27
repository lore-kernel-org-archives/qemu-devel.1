Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BF1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48FAF207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sW+4cDGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FAF207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxeG-00020W-Hw
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdxcY-0008Q4-Be
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:05:31 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdxcV-000771-SY
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:05:29 -0400
Received: by mail-oi1-x243.google.com with SMTP id 23so20767053oiq.8
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 08:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dyrz/8dGRzaAncUEaq6xyK4el1L3Q9/hNtf4U4CU7t4=;
 b=sW+4cDGdqER7eUyLRX8+YHiKQKiueP/na32GTe1ZzVI4j+j5zpZcUu4np1xzIwBvyB
 jB39grR39Bx78WRGGNmEdj7qnth1lRxRjmkPa9IWbCsuzBAQ1kReFVlDfyqk7T8KJ9B4
 6rcVnPINySo2iG08twJ8ue9lSG1coI5/siTVGUwA4zwdtTSA/pHGinvqzPdhXsfdhDDz
 T5tyUCNHwC/Lk4SLoQ/teiWE3Xz0nV5KTvEmBgU0WIjmGAqAe1ZFg020zDUnlp93LRLG
 I2rO5WlAJqJR1kiOS7RJSTm5RPmEmS6hcYBrm7gMEFmO7fREvZ8YzsRxxmkStmP51lEl
 b+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dyrz/8dGRzaAncUEaq6xyK4el1L3Q9/hNtf4U4CU7t4=;
 b=dIR0Czk27DPNM+uvsYfkSClkdQe5c7gcrrh/Ea207yqKrPexKdmJUSYLmYgA+grMhK
 K7keAcwLOolpyhT7vilCi6CXA0zD5TkzSPoG8x98q1DbJo3ZdovcpdhccdAgMep5d/ul
 w2JzGuhygzEk6BPdi4vc3gC57a1XHt1uBLj5GUPyyz51+fYpqFABT7mHMdZiVnMOUxlL
 XSBLD13LI3y4WOi0eKb5ZO+ronctt6xmV7Yj+gnVvrwfgOTMTeZVkxquwCRYcADaysTJ
 tIhNUZQYgOyn6WDe1pOYo2rR9njbL/CMuaZ9XrRa3vX/03lekPFf/G+1iOzGGaZ9pbuM
 qLxQ==
X-Gm-Message-State: AOAM532igC2SixUam1c74NOhW4IqNMeKbu95pJjlmbdWFy+I0/lszfLc
 8K2Dx5H1sPdvBZMcds/5y5Pq9s18CQEnk+zBMyWFlw==
X-Google-Smtp-Source: ABdhPJw5C2Z75OyuqPS9wvoA2+dHkgypujOr27ZfQnDOOnmoNWvZABJ5wwNLO9CQRWmv4LrUUHCt0jARXP1RgMsODHw=
X-Received: by 2002:a54:469a:: with SMTP id k26mr3001742oic.163.1590591926081; 
 Wed, 27 May 2020 08:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-10-armbru@redhat.com>
 <CAFEAcA_S_JsuPG4UN-_zhhdZppBhiwm3-4bocO7O1XdjxC9bAw@mail.gmail.com>
 <87wo4xxya0.fsf@dusky.pond.sub.org>
In-Reply-To: <87wo4xxya0.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 May 2020 16:05:15 +0100
Message-ID: <CAFEAcA-9CU8QPeafAf_VSh-Gu2WxLpEoRdUZpv+TOF0Rpq-MXQ@mail.gmail.com>
Subject: Re: [PATCH 09/24] macio: Fix to realize "mos6522-cuda" and
 "mos6522-pmu" devices
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 "Daniel P. Berrange" <berrange@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 27 May 2020 at 15:12, Markus Armbruster <armbru@redhat.com> wrote:
> * PATCH 08: in a realize method.  Can't actually fail, so let's use
>   &error_abort.
>
> * PATCH 09 (this one): likewise.

I disagree with these. We're in a realize function, the API
says "on errors, report them via the Error* you got passed",
so we should do that, not blow up. &error_abort only makes
sense if (a) we have no better way to report errors than
to abort (which isn't the case here) or (b) if we can guarantee
that in fact the thing we're doing won't ever fail
(which we can't here without knowing more about the internal
implementation details of the MOS6522 device than we
really ought to).

thanks
-- PMM

