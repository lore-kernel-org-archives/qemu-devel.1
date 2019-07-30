Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364A4C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 16:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F122120693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 16:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5/Z5B2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F122120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsVHm-00031S-8k
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 12:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55242)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hsVHE-0002XI-PM
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hsVHD-0007wL-QR
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:47:04 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hsVHD-0007w0-Lb
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:47:03 -0400
Received: by mail-ot1-x342.google.com with SMTP id s20so1522434otp.4
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nUkRSKmD93EEaLhM8tNdzGVabn/OtuV4nTMemeBGWHA=;
 b=V5/Z5B2nzOXRzWeTVqCQ55MDNnGl2HBP/bmAySM+cRNa4/YEL249lTHRJtrMJ50oNR
 Svp3FBDGvcg1/d33ohc9PU3ZeKC2GaYBlYcZmTExS6rCcMpx/ClkjUkQg48AIwNcJI9I
 7SVk+g4H8EOmUdtHNOLsenD4OdTxNZQKLE4TZCVlwlcaGH3F343TRVAZH6YqDk+En/by
 YyZ49xNI45na6CfxkJrOQiQRHbOSvLqCQO7HgqQ4bKb0l0mhWzA4K0YCPBE//BAQ3McB
 PWsrL+VpOG8jlo4Md8AX+fbdb2ZAogEvbmeJSL2Rwzwy9w2JUh/CEUAd4yBA1Y+hW9zw
 YbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nUkRSKmD93EEaLhM8tNdzGVabn/OtuV4nTMemeBGWHA=;
 b=IbbCNamDOrTUITVXHli33Tg2il7Lnl7Q+M56xNGNoCIzVr2GrSDdo1P/1ITGXB/jDn
 6DKdSfAkUyEX6sIBa5LvFB31oNnGm+Tr9Dn/a6gDpD7EPao3wr+PvYrRRLPa0YO83i09
 pmCqFK1cVqDRgDZQ1oYkHfCFnbIYrGqUD4avhfe+Tp+nTtSrYOac0aN0hSkDXI9KM6XA
 BfXvpicokAfsCylIkb9yRo900/oJgNuKuJR+BC73jr8OWBhPxikvFJd0xdCsX+HQZ1oA
 YPMtmqiPtsY1cp55g01wK//08g2s7hQCp9NRaZPE/z3+9lFbT6Pn1XnonQRvPNWOjIb9
 8/wA==
X-Gm-Message-State: APjAAAXwp1DAnAfLr0b/UcVgcLGOAjkiNXkAPbha+rjCwx7YnTsEBS+O
 pnycVl7gjWa8DrYsHnY8Y/JCfPmDmmCYeth04rjLsg==
X-Google-Smtp-Source: APXvYqyWW4S8ROi5zSb2O8UjWKsqQufpGz3Z+VohcQPodGtBNPBYt/C4m+kskBsFObP65wB6ekYyoLuC4mMlqVEv22M=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr80997084otj.97.1564505222637; 
 Tue, 30 Jul 2019 09:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <1564502498-805893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1564502498-805893-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1564502498-805893-4-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jul 2019 17:46:51 +0100
Message-ID: <CAFEAcA_M7kTA-tmdNdP4-pVjKkdzHFXuSeR3wKYSohK+W38m+Q@mail.gmail.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 3/3] i386/kvm: initialize struct at full
 before ioctl call
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>,
 kvm-devel <kvm@vger.kernel.org>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 at 17:05, Andrey Shinkevich
<andrey.shinkevich@virtuozzo.com> wrote:
>
> Not the whole structure is initialized before passing it to the KVM.
> Reduce the number of Valgrind reports.
>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Does it even make sense to try to valgrind a KVM-enabled run
of QEMU? As soon as we run the guest it will make modifications
to memory which Valgrind can't track; and I don't think
Valgrind supports the KVM_RUN ioctl anyway...

thanks
-- PMM

