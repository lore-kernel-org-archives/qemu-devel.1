Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4247BC06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 12:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EFC621850
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 12:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HC3UvwMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFC621850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj193-0007MY-9y
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 08:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42394)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj16k-0005wu-AC
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj16i-0002zj-SS
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:45:02 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:32868)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj16i-0002zW-Ke
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:45:00 -0400
Received: by mail-oi1-x22d.google.com with SMTP id u15so4872586oiv.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 05:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=whnbUgl1cVb9DFYoNg5igsT3p5GLfWmPY7USps62CfU=;
 b=HC3UvwMmfkBgz7WATe2ZqEZqUJxo5/W7wupQoDJVh0WI+kR1IzUeoYHXRLMi7UHmL+
 ba3skqP7Zd8r3Se1b870aqcv1jB5aH/eQ+ytHshDi6KlanPI4kJdjR1GLijaHpIwpPGi
 FTFoTIUUzkq7NjKIIFrZSW+kX8jbSui62o22KJfj+Z2cNS2aKSaO4+lCPcseFZCxZHIP
 IUUChq//s4JBKiFnWP6zYDn++we6xu3vpvYES3N6ybZcTU89otYIDIfb5OBMkFCUZE97
 5MO6J3fPemIr/e8DQ8eheIVExBeeLSU2DvLgcyUL3+nTqBwOXs1+SSTm253ujAULNOZT
 UZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=whnbUgl1cVb9DFYoNg5igsT3p5GLfWmPY7USps62CfU=;
 b=NPOVIfEN6oJY6qLzh20j429nG8yXGk2Ibqd4SYq57SYVJkNLcFqYCQIHMk704DkUzW
 IafwP0S7L5Mp9aDdkkoKM78HCGJLVXvBbQRCSOqAB6ZGvfsrx49ZDy7lGdVANACPTAPZ
 ST+DCju18qNhwMiWDTqcfwNADN0xSxpVFFNIsKdMuiavdATOmYOORcnOsw4ac12swCWk
 Bvayq2s+sKooE3956eBGid+vU+2A6jObhjQvnBy8d7+UhCJsJkc7GQl8BJBMcGBs7ao6
 uObOWNEX1NkbElCiKk98QCXHXadJoiAgGvIgPQ5h23QC6jNUXiT8YJToHXUAloT3tISV
 4rqA==
X-Gm-Message-State: APjAAAUoMfK7Fh61c6aFvP4PzMoxlbNZEHkXGoHgpTEMDdHnJmGzp0Xx
 +9+KYGXHuzmTIQTXp3bWxlVxAR+hyIXEktK5aBKmTQ==
X-Google-Smtp-Source: APXvYqxJ+6ofGkT6v/A3XAWZ5NW5IU8AwjlN1aQwXvuxRDQwiYC57qhIp9r0YpH1fulCzmBrqlg0q+p0A04XkchORrU=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr1752818oij.98.1562244299767; 
 Thu, 04 Jul 2019 05:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <156210666074.19884.7711861336532593819.stgit@gimli.home>
In-Reply-To: <156210666074.19884.7711861336532593819.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2019 13:44:48 +0100
Message-ID: <CAFEAcA8gM4eBk6hgLmknnN6EUzKkYuCahHo7c+jO_NWqstGYEA@mail.gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
Subject: Re: [Qemu-devel] [PULL 0/2] vfio fixes 2019-07-02
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
Cc: Eric Auger <eric.auger@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 farosas@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 23:36, Alex Williamson <alex.williamson@redhat.com> wrote:
>
> The following changes since commit 506179e42112be77bfd071f050b15762d3b2cd43:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190702' into staging (2019-07-02 18:56:44 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-fixes-20190702.0
>
> for you to fetch changes up to 5053bd781143c354dfe3c8747d6c013dc22851b6:
>
>   vfio/pci: Trace vfio_set_irq_signaling() failure in vfio_msix_vector_release() (2019-07-02 13:16:29 -0600)
>
> ----------------------------------------------------------------
> VFIO fixes 2019-07-02
>
>  - Remove outdated comment (Fabiano Rosas)
>
>  - Log MSI-X eventfd switch failure, fix Coverity issue (Eric Auger)
>
> ----------------------------------------------------------------
> Eric Auger (1):
>       vfio/pci: Trace vfio_set_irq_signaling() failure in vfio_msix_vector_release()
>
> Fabiano Rosas (1):
>       vfio-common.h: Remove inaccurate comment
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

