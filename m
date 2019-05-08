Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B77C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 18:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61B4216C4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 18:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UyJK1Yan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61B4216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41275 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOQxV-0004ct-KF
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 14:06:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQvL-0002r8-Rt
	for qemu-devel@nongnu.org; Wed, 08 May 2019 14:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQvJ-0000mt-Cn
	for qemu-devel@nongnu.org; Wed, 08 May 2019 14:04:11 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:43628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOQvJ-0000lZ-3W
	for qemu-devel@nongnu.org; Wed, 08 May 2019 14:04:09 -0400
Received: by mail-pl1-x631.google.com with SMTP id n8so10290514plp.10
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=easSRJRIFw2ZrC74E2/GAeMUZZ0pyNjONK6UMe55Q44=;
	b=UyJK1YanHnGSm77ONcpvqeddnbq5xDVq/LLA1BoYlravK5xvzT5PqjX+rIny8OjabM
	nZzQkwm8b6ZW7FOjl65pZglQvLA5FGOMU0qVK0D6zdk1CB0JmU84YinWVoz7kMXhZwqP
	vHZsL0iI/Fu3qMx3dymDuNw1RHHAf9cDlVbqaV/DB5t37aAMIutQ8em308HwIrFNlRHK
	a6RM012h8hH2VxMCNZRPdlvq1avliZcJWggjF0FJ6HOVbYQstIH+/EiyBK3Xf1QyRMs6
	4xxOhVljLg66T5kyBVq7SutuRLtpdlKMr5HqbItd3jc5uekRYrsdMBVPxdpJ1xDiPH9a
	IrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=easSRJRIFw2ZrC74E2/GAeMUZZ0pyNjONK6UMe55Q44=;
	b=QaKjSkO3Do7N9TXUfzRJA6MwMChz/wH/iQPTfRii+82xfpoVsJlMk2j1D8zqtzsmMh
	aEyk0JGMGkFo7mIcAdaQmHmEAFXJtKvSin+zck7QNa0eDNn/5OiTQOVbl9FJ2AGhTSvP
	khjM5UmQGAFOsshIPKGfrfwUSpfET1KJPtIapogLNhAv3dTS1xxv4Vcd18FiF26F8IZ3
	n7y+ijjz5L3jrSF9VHf/TRCDDxshSp/7cM2nCX4+7tKqVBHsl5hiDhZTo8THAbfa42nw
	KTpegvbcZ2IU52qkMZsIADzq8aYRa21/3m6tGYYhPHWNFPQp1uhiHTW0ItOAma7JLJQG
	gMDw==
X-Gm-Message-State: APjAAAUn+NhzpKcrhTfL7qXwqxQ9vnQvogBisiOA+yjW0mCYRs3SsSSc
	6O3XXuqjNRZ27BVg8OkMJIQR5w==
X-Google-Smtp-Source: APXvYqzqIFNnlPueyDx1/NkgGUBTstOAARobNQAoVZ6tBmtNRjByruTq2BvJ43h6PZccmSnNgfymhQ==
X-Received: by 2002:a17:902:2825:: with SMTP id
	e34mr49840592plb.264.1557338646109; 
	Wed, 08 May 2019 11:04:06 -0700 (PDT)
Received: from [192.168.1.11] (97-113-27-95.tukw.qwest.net. [97.113.27.95])
	by smtp.gmail.com with ESMTPSA id
	k65sm30883316pfj.141.2019.05.08.11.04.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 11:04:05 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190508150608.3311-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d783fdeb-fe7a-fc27-3769-1ca245ffd4c7@linaro.org>
Date: Wed, 8 May 2019 11:04:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508150608.3311-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::631
Subject: Re: [Qemu-devel] [PATCH] include/exec/poison: Mark TARGET_FMT_lu as
 poisoned, too
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
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/19 8:06 AM, Thomas Huth wrote:
> We already poison TARGET_FMT_lx and TARGET_FMT_ld, but apparently
> forgot to poison TARGET_FMT_lu, too. Do it now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/exec/poison.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

