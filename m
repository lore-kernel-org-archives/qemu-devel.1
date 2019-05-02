Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8CDC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565A02081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oKrHWHa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565A02081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52927 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDRf-0000cQ-Jp
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:16:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMDQ3-00081C-KL
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMDPy-0005Lp-Qh
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:14:43 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMDPv-0005IM-3x
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:14:36 -0400
Received: by mail-pf1-x443.google.com with SMTP id v80so1287434pfa.3
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=nmGO59YERWUu5J2WcfaWCuwKyLVj/n7bjdb7edd37e0=;
	b=oKrHWHa+8DLAJShVOORx4JlaG9KGrvuXrlgWE20PO0wPyVX/6XSPAVGDRTxX3x/QHH
	EoMHXB9R+oZ+yLy2ePgrWtdpqYPikaIbm3TZ+aN3P1sMb1DMu/DErsGf/n3UHExxHnle
	oB8LJgxoBOpS7n1/aP56VHh4sVGQyPmPBRPAHmsX4lgrxO0YV4ZqMCG7VcsUuQff5CPK
	R2ZDZenEzDpIkrzqKrY7Q9aqhJj9Bmvacj615hrSePDPWcPGjwA+5O2yx3yjxfq+L4IC
	kIvtt9FastwWlKPZhikpJpENn+UVVsFWeY35NYtlkYZicI672VtKeA6WZDUegSa/zkGL
	my/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=nmGO59YERWUu5J2WcfaWCuwKyLVj/n7bjdb7edd37e0=;
	b=idFmoPa8W1LryWDYx4617R23PZuqMIG/SoZ4OEqktOkKKplwe9iXC8WjBGQtQ8oUN3
	2QY9zS+wmbx29RuJAEwwaH6i1gipMftVaZYRFeT9IJn6mOz63qhoXMFHLacl94EedVFM
	SWIMPWxyM/8f1OmGyjslhP8XYIvDvHPWi/dZjyIeyaCbEDtWsJcAmvcc+EbcFd8lPbfJ
	vD9A4VV8M0Qk7N15nHiepii6ik+BAepsx0TK9ZVKxxZF5McASdGTeOWq57s+MobmBkSX
	wgLW3QWYd/Pg9pz9MrOUtqRnXWUlOYuGO7Fp5lGC5lv30hihdtRpxkoxcFuXgIdl7PqK
	CaoQ==
X-Gm-Message-State: APjAAAVlBlCSvUEJMetwIHCi2kUqemOsJknrgPRW0dZEAsp3UTpzn7CT
	EBvMXz6eXLUTHvsEy43bWODyeA==
X-Google-Smtp-Source: APXvYqyqSX9bKSmvjVZ9hexnw4E5Iv7j1EyFFtzxaYrW8bu4KV1gb8H5u3gzKcSOCyLr5MjANBY9uQ==
X-Received: by 2002:a63:ed10:: with SMTP id d16mr4435007pgi.75.1556810071673; 
	Thu, 02 May 2019 08:14:31 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	10sm56334461pfh.14.2019.05.02.08.14.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 02 May 2019 08:14:30 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190501223819.8584-1-richard.henderson@linaro.org>
	<20190502040459.GE13618@umbus.fritz.box>
	<5aca63b1-72e9-9402-8828-d2dd054b3313@linaro.org>
	<87h8ad5e0h.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e7318909-cae9-eef5-7f59-c9a2992fffeb@linaro.org>
Date: Thu, 2 May 2019 08:14:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87h8ad5e0h.fsf@zen.linaroharston>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 0/2] configure: Fix make check-tcg for
 ppc64le
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
Cc: qemu-ppc@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502151428.IWZutqduKAbS8vucNTmvK_HziYI0zgWd9EWywQZyTvQ@z>

On 5/2/19 3:47 AM, Alex Bennée wrote:
>> This needs a different set of cleanups.  ;-)
> 
> I guess this is another use case for softmmu support in linux-user where
> HOST_PAGE != TARGET_PAGE?

Well, yes, but I was thinking more short-term, wherein we do not test things
that we know will not work.  E.g. testing 4k pages on a 64k page host.


r~

