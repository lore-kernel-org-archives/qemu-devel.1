Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF3FC606BA
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 14:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A8321537
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 14:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ul/F1h7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A8321537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkUFO-0005EG-NG
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 10:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34161)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hkUEt-0004nz-L4
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hkUEs-0006Pi-45
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:03:31 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:39406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hkUEr-0006HP-UI
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:03:30 -0400
Received: by mail-ot1-x330.google.com with SMTP id r21so846261otq.6
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZG+8B/Eg3xk/ZeHWGGJalgJI76sSMgmWD/RrzpFEZ/o=;
 b=ul/F1h7li8LH/MjS7TXjJAgEo8VhkpA0Ingk8qJS1oiYwdECd0ReTgE9wyb1PvQVqy
 13rsh2PQqgA3yDZZZlWqNAsfR4yQ1F2dOqtmbMYRN1Vh0c2PVDW6DKDxgwr39FxrcLP5
 VdPj7WE2lL9Yoh4fZweXuDfSwkyJ5Ef9gJUmxRZa89tpyY6H2xeoXM4V8lnDeXS4Y5Jf
 JXQdm0z8NF6iS1m0US2MK2yo1pmhQSYPuEVtXedtUVxaoBAkTU50e/f2RfUL+1Bt006K
 NIasZrhcHDjAN2ahuInZ4mx389VoO6+16oSz9rg6quJ7V/9hMUPn5witIdsuakhJ6S9V
 TCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZG+8B/Eg3xk/ZeHWGGJalgJI76sSMgmWD/RrzpFEZ/o=;
 b=LH/wSGoBvt80Pn2bDnfMqo+IxL+sNdWHa7BsaCPsvkc2s+wEgizKrruaPmOtkMe6HX
 ucfd20nTATXCcuJzJ57FrBA2XSnlNxu34/2n4yL2/bx838eUI6vr754UmHFxVUsWkhwF
 NHOtbC5y++06W3pdx097uM4nHkltZWT3yrn16ArwNj4pvKhtvMtwdYqeY4iSM8pX/SRa
 dMfVA4K7tpjbNbmZJLMlfNEPRe8b246mWGbUuxq4jBATs3i1ngCWmmRiWghkrMh8IDqA
 rRDYphpUuvHwaoiez9XewL6cVpuVF0AZGHLhomAujy0Jv1oGLhJQCj7rsc25iImvkc7L
 TF/w==
X-Gm-Message-State: APjAAAVPilgZmgsOa0HWSoCqpa1HzlvFSJ2HOHjRfXgmoi/BvQsFv/hV
 6zfQ5rKzPIajngjJeoY77HNCUFtSZT0jZTClGq1JZg==
X-Google-Smtp-Source: APXvYqx6MRlUVWoBdS+9i8Ql80rmXPtg395PxT2uXw3Zvqp+ufpmL7AlZX196gJ8KnSP1vizFCjKQE3X6TxChLa077E=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr13448347otj.97.1562594606447; 
 Mon, 08 Jul 2019 07:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-yzWhwYPzC9px0H-=x3XEPVBjZOhk402is49YpbmJX9g@mail.gmail.com>
 <ac682594-fac7-ca67-2cef-85db15920c7c@redhat.com>
In-Reply-To: <ac682594-fac7-ca67-2cef-85db15920c7c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jul 2019 15:03:15 +0100
Message-ID: <CAFEAcA9poShFrf4s3p+uTkGSHK+2pPti=7510kDQqB0ei3HpNQ@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
Subject: Re: [Qemu-devel] pl031 time across vm save/reload
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jul 2019 at 10:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
> You're right, the compatibility causes wrong behavior for the default
> -rtc settings (the RC pauses across migration).  The right thing to do
> would be to store the base rather than the offset: that is, you store
> the time at which LR was written.  Then the offset is s->lr - s->base
> and it's independent of the machine on which the rtc_clock is being read.

So I thought I'd try writing a patch for this today, but I'm kind
of confused. If I understand you correctly, you're suggesting
that we should migrate a new field:
  base_time = s->lr - s->tick_offset
and then on the destination we can reconstitute tick_offset with
  s->tick_offset = base_time - s->lr
right?

But isn't this just a confusing way of migrating s->tick_offset
directly ? We'll never end up with a value at the destination
that's different from the offset value we started with on the source.

thanks
-- PMM

