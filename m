Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF07BC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7575720706
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n2Ba4DCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7575720706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igEsy-0001JZ-LK
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igEjC-0006J6-DM
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igEjB-0006ok-3t
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:13:30 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37549)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igEjA-0006lu-Tm
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:13:29 -0500
Received: by mail-oi1-x241.google.com with SMTP id x195so2591257oix.4
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 13:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RMrXhnl08yOQWoHsGq/Mqy6tAi/gvfJoz02znJajxJM=;
 b=n2Ba4DCcTtQy+TuObNMMxs6W75KYEp7QP4qYVJefSlzwufoqhGmr69lW7Y0J7nBj53
 NuQ+7XCu3ltts5rk+7ISqXvQ3xyzBoPY6Ii6wmrnZM3UxXbr40UU7IwrgC7I0P0bHIJk
 LTwV/92yIa74Qi+WpqOjSNELSVLjkJo8l/Nv2hzzMIuOVu7bc1WqJQ9RQQTn0yLspap7
 QyW9A+TWkC1Dk6x5DPa7YZ1g+4mOuMRqmjU/HiuM+CvZorTbWbibyjYhDe5PZwP7QI7S
 iw9ROzPqsjxlY9Bn2L+ipJXy1iV/044q866OBk6qd3XVi1zI0nFNmBQEn1oTSPfOw1np
 f0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RMrXhnl08yOQWoHsGq/Mqy6tAi/gvfJoz02znJajxJM=;
 b=F84M5hkjAOgqabuzHBRLENQDzTlQt3hsD5Sb6sIjlhejTr2Vj4y1sBSd/JPc/TK5/j
 vWbiZ5o7r9Wp3460mXIcGgrCuJ03Fl8mBZ2CGO3fEPWUHs1pS8XQzYFaCMz9JfNfR7GB
 1zX1rtllOSC2vInpLSzaYKq8kt6ZvaJyCL3MGoXFUEgE02DpiZ+Qq8d1B8i3p7+ujg7S
 5xKUkVFxXEuYic6lf6QjAB7wzdVg+7rf6Zs6Qx9qbiKtL8uEOaxHWKCaPxwoJd8EWNz0
 0Gr/Dz/TEbPxbe1+DfJcWImj1wRJss5l9NbHvvajcHAkjzGL50tAVbLsMVzsAHnfedMT
 StBA==
X-Gm-Message-State: APjAAAViwBCX/Sqv0Sg3WYYn9ChPvprfkSd3n2qMPS20Sz2drGUkR1bu
 eR5RDqi45TW5UMTQ52atxNl1Uvtn1kHwiW7r5hRO6DlB
X-Google-Smtp-Source: APXvYqzzYIkxNYHSaWs+IMMqyvA2I2sxvou+3EOiMc1p3klHz2Q0lFygIlhZJZ4ZtzbhteGwQHNqN3WCW60QXniIRH4=
X-Received: by 2002:a05:6808:996:: with SMTP id
 a22mr8108069oic.146.1576353716975; 
 Sat, 14 Dec 2019 12:01:56 -0800 (PST)
MIME-Version: 1.0
References: <20191214155614.19004-1-philmd@redhat.com>
 <CAFEAcA_QZtU9X4fxZk2oWAkN-zxXdQZejrSKZbDxPKLMwdFWgw@mail.gmail.com>
 <31acb07b-a61b-1bc4-ee6e-faa511745a61@redhat.com>
In-Reply-To: <31acb07b-a61b-1bc4-ee6e-faa511745a61@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 14 Dec 2019 20:01:46 +0000
Message-ID: <CAFEAcA-UdDF2pd24NoOqpXSTnHHFWdvcexi5bRzq6ewt5vrrWQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Simplify memory_region_add_subregion_overlap(...,
 priority=0)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 14 Dec 2019 at 18:17, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> Maybe we can a warning if priority=3D0, to force board designers to use
> explicit priority (explicit overlap).

Priority 0 is fine, it's just one of the possible positive and
negative values. I think what ideally we would complain about
is where we see an overlap and both the regions involved
have the same priority value, because in that case which
one the guest sees is implicitly dependent on (I think) which
order the subregions were added, which is fragile if we move
code around. I'm not sure how easy that is to test for or how
much of our existing code violates it, though.

thanks
-- PMM

