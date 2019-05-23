Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29979C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E659720868
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nn3ujwZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E659720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33817 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlY8-0005cp-7r
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 07:06:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTlSd-0001wa-H8
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTlSb-0008UZ-6q
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:00:34 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:41250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTlSa-0008TL-Jn
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:00:33 -0400
Received: by mail-ot1-x32e.google.com with SMTP id l25so4986521otp.8
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 04:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Yhv+xi8WspiYJH56L/JUHWhHhG9zt3ZSFc9V098CUOg=;
	b=nn3ujwZknruEWzcce8NLT2a1DWNBlCI+Is9u+QnTW8xL440e0djMaSZzDYCnC1ztQw
	mmOxr4aT1RC86+6HgvQ58QboIy5k8FY98r89z52qwBbL3JrqQx2DuvFtLxkJtt4t5D1P
	pbekmgGP62pAHMSH7VfpVaVdm2pCvXIgzSi2yYsamM6vOuV/yoevU9wUqDlBiWHexpBo
	Cxfw7z5xb+rPJpdbLeZJYUlNJuD3ockC6guchiwzVnRQC43wWMIeDKScFT9lAEbVEvrW
	vjoDNeNFwXId9RTsgH21ODTdrnSZuk1WoiIvP3gcWz4Ln6PYxG/lXaaW+1TILxMRTL4J
	D/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Yhv+xi8WspiYJH56L/JUHWhHhG9zt3ZSFc9V098CUOg=;
	b=maLQ+j2nO4iPLqG3l4PAOBpn1qZCk8Sv+IWhwAQRahyovDxn+iu/zgbv6mzgG0M09Q
	Tg1PIe2XT5RwKMbFtOtc1Rz5M/dSC/+fhNkqTu+fd1v0bwxpQ4kCgaT5el2jb5riIfeS
	2kHlk3CskeG1z2EDxet9Merty7KSHbSbfVrdG+qC11UQ9vlWsVSoz2e70VnZ4gahWdI/
	U5pjcoUl7cnrx8+7XZ0nvT3rtQTL8JlzdY8a2RWfQ6S1ZzTkd9ckbzJt9PmnZi4PqE2n
	Szt62KCm/p4qrdpUPS98b7+PtnRG/7I8seyDWHZPWHvKJXvc8iUKSt1kS3udmwbVpyWO
	R58Q==
X-Gm-Message-State: APjAAAWAfqzlKG8faD7Kw9zGauaENwpw56hIMHpf0FWF+fl55N3OEPkC
	9sOa1UzI/pFalrm3L9P6os9TTbCRNHHRnxfC0bzUSiKO9hQ=
X-Google-Smtp-Source: APXvYqxvwRqpXICkKdXG0TMM+wx16Wqduz1whIU1NyNqZhPIzAGNCSmmP1s6SVMUOvRnE+/Ch7hYR1Bhl/OH0eodidc=
X-Received: by 2002:a05:6830:149a:: with SMTP id
	s26mr27394184otq.221.1558609231015; 
	Thu, 23 May 2019 04:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190522134726.19225-1-armbru@redhat.com>
In-Reply-To: <20190522134726.19225-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 12:00:20 +0100
Message-ID: <CAFEAcA9Q=q+eSQ=ppQU08kpj5ZoBxak1AdY8Rk=P25Jb0SAbdw@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [PULL 0/5] Miscellaneous patches for 2019-05-22
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

On Wed, 22 May 2019 at 14:51, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit a4f667b6714916683408b983cfe0a615a725775f:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' into staging (2019-05-21 16:30:13 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2019-05-22
>
> for you to fetch changes up to db3d11ee3f0cb851124830172f0a93c3d77a450a:
>
>   cutils: Simplify how parse_uint() checks for whitespace (2019-05-22 15:00:04 +0200)
>
> ----------------------------------------------------------------
> Miscellaneous patches for 2019-05-22
>
> ----------------------------------------------------------------
> Markus Armbruster (5):
>       qemu-bridge-helper: Fix misuse of isspace()
>       tests/vhost-user-bridge: Fix misuse of isdigit()
>       gdbstub: Reject invalid RLE repeat counts
>       gdbstub: Fix misuse of isxdigit()
>       cutils: Simplify how parse_uint() checks for whitespace
>
>  gdbstub.c                 | 20 ++++++++++++--------
>  qemu-bridge-helper.c      |  6 +++---
>  tests/vhost-user-bridge.c |  3 ++-
>  util/cutils.c             |  2 +-
>  4 files changed, 18 insertions(+), 13 deletions(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

