Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712ADC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 15:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D4B21530
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 15:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTw9UvjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D4B21530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38863 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOOE7-0005rT-Ev
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 11:11:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOOCi-00051g-VZ
	for qemu-devel@nongnu.org; Wed, 08 May 2019 11:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOOCi-0001MO-0x
	for qemu-devel@nongnu.org; Wed, 08 May 2019 11:09:56 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:38536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOOCh-0001Lo-RD
	for qemu-devel@nongnu.org; Wed, 08 May 2019 11:09:55 -0400
Received: by mail-oi1-x233.google.com with SMTP id u199so7435820oie.5
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=MhstZBYMCPmMMOU9xP/v0Vc28rbFxbDh2q+MWesDRE8=;
	b=QTw9UvjNxBCsGrhLFVG4ffaS9//1ysR2DWCqaDSI1GKPw38uMRj/PG3R/Uad21KR7v
	1l7qMKAKekJvug7DjfELMxqPtjGvPALiVdYrdWIvjqOJgwtY8GiVBUsZlDxzDPJ8Klk0
	C71ljxZYEX0ln8VUXzJzSdzUNv109tLnFnbILCWlt7kN0YXhPHiKXy5iVgdymtr10wUG
	ddxbfa0/NXKdKq1RW7ssMwZ+XXag+I9513yNoKjIY1Kd4B3NeopwBaN/HeEHYy3fwuf6
	sib2Fo9BEanA0jjdG102wh8XsIV5IZyD0jRWZhtdkzfIVLFEBqLjPXU77FwG8xypi94J
	AOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=MhstZBYMCPmMMOU9xP/v0Vc28rbFxbDh2q+MWesDRE8=;
	b=eRG7SvMOxEYbiVBqxn+kUO4CFLV7qx481ZhRzm5CtLQD6Xni8iuoHFwohkryBJe2Uc
	OxTkBGELcFORQIizQeysn1tvvxzzb3o958h5qncm51ao3JSNPjuRL5sSYxA5W3nxv7Ka
	j0DnUvLKGWiVxBVLoMKvwZIyTz2kt9pp4ILc0XQsF8GdakFyJSgpmz8srxiG97oIUAlR
	GtTSiTAoFvL5YpgQRZtcV1V+F6g2tNMHG8hcUsxolJfAAHwM3pKOYWC6vtThxPzmROsW
	W8bysXXc9cc9J6Hwt/+Spd5PNX1ZbVViib3H0pQpkugmYQ+/3NjPRR2uSn7wtsMj2E45
	jt9Q==
X-Gm-Message-State: APjAAAVMsnQGCqJzccVvQjyth7UhdTHehZ+/4uK7kOJjQD6NJptqzt8A
	cHduZe9G3IuIlFDpHHEFkWc0h1wjzCfJ2IdEDkyzSA==
X-Google-Smtp-Source: APXvYqwdPr2I/g54j57sI1vdOU2gm9HxQArECbQnWHhaOtKjdVS6b7jAhxrq7RH7lXPnPu0yLGxYUdTeIlgtfhGlDGg=
X-Received: by 2002:aca:b783:: with SMTP id h125mr2564337oif.146.1557328194554;
	Wed, 08 May 2019 08:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190507134521.31044-1-thuth@redhat.com>
In-Reply-To: <20190507134521.31044-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 May 2019 16:09:43 +0100
Message-ID: <CAFEAcA-j+wQXjPW+puxk=foi2T8O=MzXHtxdWJ6E5P7o89WQSg@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::233
Subject: Re: [Qemu-devel] [PULL v2 00/28] Kconfig for Arm machines
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
Cc: John Snow <jsnow@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 May 2019 at 14:45, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit a6ae23831b05a11880b40f7d58e332c45a6b04f7:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2019-05-03 15:26:09 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-05-07
>
> for you to fetch changes up to 69f879e9fefab9aaf24893fe4ce23e07756d703c:
>
>   hw/arm: Remove hard-enablement of the remaining PCI devices (2019-05-07 15:01:47 +0200)
>
> ----------------------------------------------------------------
> Kconfig settings for the Arm machines
> (v2: Fix the dependency of q35 to AHCI_ICH9 in the second patch)
> ----------------------------------------------------------------

Hi -- this is still failing in the build test where I 'make clean'
before doing the build:

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i386
QTEST_QEMU_IMG=qemu-img tests/a
hci-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
--test-name="ahci-test"
qemu-system-i386: Unknown device 'ich9-ahci' for bus 'PCIE'
Broken pipe

thanks
-- PMM

