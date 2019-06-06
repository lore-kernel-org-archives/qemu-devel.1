Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80F9C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7E62083E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t/CYlYZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7E62083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35497 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYvy1-0001NX-Hu
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:14:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYvx8-00011v-Fa
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYvx7-00089f-Jp
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:13:26 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYvx7-00086a-EZ
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:13:25 -0400
Received: by mail-ot1-x343.google.com with SMTP id p4so2709725oti.0
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=iXNtGvdN0WFT2td7bQ3Efj77DLJfpJEGcqC6d1plKWo=;
	b=t/CYlYZavSg0T+RuCdY5o2e6ZYr1t0sAWluOk+ywUSLks7QLGAcNxo6OvinBD+dZOL
	HNty4HMc2FjMwXys3MqOSBwkYX/8eTyVxzs1vuFRCGdgxa+oNUTGtfFTOhN9IpItxsG1
	l+FFMBqFUmDuybgGpyMTpLn0jPkazEH/IQRV6BY72TWAvoliSrQkj/3BLr7Cn2xbJQGB
	nVIWsHUAj7TJiKpavlTUxjTPr8bfuvRIKAUsNm39pq0gYjkzmHv81vNOrYVr3cp2MkIc
	vX7JTiKJQOqrBsxECDip66+O3AA2Aj41AzxLnO6iYEycDbB8eKkzS8cYWpLbGz/9FSBu
	ZYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=iXNtGvdN0WFT2td7bQ3Efj77DLJfpJEGcqC6d1plKWo=;
	b=BhxYPoupRn9jiUjXAtRmvs+5BX5Sd5epWx+++Gn/9MYOAP9bK3Dz5a5JGV1oSAL9aC
	1Oxogp7j8Fi+cFp0KyTerOTrCXPXADcwAM96J1RnelSLRkvS9PsTmfo6IUPmGOVF11U2
	Xgc9Y6czW9F6uY/62h9mn5l1dB036oUgwmbfuQn8UyE2RpRnZMhwy7IITHnfGEaj+YU6
	V7rh6pPqfhod90M/uDOOm6SwlHhsC3tCsXIFiiWNFMFTSSZzsVS/LRDpLJWUGnRhHPpF
	Wpirpyi0Sf+g6WODwtzLQ5eG7DZ83peO6Y29EZeocN7Fh7LB0UBnXlZCtwYQtR2akZel
	VWqA==
X-Gm-Message-State: APjAAAWqTdwu13mWHA3C5kCiE3vjup2pNhuCdhT1SMGKa7CsnyqAISCp
	/wp8I20Q5TaYY19Hz/BAC25GTQ==
X-Google-Smtp-Source: APXvYqx6TSJvnJCKrAjryw7JlqH0tjo9bDhaMQ9vcskwP7crh2UCkpRwDzphRnHbN5Wt4psvKYZgoA==
X-Received: by 2002:a05:6830:1042:: with SMTP id
	b2mr7539565otp.345.1559841203947; 
	Thu, 06 Jun 2019 10:13:23 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id j189sm843194oia.2.2019.06.06.10.13.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:13:22 -0700 (PDT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <583e3095-2429-cda5-c21d-b6c3ccd3ddd8@linaro.org>
Date: Thu, 6 Jun 2019 12:13:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 0/8] Optimize emulation of ten Altivec
 instructions: lvsl, 
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 5:15 AM, Stefan Brankovic wrote:
> Stefan Brankovic (8):
>   target/ppc: Optimize emulation of lvsl and lvsr instructions
>   target/ppc: Optimize emulation of vsl and vsr instructions
>   target/ppc: Optimize emulation of vpkpx instruction
>   target/ppc: Optimize emulation of vgbbd instruction
>   target/ppc: Optimize emulation of vclzd instruction
>   target/ppc: Optimize emulation of vclzw instruction
>   target/ppc: Optimize emulation of vclzh and vclzb instructions
>   target/ppc: Refactor emulation of vmrgew and vmrgow instructions
> 
>  target/ppc/translate/vmx-impl.inc.c | 705 ++++++++++++++++++++++++++++++++----
>  1 file changed, 636 insertions(+), 69 deletions(-)

You should be removing the out-of-line helpers that are no longer used.


r~

