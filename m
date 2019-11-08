Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F0AC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D400F206BA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HB1DHe1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D400F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2BF-00053e-1M
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iT2AX-0004b2-Gw
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:11:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iT2AW-0001H2-AB
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:11:09 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iT2AW-0001GH-34
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:11:08 -0500
Received: by mail-oi1-x241.google.com with SMTP id j7so4912768oib.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 03:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rbgVhZXxnZswzCulD42asmbDN5pH5nEu/3r6neC03hM=;
 b=HB1DHe1KzU+F4lUuNRYpF9EMnMt6h+7mWgW+kzDp6bhaTiCMM74X+Tb9fnIcV8+4X1
 y1Bgg0ldMnD2bXvIBWgMXFXrV7+ooo1Xot/c5Lp27suOlbfPl+KPTsQuwyeCcme3cr0I
 9+okESUMv6vVEyxzQK23P7BuZhc3m8MasUN7bn+EGPAYcHNs9HczGErDdNDKrvJGqs5N
 Ln7ppqF8nUEtNhNMC39T7j358OiyGIA8qIz00KG8AHArIxruHSRKflZD1pslUiWntN4e
 097aBJ4TDg0DpFCAyLWRVhGu0wiRU3iyrWy4IPs/rakzwnB5LkCkZ2QRm9eQcCJr3TEv
 RY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rbgVhZXxnZswzCulD42asmbDN5pH5nEu/3r6neC03hM=;
 b=XutRqwhIVadCNjHzDy/7CyvCta+siEyifro0J+KfrlI+3Ea+/B3RFVvkUYiVYrv9eH
 iZvTlXeZbjvJJlHNFtLNXV/a3rOEFc8H3Z9h9RNGJkYTdhydovpjKbFknomtGlJ5wlQi
 Lhx3sLFnUcNUNIZ7LxCQcuXWnqftT69rxOqawd16h4Xehyi0eYJaDpq4Phqa2oR/sZ32
 T86RcG1uywF7D6IT+zgJQzZTZCrf3FyhOodrDa/ighCiXDC861urxaEF7FPt2t4LCGXY
 HwqQ+wXHl54Y3JEPwx7eV4D2hWDRRLEE0rYu7tFF5qF8qF0JG5gwXjtxUahBEUYl6PbW
 OpEA==
X-Gm-Message-State: APjAAAXP8ePc6bmqxbDqVLmw0DQEBrrNGmJf5KK6E5ECQoqhwpvPJZby
 Wr++elbcOgGgoxdVioNQsC7KrW61DV+WtDthahZUag==
X-Google-Smtp-Source: APXvYqwqohUzP34s9UyxRmIjzW+FL6h+tpC8/sYqMWwgs7RCVe3v+Abr9DvKdh1RIIOrLieqZes41xM9u/aBqHm0Vx4=
X-Received: by 2002:a05:6808:7d1:: with SMTP id
 f17mr9262112oij.163.1573211466909; 
 Fri, 08 Nov 2019 03:11:06 -0800 (PST)
MIME-Version: 1.0
References: <20191108110714.7475-1-david@redhat.com>
In-Reply-To: <20191108110714.7475-1-david@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2019 11:10:55 +0000
Message-ID: <CAFEAcA-mD3-Zg2JunGpMqbcaT1qboCenhqEFytZD0FmFcL2i9Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Michael Mueller <mimu@linux.ibm.com>,
 Jiri Denemark <jdenemar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 Nov 2019 at 11:08, David Hildenbrand <david@redhat.com> wrote:
>
> There was recently a discussion regarding CPU model versions. That concept
> does not fit s390x where we have a lot of feature variability. I
> proposed an alternative approach in [1], which might work for x86 as well
> (but I am not sure if x86 still can or wants to switch to that), and
> requires no real changes in upper layers.
>
> [1] and patch #2 contains more information on the motivation for this.
>
> E.g., specifying/expanding "z14-best" will result in the "best feature
> set possible on this accelerator, hw and, firmware". While a "z13" does
> not work under TCG and some z/VM versions, "z13-best" will work.

I think other architectures call this concept "max", not "best".
If we can manage some cross-architecture consistency that would
be helpful, but is s390x using 'max' already for something else?

thanks
-- PMM

