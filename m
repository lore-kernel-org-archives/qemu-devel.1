Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85F3C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15462175B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j903DU9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15462175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39277 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpyk-0004L9-U1
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:50:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTpvx-0002mM-JV
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTpvw-0007XH-FL
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:47:09 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:43532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTpvw-0007VQ-8e
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:47:08 -0400
Received: by mail-oi1-x236.google.com with SMTP id t187so4713678oie.10
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=TnyXASGskKGz+VtnCfUgH5PEnHWSMrWk89Y5SYgDX3M=;
	b=j903DU9FX+t79fPWlTT3zk1JxZZr8LF6zKw6lnpQp3XFGF/Y+jtZR+xmWY0QYh5pst
	2kfL5BxdUc0MUWtNAERDpkLilXf+Eiop4rUjYG242mzDXgnXNhwOtl/NXjXIZ79Zra6E
	uTFEF3BpMO6XWf7sjahH4IeKuZt3Ayyt/HQENvrTdRduN6lXkNmmkFVviCw8bFSoZCaB
	z0LEEgB/HNw17iaF4vB18FFgEeHtLPy7wQxgI0lSx3RL3l4sVNlsY3/ScIOa+/8fSdhb
	I/m+5luEBzJ+XHnT+XVgDKlSthw2V3/wPFMLmH41wvO1EMfA3k4IcMNvOR3kbf5WkSHU
	iMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=TnyXASGskKGz+VtnCfUgH5PEnHWSMrWk89Y5SYgDX3M=;
	b=tAb1pmeudt/LRSfonqgn63jzmHntEy45hqRoI28Q2J4K6LQis+6GuRJe/+WxThghYa
	1Y4ZpeM44CdqpMUFKdQjw0YCZRAsItTABSE+3gmCXHq5wL9+r0I0rFa4yetADp6CsH7Y
	HC16HMVYF+qKWuxgge+nIb0MESLFgg1ae505wdWTyySnBiUz3oGK+oCO0wkTGigw03z/
	FwoLU8gibf0kM4EwLq67kOz3tRgpAaZp61iylmr6H+/K1rvhCYZUTO5/VexiByokAyhL
	WBrCsuV69i1C//qhHzICYCQbJYR6dIbJLIV8DUyjQc7VbcaMJGeJuee+nq87Jmi/upkg
	4KzQ==
X-Gm-Message-State: APjAAAWGR1U/1olsibXsC4HEW7Yfl3zNptUk7NWRyspSKYS1BA4i/aPY
	N3djJUMcSUiVNkZudacW8QTO8aoLTC2cazyE8KpcQQ==
X-Google-Smtp-Source: APXvYqyD1GBeml3LfRIfEFLdUlzTHyDDng7Y9X5YT1qS83x8b7MpBq1si8E5R5G4Y6goiTinN0DXZu1DYVZkdk0dl8k=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr3200331oib.170.1558626427069; 
	Thu, 23 May 2019 08:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190523124320.28726-1-philmd@redhat.com>
In-Reply-To: <20190523124320.28726-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 16:46:56 +0100
Message-ID: <CAFEAcA9OQD=W8wuApaWzedV8tbpkLJCqVQKYYn5ihZ7nQP4KjA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::236
Subject: Re: [Qemu-devel] [PULL 00/15] Fw cfg 20190523 patches
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
	Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 May 2019 at 14:12, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> The following changes since commit c4600d5d417ea13e0f1cc047b227a2b5b0e694=
f5:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-=
request' into staging (2019-05-23 12:00:37 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/fw_cfg-20190523-pull-request
>
> for you to fetch changes up to 3ae9dd1a304248e1f6ca631cdd43eb44a3e9e7b4:
>
>   tests: fw_cfg: add 'splash-time' test case (2019-05-23 14:10:31 +0200)
>
> ----------------------------------------------------------------
>
> fw_cfg patches for 2019-05-23
>
> - Add trace events
> - Get rid of globals in fw_cfg-test
> - Explicit 'reboot-timeout' is little endian
> - Add tests for 'reboot-timeout' and 'splash-time'
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

