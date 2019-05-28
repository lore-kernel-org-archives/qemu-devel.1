Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADB1C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 12:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73C82081C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 12:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iapZWSbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73C82081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34374 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVbeX-0007P5-1b
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 08:56:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hVbdm-00077E-53
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hVbdl-0002C4-82
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:55:42 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hVbdl-0002BZ-4J
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:55:41 -0400
Received: by mail-oi1-x244.google.com with SMTP id w9so14132899oic.9
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 05:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=89/OyD3N4thNUpdzvCcEDKC/AKoJca7O48Zz22pYfqw=;
	b=iapZWSbV7qjneh3g2ha7OM+qg9YWRbjap6oFkFaRetD/D5nslvxhnsXjiqmtpOENUc
	mPYFdr6IdZOHSqBnLz3VtowpxrVzQ/vXlzp+tL24Vcf5KF3BKdo09AxmF2TKS+TZocgZ
	bSFVfL0n24+qjQlFwEYw+8egVTDETEccOrJ70xTC1pNNU/yscRFcf7KXwQYKCpxEmA+Z
	tmC/hzA5NuEohPqqL1CYoV/s43zMQpkD1JMK20raaIg3ujhY0MNxujH/rN5I3FIOhNCu
	PN/oBEmyT44ixI/VEFJLKzn/p9TGBwvJYhEJLnVCyL89AKnvcl5sRcy3Ap+kdWwqxUzw
	sa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=89/OyD3N4thNUpdzvCcEDKC/AKoJca7O48Zz22pYfqw=;
	b=gkXLhDcCOV//+Whri8xC8JMIeK2GwmRlCvdjryloj0mftwWnVbFoErzA9YeJaOgCH5
	FNCOBJdtYdkt7FOpl5mb6+D7JziO/0g1MYlhnyTgngbwLDO6Kpc1GJb6/VA/sXvm+0yu
	aPzVgSrF3/Z+pV8FU8TuL81E0nT9IvDZVN8YA/BYELr/m20DPVhYbVmfb1K/YJ0seshK
	1vC9kBehxbqW70ENp0OIzHir1NRoD1h6c4WCH1QiVoo/U5oIHoA5XvXQu8Wp7js7WlhZ
	vaFc+a6MPtTL9rmEI9rUNXhSB3+ZbltpgF3jURtyKsl2no+BMByIkLvqNAvUu7J+IY4F
	TWSw==
X-Gm-Message-State: APjAAAVLjGKaDz/HVabkU6JxJSIXA75sY2xKtP+DO/dFRuznfFVLkJ1Y
	i7j/J3RECd1SNZtDONX5JeGpvQ==
X-Google-Smtp-Source: APXvYqye3PjrcIkm6ZRau/mpfaQ7gEJ4gSkSPt4JMxTj16J2ETg97iqxK3vldp7cVUvIZKLXP2ECqQ==
X-Received: by 2002:aca:f4d0:: with SMTP id s199mr2448808oih.131.1559048139823;
	Tue, 28 May 2019 05:55:39 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	y12sm4819403otk.21.2019.05.28.05.55.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 05:55:38 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190524093335.22241-1-david@redhat.com>
	<20190524093335.22241-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ede41873-91f7-b1cb-8812-7c2f0c0ab54d@linaro.org>
Date: Tue, 28 May 2019 07:55:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524093335.22241-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v2 3/5] s390x/tcg: Implement VECTOR FIND
 ELEMENT NOT EQUAL
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/24/19 4:33 AM, David Hildenbrand wrote:
> +    /* identify the smaller element */
> +    if (first_inequal < 16) {
> +        uint8_t enr = first_inequal / (1 << es);
> +        uint32_t a = s390_vec_read_element(v2, enr, es);
> +        uint32_t b = s390_vec_read_element(v3, enr, es);
> +
> +        smaller = a < b;
> +    }
> +
> +    if (zs) {
> +        z0 = zero_search(a0, mask);
> +        z1 = zero_search(a1, mask);
> +        first_zero = match_index(z0, z1);
> +    }
> +
> +    s390_vec_write_element64(v1, 0, MIN(first_inequal, first_zero));
> +    s390_vec_write_element64(v1, 1, 0);
> +    if (first_zero == 16 && first_inequal == 16) {
> +        return 3;
> +    } else if (first_zero < first_inequal) {
> +        return 0;
> +    }
> +    return smaller ? 1 : 2;

Perhaps move the computation of smaller down here where it is used.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

