Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAAEC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080D120879
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+tyrXGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080D120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35635 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnIR-00053L-48
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 08:58:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTnGV-0003dk-2k
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTnCt-0007h2-D0
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:52:28 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:47044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTnCt-0007fB-99
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:52:27 -0400
Received: by mail-oi1-x242.google.com with SMTP id 203so4226827oid.13
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 05:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=rz/ZGOyuPlC+7X+pyDeztrw2+gNVeboRhW1U8wDne6Y=;
	b=E+tyrXGJXWg1H5qlzp8r4QHzkqud7f4INnDFcKbrH3PegrSuE+0p6gamtP1d5xRSZD
	NPYqQfNN9u2iJUUi3bBdIazP9WHuL4Rpe+IQbev0/pvy4p5CF37+e9fX6txqikdLKVo6
	2zuqklXt8NwYfecmjGOZKxhJ8IRIajXX94sAy+sULti7yNpM8F71szzVjuMA+5cyYi5Q
	n2a5DoWM1b4JMj4xf1LmcZseVin9laCzNRN6bgdWIcLF23TjBG2VBf3RPB35OSsKPdeq
	dd+DK7R/a4Pdy6jDSNCoLbl4Gvzy+1hnpyfRLnaywmDmNMJ+zAZL4GHDcZlCNGQyrsnk
	ZQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=rz/ZGOyuPlC+7X+pyDeztrw2+gNVeboRhW1U8wDne6Y=;
	b=RziLDo/TSyZ1I3rcWTV+DHqLE+h38qdKCphy1fL6K1KQxf/k5+vlZm+3hY16tK5NSO
	cghZfFeYIhfa6/pVunQIq2j6uokmqyVfUkCMFMgd2xeqQrU2nVz1bSgRhJTl74dbhXRj
	WTPtTXVMr6dktzuStTPwKzjtQ/rRjN8Ms1I+y7UUYKGT+v4ieOhxCBHT1QUgEFiif2qw
	KGZrNejKwDnKoq7ezzfZTl1F9tO9YmDN3aoIE26PSbJKxH/NaOnRo9r7ATV2q3ln5+oa
	sE2O5SzT7mld3+zHE96RNdJB/HP/F/DQB4UK2tih3OjEqDdJe3w4ehcWzVvaRPg+51x5
	1NPw==
X-Gm-Message-State: APjAAAXw4jyUQx/fU5K30kU9LRAaL0vHUjGMAIRwYQfqhdKTBfpihINQ
	HyKsp8mkQHFD/OOB873JwgLYwRmPho3rUtMBpDAH7Q==
X-Google-Smtp-Source: APXvYqzCSVCqf0sQHAPRvvN4TziKki28f4o59uxWUgQuMMQ4xf2JAAYpChKB1MBD5bAvSKGi31rn9s21Ue+FZhITWrM=
X-Received: by 2002:aca:845:: with SMTP id 66mr2601464oii.163.1558615946302;
	Thu, 23 May 2019 05:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190506142042.28096-1-clg@kaod.org>
	<b12201c8-7d5f-2108-6666-75543c38f243@kaod.org>
	<f1ca56fd-c83d-8ad6-29c9-a8fc6af4531c@redhat.com>
	<270e510b-687a-6b43-8cd6-c1eb1aea41e6@kaod.org>
	<6161d982-0d21-99d6-680a-37ae300fd7cd@kaod.org>
	<98d1e57f-c033-fdb4-51bd-4a6fc2223d58@redhat.com>
In-Reply-To: <98d1e57f-c033-fdb4-51bd-4a6fc2223d58@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 13:52:15 +0100
Message-ID: <CAFEAcA-eVECkPpxnvDtX3v6BFMSVCF4SU87r51PdG=E=hCYLfA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v2 0/3] aspeed: cleanups and extensions
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
	QEMU Developers <qemu-devel@nongnu.org>,
	qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 May 2019 at 17:32, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 5/20/19 3:32 PM, C=C3=A9dric Le Goater wrote:
> >> Peter,
> >>
> >> do you want me to resend with only the two first patches and include
> >> Joel's in the same series ? I would leave out the part Philippe is
> >> covering in his object_initialize_child() patchset.
> >
> > Nope, we can not do that, conflicts arise. I suppose the easier is wait
> > for Philippe's patchset to be merged and then rebase.
>
> Eduardo said he'll send a pull request during the week.

I am now completely lost about the status of these patches,
so I'm just dropping this series from my to-review queue.
Please send a fresh patchset once any dependencies have
got into master.

thanks
-- PMM

