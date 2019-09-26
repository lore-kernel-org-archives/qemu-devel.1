Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5BBC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB23021D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dk5OhpWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB23021D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDUt6-0006AP-Vg
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 10:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDUs4-0005J0-LI
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDUs2-0005Gc-Gt
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:35:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDUs2-0005GF-8q
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:35:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id k25so2233519oiw.13
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 07:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yPYX5qHyBzPgnzr5y6xx0wXzRwdWF2zDUvvfz7NAvTg=;
 b=Dk5OhpWrYy/kVzOQ7C8K/AxaUO4B5h6fG5+c9pEfO72JmBpvc5DviqkpeHxwp2M1Zz
 bTtNua5DHrM+yG7f6ZfXTzPohcExQGX3NdJdtygj9+ROaagEsvPcYxUXWTOdFvx1qp4W
 gc0hneyX4VaiHjEmVbK9JnKZ8ZfIizsVbEzXMuTQGdG+/jv55N/Z75NTcIMjWufJbynA
 sh9qlWI6FbkD4dmgNfT18voq8LFWwU8+G7hde3Wee+D/5hk8uhyOGJ1GGLdv0yLuCCco
 AiDTaBOn8g8ySBFSifG+CDqf4lQ6apZMtJrfeycFWio08vljgdw1nJoFbaDWFiFwHyga
 BB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yPYX5qHyBzPgnzr5y6xx0wXzRwdWF2zDUvvfz7NAvTg=;
 b=dknHjlugoy9mUarrwjDYB7b6wKzkNn+cVsiKufjy9OzzH4Y8Z8wmFrqIHtBJzZDuTu
 BIE01g97Bn/ZfuYN8kGF0X8JFSN4QR8W8VWdz/VK03gNvnVd9yWLWKNDErTHpF7kNOh3
 40yzVKvV4QR+9I+ApoGc97nZKR9YpPi8kdQqIusw9Ml71yS8e8noAZS0nlv3WgBxuH1r
 kie85e/ZvGBw+NnXRepDDfl1lYVTlqFzH2PvKs7283TmxdaLLzy68TgiKO5I4ZPLppr0
 vCmNMtjMYvt5Q99fSi+i+z4gnak7LY89nL1j9877V/8cfhd4ekbxDw0Yg2+YE/rVlXzb
 drNQ==
X-Gm-Message-State: APjAAAWzKlA+eA7KUR0QQ4/BeYRAx298976laOQ0Pk4pCbCz1kPWUdOD
 GatM1WFn5YirbzP2SdEFSyABUqkqsxW0K+sHveBMRQ==
X-Google-Smtp-Source: APXvYqxnjmILe9/jRHdgrMi9i3hgEF0hkOpFtIbkKED++e3MFtju63xbHTkfAXa2amamii0JW5+L90EZDlJxCZRDZJk=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr2717450oib.48.1569508489545; 
 Thu, 26 Sep 2019 07:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <1569507036-15314-1-git-send-email-mjrosato@linux.ibm.com>
In-Reply-To: <1569507036-15314-1-git-send-email-mjrosato@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Sep 2019 15:34:37 +0100
Message-ID: <CAFEAcA9VFmeqGy0Rt7_8GEenQx_8M75=FQX4zbL+c904hNx0gg@mail.gmail.com>
Subject: Re: [PATCH] s390: PCI: fix IOMMU region init
To: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.195
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
Cc: Collin Walling <walling@linux.ibm.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, stzi@linux.ibm.com,
 Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Sep 2019 at 15:12, Matthew Rosato <mjrosato@linux.ibm.com> wrote:
>
> The fix in dbe9cf606c shrinks the IOMMU memory region to a size
> that seems reasonable on the surface, however is actually too
> small as it is based against a 0-mapped address space.  This
> causes breakage with small guests as they can overrun the IOMMU window.
>
> Let's go back to the prior method of initializing iommu for now.
>
> Fixes: dbe9cf606c ("s390x/pci: Set the iommu region size mpcifc request")
> Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
> Reported-by: Stefan Zimmerman <stzi@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

So in commit f0a399dbae6a2d0e2 (Nov 2015) we used "pal - pba + 1".
In commit f7c40aa1e7feb50bc4 (June 2016) we switched to "pal + 1".
In commit dbe9cf606c (Jan 2019) we went back to "pal - pba + 1"
Now we're on "pal + 1" again...

Are we really sure that this is correct and that we're not
just going to keep looping around between these two formations
forever? :-)

thanks
-- PMM

