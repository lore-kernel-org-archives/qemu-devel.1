Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2DDC3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73CFE20836
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guGsAumC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CFE20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9BGJ-0003o5-FS
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 12:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9BEd-0001rk-Th
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9BEc-0001Ue-4o
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:21:35 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:40971)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9BEb-0001UR-Vi
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:21:34 -0500
Received: by mail-ot1-x336.google.com with SMTP id v19so3766840ote.8
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 09:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y1+PkTQlrpdH+in4nomBYqmTaU3YPfwHTIb2NSO9Pds=;
 b=guGsAumCtsuopkEJZSfEu3oHR9TG0vuEFubkXC5PmL5nqp6dz5mnkUjSdnrdgQ7kwy
 YwrE2Gsd8dv1n7ap5Gc1sjqHyhnu6RXzo7NMu3P/wF0jlUhbIXuTrUojJg90dbkadVYl
 tOdNSmxzfXXqAW9xKp+QDCFyZkxqN6ISKJf7jS4WWZs+maA/fLbGKDAXWIeSNQcKKQS6
 UlyY1pUesDDVV/cZ3RbZeAuUqHcbDhZk8U1p47RudtObsIVaYgwCNlZZGNYCNzIFBbG5
 c8PB+1iCngCNlelkanFOU1xMNncrkbhMuZWlvFZ6oMe722Ot4fpw41zDKbNRC9WJrIaW
 rgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y1+PkTQlrpdH+in4nomBYqmTaU3YPfwHTIb2NSO9Pds=;
 b=O0Cao4Lr9JgEmBD/WglrHa4t71vKDC4w9KcEeY6F/CpeHY5DGOERftGZcCW7aYYRdw
 puAvKjyWtiiGPIFkX5xIZrRn//jyJnqqHaZ1ngLFaYwkBR3n2ipc8lMiyNSd1LzX+5YB
 bySzRJRAcRPeKdRqWG4Idu1/EeRBejoOLwGubiXw1dB4ioRhE60mqDueC3tcIqCJ/Qn6
 DtWYqDpUQ7SH3ApdM5PkOwc1t26B6uazK61pV/S9dDFh0d0h7Rx5AlSgZXKOLTndsFoa
 A1tq/YoqfEb+DZEIVZoU/pPy5EJbEAH/48pxhKThr+ivejumWYvWp4NpaOgmpihoFOCa
 DXgQ==
X-Gm-Message-State: ANhLgQ1Le6KywMlrbf1Klv6TjtQ5mQho3Vm+H5rvxGa6r49F+snLIsVG
 lNZEQcCmlO+WsQ9ZaFn/F/sk2TTKhQHAcI3n6l+kUA==
X-Google-Smtp-Source: ADFU+vsUxvuAOJLycPTTFbYjiCc09gkpSg+pSp1rfC1diQJfwFNipk08oKc/BYpWxLvFfzTZGki4WZ9nouNH7P2Hak8=
X-Received: by 2002:a05:6830:1406:: with SMTP id
 v6mr4256591otp.232.1583256093232; 
 Tue, 03 Mar 2020 09:21:33 -0800 (PST)
MIME-Version: 1.0
References: <20200303163505.32041-1-armbru@redhat.com>
In-Reply-To: <20200303163505.32041-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2020 17:21:22 +0000
Message-ID: <CAFEAcA_g=ghK1OO0dTdEoYL2Gon4gPff4pfj5kEo8C1v8N4=wA@mail.gmail.com>
Subject: Re: [PATCH v2 00/30] Configurable policy for handling deprecated
 interfaces
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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
Cc: Libvirt <libvir-list@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Mar 2020 at 16:37, Markus Armbruster <armbru@redhat.com> wrote:
>
> Based-on: <20200227144531.24309-1-armbru@redhat.com>
>
> This series extends QMP introspection to cover deprecation.
> Additionally, new option -compat lets you configure what to do when
> deprecated interfaces get used.  This is intended for testing users of
> the management interfaces.  It is experimental.

How much do you think this is likely to affect the
generate-rst-from-qapi-docs series? I'd really like
that to go in for this release, but this looks like
it's shaping up to be a big conflict :-(

thanks
-- PMM

