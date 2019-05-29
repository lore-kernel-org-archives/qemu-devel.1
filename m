Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE4DC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:51:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC9A23E47
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iILTnX4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC9A23E47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58085 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW1ne-0000Tn-Th
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 12:51:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hW1mt-0000BI-9N
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hW1ms-000838-84
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:50:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hW1mr-000821-UK
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:50:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id y3so2152723wmm.2
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=Bcj+PZz6w7A7e+eSJkgxIOPffRR8inMczDju2EmRKGw=;
	b=iILTnX4/B62Aysc6tGUPKOH5LySJflbuVVVgsBHW/T1B1pS7RTOLyCHRwDKuL3GZwk
	LVX/UF5vjAtd0Mg5I++FXjExVpRJRx3KuNW9BkfF3NFAPTfPXAST6N+ByQXM2KsdYJ86
	+xCuPnl97HAr//lhQTvWcbhnqEposf7EiU55GaJeCmZeDg0b5uq4JN+7P7Se0JYcYSMf
	PpB9eGEqK6p85cG8ihS9pugeYBEyo/EX0VWzglrMPTYpUNADAOCWbQef7Mco0GKk2TEN
	wBlhKaX2fWNQ7yMs3RTcivGNDxxoxXimaEBaV19lD8kJvPiZRiODuB3Uru9AntQ5ALb4
	U3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=Bcj+PZz6w7A7e+eSJkgxIOPffRR8inMczDju2EmRKGw=;
	b=B2NF+jIT4qO+WXHuOa6FH1w4fPZGrd8cneMQLoD8PKY0wT0GdYbEK0gwoMhL9egCN+
	Jywj6KEfGa/2T35I/X6+xVrCm2r3z0GEoXOHSoMrG5lFwMgqBIMrfxdqGjSOK9/3O75j
	2Oqcbb+kSO7DGC5V3teJzBc7JzerVr5pm5s0MUigT9brMFqTg2dgrpoNYyA4E2YkOmg8
	lWwPxDZgk3d+qT/gaVvByf3jUIgRHqFFRch3aS5dMfYILZTkFgZUK8zoe6fBxXVlmc0N
	ToFUvaLeUXiKBqRe7WXA9G5TC5b5/Lzuy1dgMIIlQ2hlwF51HT8ZEAw/ihW061lD8sf+
	L5AA==
X-Gm-Message-State: APjAAAWn8T6hg9n0DX+SqiIyLDAIpZqfvZRVXkyJXw0HCcsrjCJB+AHe
	kUSO3J1E5csjwxWx9yrjYRm8+w==
X-Google-Smtp-Source: APXvYqxWsMzJBeZD2EmJJZJiSpiyG/K+xO0PANG/NYVaNXBRmLgxtd6FtBY4F4mcMRLGiV1nAD4XQg==
X-Received: by 2002:a1c:2947:: with SMTP id p68mr7229986wmp.71.1559148647957; 
	Wed, 29 May 2019 09:50:47 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id d17sm31966wrx.9.2019.05.29.09.50.46
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 29 May 2019 09:50:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 2F4EA1FF87;
	Wed, 29 May 2019 17:50:46 +0100 (BST)
References: <20190329210804.22121-1-wainersm@redhat.com>
	<5005fcec-42af-427c-4f68-8415490e9598@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
In-reply-to: <5005fcec-42af-427c-4f68-8415490e9598@redhat.com>
Date: Wed, 29 May 2019 17:50:46 +0100
Message-ID: <87blzl5hnd.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 0/5] tests/vm: Python 3,
 improve image caching, and misc
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
Cc: fam@euphon.net, peter.maydell@linaro.org, lersek@redhat.com,
	qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Wainer dos Santos Moschetta <wainersm@redhat.com> writes:

> Ping. More reviews needed.
>
> I've already got Philippe's reviewed-by, thanks!

I've queued patches 1,2,4,5 to testing/next, thanks.

I'm going to see is 3 is obviated by Gerd's VM rebuild work but I've
added it for now.

Sorry about the delay.

--
Alex Benn=C3=A9e

