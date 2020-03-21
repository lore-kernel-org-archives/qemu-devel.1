Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CC2C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 20:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A7920637
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 20:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BE5yM0RO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A7920637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFktp-0001Y2-6v
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 16:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFktC-0000rF-FV
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 16:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFktA-0000Ro-Vd
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 16:38:38 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:43002)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFktA-0000Qw-NB
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 16:38:36 -0400
Received: by mail-oi1-x22a.google.com with SMTP id 13so10526218oiy.9
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 13:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Kx65IdiqY0Rve+8pstLZqhopWGMDHOmptSRxaSeY7qY=;
 b=BE5yM0ROaiKCzZIy/gODWeyYZZ/CuTkYeGFpEnHPW3KQApmfiPWFFu/aRFszy37pS7
 x1OC6zhK4tSeuhUz5OAfz+7oeJmTOm3tgSXi+YMDoYtyW2lFukdrTGVkK8e8MfCeap7g
 3XFeBVLlE+np0ekOvZvehyVCOKZwcIQGhvTrpWM3a/O9aF/CiCkxJgfH6qSP6s8lLI6x
 CWNR47tm4JqDUe9PaqyCFWOxclsz8YL1C9Eh6Rkzkd+gJRmAE+5YWCSGx/Kz//XPZat1
 i1IPW4Ij+BZVyGux8QmJGFiosEYuVz4SYQ4IX3zY66vUXJR5EWBLtLkJUc8G1VvnHvkC
 N6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kx65IdiqY0Rve+8pstLZqhopWGMDHOmptSRxaSeY7qY=;
 b=VvJ+48psl+r7p+2XP161Gdv7zuxdkWVCk0mvtThkIjVzjOYJo7oQOlDFj2s7yyex9y
 j6zCzUdHDGImfEWxrSZBnolLgqg57arvssXT3tkyBfEyh/xez7Xnsu3aFPCQP9nPkPdF
 LyUDm7BoEnLXJCYE9U9KTXC5hUx6qyiKl6b9c1nEe6I+ZCLVBicz/phgs9oXCfJnR5fu
 hFEsZxZlSeflW/uSTnZWVP8BhwnK5d8fNlVZktL8Dzjxd66+st0XiMm/eMd2BSRI5YB3
 jd6BH/r8bsqtrtOJIDwIHCV/3AJTjqoXgoP3TpTW72ZKYlicNIG4eON9yghD7m6vX0yu
 afbQ==
X-Gm-Message-State: ANhLgQ2jrmpH6TBMnYZ22l1y/zs+IUM7HscteXF9WpPYitcy5yUF3lKx
 Kbf7R/gcg+wy0qH7ckWvaruYa80v9hyeShtRTOJgTQ==
X-Google-Smtp-Source: ADFU+vsTRQ6XOk+BrN6Vnr9Dh81jwtesfykU10k7t+6svQo+ozeBQ5D7sOsmL1SVLWD4jMsaC+8UeL+rvAUkDxjAXgw=
X-Received: by 2002:aca:c608:: with SMTP id w8mr11924644oif.163.1584823115476; 
 Sat, 21 Mar 2020 13:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200320215916.3054194-1-alistair.francis@wdc.com>
In-Reply-To: <20200320215916.3054194-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 21 Mar 2020 20:38:24 +0000
Message-ID: <CAFEAcA-eUnNuK7sf99C4nWmfH8HS9uOGhRzV59=1Vqy3v+7_jA@mail.gmail.com>
Subject: Re: [PULL 0/1] DTC queue for 5.0
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: Alistair Francis <alistair23@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 at 22:06, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> The following changes since commit 3d0ac346032a1fa9afafcaedc979a99f670e077e:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2020-03-20 13:54:23 +0000)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-dtc-next-20200320-1
>
> for you to fetch changes up to 9f252c7c88eacbf21dadcfe117b0d08f2e88ceeb:
>
>   device_tree: Add info message when dumping dtb to file (2020-03-20 14:55:44 -0700)
>
> ----------------------------------------------------------------
> DTC patches for 5.0
>
> ----------------------------------------------------------------
> Leonardo Bras (1):
>       device_tree: Add info message when dumping dtb to file


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

