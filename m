Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979B4C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683A12067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ww6Na8zO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683A12067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipFVq-0000bU-Fk
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 12:52:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ipFUe-0007Cr-LV
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:51:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ipFUd-0002nM-Ij
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:51:44 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ipFUd-0002ly-CA
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:51:43 -0500
Received: by mail-ot1-x343.google.com with SMTP id r27so4394613otc.8
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 09:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EumLXX1XF7D/XgT2FUPJGk5UmCAhXwl1l2QbIwTe7x8=;
 b=ww6Na8zOQ0Achy4Zm3ObKx+J/XtmBQSktzmMmpNddc/+9aeSV+oEq/F7q8HoWZmX9A
 kYWhmZO3F3GkK0099+SYh6hoLsAD2Nu2wyJ7Krknuh88PoVPbRr00b2tP/xtrCQ+Xyv4
 YBhpZsvVQCSpIJx8/UFa1Z1XvAAzbNeZmxmEulLGSm0ggyc+oFthKlOzVGIwsIHYQWfq
 W7Av51d0QymQ7WAPElg2ZzbSG39opWhO3um9ikzbiXM5Il/gRaod8au1ouyI3YYAvpJG
 g8HJwZrbzN0niA4KW9xhG8ktXx2B+ajAgHq5g4reSgD1Q3u7UKwGcfH0T8D0Rqb6kFpo
 oEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EumLXX1XF7D/XgT2FUPJGk5UmCAhXwl1l2QbIwTe7x8=;
 b=cCK32aZR/wi1J1hsHLPtuqSJ6EsKcM19GXWTpMOfsVA/1t8wjJjPiM73Ej10UDbRd7
 zF3MvUav9HU43eKfL87kmg+wrkpmE3APpMxmvlRIM/ZmSqewqTIWzBzqVq6u0kMhIt9X
 4wch6WfN5bVxYJnPnwmOp/edxhOSLzrUTTEKRbaQBXiAMBP7l1OZPCmRZXhZd/T3QtGw
 Cp42yw7JO7kdc0WuOZJOUX75N0gqtB4y7nnJb6iOO3L+IFTy0TANZdxbZ6v3Fk+vnUNo
 3gCRhEbm2lSnPhQBdjXNCMQa4SQ2sv40YSlwlwjblv1BfwGXpo82mni8nqrsFLsmV9/r
 1COQ==
X-Gm-Message-State: APjAAAVEzAB4zmD5Jqwr4IpMryYYLcjV6T6GnnCBHDNKP/nw1vDKrJh4
 yRBZ0i5fLHt456jfsUEyx1oM1lXBEb3doNUTuD4v6A==
X-Google-Smtp-Source: APXvYqzCD22PBgif05TUFv5KWT98RQsAn7VMZDlw1jfRa7dq8WIvkq5Zohrnl15Oa2K3R1bXGKIQzOnZlMViuNSko+c=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr5127266otq.135.1578505901742; 
 Wed, 08 Jan 2020 09:51:41 -0800 (PST)
MIME-Version: 1.0
References: <20200108161618.221116-1-afscoelho@gmail.com>
In-Reply-To: <20200108161618.221116-1-afscoelho@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Jan 2020 17:51:30 +0000
Message-ID: <CAFEAcA9v-x31y0CraXkfAN3PVQs+Oyo3F+mTA593Duf0t1Wb0A@mail.gmail.com>
Subject: Re: [PATCH] virtio: Prevent double swap due to target pre 1.0 VirtIO
To: Andre Silva <afscoelho@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jan 2020 at 16:20, Andre Silva <afscoelho@gmail.com> wrote:
>
> Remove the bswap function calls after reading and before writing
> memory bytes in virtio_pci_config_read and virtio_pci_config_write
> because they are reverting back an already swapped bytes

Is "because we wrote it via virtio_pci_config_write" really
the only way that the data read by virtio_pci_config_read
is ever set or updated ?

thanks
-- PMM

