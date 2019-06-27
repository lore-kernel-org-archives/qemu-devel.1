Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE737C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0102083B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xj2E+4v8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0102083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSZl-0005XR-Mn
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60607)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgSXb-0003wJ-BV
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgSXa-0000x3-5K
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:26:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgSXZ-0000wD-On
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:26:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id r16so253665wrl.11
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4RkMmGKQKjowWesS7S0Mr0HIQPeKOUmICFDQ7aVky7A=;
 b=xj2E+4v8t21FnhalvEERtadOJQgsl8MKmfnu1cF9OgE+E6I1BLvHr/W65X3JZGtt3R
 K+9B+4EDu3HYCbviusn3FvNF8L50T7YZDnpxzDzxGCnxF08/Pd9Yov5qBezTxprish6G
 Km+A+tVFz5a80Gipl7vqMTV1to2QdyD4V4aSWFkadsJCXOE7UmAytJfL2QJrE5KpDpvy
 IWzQ1/NtzwWK0xqqv2vaphcm7EPvQXkfndyZWbgd2fys1VvLORFeBbvsxlx9LX3hVavM
 6qmOBJ+Xaxi3bdnmO/pSI5kOfpI3E0228jcs/oZrROe8VKV1TNJZ9K0amukuiKgJkNEq
 siGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4RkMmGKQKjowWesS7S0Mr0HIQPeKOUmICFDQ7aVky7A=;
 b=VUqLz6vMsQi2ZyfdXhOLp2JSC23N6PFfpHZocH0HnqYXFyasBL/zSBx9lIY9SJYBFv
 nDtxxKQR+pS+xkvuzT1/Jmm/wcjAUTjLQyNwNezHLojJLe9bGH2EaleYYE3S+bkZBowS
 +5U8CpXJ/1VImdr0rBBe2bwoDqxCSLWObEfcU6MaNdOfJXobNf0vzi4Oywn/eOGHQT2V
 iOIyPWyeOjTg+UM+QIfwV7JnkOpQo+OkAPf4HYuL+ySwxh3+JeGZSAVQ8OsIuKqusRtX
 Igs9Cega9NmUoWJvVb6fQdOSkTYJuqXqwp0t+tYicQ6M8BW9q2/FR9uOk+TSgbgsxcC/
 5ZkQ==
X-Gm-Message-State: APjAAAXhRaFrLLXqY4L+DCosnG7aq2HRA8i9Yb7wLkVqO4ns9x7aQ14Q
 Fj5DDsJNOYutNLBCwGAsxYS5kA==
X-Google-Smtp-Source: APXvYqwIYLbZetqyxTG6VJd75yzRjv3mfCdVMMqeLKUKiXueUKyUshNHaA2dA0sYywJt5U2PbDvbPw==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr2897586wrq.143.1561634768442; 
 Thu, 27 Jun 2019 04:26:08 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id z126sm7569242wmb.32.2019.06.27.04.26.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 04:26:07 -0700 (PDT)
To: Dave Martin <Dave.Martin@arm.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-11-drjones@redhat.com>
 <1e0bc93f-42e3-087f-a4b5-d356879cb806@linaro.org>
 <20190627105911.GD2790@e103592.cambridge.arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3e935f36-1065-b82e-86e0-f3e4cd11f95e@linaro.org>
Date: Thu, 27 Jun 2019 13:26:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627105911.GD2790@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v2 10/14] target/arm/kvm64: Add
 kvm_arch_get/put_sve
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Andrew Jones <drjones@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/27/19 12:59 PM, Dave Martin wrote:
>> It's a shame that these slices exist at all.  It seems like the kernel could
>> use the negotiated max sve size to grab the data all at once.
> 
> The aim here was to be forwards compatible while fitting within the
> existing ABI.
> 
> The ABI doesn't allow variable-sized registers, and if the vq can
> someday grow above 16 then the individual registers could become pretty
> big.

The ABI doesn't appear to have fixed sized data blocks.  Since that's the case,
it didn't seem to me that variable sized blocks was so different, given that
the actual size is constrained by the hardware on which we're running.

And if VQ does grow large, then do we really want oodles of syscalls in order
to transfer the data for each register?  With the 9 bits reserved for this
field, we could require a maximum of 1024 syscalls to transfer the whole
register set.

> It's for QEMU to choose, but does it actually matter what byteorder you
> store a Z-reg or P-reg in?  Maybe the byteswap isn't really needed.

I think the only sensible order for the kernel is that in which LDR/STR itself
saves the data.  Which is a byte stream.

Within QEMU, it has so far made sense to keep the data in 64-bit hunks in
host-endian order.  That's how the AdvSIMD code was written originally, and it
turned out to be easy enough to continue that for SVE.

Which does mean that if we want to pass data to the kernel as the
aforementioned byte stream that a big-endian host does need to bswap the data
in 64-bit hunks.

> I don't know how this works when migrating from a little-endian to a
> big-endian host or vice-versa (or if that is even supported...)

The data is stored canonically within the vmsave, so such migrations are
supposed to work.


r~

