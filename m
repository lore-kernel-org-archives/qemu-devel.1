Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B06C54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E37D2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qNFbj0zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E37D2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7xN-0006wA-7H
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1jH7m8-0005oc-Vt
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1jH7m8-0000nZ-3E
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:17:00 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:45491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1jH7m7-0000mb-Vp
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:17:00 -0400
Received: by mail-io1-xd43.google.com with SMTP id a24so1981212iol.12
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9RGHKxNbbnl/s4SmG5NdZhXSU8xB6QWkp3vD/nnEXdQ=;
 b=qNFbj0zmmpZYr7uKM8J7jzwlFkp3/oK+09Jtl7asSlyGxlS486Kezm77V/3MtSEMno
 fW3hVmHhXU14kpel4gG/Z1xg3nfey4dplu4o/+bakM/f/A6kmsxu4C1cpL5Z6sUn40YB
 0C7NGCxv3ElTOlSTJC1GFoJ0q2dtqQ+x4cCTgUtL5yFplF3RXvadbMMu4HLjKgHhheIf
 eMNW98F2Jq27GqXdXBx/hAZuAQhzwfW7wsegTJ4grlpjKr5ei2UUTUiIhQggLdBRGMPp
 irTc6RIOFoBUg3uxmc0dn60FeF2yyp+0Gg3qbnBnmxNuVTB1dHL3QkO8BAQfB7ptTfbN
 klOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9RGHKxNbbnl/s4SmG5NdZhXSU8xB6QWkp3vD/nnEXdQ=;
 b=mkD12NwsRYojWBiG8tKDvZb+JLDxqB8llj97GfEX30QP0NttmEv8inF8XueiSKwkUx
 IG/YCKngvRG784D/T8dALxAXSmPKlYVCqxfd9rfZKHavMCducfOFZZ2gMcsJyoh35jT2
 7BJa1waHG87aILmcXRIypjCasGF7bBZkbhDdv9EMRBwQyKmZnO4o5UD0axjNuMxfvJBt
 WAN8JqgdSHYWEaaYZVzvIO0EtLCeMuuJTy7cC3jyXVI44RCT4FbEV3mi7Qnm7s52fp4X
 dZx7oWbrmrxVq8e8hxV+TKEJOOISF+Gb6/7bIcLBcq78wWRXG1OZfUnGSfAl3FX3zf9B
 5C0w==
X-Gm-Message-State: ANhLgQ0Hr5XIeKWRKCSc0Iz1THuJb0sB4K0BmGUlF2UGgAPf8xVptXoW
 LS3+QWHrIzhQhODwi2ws5/EHjbstR22L2A5LYUYnpQ==
X-Google-Smtp-Source: ADFU+vtiYL30PNCMxaUigbiLawILpk5RA5aaHfFoG4N3RszvvhUgvausmB69gR+PBEN213OVwHhebz5+d6npj6zlDjw=
X-Received: by 2002:a02:2944:: with SMTP id p65mr3247806jap.89.1585149419207; 
 Wed, 25 Mar 2020 08:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200323113227.3169-1-beata.michalska@linaro.org>
 <20200323113227.3169-3-beata.michalska@linaro.org>
 <fdf4d6f2-ecab-6358-9f74-480f1fa6fdef@linaro.org>
In-Reply-To: <fdf4d6f2-ecab-6358-9f74-480f1fa6fdef@linaro.org>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Wed, 25 Mar 2020 15:16:48 +0000
Message-ID: <CADSWDzsuGXBwZLm-rJ7ULbODVk4SgoNvXHqJM_BR-gYJNeMB+w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] target/arm: kvm: Handle potential issue with dabt
 injection
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Mar 2020 at 18:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/23/20 4:32 AM, Beata Michalska wrote:
> >      uint8_t ext_dabt_pending; /* Request for injecting ext DABT */
> > +    uint8_t ext_dabt_raised; /* Tracking/verifying injection of ext DABT */
>
> Is there a reason these are uint8_t and not bool?
>
>
The ext_dabt_pending is reflecting the KVM type.
The ext_dabt_raised is following that one.

BR
Beata
> r~

