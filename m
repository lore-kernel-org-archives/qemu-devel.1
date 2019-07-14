Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3A1C73C66
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 10:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998082064A
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 10:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A89b0bLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998082064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmbx8-0007Ke-P5
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 06:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54117)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hmbwx-0006o4-F5
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 06:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hmbww-0004BX-C5
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 06:41:47 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53321)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hmbww-0004Aa-3X
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 06:41:46 -0400
Received: by mail-wm1-x343.google.com with SMTP id x15so12461375wmj.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 03:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ekfN7zelEptPkdaz3uwfS2QEwGl6oC2JaNU4vJovymI=;
 b=A89b0bLG5oxqUB9xsoZfD+iKpMIbIz1KU4gkjLNIqE3QCJrhB2AU/8yc/I3MFvXAD+
 xdKRQSu3NocbVa7sBQnoDyGoVWYtf8SCz2cOR+2lMEe9CoeTDuBJ48NShNbqJC1yJ2iS
 SGEQ3dXam9kBx2aD12yiEnWhsjLCd/S39veEPNPwBkMBo+JEn1D8ds3fnbIWGAZYiMD9
 K3rNKolHXFqF5CuuvnmybdRdxrbxYYlegjOxeQgjTTOOulxfTUkVftJV1e8GorQHbcXp
 BOga/sIoVxpatLNNN989ag8DHiP2g197eajJcAN0xRq85Ypd/6Jbs9JYLQ/o+oyxC0CD
 HPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ekfN7zelEptPkdaz3uwfS2QEwGl6oC2JaNU4vJovymI=;
 b=GJohTvFtZCuw9kCmqSQDke/syj+0hxmkcw1SeD6enkf/ubLErv7TlVmuZ2dMO9O68U
 9uB+v5Hk1MX4pj98Blc+wOsfAn7DLa79o/BQFs4n7wTl6FcSU9oGlo4sRaL33oodTv4x
 xnjOzqtz0ridM4FEgsHc9y+zWRenNOZc++N6kSOcy32B8AHEVScnA9KAKOFpT2B2lP9W
 ld9iOHk5qLdlWKXtRO1aaC/vA5jEsoStLCPXk4uMrQNMWW1U2WJ2sdNJRHlQPFiag4r1
 Od0bsry02WH2ZoJGQQOvv7Z2BfyUO66U7npqsrUKQXX2owrqDpBHorrCFKmLOchkzXtf
 W86A==
X-Gm-Message-State: APjAAAV8B2hMT8VHoP1UL6PJpZawmZABEoMjCytaKpnm84GqoK7P/aXm
 nRrVQ06xQ3fzzNXUrRr+8Gn76w==
X-Google-Smtp-Source: APXvYqz2P6+01VRLqfOunluUmvcFHCnXWe0yEtdOGyuZgqlDDHGah4PXZwqkYrQqIf3WgN+TrNSByA==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr18953733wma.120.1563100904033; 
 Sun, 14 Jul 2019 03:41:44 -0700 (PDT)
Received: from [10.0.7.42] ([194.144.248.241])
 by smtp.gmail.com with ESMTPSA id 17sm14057302wmx.47.2019.07.14.03.41.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Jul 2019 03:41:42 -0700 (PDT)
To: Arnd Bergmann <arnd@arndb.de>, Laurent Vivier <laurent@vivier.eu>
References: <20190711173131.6347-1-laurent@vivier.eu>
 <CAK8P3a3-UaZ+RzYNZ25zFHs=1iZNrnaP_eAuHE0WAztztA4EGA@mail.gmail.com>
 <74807892-5d59-0a9a-8385-48cce361d842@vivier.eu>
 <CAK8P3a3XR=C27eYWQ+AxjZ1EEDNBz0HBB_NHh0hbrSDF5ASyqQ@mail.gmail.com>
 <e1c736b2-6f68-208e-9993-57ae143195ad@vivier.eu>
 <CAK8P3a3fZgcSR7V=NAjDa37-5j8L+n-cF1CVPiWjteV6hfHSLg@mail.gmail.com>
 <db82d6a2-8ca7-5bbb-0cf9-feecc8b2adfb@vivier.eu>
 <CAK8P3a3GwDr1wPU3hfnmN-N4kvBvSqxa2aRVLQABO70fv21YhQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ac90d2b2-83e8-6ad3-5dca-81e179edec00@linaro.org>
Date: Sun, 14 Jul 2019 12:41:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3GwDr1wPU3hfnmN-N4kvBvSqxa2aRVLQABO70fv21YhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v4] linux-user: fix to handle variably
 sized SIOCGSTAMP with new kernels
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/19 3:55 PM, Arnd Bergmann wrote:
> glibc will have to create a definition that matches the kernel, which uses
> 
> struct __kernel_timespec {
>     __s64 tv_sec;
>     __s64 tv_nsec;
> };
> 
> As posix requires tv_nsec to be 'long', you need padding between
> tv_sec and tv_nsec to have a libc definition matching the kernel's
> binary layout.

Yes, but that's glibc's lookout.  All qemu cares about emulating is the kernel
interface.  So I think Laurent is right here, in that two reads handle the
above structure just fine.


r~

