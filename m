Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA5DCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9772C222C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiPApjjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9772C222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUKC-0006cP-Li
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 11:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLUJ5-0005r0-Hz
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLUJ3-0000ub-Vv
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:36:47 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:40211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLUJ3-0000sp-Qq
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:36:45 -0400
Received: by mail-oi1-x22f.google.com with SMTP id k9so5555843oib.7
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tkU2JoAZAI0BuIIsuGv3Szrk251yw8Yg0yCV9Lh/kkE=;
 b=XiPApjjhXDsyKfGQ6lbOy7vGn48kFsWwfycyCC3wGUtx/wLHgwhQI9WYgcSis1gliU
 B42aAcLZHjS5Dcm0o8AuqdJAemQ8exbJOJo+lk/pRmhx2h86PPEXpogb8RButSQFFjuY
 O+8nONUqM4NXczY5mkRDyTG543cZZTojwU5MXsSgDZliSA8iTZxGF9k1NoXp8A/BwMwI
 DHijB5aM5fDq9W/vFeWCMzx02F/03mjyfEUwPp+bqMIoWCyqTzE53UFKA9saNXtE5W9m
 nkpaJJl4TTWw5UeRR/ClPw8y8NQwn7Pr2Z9vINpO1jOpFpCf/kkk7Q3fZp7CtBWNkEoZ
 lFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tkU2JoAZAI0BuIIsuGv3Szrk251yw8Yg0yCV9Lh/kkE=;
 b=Fe7NDSadsG912wwoBQMQ4ohggfKPzuJWldD3foztK7+WZRsiBYL7ld8VAezq7Vqbhu
 9FQg4sAgAa+xVHlP4ZDaHiIWxLclS0rbbSlKRuFT/fmgZkSMQVjR7XZb9/F+XN0ezIOP
 rlRqLtJnyl0pU+FRC5XI/LhLEzlVkILv9djnw6ferzx9FKVTnHihku4DsxJrCQL5MLlf
 sAkti24jLM8LbW3ctmKw0ZJaZbwKBjanH22VZMNzpc1GO57AyGKHXz8rR/0z2l8XMr47
 fyA8DsHXzTFsl9fAoxrDxEDQ+Gw4tau/inl+A0HO/S8/jPxnvKhL/atNTnsm39XZ4gcV
 G//Q==
X-Gm-Message-State: APjAAAVcPY0b258wM7EAnfmNMDl0xsAn6rGjkbM99FB1nMFnACJJ9mJS
 S6F6448FpkgFkMQNJDhNoYF2ZXowi8CfJ0HSu6/J+Q==
X-Google-Smtp-Source: APXvYqz9NZzolbLlSzusm07bMNfcX8HIde+qJI/L4n9EYws5ULtaPoXOAKJTWPsZYoOrU3SURMVyBHg7gOqm2srP8kk=
X-Received: by 2002:aca:3b41:: with SMTP id i62mr8200228oia.48.1571413004656; 
 Fri, 18 Oct 2019 08:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191018074144.24071-1-kraxel@redhat.com>
In-Reply-To: <20191018074144.24071-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 16:36:32 +0100
Message-ID: <CAFEAcA8dB+yuJCoqfW4rEfDeZ-gBsGALuGb+Hz=deWpWzoqFSw@mail.gmail.com>
Subject: Re: [PULL 00/13] Audio 20191018 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 08:43, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit f22f553efffd083ff624be116726f843a39f1148:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20191013' into staging (2019-10-17 16:48:56 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20191018-pull-request
>
> for you to fetch changes up to 0cf13e367a99dd1abefc46ec94b4c1a80c678f61:
>
>   paaudio: fix channel order for usb-audio 5.1 and 7.1 streams (2019-10-18 08:14:05 +0200)
>
> ----------------------------------------------------------------
> audio: bugfixes, pa connection and stream naming.
> audio: 5.1/7.1 support for alsa, pa and usb-audio.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

