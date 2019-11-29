Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80A5C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88DC8208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s60gmHhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DC8208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ialjl-0004sw-Mk
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 14:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ialXr-0007Oq-Et
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:03:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ialXo-00060z-FH
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:03:10 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ialXn-0005je-6U
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:03:08 -0500
Received: by mail-ot1-x341.google.com with SMTP id n23so25607382otr.13
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 11:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XNMHPRJf7NX4zIxzIyJqa1bB7RVy5DxMdwYmmbkL0uY=;
 b=s60gmHhx4pvqe6li5zizwIYX3jAsP1G8IfSZ2bNJ/uA6Le64aihajegOO5Uv2Px86o
 qSb68919UCMvqdDCnW8BjWhGh4aHM2XWnYLyyHI9E09v4y9wv5LZj2axcGHPRuUqkTSz
 JFj4r+eZcneeA9nysMl5SNgyZ+WihzqOLTfwDxWadM4Oakew7o1mIrauhHjL1unT1U4J
 CsOL+UuPOL716rGY/MmfrkPk/nFHna75AI79ygSmxghlXpNV+oNaHcObNs1hcJN/DtZo
 JDy0DOaBddIbbGXzaK3J2V1s+mmydFxsHmx6ChE7SU3EVhnYlWuobve0BW8tJec7mToi
 TFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XNMHPRJf7NX4zIxzIyJqa1bB7RVy5DxMdwYmmbkL0uY=;
 b=UfTn+a6/zcizWXD+Rbd2N1rjwpAOOMZOEwtke4p47gHSZ9cRZozz1kCQTRPFfJDzsJ
 7uW4xQfh6W4+kmbF0/bbKKVy38byFIJ/UXYZHMCQCsUEgIqG5WcooeMxOYRt0JFfrab0
 XA5ui8dssoYbv7l4ZM5EAvOJ2i3n4JYJsP0oV65OFc/Bi+/qA7cR+zgZj4H6MjE2lnUG
 4yvXod8rsbNmFZDzBBXuYi39QeILH/1uBY9pt539oj3WwkeX6GNNx+cfHhWjzKce+2qi
 7p4b5ivCEef9lxpA6ld2Wa32w63+gnqVpJlX+FjxggPpS2I9SjBYKlNgoZYRkGoPv8cj
 c0mw==
X-Gm-Message-State: APjAAAW9ClB79zKf6qWe1E1oicC7K+TwPmvP8J2d92vjv5GOLzVGWZ9Q
 9Bon2Qwrgww/rgS4+h+oWXUpImfghOV16NNEiXEpfA==
X-Google-Smtp-Source: APXvYqyHMRbCOPjE9HwyCJAZdUepMbyKlj8j8+nuvO2Gff6GYeZfG04u2QASAonTv4I4zCs9F5U/7o7XbGEDaqS5N9M=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr11206932oto.97.1575054181206; 
 Fri, 29 Nov 2019 11:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-14-damien.hedde@greensocs.com>
In-Reply-To: <20191018150630.31099-14-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2019 19:02:50 +0000
Message-ID: <CAFEAcA9ScnmyFXec7sdqjUdKJ1FcJCnOdiHZYqavveTWoQ78zw@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] hw/gpio/bcm2835_gpio: Update to resettable
To: Damien Hedde <damien.hedde@greensocs.com>
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 16:07, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Transition the bcm2835_gpio device class to Resettable.
> The sdbus reparenting is delayed in hold phase to respect
> resettable side-effect rules.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

