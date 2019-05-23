Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79B2C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C66220881
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7IqlLLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C66220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34406 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTmMY-0004vT-JF
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 07:58:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTmLE-0004FB-Ek
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTmLD-00024m-EU
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:57:00 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTmLD-00023x-6x
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:56:59 -0400
Received: by mail-oi1-x243.google.com with SMTP id q186so4155959oia.0
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 04:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=NZDEYEz5nD7XS3id+akGIIH+Yn6baWTOmRiQPpPliAM=;
	b=B7IqlLLrYVFEDJEBzBf57E56eW+EnSDVdyLi0xapbXFWIyo+Ye0sEBfC2h21aO5qOz
	mQW5gmxDHSmCCsNBsgwijKlwhvWC53+5Xd3xgm0C+gmwkFwqrIAnRH3NrGwdABScrCFX
	kat2p1fzv6coZbfDxIE7gxAqRypFqP7i0yxIaitRVNORzyVy/+uBvLOY3PdkgCZ2XnAf
	7VNRAfgMxg1oQBS/Bjvy9uBfvuFNLvhUteB/Qr3RHe/ePiGJTpyEXI9Dptya+xlVyU/s
	DydKeg/dejbOHQ673ZbInhsW2ZW4h4crcarGPtFaUMGt3SpPnZQIa+mroxb9n/MVxNxT
	TvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=NZDEYEz5nD7XS3id+akGIIH+Yn6baWTOmRiQPpPliAM=;
	b=UykxqGVif2CcE1PGJrLqQDdIwtpyBOqaNCZpSuLuQnkoXd2hi5TPl9OgBNrH8Os9Bs
	9q0G85qaJiIz2UfEG97Ha6HBw4ebPmlqWum3A2ca1Oy8GY5rVjmPIytimZ1PLlOP+kGm
	gR/t2DfpqHF5iApc4Ft0s/+7fN7939zMqdwI9SvLB1VPzotqOp69Yxqk2rnfjd84pO6a
	s/woY26nQeUBz/2Cygub19N2EDdFh0n2DNZLA55mDwY/EbxmJVDB/LtW06i7p3xHl9CU
	xV0jr1jMPmUKZHlg+oXmnP4qZxfB7m+HY8N8O4nHX8Z9z0upejOuvOfY8bF758+bCWjD
	1OiQ==
X-Gm-Message-State: APjAAAU0aAfiqGiUKATa99/DYPPfynSArb2tdoFHxrDJ0BBg6zGovoq6
	/ChiKYt1HyshO9cqk1lhf6PUoO3/Ajrez396Egs19Q==
X-Google-Smtp-Source: APXvYqx8TShlZQ7WnClyodAMyAeiO8vmzd5+CFcsE1NtRZEMP2/LmgAmb82s9aSLT0HAmBHdXOsMEFu4KIERXqvItVE=
X-Received: by 2002:aca:5785:: with SMTP id l127mr2344269oib.48.1558612618333; 
	Thu, 23 May 2019 04:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190522160723.31484-1-laurent@vivier.eu>
In-Reply-To: <20190522160723.31484-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 12:56:47 +0100
Message-ID: <CAFEAcA9LtfvZOgqSN=b19kprFL_6CEfBcXynqbfn1LniGHdPhQ@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PULL 0/9] Trivial branch patches
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>,
	Juan Quintela <quintela@redhat.com>,
	QEMU Trivial <qemu-trivial@nongnu.org>, Farhan Ali <alifm@linux.ibm.com>,
	Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 May 2019 at 17:13, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit a4f667b6714916683408b983cfe0a615a725775f:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' into staging (2019-05-21 16:30:13 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>
> for you to fetch changes up to 2d9574bdbed69b374116c59259f6bd14f7dfad7f:
>
>   pci: msix: move 'MSIX_CAP_LENGTH' to header file (2019-05-22 17:35:27 +0200)
>
> ----------------------------------------------------------------
> typo fixes, TYPE_XXX usage cleanup, comments update,
> virtio-mmio trace functions cleanup
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

