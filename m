Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAEDC4332B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:16:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F6D20714
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PtLqoqVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F6D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEgzO-0007Fg-UP
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 18:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEgyQ-0006ff-O3
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEgyP-0006xS-7o
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:15:38 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:33655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEgyP-0006lq-1b
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:15:37 -0400
Received: by mail-oi1-x231.google.com with SMTP id r7so590366oij.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 15:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1FJdOAfmvJnxfqY1N11F4vMcxcfKu2rQ/41hzuvZ+jM=;
 b=PtLqoqVtVlTF7Q7c/qbGJdQmtUO8chKKosP0yrBbNfcc7CGQQcaILwLHfPsHOvrLeo
 9n6GDoDzCsdl74JYJTElk97iSNZRGDPmuvnlD70aAWutzPfDxw7mnuOwTeT81/yv1TCL
 jxNKyJ+jlNu/vBoqomEyF7lKpTJ5TL4DvSsZXxg6S+x6BwXohqzhUcjrsmSR8iyoyaJx
 uYhCBufPDQMVDP6347Hb2jh7h4yAizB/v8i1PfaXZi0OvEt3+UatNU187/qALzpnctv+
 jdz4ZK97ye4j794WG/0nOcr9CzLgBhql1yEQB7VrNiRxc2z91SCO6yO0Ir8T75WHBKWF
 3O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1FJdOAfmvJnxfqY1N11F4vMcxcfKu2rQ/41hzuvZ+jM=;
 b=NeOF5U/G5jGtHbIVmHOPdutAGtzNQ4fpqVbYB7ZnpSf6HheFGmaoGdLh/+tkxIafz8
 qEzdrawhzSs06T7sTGHpIZlwKZGBwuGv60d1BxhzFAPsZm2SpcDXSBa+Y/IwJ96LAnea
 kBzeXQHsu2jsisYAZAM82sktVWcMoLdLjDSrD043O1sAYkRgSllXJeGr1enx60Wddm/7
 TcCTg6sVs65ZZO2BZixfBh1z1rPNO0U4zhoT2hutc2NF9j8j0uTM7cQRmqZncEDJ1wA0
 B5RlQOx7xC7I+9ktO7nVdKeBX7yA7Zz/Cmd6i3/rlsnkP4fXk/H9ljQYpIB5ZiUWmLgN
 TZiA==
X-Gm-Message-State: ANhLgQ3NpnIWamGG4dWD7dZ6Xtbj0B3U5VT3fU8FL1AhGE/CCOrKWZLC
 1USxt1lainwp/BxzsTq7sgTxddnLZmHnHcYpDG640A==
X-Google-Smtp-Source: ADFU+vvK1FyIG4nJRXnEmP0GUyAIpmMpTbwMwA8Rkf6U1ZHUCUZRvT347gqvG7xyrmdUPnslJWBVEQO5PsyJHpy3YwQ=
X-Received: by 2002:aca:c695:: with SMTP id w143mr142348oif.98.1584569735733; 
 Wed, 18 Mar 2020 15:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200317175053.5278-1-alex.bennee@linaro.org>
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Mar 2020 22:15:24 +0000
Message-ID: <CAFEAcA92z9a24P3EK3wPrjHTuvL4Tz9zznbQnNns4-Qg-TsvAQ@mail.gmail.com>
Subject: Re: [PULL 00/28 for 5.0] testing and gdbstub updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
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

On Tue, 17 Mar 2020 at 17:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 6fb1603aa24d9212493e4819d7b685be9c9aad=
7a:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
00317' into staging (2020-03-17 14:44:50 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-and-gdbstub-17032=
0-1
>
> for you to fetch changes up to 3bc2609d478779be600fd66744eb4e3730ec5e33:
>
>   gdbstub: Fix single-step issue by confirming 'vContSupported+' feature =
to gdb (2020-03-17 17:38:52 +0000)
>
> ----------------------------------------------------------------
> Testing and gdbstub updates:
>
>   - docker updates for VirGL
>   - re-factor gdbstub for static GDBState
>   - re-factor gdbstub for dynamic arrays
>   - add SVE support to arm gdbstub
>   - add some guest debug tests to check-tcg
>   - add aarch64 userspace register tests
>   - remove packet size limit to gdbstub
>   - simplify gdbstub monitor code
>   - report vContSupported in gdbstub to use proper single-step
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

