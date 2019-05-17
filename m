Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23990C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E388A20879
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEFiFr/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E388A20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46566 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRahq-0006xO-3K
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 07:07:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRaEz-0005wc-3U
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRaEw-000054-5m
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:37:27 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:35005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRaEv-0008Vp-Qr
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:37:26 -0400
Received: by mail-ot1-x333.google.com with SMTP id n14so6308795otk.2
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 03:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=AkgTRip8nQCQCyswcZVXKG+vuWR6epbYalUUvjzFM8I=;
	b=HEFiFr/12zw0EHkEwL6EvLMoFZm1IRRR/fDl0g/LhuIF4e/99IUF8xIDALZNACPYed
	Fk71ZRRwG+ndXnHXKyxx4ue+5bMyEpELWwokRK7yKYMsJAkPmqcQcie4s6wD6zrMa+LX
	HlOFbhLzUZTaacVLkSGSXXPlVUM29wRUKNRfS+mhuKvGanq+uR45WN7LcEiFdsSlGKyU
	TDR/Gmz4ceNgbUyHEXxN2ru/wK6A+bVQD3szdvEdtIdnPZTiHbwpUr+Qn2FSbIy5dxq7
	28DAe04+kYy1SA2YJ7mAo6sjVk5Yx8jpg5uI2nY9ODf4uTNWk/wd/asHanDJs07WVqOA
	ldKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=AkgTRip8nQCQCyswcZVXKG+vuWR6epbYalUUvjzFM8I=;
	b=aA4C1NTVeqQyYSrwzgoiKYlLlc/3rrOTchvcRxe7KprYTeeJT4BzvtODhGXEa76W6Y
	I56U/6i2rnh/3rmaSvqw50uAxua44zImX5hKBr4+q3cVCRMYIJdEvQmuxAQopw4CVnUo
	s1gYHb6ZmufpWKUbTvnEeCpNqkW5dWdSVbsQQ6lZ3IwXXkZ1cgCM4/06ASxR/ZX4bYKu
	/lkQnrh9kfu+xbZKIhTLQ2CdyIwbiFHJSa/bLKByrIxEdtMUIIWIJNolB3x7QKrbkRtf
	xJicVdA9Q1wfBUqLk/pSaoIoit5HCK7EichlhLUe5v6Wj2znwNTABFgzQpoSDsK8PhK5
	OCTw==
X-Gm-Message-State: APjAAAW+JRxJiVlb9y5gNLPMukqo6BnWI8rHCgDoVmjbEcYdoDeqFR9E
	UaC/rdS1Kunbpm6aRkR2OCeve7gpyQh1AY0SpOnclg==
X-Google-Smtp-Source: APXvYqxIaZtqQ/n2aLNrgSmKvoGNHiXw5kAz1CJNZixGVnKa5ex9YdijLuf1CcB1h+SDgcDW4b9t+qoO5GqoWmhP5ZI=
X-Received: by 2002:a05:6830:149a:: with SMTP id
	s26mr4678233otq.221.1558089444770; 
	Fri, 17 May 2019 03:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <1558065678-21543-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1558065678-21543-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 May 2019 11:37:13 +0100
Message-ID: <CAFEAcA_7W9sj3syAsU6aBsyn+D1kjFVLfjeVvZXRvf_HYZOrWA@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::333
Subject: Re: [Qemu-devel] [PULL v2 00/21] Misc patches for 2019-05-15
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

On Fri, 17 May 2019 at 05:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit e329ad2ab72c43b56df88b34954c2c7d839bb3=
73:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190513' into =
staging (2019-05-14 10:08:47 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to ff4a1ff34ba90203845d9668d4ef7d7b5973c64b:
>
>   hw/net/ne2000: Extract the PCI device from the chipset common code (201=
9-05-15 11:56:54 +0200)
>
> ----------------------------------------------------------------
> Mostly bugfixes and cleanups, the most important being
> "megasas: fix mapped frame size" from Peter Lieven.
> In addition, -realtime is marked as deprecated.
>
> ----------------------------------------------------------------

[staging e36f21cc64] Merge remote-tracking branch
'remotes/bonzini/tags/for-upstream' into staging
 Date: Fri May 17 11:35:53 2019 +0100
    Signed-off-by: Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@redhat.com>
    Signed-off-by: Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@redhat.com>
    Signed-off-by: Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@redhat.com>
ERROR: pull request includes tag with UTF-8 error in person name


thanks
-- PMM

