Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0A5C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC32520663
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZGUbMC/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC32520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGItI-0002eN-5z
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 04:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGIsU-0002CN-Qk
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGIsT-0006R5-Fs
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:56:10 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:42579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGIsT-0006Pv-1h
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:56:09 -0400
Received: by mail-ot1-x32e.google.com with SMTP id s18so3016710otr.9
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 01:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=koQ9oAGfshrcRHgV22ws4BNgcwoRE+Jv7RRssQFdKHw=;
 b=ZGUbMC/81okYklbErePacxv/K9ygj4BbpzOcP+gUQlZUnjRT3kWo/HX/mPkfQ9C8ef
 Gvx2W/0l//B8FOxr1A+pIdzJ5mGgQfHzD/q77sWVAu7e3FHrbcOraPw7RwJCg7IsJJRr
 xX35T1jntrdZufvSO8YKQ3fbbXL/7T/jA7XMzciWu13bBvy/YD+fQOmcJFEzRf8ieCmB
 kZt51PcaDd1J6k9OJBoI7aTQu1ZKX35fvW+c5htDcHyCRC26W9asf/JCj8XXZtdKMrwE
 BS0mqYNW/APttRZqtR50YTpobrITRI8NxsSDfgJeAAggMQkoFuK2rpvixCZf2VAy349a
 aVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=koQ9oAGfshrcRHgV22ws4BNgcwoRE+Jv7RRssQFdKHw=;
 b=h9WEPnyLu/vNJ9NesI1VI5uEd+vDOq6q2vcYZfn+HKaKlNzJnP+27MjJ8i6wRvW1hZ
 cA/M53LJRqIBLdINt/kT9aA8TnT2zlfmYaT+62XqM+Ygv3VVRwjy5+qqiD4ERgT8XeK8
 IBKd2p6Atkpo2gFKgQ3quQcJObDPp2n6LMij7crzn21L6mpAccmBOGk2F0kUYqfAblyO
 tnOSvCvLTrs6fnl+IjGtWjcQq9hOiohP3UaRoHXvJ/hL/8zZvghMTO9jHTonAkqHp4dy
 FYfqFOLL8ThvxQnHA1FvQAm/ydivpCcEcjuWS7StUIl2f6c4heKxYJU9ty0q4rSMenDC
 3QyA==
X-Gm-Message-State: ANhLgQ1rVKxP3HWc2XIK7O+9NgMhOOifCdstuUrfZJCXZAWAvLwAmUTb
 tutnqjsKU3U0etvHwvIrhwrXWOifKaak/XAgzzVi6w==
X-Google-Smtp-Source: ADFU+vtWsgSkQYZVODebrMCg094btkYRw7g+0ntB6ECtLUu3uOpyN6lOCSnL49r5iwOaWw3aK31ZVRiiDlHv1OqjyzQ=
X-Received: by 2002:a05:6830:1f39:: with SMTP id
 e25mr2133080oth.135.1584953768173; 
 Mon, 23 Mar 2020 01:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200322171635.678219-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200322171635.678219-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2020 08:55:56 +0000
Message-ID: <CAFEAcA-Nx0btFO_g8e5C1Dm8bQSx4unnqGKvZ7XAX9R5KMyCkA@mail.gmail.com>
Subject: Re: [PULL v3 0/1] Slirp patches
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 22 Mar 2020 at 17:16, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit f57587c7d47b35b2d9b31def3a74d81bdb5475=
d7:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-03-17'=
 into staging (2020-03-19 10:18:07 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/slirp-pull-request
>
> for you to fetch changes up to 9c1f4f1b9bb4e5df43c4267d519938c1a2aa8e27:
>
>   slirp: update submodule to v4.2.0+ (2020-03-22 18:04:14 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Marc-Andr=C3=A9 Lureau (1):
>   slirp: update submodule to v4.2.0+
>
>  slirp | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

