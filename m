Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB63C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:03:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B7D2086D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o54X3Jik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B7D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqx4p-0007Jr-1Y
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 06:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33068)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqx4Y-0006vK-R8
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqx4V-0002Aq-MW
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:03:33 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:32874)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqx4O-0001Ni-Da
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:03:31 -0400
Received: by mail-ot1-x344.google.com with SMTP id q20so54727602otl.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 03:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P20WdgtHqqVlbO2NgdaGAJ5MUr3dVLCfw72U5U/80Qc=;
 b=o54X3JikoqUHgr43FlQkaH2ThCcspqj5yOvvrCczmpnhfWmdn9MabfQhBtGzslD97M
 MySjNX3S1v8Uh7NR1Z8v6n4FA4a8NxmrQvxqEEqnVTGTNz07grVyiHbrIpmsMrc/Cmx2
 hSRmHk6nZCQ3wg1IaurAiJiduhPZYpcQnDxcxMzsEz3HxP7chsx0/2zxrnK8D4G2XXOO
 qQi+1CC5tEI5Y6uIODRC0OA6HeptSSlZ+lM9AYRw2zck0NVXgd7T0XzBbGDbgZzUuW43
 7IM84JK3ymu0kPAAj8jgAbM1ijpWeXuGT+juiEQDyt7m+PhvpOWqpj1iM0j24ODmoZVX
 GKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P20WdgtHqqVlbO2NgdaGAJ5MUr3dVLCfw72U5U/80Qc=;
 b=EvUF9mhmXovVXbCkEZ/dMMoK4aBGMy7S6pPo+etU5aggs+kLyi6sxXMNPfWdfFW8l7
 VxmzPn0eJRIZKRMDXjwA/q0xe+8SR/JYPJsTa676UH4q7bMr4phmnX2Yh5q40gdvxzZZ
 5SnwnDeqJam+gDu9kTtgySeUWTDse0xuPuG7NTnsxE8Zt4nZ8IGNaGEv1cqqVU5p3Tdn
 NdmCwXgNfm2vSK/pJbVeF/VjRMqd9uSzOjVyuGeDjtbey4Fke3AwiMoZIzWebETPUybk
 KlmByUV1ULIk/34gms/2ABzrY2XBUnJHkdsu63/KhJQVblWmLesjdU5Vzi5uKhx6UnBL
 /tqw==
X-Gm-Message-State: APjAAAWPwVEip/2ZAHxiDO/prKZBGAyYSiUQA2sgheGZpVvkEia8cnZE
 SbHuQ7x4SL8smTilxLqvMXDGZYCs4F384Y4TcPbFMw==
X-Google-Smtp-Source: APXvYqxsrhHxbkq+IYHa7rObxSwM+dHpDXuYUUnHjP23Wssj7eDTHCULkTXUvQsXQfsS7fzMvVcRoMT2XPVXlAzuc9o=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr21085506otk.221.1564135402023; 
 Fri, 26 Jul 2019 03:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190725163710.11703-1-peter.maydell@linaro.org>
 <20190725163710.11703-2-peter.maydell@linaro.org>
 <20190725170228.GL2656@work-vm>
 <c5a0799e-2ebe-5a79-915a-af52d471a589@redhat.com>
 <CAFEAcA8PROpFeKfxXFdVvVoZaus-MsX_EHGxw+yEUty_mnQdMQ@mail.gmail.com>
 <20190726095925.GF2657@work-vm>
In-Reply-To: <20190726095925.GF2657@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jul 2019 11:03:10 +0100
Message-ID: <CAFEAcA_Rtv8sCk+JKBUWKYYg7drqj_8CTkCfxjjCzKz3rPuQzA@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH for-4.1? 1/2] stellaris_input: Fix vmstate
 description of buttons field
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 at 10:59, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> Don't worry; you can always change the int to a uint later without
> bumping the version again.  Unless someone somewhere has a device with
> -ve buttons it'll be fine.

The number of buttons is a constant set up when the device is
created (it would be a QOM property if this device had been
converted to QOM; as it is it's an argument to the
stellaris_gamepad_init() function) and the num_buttons field itself
is not migrated. As it happens the one caller of this function
passes the constant value "5"...

thanks
-- PMM

