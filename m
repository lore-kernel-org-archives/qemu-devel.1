Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216A5C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6FA24659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zxIK7zx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6FA24659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGno-0002l2-LI
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idF5Q-0007rm-8e
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:00:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idF5P-0005nt-1z
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:00:04 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idF5O-0005lR-PD
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:00:02 -0500
Received: by mail-oi1-x241.google.com with SMTP id j22so6379772oij.9
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eOLM4an9fc0aqxUJp71/rlPAB5BObyJXmI160pSiPVY=;
 b=zxIK7zx79X/dzDCJPrU8k6TPGxbecc6UbR4y6TTpTz3DjhmKeLDYXeZiP9fAVd2Y3A
 PYo0Uy4IG9YJNo2tXj11Dny0gOc0ZrxXCwTfYBOMy21rbjFknJNnJGpMeWALjYt/J9KF
 hABouP+p+xi7D9v3ne1hk9EGDRuAsTm6x8g0/n8r1g5lLAUCui4OV5IPqV2KvIdXbV/h
 fYmBN7Xnn85UyLkXcXx5ZTG0HP487OrdOz5b6lu8eZb2ZY0GweAvUgNnQhyCqrbDSKcg
 d81tT0aNtFZ61rzrLNaYqeZVPixYEMVZm425HU3H+Ka6EQIhQeuptbt9e06mpQdJnAzz
 xbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eOLM4an9fc0aqxUJp71/rlPAB5BObyJXmI160pSiPVY=;
 b=hi88ECIH7Ol18QrR31uX3XzvwD/MYbFK/c4pn5ISS+jLQJYpFqL8eIvG8P6nyT0Y7m
 TIapN93KDy45tEIbvwtgMHVfPP5YvokJSHOT8WpzpO86UQFGIXh7Enrubw6UJYD7wz+j
 Q2Y3CaR5NvLAi2lskJ+SivWi9u+M/SkdVK7n05TTKgz/9l6fWOVcQ/5T5GJ4CQl5rd6s
 Dg1WGsXHJNa0mya3ICOmZw/tBVHy5Q+Ix8hRjXrOSxls4CzsKQj73xwU1eiZa7OeqnYk
 sL/SPcJo8vsLT5peaZ/NzkLWOMa2n3Q6PpE/QnDzQvGw1bpM1gOE/UeV3/8+VpcuMdU7
 M9ow==
X-Gm-Message-State: APjAAAXdpYtbc4M0e/9Q2bl0c34A5xInbGdbujFkYtNjAqQAYIkcVrox
 xxtc8EhP30IkQY3MDzINPQ8bGFB/NlOpp2wMn10e2Q==
X-Google-Smtp-Source: APXvYqyW8BtYV2mrUNt67h9M6TKKFEoFrbE5dXdkMxeaeMaRe8xgyZT0Xqc3AaoWPU0qkfYGiYMREuLsB5IboOOlODg=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr12877351oih.98.1575644402117; 
 Fri, 06 Dec 2019 07:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20191121000843.24844-1-beata.michalska@linaro.org>
In-Reply-To: <20191121000843.24844-1-beata.michalska@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 14:59:51 +0000
Message-ID: <CAFEAcA-8gm4Ug=NVONfXN_4Ek8uL6NcjqkOzpOpsSBMXOHmUqg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] target/arm: Support for Data Cache Clean up to PoP
To: Beata Michalska <beata.michalska@linaro.org>
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
Cc: Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 Nov 2019 at 00:09, Beata Michalska
<beata.michalska@linaro.org> wrote:
>
> ARMv8.2 introduced support for Data Cache Clean instructions to PoP
> (point-of-persistence) and PoDP (point-of-deep-persistence):
> ARMv8.2-DCCVAP &  ARMv8.2-DCCVADP respectively.
> This patch set adds support for emulating both, though there is no
> distinction between the two points: the PoDP is assumed to represent
> the same point of persistence as PoP. Case there is no such point specified
> for the considered memory system both will fall back to the DV CVAC inst
> (clean up to the point of coherency).
> The changes introduced include adding probe_read for validating read memory
> access to allow verification for mandatory read access for both cache
> clean instructions, along with support for writeback for requested memory
> regions through msync, if one is available, based otherwise on fsyncdata.



Applied to target-arm.next for 5.0, thanks.

-- PMM

