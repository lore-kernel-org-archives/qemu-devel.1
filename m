Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A66C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:03:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB643214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qfvYnG0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB643214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAJgv-0005l1-Me
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 16:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJer-0004Pq-Ei
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJeq-0002uj-EL
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:01:05 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33697)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAJeq-0002uV-6r
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:01:04 -0400
Received: by mail-pg1-x544.google.com with SMTP id n190so2583194pgn.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 13:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eDKd7lKqLFZO1obItt54nFa6BPvqILU8pxJEBd7wmFc=;
 b=qfvYnG0k1K5WnHGgrUYyQFXRA9NlEOz6cqUkuQV6TJ8jaeIuWcnC3r/CNdtPZsWWQN
 NIl+n4N7G/mKGn/RcXWZ6vXnre2g7YJz5Z1jkJjnyHPZrxpxdBGK0hqD+22vdZfMP2rg
 Q5aQE99ym5VJTREnCtO+ZvPraMxlquB+VA4pYXQqrgWIglDq90OCa16r4BOD2DJm23Gf
 Ii250Iyq6p52FA0RuYlGuXgHBYKCw+jGOt65k0YJqyTiqQO5i2fVLC/Vv+lLS9tzYY3+
 HmDvy14kq5zISeiosz/oIvtpQeKQx9JWhAYmusePSongAEDrppfCrpjvfxOhcAkMPVRd
 j56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eDKd7lKqLFZO1obItt54nFa6BPvqILU8pxJEBd7wmFc=;
 b=uaG88oz/wDyWYcaF+FawmbCkaUyUChsDL8Iamzl6f+vxqaAT5wDgUpfJ1nPe+7ekiD
 5/+sJ2zw+LqrAm4jB2jZBDoVY0p1M1pWaYH8EpBW4xfFl18mfCTjL6rub33dxida2Uzz
 U/pASI0NOo2WUMNo5pV5dYUcaDfLfTLSGUHkEQ0b2J0Lu+zTuiZkDGg+seRwptnqISOF
 7RJJQ/DAMS2kuaJe+96O3Nj+9w+mHGNmsEDdwi02BsxMn377WI3BKPAhz8I4VL1e6wU1
 Fh8/K3mUAnHAX4MdM2UG94Mb4SzBff2v2Br81LFYpXM3RnchGKeZU4C56lvKqJPa4orV
 hBfA==
X-Gm-Message-State: APjAAAVVlJb6wcRYx3WvlS7+RuhPp6tKzENih3omoU7ciTR4PKplhd0d
 CeuFJK9XFi4VHvkDqyjDt1lYBw==
X-Google-Smtp-Source: APXvYqxxdbH3aIViQYFhRCr7Q3wg2GuI90QeJacQ9y+hbbp3Ne4ERUsn11wER4HecFN+kIPE7CEBUw==
X-Received: by 2002:a65:420d:: with SMTP id c13mr530874pgq.293.1568750463127; 
 Tue, 17 Sep 2019 13:01:03 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b20sm5930871pff.158.2019.09.17.13.01.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 13:01:02 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190916135806.1269-1-david@redhat.com>
 <20190916135806.1269-10-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6cfc156b-7a5a-0a18-a844-ad29ec7c8aba@linaro.org>
Date: Tue, 17 Sep 2019 13:01:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916135806.1269-10-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v3 09/29] s390x/tcg: MVCLU/MVCLE: Process
 max 4k bytes at a time
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Dan_Hor=c3=a1k?= <dan@danny.cz>, Cornelia Huck <cohuck@redhat.com>,
 Stefano Brivio <sbrivio@redhat.com>, qemu-s390x@nongnu.org,
 Cole Robinson <crobinso@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 9:57 AM, David Hildenbrand wrote:
> Let's stay within single pages.
> 
> ... and indicate cc=3 in case there is work remaining. Keep unicode
> padding simple.
> 
> While reworking, properly wrap the addresses.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 54 ++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

