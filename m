Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3DEC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4C724670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iStXnNhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4C724670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHkP-0001g7-DD
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idGo9-00042c-Nm
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:50:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idGo8-0007dZ-LR
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:50:21 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45349)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idGo8-0007cd-7b
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:50:20 -0500
Received: by mail-oi1-x244.google.com with SMTP id v10so301624oiv.12
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 08:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NhH9cQuwZ6wh09C4eiQFRoMsO/bFkITZxzUDpgm+jXk=;
 b=iStXnNhPED2DTzabkjMN8csFTr/Ry6qjHON3worMXfOUDhk+UzjvCwmXONhT6pK/oP
 9/UJJ+8C/6Xs4Y6mB2yvtpouPm1onCl50t6jf9r4G2uPsv6uQzuxikdNmsyDKbA94vYB
 sokK+XpQ48AbpMEQZV0wcDDcjzGcwzdmOgqxkgCbnvB0d+2JhikhFf6Rnkp3Z//cW12I
 ltRrlY0qB1CSbO3xJVmc5eIrxWUrvksX9k0d89mqN//3QSCcSU6HlMb7tOt1V2zN5a0O
 X3TWN8GH7OewOlucEy21ZkM2gpfnQcNxxbIRlWXy9B7nmVeYllYn4YdXj4ZxQO58+uGu
 0IAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NhH9cQuwZ6wh09C4eiQFRoMsO/bFkITZxzUDpgm+jXk=;
 b=nioORYz39F7dgJlN4iRkDQoijnTcnNyZ8dxEYHXWconG/aYrTOggg0ZkhKcTks0MbE
 Xk2AvrOknzUNyFMvijhJ+b4TsEPh/VFoYntgl0CgM9SEaheoRt8pKQulXP0k0U5hv9v2
 zIcm3spPdtcoTwcNOuG5NzffO3eXty0r4Nh2IpudqBeu11hXfQoS59HYg7GTvYuRej0E
 8bwh3wjaamPMqqsKKwnMjDxOje41nEHBGApWxVoRNw2vr5YPh26r8A5aU/Zq7PiXLNfK
 IjGYKaqYKf4pPYHsr69RWYXpfmYJ2Rmnmp6o4paapR1eA2o6du+Ateqk2aWdalKeEGcg
 JSyg==
X-Gm-Message-State: APjAAAVKsPRk7X985ZtdxaVyODukHi4cop3JqYBO5JG+8mP7JfxbTLgp
 SO1K7bWycF/AVmd/JZhLOEjKlE9UhAz3wnvjm1gbug==
X-Google-Smtp-Source: APXvYqyYISMNRQQDDf5ela/v9HvXFvxULO5ZwjQPW8704he3VcErjTo2iax09C9yfffVc4rOPEJWZ5N7U2JWlcaEmoM=
X-Received: by 2002:aca:3182:: with SMTP id
 x124mr13325816oix.170.1575651019454; 
 Fri, 06 Dec 2019 08:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-33-richard.henderson@linaro.org>
In-Reply-To: <20191203022937.1474-33-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 16:50:08 +0000
Message-ID: <CAFEAcA-bDuohoe8efCJGqn3x7GKcJOsqJW5iWaQHUkFSfoLKZA@mail.gmail.com>
Subject: Re: [PATCH v4 32/40] target/arm: Update {fp, sve}_exception_el for VHE
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 02:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> When TGE+E2H are both set, CPACR_EL1 is ignored.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

