Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3016C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 15:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3D121734
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 15:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+AC+XMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3D121734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50031 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRed8-0000WY-Ew
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 11:18:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRec4-0008Sl-9G
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRec3-0000DM-DK
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:17:36 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:34590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRec3-000092-4F
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:17:35 -0400
Received: by mail-ot1-x32e.google.com with SMTP id l17so7084768otq.1
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Fx7pwgDGopZal2NXN9oHRgIxBnQ1rAMA2tgrM8gsQGs=;
	b=s+AC+XMuBqIIVJVNrmNHIzcD5ZLgAYjnxoTVxbzLFbsIDAQPS75GoRx5UMLvxbxOBj
	V2jAw2SCcSRdPtWzy7GqDEG1XK08ee6X93ZkL39vzehhWMS/Ivnf8WMWoHxh/TJ3+I0i
	Z3qobYYFX8KebC/l/eEKHQSfDTKWHa3zEt9Vu3F6lrzeV6Nb0fwvx2nayU7afvdAIRof
	uMrCevs1idHsdUdq2EOGmqinaCoOJVkIQ/WPXtNhowB3hfZ6UjCqj1h7xw0ndUXYLPUP
	X0afvZ2zSfh79knfqMk72uAW05FrisJK4G2fwooXgkMxe0LGtwd4ckidzPt0DiIre8CQ
	Hdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Fx7pwgDGopZal2NXN9oHRgIxBnQ1rAMA2tgrM8gsQGs=;
	b=twiaIP+UYQVzR7tqKsMrRytoCFf4XOgkbHoQvqRPurwf0TDfn5zPSjKcQ3jTQwNXCO
	egN6g7oWJUecBvE8R2m34nwaz8zrbXQBB6RIBmVgABVK1eJhlL2RU2ilOM3A50VZf5cn
	/ecrBDzv1vhJ6HrqolW6PAWtlp6UKsfBq6EBlk4xcNMMcDYqe3rui61ldQyzwxjuxNPD
	2SA0c+8XwPxLIYUkdRop/Hff68s7/9DDBJBoNV8HY27zmpUJJysRXMEtWSMKBZjvjOX6
	zCOzWDNh2Nb+daGAcx7bUgbpwbMdN1dmW2S6fCj/BrgUDlrFXlo4ju0senh+7vZ8C0rv
	vLtw==
X-Gm-Message-State: APjAAAVmH3OvX23L3sOwDWmZ7+1QrlGr2gq5cVDUDiayMcDR3pEPYAVI
	Kp1FCDKL9hsfQfIaK2YlzJ7ViqnUhBWDhdQC7GkCpJHnmnA=
X-Google-Smtp-Source: APXvYqziH2CUuJnhrou6bwe1dacubVSr85O92hvx4psWaqKzFRcM+eeKJs6ye8dl/VuuR8GCVjZmDNTwd8M5XIhdhFA=
X-Received: by 2002:a05:6830:149a:: with SMTP id
	s26mr5608246otq.221.1558106253778; 
	Fri, 17 May 2019 08:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190517094029.7667-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190517094029.7667-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 May 2019 16:17:22 +0100
Message-ID: <CAFEAcA8j+zjxb8SNMbKgTAixXHg1z0pbc9tYeom=UwO-5d5QAg@mail.gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [PULL 0/8] qemu-sparc queue 20190517
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 May 2019 at 10:42, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The following changes since commit d8276573da58e8ce78dab8c46dd660efd664bcb7:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190510' into staging (2019-05-16 13:15:08 +0100)
>
> are available in the git repository at:
>
>   git://github.com/mcayland/qemu.git tags/qemu-sparc-20190517
>
> for you to fetch changes up to 918b8adeb20d9635b16ffde7a413b15f6761b7f3:
>
>   MAINTAINERS: add myself for leon3 (2019-05-17 09:17:11 +0100)
>
> ----------------------------------------------------------------
> qemu-sparc queue


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

