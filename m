Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F242C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:46:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA07E2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GszemOh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA07E2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibm2R-0000jA-18
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 08:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibm0c-0008H5-Dk
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:45:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibm0b-00021a-FD
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:45:02 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibm0b-00021B-8x
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:45:01 -0500
Received: by mail-ot1-x344.google.com with SMTP id i4so4192052otr.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 05:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UNCsfXRsfWtMe/ccNNxw+9lM/I8D9p1NJg7vYX4iwto=;
 b=GszemOh2qwGzBLjApmjYSNZ2JTIrzG+/uWRRrnG15sjyz/gqhzW050LjQ7RzIVOFMh
 d/34ZiuyCFqlDmSgEREJEF9kFaXCVd6dksSzcYTV73OdGkab5RntwQzuAzZ8sLicqe2O
 9phzehzJGyEQL4sWDYRWol0qaRDk587Z1bjdU/cBRWIpjMP10hBnn5VWrCk9e2mHU09S
 mwaRUsjRJQHQ86/QPFGndOlwnv7iQNpJ0LwFVe2GjkCx9ae6tB4NYcxdku9YNIZaO1kK
 +Zodi3RNp3RhI6vRedjt9/vgUtceKpadfK5LfZ6j2D9u/9BgxqfIJ6l8lGJAkPwxiNjw
 j61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UNCsfXRsfWtMe/ccNNxw+9lM/I8D9p1NJg7vYX4iwto=;
 b=tNfPC1vjTb7rzfhomY0clnyRRFxTIWOnMNw++iNH2SJbCE+Zpq5D/TiLa3pyfXJNmr
 90B9jBrk3NWoHtCglsYeLc+KRHU0qH4AbYapKXS8wbLiymB9k/VI+XWVERbwOSYV7AuO
 rHCAb+uX/YTrLJE4pAlVD/c6S6YN+iKW/cLb5F+J6iuNomoAaNY8+yF4E6oFtPH65wAo
 KlkoPpA2//Njy5cOa44TBuV96iUrNkmSdHTySKIKlKvQkW56WDScr72pmMhE8j4J6lYE
 3D00t5NrtM2AFVkAVbv/XzcBCBJOljAdcFI/h+bNkr2eANLOoQU39e3BXHHQjEZGGcF2
 qjog==
X-Gm-Message-State: APjAAAV5ngztxnTPJYPid0IHfjGeSFks2kvPbEz9JYgNH43BVH2AWt4r
 N+XGlmHL0Hcd5WY3FHYz5tsYsDvaQUXI5Zmf51Ke5A==
X-Google-Smtp-Source: APXvYqwMNW5R89L7qSQaUOBmrKmhK1tiHhCOovvXGkXCQgCihROMR0Q5gW4mZsY+lwlAt1iLqkCLUlfYytHIK08qI4w=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr22150584otg.232.1575294300474; 
 Mon, 02 Dec 2019 05:45:00 -0800 (PST)
MIME-Version: 1.0
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-3-damien.hedde@greensocs.com>
In-Reply-To: <20190904125531.27545-3-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 13:44:49 +0000
Message-ID: <CAFEAcA8mBqt-zpoYGQYa1OwRzT90Vx-QUEWcsDH=eFecXVk+OA@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] hw/core/clock-vmstate: define a vmstate entry for
 clock state
To: Damien Hedde <damien.hedde@greensocs.com>
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Sep 2019 at 13:56, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
> This was in the previous reviewed commit. But it can't be in the
> clock.c file in order to allow linux-user builds.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

