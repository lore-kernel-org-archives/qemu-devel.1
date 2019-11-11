Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43445C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F8A920679
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yl8A7lv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8A920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCxq-0002w4-8S
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUCxD-0002TO-6g
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUCxB-0002Ih-QL
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:54:14 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36275)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUCxB-0002IS-IZ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:54:13 -0500
Received: by mail-oi1-x241.google.com with SMTP id j7so12092246oib.3
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 08:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=5T6ZNB8LXGt8lZJKqiUAZ7ZHK2DtLRkHK8we+HmueO0=;
 b=yl8A7lv8mm5XCZ2lgLiNFw8qkMEF+ZEzG4Xi5Je8O9Z6H+qxcFFB2yr0PC2VUqfjrV
 nw1kyeI+gtfO5vRO3viSHlQrdo9zx4ovsmYt3ezGlbfUoFSbwEIEGukc+Mzsf1mDeBxI
 /SOi6R7B8PbpIIrsqg5M3ugwOfp0emudrPlU6o6csQCo6c6wV5sIb05P2ogI7ckV/BuW
 T0zKM3/kJHNktwKiKCiwFRRMJH6/Vf1KTmX9+tsRMSvOchIQiQWD4wrulbC2EtH5QVWu
 DXt1OTbA/W+fzKhHlXC6p3IjobRjX0WruWw1BRlXsaxrvMr9lkUm7QI6saPVPesaD7d3
 Qt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=5T6ZNB8LXGt8lZJKqiUAZ7ZHK2DtLRkHK8we+HmueO0=;
 b=hATy7lwHJ7ilxW1DBjyfoyj7mAmTO2cJkDNjgZ1kBxFMoFNFeieQgAUxvmSntOVAhZ
 qugXaPJSKWVKVydQ+f8tozxiTzcfZOXGkZMSkUdHuaKCJbAEh/eodGzDJQHt523Z0Yu/
 dP9FX3Y87uI5r4dD0ddivJzwk5uKPj23r2QRQfsPbjT6nJ+IDLO5C8nAbpOGy/7wUJyU
 GuWqXX0mc4x724q7HbpoXvOJROWolDkaAkITtjj3Ne/zAbvuYhzvs4KuhGYAPtxVG9JP
 dgJEsBKD4R3/g0NsBEBxRXC7IeeFfpQyUAzceq7w9gh73ekcGojZ/QDxa1uhI1cMHFFQ
 ZP3Q==
X-Gm-Message-State: APjAAAXePfXoEn8r9YteXCDANc5nvYp0TjOPkdLFni+aZXTikW1tVQzd
 WC5z746NWW1PFhYK9Xt9iZrxA9c4yFGkr0yiURb73zndVjo=
X-Google-Smtp-Source: APXvYqzXMCZ9IACmqGfoUEfsu1eSRdEpunqqzLUTRZ3AVZQ/RJUNAcNaSiqy+2dADrgAmsgahy3TgLUQrF19XBB0bFY=
X-Received: by 2002:aca:cf12:: with SMTP id f18mr23630902oig.48.1573491252195; 
 Mon, 11 Nov 2019 08:54:12 -0800 (PST)
MIME-Version: 1.0
References: <20191111135803.14414-1-peter.maydell@linaro.org>
In-Reply-To: <20191111135803.14414-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Nov 2019 16:54:01 +0000
Message-ID: <CAFEAcA9LK4vX+K3Qf2jGLhXjyOqF493KOJRRCkPEyfi_2FG7Ug@mail.gmail.com>
Subject: Re: [PULL 0/3] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 Nov 2019 at 13:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Arm patches for rc1:
>  * two final "remove the old API" patches for some API transitions
>  * bugfix for raspi/highbank Linux boot
>
> thanks
> -- PMM
>
> The following changes since commit 654efcb511d394c1d3f5292c28503d1d19e5b1d3:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/q800-branch-pull-request' into staging (2019-11-11 09:23:46 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191111
>
> for you to fetch changes up to 45c078f163fd47c35e7505d98928fae63baada7d:
>
>   hw/arm/boot: Set NSACR.{CP11, CP10} in dummy SMC setup routine (2019-11-11 13:44:16 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Remove old unassigned_access CPU hook API
>  * Remove old ptimer_init_with_bh() API
>  * hw/arm/boot: Set NSACR.{CP11, CP10} in dummy SMC setup routine
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

