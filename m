Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692C6FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E279220640
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3jbKYdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E279220640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKlUq-0004VT-WE
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 11:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKlSe-00039E-7w
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKlSc-0006mA-UC
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:43:40 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34849)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKlSb-0006lC-GW
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:43:38 -0400
Received: by mail-pf1-x441.google.com with SMTP id 205so14989135pfw.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 08:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EA9zcpkFhFBVFdP9uD0atbtljeKL9cSU/AhS7aO0ASQ=;
 b=F3jbKYdCfCto85j60IRAK/pLt/1vYqBvIPfjI/SfnFh2LGuh9D+eJ87RPbPP0p7uBy
 0F2w30euZUNDUQBTWRvP38AcDspsHgcV4N7Gx3AKrpWrGyOj5m6Xs/P55gjtJ4Dknq8+
 1q+TNgFCwts5SBKhF1m7ARk57vAGBJC8sNxSH3jORDH4Td5js9ALmho2cqf5KisgJlmF
 DhtxyOeR8XBGP9QdJlJHAPFHKAGDVfR42QoxBIXv47MBS0K3Uj5pXwD4fj1k3KWtOefo
 DjE03li6ObAxMXMK0Ehkz4aZuqRzvZjeH7G+cceLwIzrIj8Rsx+3eMnagWgcgeFE7nx9
 K6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EA9zcpkFhFBVFdP9uD0atbtljeKL9cSU/AhS7aO0ASQ=;
 b=oRw+0ZYZ2P1jY5dK5C9sFmxGV4fF9dnm1rXV29Wdreos8mQEeHkpXXWeXb+ucAqzBV
 LxMSlXv6gnSHh8SPixyM9O9qdP4KN/mVsaVBUmvwf+LMTBzZs4DUYhIwywUhIHThO1Ew
 mLCExcFV1Wx494tSY2N6Xd1FYxYUw9K4zwQkRj5ST/HXqdMMCxPMl47dUOnWh7BfufPo
 UAioiPUlF2y6VzRr7IznC7dFm9JcI5Xq9bBMRLOYNALynSW92sayz+1DRLm9PbGctOl2
 iRFvCrH1WoT5fAfZO50rv2ZupE9IwY2U5RUxE0KaMsh1zFGHmZhsO7aPodX/qHLRLKIt
 SDIQ==
X-Gm-Message-State: APjAAAXMU1Ckcb9Fztc+wpzSzu7rwPby4wrKozYinoSETYoWjtSlHE5M
 nYesJ0UgiinfTlNkTZQysEGRH6cssA8=
X-Google-Smtp-Source: APXvYqwOv99Yy+EPIZ/B5Y6mODRaFTJOJ3NFR4UGsCNZqnZ/ELQ9xX+Ogm/Md0DFlyVFzhikcoHfDw==
X-Received: by 2002:a63:1e1f:: with SMTP id e31mr24363685pge.303.1571240615211; 
 Wed, 16 Oct 2019 08:43:35 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id c8sm30088162pfi.117.2019.10.16.08.43.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Oct 2019 08:43:34 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: sugguest to use qemu_real_host_page_size
 instead of getpagesize() or sysconf(_SC_PAGESIZE)
To: Wei Yang <richardw.yang@linux.intel.com>, pbonzini@redhat.com,
 philmd@redhat.com, thuth@redhat.com, eblake@redhat.com, berrange@redhat.com
References: <20191016012432.22731-1-richardw.yang@linux.intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d45f4f13-cff1-9a17-6ce3-255dcca5503b@linaro.org>
Date: Wed, 16 Oct 2019 08:43:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016012432.22731-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/19 6:24 PM, Wei Yang wrote:
>  		if ($line =~ /\bbzero\(/) {
>  			ERROR("use memset() instead of bzero()\n" . $herecurr);
>  		}
> +		if ($line =~ /getpagesize\(\)/) {
> +			ERROR("use qemu_real_host_page_size instead of getpagesize()\n" . $herecurr);
> +		}
> +		if ($line =~ /sysconf\(_SC_PAGESIZE\)/) {

Use \b to match beginning of symbol like bzero did?


r~

