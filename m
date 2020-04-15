Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29102C2BB55
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB35220737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KhPc6Tx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB35220737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhN4-0004oM-0Q
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 08:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOhM0-0003vT-9c
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOhLx-0003dQ-Hq
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:41:19 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOhLx-0003cy-9r
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:41:17 -0400
Received: by mail-ot1-x341.google.com with SMTP id g14so3180447otg.10
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 05:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2hfbt2K15csCGvIx3QO/hVwsuFsbfh6/5w3bbgIgOk0=;
 b=KhPc6Tx8F57fncSLkiACqyRc6Xc8vSLnhul0OSweWzKF0zhEPqaOetFEVCZXDKEoUj
 AXShra4wkNjMJSJGwGwrXhnFAew7CS8UPsMrEuK15eHx+jVH+rYes15sXQzcP15H/p17
 SD7qE1Ofwr6YHk2CEcl1UdBrXvUEJxTC1Iv6AAgeGgGvwBeKHS0HgjILbUiK7YrHRG3+
 g+EWfxN9GrBtCmNT3jj19lRFvoEJs1Hyf5JY1oLXB5LwDJnC4XfVWsvtNi1K1liQkfx4
 j6btNl8Q91JoSwS0724lCAHdnVazmBZIJT2qy59vmWvNQ1xcFBj0s9W3o1cq3+qrCzcw
 qCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2hfbt2K15csCGvIx3QO/hVwsuFsbfh6/5w3bbgIgOk0=;
 b=elXCH67og6rj70+y73BQw6aminVNy4gjdCiFqrwvLHmKBXMqko5gzhHw0Qv0uKkKhm
 9NbeEIUaghfZDZjetDgF3Ol1mSjyCkQVlG2+hr8PUGqOk+PGuXe888quaA5Njj+lyMjU
 MC5sOTXXNw9vf8373SGf0SH7cUfeCwcM/3sMI8w5a8jRxIcGrgfDv3gGse3E9lGJoSMp
 +kEPVX+ZVQIUhIbZtTd0x6uFAlesJTD9myBFs/N3vpXupn6anBb3Q2U9ytLoJnFRdjoS
 DdY0NCHQvv140+weRJWeBcwKX0GnJ4fImBXwPciGskgIBoLFYEZQyzdEARzlQ/KFj1SY
 2aPw==
X-Gm-Message-State: AGi0PuYgTqyX0cUQxAPeuzl5H+NUXoTZ4IjyWjNj8nb8KpoR/II7arsb
 qTJLshNAKpmpDiLhYf4gEg/dAcj7bpB+AE/3eSE8HQ==
X-Google-Smtp-Source: APiQypIItO82/GocMFCPY6s/peMkrrk5tCVQY0EzuqOxXrHZ0yHAchSC8fQW26ifmZWgK5bJ5lbrpgqR5F3r7nUZs+I=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr1248988otc.221.1586954476361; 
 Wed, 15 Apr 2020 05:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200414120935.12719-1-peter.maydell@linaro.org>
 <20200415123310.GC1344391@redhat.com>
In-Reply-To: <20200415123310.GC1344391@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Apr 2020 13:41:05 +0100
Message-ID: <CAFEAcA80g-Zohi0t7u51aNs58i8_zPCOcRob6zx6DYdTjYfXWQ@mail.gmail.com>
Subject: Re: [for-5.0] Deprecate KVM support for AArch32
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

On Wed, 15 Apr 2020 at 13:33, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Apr 14, 2020 at 01:09:35PM +0100, Peter Maydell wrote:
> > The Linux kernel has dropped support for allowing 32-bit Arm systems
> > to host KVM guests (kernel commit 541ad0150ca4aa663a2, which just
> > landed upstream in the 5.7 merge window).  Mark QEMU's support for
> > this configuration as deprecated, so that we can delete that support
> > code in 5.2.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I was reading the 5.7 merge window writeup on LWN this weekend
> > and saw that the dropping of 32-bit support had gone in; just
> > enough time to squeeze our deprecation warning into 5.0 so we
> > can drop the code in 5.2 rather than 6.0...
> >
> >  docs/system/deprecated.rst | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>
> The docs are sufficient to start the deprecation process, but
> we might consider also having a warning from configure, or a
> message on stderr at runtime to make it more visible to users.

Mmm. I didn't feel entirely comfortable making code changes to
print messages at this point in the 5.0 release cycle, though.

thanks
-- PMM

