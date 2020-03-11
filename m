Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7D7C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE18C20736
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2blL/zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE18C20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC549-0001Ln-GZ
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jC53Z-0000nd-He
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jC53Y-0002AQ-6t
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:22:09 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jC53Y-00029h-1K
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:22:08 -0400
Received: by mail-pl1-x642.google.com with SMTP id t14so1396814plr.8
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/P3S/m9MSwDSJjJF6DEle31LnWPFIIeZ55U5cXyJnAM=;
 b=K2blL/zp2a0gUZ7lQelZ+jpOhSCEBp8n/bQQTJHSWh/SnMiNuEFPwZ5XXLknp9RKRG
 1kRlWoiK9V+DgBLkT028JGrOr4pr+K+3qCXX15Qgx+YOKue95Jb1gzYtRfdas8eQWNrm
 p+6sDpiRR49T7fspdBiL1tIXcrhMnbTNY+vefNL1siHcjAEkKKQ1G7+MKsudg4BjmSSN
 8syBfOrrhme5ltp5XMZb1ndxENBS3+pBNelMzGNWRnK1imsknhuY+ATIdqP1DHRpgSJS
 2UhWOub2lRlsC2WeHsQlnm0DwUidLv7RbwWyCF1pbrSQr7hTdY0gCc1y/jHBCd0JOvTW
 ihQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/P3S/m9MSwDSJjJF6DEle31LnWPFIIeZ55U5cXyJnAM=;
 b=XrcD3tylKPLKht01n8LgYmleEQRPB+sfR83ItltXzjpv5LL3ejUVPs4X3qzST2gVPc
 jYf8fWswr9fb/AIXVi+Hd4O+0rHfITdzRTWVKh9FPqmxpWFiNOsTU7ivOoqFigyJOJxL
 DQ6dbOQ5ViKzbzAAB9SSo0sqvN9TRrfamuloKXLXR+jOOT5aGf/YIqpDv4+fVvQQrLNy
 oX+18LgDxKH0waqQ9cNpIJ/063tAcz3k5wGwtgVqHic4/z3js/Qun2eb9lO0CXEV0CBX
 QDqmGMtehl9pW6N3/fBApQUD9w4IpwOpT4AnN/PsTCLcSG4zMZou64fGbH7H3mN23Ma2
 oi+w==
X-Gm-Message-State: ANhLgQ3Oc6X1VhgATv4C/wY5NOJBeVKexx9lHs9WW6+QQARCpYEP+t56
 0szHoVPrC4Va81hoA9YARskv2w==
X-Google-Smtp-Source: ADFU+vseHI5fex/sdnCS6lVUIB0h5ZAOrQ8qmtJ431pLwzPgmLWaOU1y9nWw5FATrE6g3kXkaT5oCQ==
X-Received: by 2002:a17:90b:370c:: with SMTP id
 mg12mr4160249pjb.96.1583947319894; 
 Wed, 11 Mar 2020 10:21:59 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 5sm7819263pfw.98.2020.03.11.10.21.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2020 10:21:59 -0700 (PDT)
Subject: Re: [PATCH v4 03/21] linux-user,hppa: add syscall table generation
 support
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200310103403.3284090-1-laurent@vivier.eu>
 <20200310103403.3284090-4-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ffc6073f-1c5d-6457-6694-e83ae6f4847d@linaro.org>
Date: Wed, 11 Mar 2020 10:21:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310103403.3284090-4-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Taylor Simpson <tsimpson@quicinc.com>, qemu-s390x@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/10/20 3:33 AM, Laurent Vivier wrote:
> Copy syscall.tbl and syscallhdr.sh from linux/arch/parisc/kernel/syscalls v5.5
> Update syscallhdr.sh to generate QEMU syscall_nr.h
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  configure                     |   3 +-
>  linux-user/Makefile.objs      |   1 +
>  linux-user/hppa/Makefile.objs |   5 +
>  linux-user/hppa/syscall.tbl   | 435 ++++++++++++++++++++++++++++++++++
>  linux-user/hppa/syscall_nr.h  | 358 ----------------------------
>  linux-user/hppa/syscallhdr.sh |  32 +++
>  6 files changed, 475 insertions(+), 359 deletions(-)
>  create mode 100644 linux-user/hppa/Makefile.objs
>  create mode 100644 linux-user/hppa/syscall.tbl
>  delete mode 100644 linux-user/hppa/syscall_nr.h
>  create mode 100644 linux-user/hppa/syscallhdr.sh

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

