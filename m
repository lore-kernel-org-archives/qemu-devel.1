Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD868ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B71720872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xzpils4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B71720872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9Vy-0004LR-4S
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL8P0-00023a-7x
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL8Oy-0001R4-9R
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:13:26 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:38925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL8Oy-0001QN-39
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:13:24 -0400
Received: by mail-ot1-x32f.google.com with SMTP id s22so2374511otr.6
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 09:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ULGX1Pw0oU0K+1vmNUVb8VFsgvzKvU/ec8B90seQ/cQ=;
 b=xzpils4xsulwztPOEwAPFmJi5x96TP6E6YT0wXTwPW06R1YSb4xSbH5/n5N33LEMi4
 l7yC2oj1BZmn1xmhL6lXfvfxdUqp+gwt/dFVu1YuPck2KQ+ob0oWdji1yoiHfv1986Bt
 B81ADXDpx5A7iqORWmSmSwytGyGXLyBUc1sGd//n/ihAI4pUukgc/dWhVAgdOIaPa2fN
 cQs25yZff92Gi4M6IZggHTOACAeBPEzDWp6C+sO6RFlH/bvOIgRmlunoIfMOerkb8KfW
 amkH+qeenG29hORl/bnz28jiiP7JOyNo6J9NWD4959Nc4CzZUdb9BbvSGOqjY9VXbXNg
 k0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ULGX1Pw0oU0K+1vmNUVb8VFsgvzKvU/ec8B90seQ/cQ=;
 b=RF2wzgfJVvNlHOWjq2lV0L1hFuAGGXvwP3TWS2dPud3R9WEBBCP/mpS4VK92aC+cFb
 NKTYez9GN9via5mqXC61tyirRZ045UlZoUWD/rfAjC6uPck2C9pmRFaOqPWAC0v7sVxx
 KZJvzmtSp2rz5Fgqktdw8L4aIQ83iD3S0M781dI4r19bA13/YsJ23no9YTM87Zln6meb
 gCz/NFoAoQPPhr8BZEqM0rc6KaGxHsk/YFBHxYQ+ufjMwje34SzQwBN3pLQ2stXcFu8S
 9v2KyJlLu01ZxAmnK+VTzEYJR5P6nZsHzCWiQ8cQHw9C69yli1kOcGZIvrfq+oWjr+n7
 1J7g==
X-Gm-Message-State: APjAAAWuk1g/o+scG1rRnNqYW7Cyir4FBiFaYqqiwxVR6G7FprD/3Lk9
 GjzEPAvHx/FjIpboknMlwClyJHMhQjW+j3c1rRoqGuMbkVU=
X-Google-Smtp-Source: APXvYqwuwA9uUCSNFBfLocasJQ3cAnaofaYkAmhWWYnDSm/JcOVc3UxUiP0O81EW1CCaUtR/Eka/hhH2jUMcmb103f0=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr3757501otj.135.1571328801844; 
 Thu, 17 Oct 2019 09:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191017151606.GA1880840@orkuz.int.mamuti.net>
 <82ea23ea-be23-c374-3f10-65d8f6e79432@redhat.com>
In-Reply-To: <82ea23ea-be23-c374-3f10-65d8f6e79432@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 17:13:10 +0100
Message-ID: <CAFEAcA-pkD_LCh++TWoO77=Bu9mYe7HOkaeyCXjLopAmqhpi-g@mail.gmail.com>
Subject: Re: Default CPU models on s390x and ppc64
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
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
Cc: David Gibson <dgibson@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 David Hildenbrand <dhildenb@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 at 17:09, David Hildenbrand <david@redhat.com> wrote:
> The default model under KVM is "host", under TCG it's "qemu". We should
> not use "qemu" under KVM, although it might work on some setups ...

Possibly a tangent, but on Arm the approach we used to deal
with "'-cpu host' only works for kvm" was to define a "-cpu max"
meaning "best thing you can give me", which is an alias for
-cpu host with KVM and an alias for a CPU with all the extra
features we have emulation support under TCG. Then users can
use '-cpu max' and have something that generally will DTRT
regardless of accelerator.

thanks
-- PMM

