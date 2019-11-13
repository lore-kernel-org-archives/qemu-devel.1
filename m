Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEA5C47409
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC6D2245C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O62DzsnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC6D2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUudw-0001hL-Gq
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 10:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUucy-00014u-0d
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUucw-0004L6-RD
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:32:15 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUucw-0004J6-NL
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:32:14 -0500
Received: by mail-ot1-x341.google.com with SMTP id l14so1941586oti.10
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 07:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m6otvXm7FRYsOzQexRm28vZfmpNFDrAkgCczbQKPxXc=;
 b=O62DzsnF14+iZVGoPr2DEYrYR4/T8L0aFu62NjsvCUG2z2dxgzf2etuVnKYJnKpl1D
 hDgO4PpBa0bt7mZBV4ZwSmPYhoaLAb3919bv0OaFVuOMabEA6Zk8ltXrOlItkZMc/8vA
 DHJm4Wvl77TbdsTyovsXT8w0Q5PofoaFMxRacnmopX2CqjHiTHcYyc9FP7jBLygEyagT
 4aVWUBCLgnmD99fmrqb4SijkeHCjBuUjGPSmgYaYbHGPavfNCA4Jq3198ASVcAzw05v0
 WMiw6Wkh6GLBycwKAcCkUM1Un6CqOwb+8bZXvO+O2moLmg4JlObXgsaVhnW4gGmc/sgN
 /k5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m6otvXm7FRYsOzQexRm28vZfmpNFDrAkgCczbQKPxXc=;
 b=LO3RAC7m8tnUtCBMY0vqK1xYy+ubEW/ONi3Hur54qL4xDTW0WBVcN7BB25PRrtToMx
 gFLvGt95LR/1Dm+iqMB0ImCSv+qa0DlfkCzfU7N8OMwk1qBKMtauaRKKnRBZbTcg33ux
 k5T0H9kziVWIjtaq6/XuhKSr9eKNXzGy2b5Yu1GZNCO2V9W4+manWzI1x4jG8pGOX/0n
 Vna365D1WGE3yKiz8yF28C0lHaSWJxXZkOdH1HGGI2j/a1Mjt4UzjjDtf9eCUSZQuW2/
 x1VgA4leGyEKh24kDJOdTQ2r7S0BZbgaGypd7idoLpJx2jj+Z5tEqE9OX8RxNlq1+uvx
 sWug==
X-Gm-Message-State: APjAAAWL43cHnYiSJxEQpOOlPwWJwcX68qgZpBuWeUWVI40q9rzUCWsL
 8Js4qhg9PUSCRNC31k55vhDZND+AwEQ+sNyLvr2K5A==
X-Google-Smtp-Source: APXvYqwG9D7t1OIYN7pkrdiTaBBoo3x5Rw86eLlLq92DTnt0nMBrclCJtB70rlVO4cI4/EuEDS0z7puiMHQ+pmJmQoQ=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr3867008otg.232.1573659129302; 
 Wed, 13 Nov 2019 07:32:09 -0800 (PST)
MIME-Version: 1.0
References: <20191030163243.10644-1-david@gibson.dropbear.id.au>
 <20191113144344.GA4204@orkuz.int.mamuti.net>
 <20191113160900.5f9f5415@bahia.lan>
In-Reply-To: <20191113160900.5f9f5415@bahia.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Nov 2019 15:31:58 +0000
Message-ID: <CAFEAcA9+VzDC9N5vGcA9COUaPsSue9VWmtoaPneCqY7drtbVzA@mail.gmail.com>
Subject: Re: [PATCH] spapr/kvm: Set default cpu model for all machine classes
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Laurent Vivier <lvivier@redhat.com>, David Hildenbrand <david@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 13 Nov 2019 at 15:10, Greg Kurz <groug@kaod.org> wrote:
> David is away until the 19th of November, which is the release date
> of rc2 according to the planning [*]. Then we have rc3 the 26th, and
> final release (or rc4) the 3rd of December, so it should be ok.

Please don't actively plan to delay putting changes in
until later release candidates. The release process
involves steadily winding up the bar of whether it's
worth putting in and hopefully reducing the volume
of changes between rcs. In an ideal world rc3 would
have very few changes, and then there would be no
changes at all between rc3 and the final release.

thanks
-- PMM

