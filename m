Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15BEC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:10:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F0A2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0xJnxhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F0A2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44698 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQUO3-0004fM-V3
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 06:10:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQUMm-00041r-1U
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQUMk-0003tV-3D
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:08:59 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQUMi-0003iK-Bi
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:08:56 -0400
Received: by mail-oi1-x244.google.com with SMTP id t187so8344773oie.10
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 03:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ieeBAjC7rpZuKx1Vo4jU6/Nl1XP+QTqXW/y6IG+o4pc=;
	b=B0xJnxhq1R5cxGp1jHWjFsh1nZBukb3pqwtpRvb+wRBqp4tuPL20yENIH5UIdGgSKe
	TjLmt74fl8aLmfHvZKJL53FiE18akQ0c8YOUwfnLGtVvtGoLb/Tj3RIOVBq0EsgGEEHO
	cH41m3Oy/SVZRjCJaNYh8RUinmTOawdxY7c+aOts1eH4kdTJEhc4Il0QlYP2/g+RkZEc
	bXNITqGgI+EZwtf9oku1ZvpfWyQl8QN4Z9OBRLQCmSMSUP7C5qM0POaqPL5dzhFde/ns
	Ut/Tox2xFhVDi3L05luAQNCFkbO1ci7RL9mdwkRUNdIuCcnCXRR4kySYMWuEoXJI1tgQ
	ZL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ieeBAjC7rpZuKx1Vo4jU6/Nl1XP+QTqXW/y6IG+o4pc=;
	b=WZZu3LeSMYzBud58DVJpn8acstbx0OVzybVz4/18YIJVYdhVF4TesvycJjoYZ4ci6b
	KmwljlxfKMoN+t0xx1XUFY6SCy/mEBSFyf6GKlgq1rlpqC8SRBYgqH/cJFlQFToCkKl1
	D/8fCz7O7RE0trLCs+GkcRknJOpBFRp9OldH00YjRmHUqNpu3xsOhcwtyAzoVeZiQvJx
	t+zRKnX7BNao+0sVGqsxlIJI2lkmOS/QfjARlGriOKnr/SkhlD+I+r7mRUenPItPIYw4
	vhZ4uxYbOeKv8p52OJJB5UOcDBrbMvbJlIiaG5PXijNwn6c8v8r5ZDCbjC6rn4M7NY4M
	lHPg==
X-Gm-Message-State: APjAAAU6SDbMfNBFdttX5Vt6qxrepllKNU4c1Briwxzvn2FnbfvdYpGh
	EuRZz9vVcH8qeEbuuiFBEGvP6yLC1B074RLAjC6ChQ==
X-Google-Smtp-Source: APXvYqxg9Hv8LjlRUigO2PmtU444YGhXU31fLs8EVrvXrA2sm+FsxqyLFLl6dpOX6QkpeFRiSArNt2ljAS/WsiOPy6o=
X-Received: by 2002:aca:5785:: with SMTP id l127mr2203222oib.48.1557828532815; 
	Tue, 14 May 2019 03:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190514100019.13263-1-thuth@redhat.com>
	<20190514100019.13263-5-thuth@redhat.com>
In-Reply-To: <20190514100019.13263-5-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 May 2019 11:08:41 +0100
Message-ID: <CAFEAcA_WVjE5hZh0EibxiqV+NtqY0VsMPs-tqC3Y=GRCbvhEpg@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 4/4] hw/misc: Add a config
 switch for the "unimplemented" device
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-arm <qemu-arm@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 May 2019 at 11:02, Thomas Huth <thuth@redhat.com> wrote:
>
> The device is only used by certain Arm boards. Now that we have
> fine-grained Kconfig for these machines, too, we can enable the
> "unimplemented" devices only for the machines that really need it.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/Kconfig        | 9 +++++++++
>  hw/microblaze/Kconfig | 1 +
>  hw/misc/Kconfig       | 3 +++
>  hw/misc/Makefile.objs | 2 +-
>  hw/sparc64/Kconfig    | 1 +
>  5 files changed, 15 insertions(+), 1 deletion(-)

Commit message says "only Arm" but code change changes
sparc and microblaze Kconfigs too :-)

thanks
-- PMM

