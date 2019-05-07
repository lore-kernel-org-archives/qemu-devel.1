Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B79C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 20:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1ECA20825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 20:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFgmd8nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1ECA20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54686 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO72d-0001hk-S1
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 16:50:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hO71F-0001Bv-3Y
	for qemu-devel@nongnu.org; Tue, 07 May 2019 16:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hO71D-0004rj-Cq
	for qemu-devel@nongnu.org; Tue, 07 May 2019 16:48:57 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:43374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hO71D-0004oO-4U
	for qemu-devel@nongnu.org; Tue, 07 May 2019 16:48:55 -0400
Received: by mail-ot1-x331.google.com with SMTP id i8so6587019oth.10
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 13:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=X2bzEXwhoqBgBx5Fz8GIgVWU1fWEI1ArFuUV+AksY94=;
	b=pFgmd8nrqhVgstEBX4aTOTbV3L0WS7I+vZ475poMJ8nZwqTen7HCqlW6r17uELMgjm
	SmjelXPidvSX//HNMHVUJC1QrWt9IT2illPo5ktCi9qW6iBAYZQdhVfNgaKnnvjstcls
	oDr6g4l13cgbe+xsS4Od8hSfAcfx4Eyy/TlKPbYcE3vc5nVXmN3BzC/g14R5os6CAcuA
	ZC5py7t8DzQDb5xp0am2+tzdr3KpM6mIHAJlC2Z3u/eqDGf1Ipddo+7AqIXKJxcqUsEK
	7ZWcvEEM8/D3PZF7LBzToaf0I/OwGazLXHCN1CAlb9YdPhxYiD5LumvIua/RfCREhwhY
	KVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=X2bzEXwhoqBgBx5Fz8GIgVWU1fWEI1ArFuUV+AksY94=;
	b=JEO+laliFlBqLyD0rJTjMR6Q9Ea0kUejB/Icm2lcSEMP2TQL5QFBW4VF5f4hDiW734
	LgGDjzb67Gh3oJ+2jmMLMgeBWSOHlslPNxCnkqlynSkM2JYKLSuOUqIajV6/N3jZthHE
	sPkYRt2l38f+9j/vNVnteAENXrypThY5RKK8cL11uCY+IqnG3UtXGyNMPhFB2p0HP173
	C92aRAe10SZwcB00acMAZzfg0ZWjHmgt86vC+YeaPldsZ9TGVZ/+g//3hM2z0EfG0YWK
	TLnBNhpFxee3pNYnEvPtBwkyr6PmEzpZ3co+ii7yFcb/r8eX4zIMV7wOSI2DQNanf+tX
	DWnw==
X-Gm-Message-State: APjAAAXuzYpn+nDpKjNofSPDN1LzA+Mf0MqkNG35HNvV2a7Ixhu17JLm
	+SU6k7TEkjza0Ios7ZycDovo7p4E2kksQpwuIDrvAA==
X-Google-Smtp-Source: APXvYqySAYC8o+uZUDrnfIPpwl+RwiB7QsosKVTkB2x0vLOUaWFDnF0/pfL1y6jkvfIsh+gm3OJlqzTh9hJKoCuSrBs=
X-Received: by 2002:a9d:404:: with SMTP id 4mr13624743otc.352.1557262132825;
	Tue, 07 May 2019 13:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190503112654.4393-1-laurent@vivier.eu>
	<80fb3313-239a-5828-94fa-d27137bfcb05@vivier.eu>
In-Reply-To: <80fb3313-239a-5828-94fa-d27137bfcb05@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2019 21:48:40 +0100
Message-ID: <CAFEAcA_y24gpugttDTR-QrJ0fA7JCQeC0XXsR6pjm2rQ19rfCA@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::331
Subject: Re: [Qemu-devel] [PULL v2 00/12] Trivial branch patches
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Fabien Chouteau <chouteau@adacore.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 May 2019 at 20:10, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Ping ?

This is in my queue to process, but there are still a bunch of
other pullreqs in the queue too; I am working through them.

thanks
-- PMM

