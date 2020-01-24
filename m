Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E248C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA5620718
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XzAT4W2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA5620718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuyBv-0007Pu-28
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 07:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iuyBL-0006tf-Jw
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:35:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iuyBK-00028P-Eu
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:35:27 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:33355)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iuyBK-00027I-8j
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:35:26 -0500
Received: by mail-ot1-x329.google.com with SMTP id b18so1466384otp.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 04:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oNAtJLnuhmMFXycXLNnPn7OxpMKxfxO07z4pOrrGKGA=;
 b=XzAT4W2IoM1bMkR3LSgVDVTu9eb2Z1tCXkew/RPz8RjGmPAwyUMHzTWZUf1ayNPKWf
 i5x2VzzAH8H7z+PmHw8klh2q2wfH1cGP7/uOUUuZkcUAtVwLYOP/9HgBuW9MnhVp9BUZ
 SJ52sGpyguZMmdqpuSbUp+O6jzzSGbqSlJuQUcF2+EBo2LSc7EigBeBtEC+Ogto1lQ1M
 BTj8cjkQwkDpGuKzWczcx/fub8o5KWUyxnal2/dawkPZH4E1hGWuwn1ChAKmBr+4IcYc
 4cpZXVRwGmGQUrhxX/RvXldvNp6jZ2TaX036rPjhGfF5cfbJn5CVsjFTp3nhYCYuYY8S
 fB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oNAtJLnuhmMFXycXLNnPn7OxpMKxfxO07z4pOrrGKGA=;
 b=OgdIQnW7+4UWOymuuFv2foxwTTZTteGSF3xb2MCZWlFd3CKFyzCw5+m5EkwzHusXeo
 WAIgQaq6e6yjCqtg7vR0VujUDzx4hlJc/K3WaAsdedjgXMA7aUV82u1SwX9MGgrzDNk/
 K+Zu8KAY54p/8DcXwLlX7PPgOZ6KSNKhEgh+OkcOL+VO5Ndo9EN2rHc9QJfsxFoba9qt
 dvJWBCEwqAtPZMCxFBbGGKSqVN7j/DPYBfjd9zDM0JXocs7xHwLm41ZuznBtt+0PqB2K
 EBLmK70zUvU7GL4FwfK7EfxtyhXGuqD5mPeK7KWivHV6nhg254K/MciTlF4nSwg6tBIE
 iZDA==
X-Gm-Message-State: APjAAAXZsJVkYcPf/voVmKDJ42jHVSJSp53s0lVGiwJg6xfcbbcyC/SE
 iSCVhJJtt+o8/uvZ9myZW6a4YV2NwpPrEavHL59cVQ==
X-Google-Smtp-Source: APXvYqzk++7qX0uy7J/QkZb1zfqlYyTqpnw5HE4NQLZFa69aWTTeyndiSzgpfxD2wXnYxfLm0R+HS6M9YHIvoRY2JSo=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr2490043otd.91.1579869325298; 
 Fri, 24 Jan 2020 04:35:25 -0800 (PST)
MIME-Version: 1.0
References: <20200121225703.148465-1-palmerdabbelt@google.com>
 <CAFEAcA9YoAjASu4F1hZRjbq5S+h8GtBUVb9dgecMdaWb9YENEw@mail.gmail.com>
 <mhng-ea4d4047-6dfa-4be0-8ce7-424b1d17560a@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-ea4d4047-6dfa-4be0-8ce7-424b1d17560a@palmerdabbelt-glaptop1>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jan 2020 12:35:14 +0000
Message-ID: <CAFEAcA9HnhKE1nS+ubmCD4AgS-EZ_J_XcWapzUvM2pegHs-imw@mail.gmail.com>
Subject: Re: [PULL] RISC-V Patches for the 5.0 Soft Freeze, Part 1
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 at 18:43, Palmer Dabbelt <palmerdabbelt@google.com> wrote:
> On Thu, 23 Jan 2020 06:38:07 PST (-0800), Peter Maydell wrote:
> > Hi. This pull request doesn't seem to be signed with the GPG
> > key that I have on record for you...
>
> When I moved to Google I got a Yubikey and made new subkeys for it.  If I
> understand correctly the new subkeys should be signed by my main key, but maybe
> that didn't make it to your keyring?  I see
>
>     $ gpg --list-keys palmer@dabbelt.com
>     pub   rsa4096 2017-06-06 [SC] [expires: 2027-11-13]
>           00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
>     uid           [ultimate] Palmer Dabbelt <palmer@dabbelt.com>
>     uid           [ultimate] Palmer Dabbelt <palmerdabbelt@google.com>
>     sub   rsa4096 2017-06-06 [E]
>     sub   rsa4096 2019-11-26 [S] [expires: 2024-11-24]
>     sub   rsa4096 2019-11-26 [A] [expires: 2024-11-24]
>     sub   rsa4096 2019-11-26 [E] [expires: 2024-11-24]

Yeah, I have those. I think I must have fumbled something
when I retried the pullreq after doing a refresh of your
gpg key, because I just did a retry now and it's fine.
(I'm just running the pull through my tests now.)

thanks
-- PMM

