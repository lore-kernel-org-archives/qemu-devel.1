Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A38C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 20:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC4520719
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 20:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sv5GzYNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC4520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDw6M-0005c9-9u
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 16:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDw5T-0004Lv-Th
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDw5S-00017H-Pg
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:11:47 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDw5S-00010C-KW
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:11:46 -0400
Received: by mail-oi1-x242.google.com with SMTP id d63so19246871oig.6
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ijs2BAIZQngYJr60lDXDIztUajpq/leFmXIdziG2LkM=;
 b=sv5GzYNwiSh3FeS0FRD8JM9TyIwu42PNDUBqb2XRpr7JWlyBhsNwNdpjQBWBU+l1bR
 WN6v2XTv991YfA+F1LJE3nqARuovbsoRT3n4bJouPNyhgwsi6Fl2xAIdDG+rNfRWzw9N
 BeyPq/wVWSA56Wg5t/+hJhUDQuLoL92VYEEyb76M2cFYJjW/MPndakK64X7XPFlhMDcc
 MnKhzJo21aBHp9XNHOLp4MHAGgi6uP28iPP2tAmsbd4osuHZ1UQKD6YU81yz+a8mt1wv
 KExbnv7HV333vv/xrvNbN6VMES9N3EELGs5ODy6fE7X+/Obh6Cw/X+6S1RJdf6t6o3H8
 OnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ijs2BAIZQngYJr60lDXDIztUajpq/leFmXIdziG2LkM=;
 b=gp+LLwY+zw81AmyO/8bGXzq5501AYmsQ+qG9XZvO37rLywKDwXWqUbZbNYi528nYli
 +ZW8qoOxmWrD16jtKGKK7pH1zEaUL6b2TdOhMpHIy8RiyjWZ/h08fjS1mD/96KE3rzYT
 SScXZzgRYDOSxOxYkWLr/KDLzc3Pa93W9FaXFUtnmmhCLxRExBusr8Bctpgq122rip2J
 Cu5qXpwCfth7g0ZsjMIUyZz8PK+Dw3aidMFkjafZOAZtiWlQux9OxxBB90geENpnmAtE
 +m8gDrxwQdY9H6ho79cKsQmTqr1o//RuOyrvuMN5PC5ijmU2og01Gim2q8kgkKdHv0Un
 NMxg==
X-Gm-Message-State: ANhLgQ0gSn/L6JFfN8MPz3PPI1e50bPQW6OY6dqrbX6wZM10xaaqguw1
 ehk8gQI3XpUEsSgd2cMx3XydLpwXko2kdzXxVE0WTQ==
X-Google-Smtp-Source: ADFU+vuNAGWfTNfTG7BCG62IAVcWTMGcJnSdFo65qjGsPUVKe0hQPlhhs0R7X5BcJqT9yHK67QFaPQIXmPb88pVygO4=
X-Received: by 2002:aca:190f:: with SMTP id l15mr937814oii.48.1584389505745;
 Mon, 16 Mar 2020 13:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-4-philmd@redhat.com>
 <f570579b-da9c-e89a-3430-08e82d9052c1@linaro.org>
In-Reply-To: <f570579b-da9c-e89a-3430-08e82d9052c1@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2020 20:11:34 +0000
Message-ID: <CAFEAcA8K-njh=TyjS_4deD4wTjhqnc=t6SQB1DbKgWWS5rixSQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/19] target/arm: Restrict DC-CVAP instruction to TCG
 accel
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 at 19:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
> I'm not 100% sure how the system regs function under kvm.
>
> If they are not used at all, then we should avoid them all en masse an not
> piecemeal like this.
>
> If they are used for something, then we should keep them registered and change
> the writefn like so:
>
> #ifdef CONFIG_TCG
>     /* existing stuff */
> #else
>     /* Handled by hardware accelerator. */
>     g_assert_not_reached();
> #endif

(1) for those registers where we need to know the value within
QEMU code (notably anything involved in VA-to-PA translation,
as this is used by gdbstub accesses, etc, but sometimes we
want other register values too): the sysreg struct is
what lets us map from the KVM register to the field in the
CPU struct when we do a sync of data to/from the kernel.

(2) for other registers, the sync lets us make the register
visible as an r/o register in the gdbstub. (this is not
very important, but it's nice)

(3) Either way, the sync works via the raw_read/raw_write
accessors (this is a big part of what they're for), which are
supposed to just stuff the data into/out of the underlying
CPU struct field. (But watch out because we fall back to
using the non-raw read/writefn if there's no raw version
provided for a particular register.) If a regdef is marked
as NO_RAW then it means there is no raw access and we don't
sync the value.

(4) I think that in KVM mode we won't deliberately do
non-raw accesses, and a quick grep through of the places
that do 'readfn' accesses supports that.

thanks
-- PMM

