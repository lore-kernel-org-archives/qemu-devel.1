Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4915C2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 385C324125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r9Cn8ghf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385C324125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifnLy-0007i6-So
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 10:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ifnL0-00079C-9C
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ifnKy-0000ZW-VJ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:58:42 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:43168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ifnKy-0000Xs-OQ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:58:40 -0500
Received: by mail-ot1-x32d.google.com with SMTP id p8so6971584oth.10
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 07:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1gMq4r3ksiE1RRJUmICWKucGCYMCWCZ2HaS2ZBh9Pl0=;
 b=r9Cn8ghfmB2BicULwcfOrMkEQwG6E9IMaaeWMEHmVlQuBdQ1n6FAqdFKh/pVJ3tFWv
 7e236gGGb17BLo7rMpahhnKTqe8F9EXQsxaczuw+JD+NCm1pLYW6RDw1U+OOqvGf8nKw
 BK0py1tG5aKxR9ylr7PewsvD/lWEDCKD5Nb1gPCsnHOjUZJwNZ6psVx0zhRquWXYlxYt
 yO3i0mB2rcwxAmEHzeQ+XefU9ZmV1VxNMwIclpHmg5fCLUI6dWBtPwbeAKL7C85pDtHB
 ZsKJRRzD6PjGGNAvkIkDKojECX4VAWoZs5AuYzuV9xzGl8wjMAKRHtAMBnV3l6Xu+1Ss
 tEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1gMq4r3ksiE1RRJUmICWKucGCYMCWCZ2HaS2ZBh9Pl0=;
 b=hCi11Puf43qIlA/YdU3T95rAN+NQ0Y1F2IvhtBe5qUCyP59akaWK01V5tgxdHfQJoN
 yOvPSso4nYBioXABpJr76DJ4rNUyvhI4kOccUM1G53GizBInShsTMlbLA8Ri6iPtFn3b
 YQPVfYcDsZ1OC7Xvlk0BgnJrqmYL+BIWVMuNtKIspBThHHnP4WqL9eIyuLP9Eve79B8R
 9BJFAijwPrrGKlD1vl935GGdErF2gHLfNeM6qlkOkPQTVR4ncWhMotfT/BZYzFoVPoMq
 g4c5pVzfXzDSglirFJI4aSoSBHAkVFt0B/Q8cg/7TXx8vlcHrnT3jGGX+bZMViO8lM0P
 yGHQ==
X-Gm-Message-State: APjAAAUQUtpKh0zeP/iE1OVM6hFFwVe+SyiApzmSQWVEUQPUoetGM9q6
 sRExFYdzLCjbyejeFZRNyIg6mawkRngOxiEwSv21zA==
X-Google-Smtp-Source: APXvYqzei8ekSdQ8UNcjocsvKdaip5Qyfo9p3zbfb0x9xdp2nFkG9nU8IWhJx9uH+PJYCBPHIUE0c0sHe4rcp8Yz5eI=
X-Received: by 2002:a9d:6745:: with SMTP id w5mr14623595otm.221.1576252719375; 
 Fri, 13 Dec 2019 07:58:39 -0800 (PST)
MIME-Version: 1.0
References: <20191212223601.309245-1-groug@kaod.org>
In-Reply-To: <20191212223601.309245-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Dec 2019 15:58:28 +0000
Message-ID: <CAFEAcA9mfqoKOtC6j9z62GauDyO2r2MZ=-vJ1dpE0W225HNnRw@mail.gmail.com>
Subject: Re: [PULL 0/5] 9pfs patches for QEMU 5.0
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Dec 2019 at 22:36, Greg Kurz <groug@kaod.org> wrote:
>
> The following changes since commit fb2246882a2c8d7f084ebe0617e97ac78467d156:
>
>   .travis.yml: drop xcode9.4 from build matrix (2019-11-29 15:51:52 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/gkurz/qemu.git tags/9p-next-2019-12-12
>
> for you to fetch changes up to b3e2bb9458af556cb8aa0558f59222f462b81069:
>
>   virtfs: Remove the deprecated "-virtfs_synth" option (2019-12-09 18:00:35 +0100)
>
> ----------------------------------------------------------------
> - conversion of virtfs-proxy-helper from libcap to libcap-ng
> - removal of libcap-dev from docker, travis and gitlab CI
> - removal of deprecate "-virtfs_synth" option
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

