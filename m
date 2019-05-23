Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2DCC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 19:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F391D2133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 19:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTVj5E/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F391D2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42225 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTtKs-0006Yq-8H
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 15:25:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTtK3-0006E6-HV
	for qemu-devel@nongnu.org; Thu, 23 May 2019 15:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTtK2-0008Gb-Eq
	for qemu-devel@nongnu.org; Thu, 23 May 2019 15:24:15 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:37655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTtK2-0008GL-7X
	for qemu-devel@nongnu.org; Thu, 23 May 2019 15:24:14 -0400
Received: by mail-vs1-xe44.google.com with SMTP id o5so795296vsq.4
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 12:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=cSc2IVkhJ1Tp7T70jNS9QNhaOWpRHHbn9SnN5c+Iw1E=;
	b=kTVj5E/SAy7A83tbqlgMmSyQra2dDUdtU50myDo5RWhg7se5r48NEi11DLiKRV6uwh
	iowv6tzYhBTZF4ly2pPUgm378+PZ1fZSaguKKOfCq2cohy1ZahNCdA6Fk1iH4aY4SxAG
	jZ1v7XTCOWO89O8b2419uFQ68TKTg2sOPePzGXjHPnTO9OscZQ/4a1k8reczZGcm5mIv
	UVn5Bjri3cOeAxzkM22BHqMrIatpuuapnu76ePw4I7tSVYhY2rfZ/1nH4Xt7R5CPwGI2
	ZZA7nuMGv4Yb2gzRRQWwMsptNN6tAf53keyGglJiRK98nxjg+NlwkNdi4ZxgHCHpzB6y
	Ev3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=cSc2IVkhJ1Tp7T70jNS9QNhaOWpRHHbn9SnN5c+Iw1E=;
	b=NeVgYAqxu459CO5RPOcQsY4sXTyegr4j83IzFQe1jSWwk6eL+51CpKNEF2u0V/glD2
	1UGKhc/MDso+YlmmZfBQ+AbY+CuLaC8QfWkojWYqDQ8Z+zTZJbf/ioo8fTysr8CzUy88
	wBCQoQfOi1w2ZA/PG0QMimVbcq6cD+amvR2D8748rX3oZQQbSLtArWLJ/3V2Q8JvduxR
	e7+zPJFKbU1peCqbiu07C9+KN/RlF30fNJNvqUGRnNqdi2V4KRFLG77nXB2+MthhooQI
	8LSUl8QSDQNLe92Ff82bFN3X+14ZtBGzcPS3l7c1luzin+MwKyCITM2jZQbSEtbLVcz4
	0Etw==
X-Gm-Message-State: APjAAAUAdZ6n06yf8FhBJ3UbTOKHt4HeG+SyS3h6DkZn91Jh5c9VZTPg
	xj7odGReUu7CjHmmM7idVXs+tw==
X-Google-Smtp-Source: APXvYqxComrDdmT57CzUFI214xIKZcm+mVqVGgfmzouruYgvwcNivOwJR2T5rUTNmBt9s/LZI/unTw==
X-Received: by 2002:a67:ad0f:: with SMTP id t15mr29989123vsl.179.1558639453231;
	Thu, 23 May 2019 12:24:13 -0700 (PDT)
Received: from [192.168.43.94] (ip-173-130-172-85.orldfl.spcsdns.net.
	[173.130.172.85])
	by smtp.gmail.com with ESMTPSA id p20sm23297uaa.4.2019.05.23.12.24.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 12:24:12 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190523024229.1158-1-richard.henderson@linaro.org>
	<20190523024229.1158-2-richard.henderson@linaro.org>
	<20190523110736.GD20973@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <174ecff7-d5b1-9264-2a37-ffdda292cc0b@linaro.org>
Date: Thu, 23 May 2019 15:24:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523110736.GD20973@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e44
Subject: Re: [Qemu-devel] [PATCH 1/3] capstone: Adjust include of capstone.h
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 7:07 AM, Daniel P. Berrangé wrote:
> On Wed, May 22, 2019 at 10:42:27PM -0400, Richard Henderson wrote:
>> Since v4.0, capstone.h has moved to <capstone/capstone.h>.
> NB this was a regression bug in capstone pkg-config file which has been
> fixed upstream
> 
>    https://github.com/aquynh/capstone/pull/1276
> 
> In Fedora we pulled in the fix to our v4.0 builds and I'd suggest
> other distros should do the same
> 

It seems this fix is present in the tagged 4.0 release.

This would have only been present if a distro packaged snapshots.
At least one may have done so, based on

https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg00329.html

but there's no further information to go on.

I've checked Fedora 30 and Debian Buster, which are the only two I could
immediately identify that shipped 4.0.1, as opposed to some 3.x version.  Both
have the pkg-config bug fixed.

Since I cannot test any fixup path, I'm going to drop this patch entirely.


r~

