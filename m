Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9585C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F132173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVwxB18q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F132173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52398 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT3SP-0004bS-UE
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 08:01:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3RM-0003pY-AU
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3RL-0005YU-97
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:00:20 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT3RL-0005X7-2z
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:00:19 -0400
Received: by mail-ot1-x342.google.com with SMTP id r7so16056798otn.6
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 05:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ZO7whUSKyWkUiV2ngbKH5XUo+c4tErH5GJB9Y2tBsjA=;
	b=eVwxB18qZ2ztJjBafgTt+/o93/t0tBhbwvucwsAaEWfZmV3yopjmUMJ4Jk6N1tFKh/
	GGtskiZqhDDl9ND9gh6Fz+rsqb98Sm6PqKuZPiCerNcN2WEq+LZs3sTdchJ++mPsVLc5
	9kxbfC8hNDqKcGrnSK8XiVNOma7VJyZRbo53xShx1gPrJhtUD1JxuiqBiH8i9ZxuKnLM
	SSboRmLzdpcPvNToLEVs2gwTMC+5uASmfBLP61UUVpTPsQTNTwElS/WqVT6qB68bgWr2
	Pbz5k5XQrGEpATSI0xItTHfdTgPLj23f46lqSjgSJd110byu8qU67Map3h6g06CPUhI3
	tOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ZO7whUSKyWkUiV2ngbKH5XUo+c4tErH5GJB9Y2tBsjA=;
	b=QkSf36rzBAl/ydjGIpsPi41kN62jVo3sTNl5ShpqhOGJIqM6jNEh0DyCuPF4iVHVe/
	r1YtEFS+78B/Q3tQk3B2kdbFvEApW1odOlpIJi+b/mzZTQA/apYoVVAx+cK4qBnKzbmS
	o0sxzeCcKWr2x+M6RE3zxoL6UMnVh2/X3P7Fiwv332l2XXCBtWbYiEvkmHkCRZF5X2TH
	jI/AeZpJ+W0cD6VByeXhQhtCLuC0ixLLCUuLYOPIrhv45mixYyNG8BXHDO0QrGVTWFWb
	AowvHrninDtD/4pG/ROs2d85ZR3DnDvJBSbH2avc7Ke+yhenqBmcQt2I4LXOIyQVDOfC
	z03A==
X-Gm-Message-State: APjAAAW6LkgTjjLPj3494LZAxM8S+7cQW/Civ/rNJDwNC2QnpatcGuFD
	iGT+BpmGHOX1E0VyGLzRuhgC0lQkkesbjSCqiMxyig==
X-Google-Smtp-Source: APXvYqxd8C0NMMU9JxOE+9VXV99v8aPLJrPoV0PdTlXSpUUzHOAWI0T1iGwDyr7wk6Kfo6Joia8rW9foKAkJXEmiuDM=
X-Received: by 2002:a9d:77d5:: with SMTP id w21mr203459otl.97.1558440018060;
	Tue, 21 May 2019 05:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190521062924.6930-1-david@gibson.dropbear.id.au>
In-Reply-To: <20190521062924.6930-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2019 13:00:07 +0100
Message-ID: <CAFEAcA9bmghTq9uZVVruLmK8xhmq+mQzETwKPDz6=q-AJf7zFw@mail.gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 00/38] ppc-for-4.1 queue 20190521
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
Cc: Laurent Vivier <lvivier@redhat.com>, gkurz@kaod.org,
	qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 at 07:29, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 2259637b95bef3116cc262459271de08e038cc66:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-05-20 17:22:05 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190521
>
> for you to fetch changes up to 271226c30a2128c563974dd359cb1e25a54e1cbf:
>
>   spapr/irq: add KVM support to the 'dual' machine (2019-05-21 10:55:47 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-05-21
>
> Next pull request against qemu-4.1.  Highlights:
>   * KVM accelerated support for the XIVE interrupt controller in PAPR
>     guests
>   * A number of TCG vector fixes
>   * Fixes for the PReP / 40p machine
>
> Other than that it's just a bunch of assorted fixes, cleanups and
> minor improvements.

>       linux-headers: Update linux headers to 5.2-rc1

This doesn't build on aarch64 hosts, because of the new
asm/sve_context.h header. Cornelia has a fix for the update
script in her s390 pullreq, so probably the best thing to
do is for you to wait for that to go in, rebase on that
and drop your version of the update-headers patch.

thanks
-- PMM

