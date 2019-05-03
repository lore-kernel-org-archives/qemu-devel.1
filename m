Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D10BC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 10:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9CBB206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 10:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ef0n1Xpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CBB206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37767 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMVS0-0002Lc-5Z
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 06:29:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMVRD-00022c-65
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMVRC-0003U9-Cn
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:29:07 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:32973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMVRC-0003T3-2o
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:29:06 -0400
Received: by mail-oi1-x241.google.com with SMTP id l1so4056464oib.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 03:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=W+9F26wJZLvO6u9zd0cUO5/pkkKiUaMfDJ3y+1tnKrM=;
	b=ef0n1XptoJ+/NQT3Mlz8AlNzI1VnWDOgDNpAdGLWt49dhVzpdfX8U9OJDezo3Vmhkl
	jDnG9NQzz4Bi6/F3vuPM40VZOYCreDzFdoulBg23W19n1y7ifaXM2FqIsoSXnBcifJlT
	P064gTm5E0qxAcR1mcXhGvPHrkpdvp8VSAXszQs4TYHrunTZy/2dbdtooMWI8uabXlDp
	05hyskcz8QMkOgRlUxVHKdylt5xct3sOi3ScseD0MbTdgtBKuIB3wSpoVsiZ85ZgeJ//
	b35/eQxvUMzc1+drh0NMANCdus0aSlj0vCqZL/eBBn4IC54IoNKepOLYjJsiEippkBnA
	oXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=W+9F26wJZLvO6u9zd0cUO5/pkkKiUaMfDJ3y+1tnKrM=;
	b=pXKI9sFf6ttJdRB3dBO3TaYVms2wxKZkR3ySAG+44dmz+67MoJddbsZ99y5MASth7t
	jMlE6Mwp9MmqFtGlsriodEip3ESAIntSGCICnrlq0DZ5fyqF5UfMHTkOM0v88TN5IRCU
	bXqi5bWw/26YslavLlBNhRReL9Um14kVHszdQHtvbkpebxU/s/Gh0giaFSsCWpYPUiiv
	VYTD9aXA7oAd0Wsix5WpNKMnnvXPe+O5SnbJq1e3GqY/UX4Ta698dc5wPdBvE/OsocTn
	S4hGw10t1JttqTpiFbmj4AWZ6lmQY9rM54PwLGVAqMzTizo/uavAEDy7iTl9J4b/VQFb
	6w7w==
X-Gm-Message-State: APjAAAXSo9XoT6BwFmmjg3vNj9Dh0cdpFt+6nBsCpP26c3nuIBdgLDFs
	/Jah+ion7irZw+j7KnXLHFlFWg2NxUjYY6PfH32T2Q==
X-Google-Smtp-Source: APXvYqxC6Atjk1ZLaTqkWuanBL7Hlta0R0KnNga9faT6fkWlHiYzVcxino9iMAPX0MrVw80Systc/tsa59dHJ1SzULY=
X-Received: by 2002:aca:ed17:: with SMTP id l23mr5271275oih.146.1556879344323; 
	Fri, 03 May 2019 03:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190425133503.30847-1-stefanha@redhat.com>
	<20190503101921.GC17905@redhat.com>
In-Reply-To: <20190503101921.GC17905@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 11:28:53 +0100
Message-ID:
 <CAFEAcA_CkUBHe1fWg9wy-+HLw8WBZrp3M_oBksCN1GQc1qp4hg@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v2] security.rst: add Security Guide to
 developer docs
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
Cc: Eduardo Otubo <otubo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503102853.pdoyOJPjmC-8TSu1v5BtZz1Brf5kXHoK0GHL_wh7j7k@z>

On Fri, 3 May 2019 at 11:19, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> Everything above here is useful to QEMU devs, app devs & end users and
> should be made part of the main QEMU doc - convert it to texi and @includ=
e
> it from qemu-doc.texi, as we do for other stuff under docs/

If we convert it to texi we'll have to convert it back again
as/when we migrate properly from texi to sphinx... (I would
like to make further moves in that direction during this
release cycle -- just need to find the time to work on it.)

thanks
-- PMM

