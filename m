Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CD7C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:34:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7FA26D3A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDYb1FCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7FA26D3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46962 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWlQO-0006jg-2E
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:34:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlPd-0006Nc-Li
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlPc-00014t-QB
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:33:53 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWlPc-000143-JN
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:33:52 -0400
Received: by mail-ot1-x343.google.com with SMTP id r10so9989672otd.4
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=YORIACOqdkUGhDKSz1ZK+IFPJUbAyFEsUKK2vUMo2Ss=;
	b=CDYb1FCD4VzZlcm7SrFqOFtClgaIzC9c2/1hNkDScr0zUcdPQW6g9resyCWF0hPMur
	MK1hs7qlb/fLhdVx4jcSIyoDlCGVjj5abgNs2X0lh8AFDGluNuqk52CxJzQEgMCsoZ9b
	hYanIhlmk+c5NL7o+ri3bQ4WWtLzxwsz9mOVrr7F+DVbdCeE7oKlwG9r3nZKvCcJV5Wp
	ie9JmJWcZokux9htrlp81jW2IF8GKczxPXvS3hsdHEH6ZXb4zWbucSKbKpPmpwqMgJer
	KvIhF1OPEs1UalV5Tm9EpVA01+cTNCQ2Ynlnnhk++rF2G1enPNlhXYpw6XAjkKrvS3rn
	1TUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=YORIACOqdkUGhDKSz1ZK+IFPJUbAyFEsUKK2vUMo2Ss=;
	b=psRaKIKQ4d5wAZRyaVrUf9XZ49MVYrm5XCaoRriVG3mFE+UMivDXkXQ5MYLowFEJq6
	GkJCvLj6NIybupt3o4cH2MBG3ZRRkfaXfBifKsUGw7Xh+JyVhyWrShltTvg5o0iaa9Nh
	eeNCnbK05DwNtqkOOqEVEdcBzLRcikzMBHbSEDo6sCIOtd/AWGksIIp5o6eTwIkTs5qA
	DGBphwDXN/BtiVcq3LfZAfC1LdpqDuL03/kr/5gz0BUw+ApP7wUZ6PHiWW1jiiWiguST
	42qhKQhIoZoQB9UckA9mo6fMnOFbEWUyTa6b/ZhmB6ifLwtnKureig/BFlcryQzXC0Ce
	4uXA==
X-Gm-Message-State: APjAAAVUS074YOwVHYBzYpU2jbQhWnOIBdrsb8tHPAFtHoOJEHDJsNLw
	04RS6t+W+RSJXF1mMfawvH5DZA==
X-Google-Smtp-Source: APXvYqz+nSg3sioFLAimIIj5AciNXVBpkgOxJ4er7wROBsgCfOLvybcwVVbU8687evZOLxD8fH3X5w==
X-Received: by 2002:a9d:529:: with SMTP id 38mr2798420otw.145.1559324031431;
	Fri, 31 May 2019 10:33:51 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id 62sm2400839oid.35.2019.05.31.10.33.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 10:33:50 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-14-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c2c09ef3-10f0-7dd7-c1fb-df6583ca5464@linaro.org>
Date: Fri, 31 May 2019 12:33:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531104432.29379-14-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v1 13/23] s390x/tcg: Implement VECTOR LOAD
 LENGTHENED
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Denys Vlasenko <dvlasenk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 5:44 AM, David Hildenbrand wrote:
> +    for (i = 0; i < 2; i++) {
> +        /* load from even element */
> +        const float32 a = make_float32(s390_vec_read_element32(v2, i * 2));

I suppose.

You could also reuse vop64_2 with

static uint64_t vfll(uint64_t a, float_status *s)
{
    /* Even float32 are stored in the high half of each doubleword.  */
    return float32_to_float64(a >> 32, s);
}


r~

