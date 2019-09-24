Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBDCC432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A916D2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+zEpaXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A916D2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtsz-0000dg-QS
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 19:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCtQP-0002jM-0h
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCtQN-0001rk-Q3
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:36:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33839)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCtQN-0001nW-K3
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:36:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so2189006pfa.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 15:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=q3E+tLqCWUDQTPWISOun8wsnLQJ/9VZo9+vIlBqeaLo=;
 b=h+zEpaXgMrVdmO70TOX7b/KK3/AZxhjwFMdL2kECVDFAboUcVZUaaxEXASckODyivN
 PvQnTi2lvKlhG/CjeKc3jAfsNyq9adJlpA4Yb6ktCDjKDvOKuQztIhLqC2OTnZ+30Y6A
 SUiqFl2FCXW2fQ6mUlwjEhnI3kJN8VnUSQtk8b28L5/31uu/Jy6XSc8+d860EAhzT7Lc
 a7g6mtH3BleGV6oLMsqR0GIuiSJePvDrr0BwGNQPLnKF+YWwsBxJbgAvqY5nOpBCoUr5
 XCNSHRHpzoH4sB99nJRnu8JKVPfAcqVoRyN49DnRRQ9GbaaXWgIAbpdCwraYpoXQeUJE
 XMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q3E+tLqCWUDQTPWISOun8wsnLQJ/9VZo9+vIlBqeaLo=;
 b=eaHKpXHzeQCbPiuSXMhujIBJrkvA7bSMKAkUQkDsOYkZmiWrukNDeB4RrkWjFZUJGS
 +iUQ0eg2seyidsF362Z5n7yTdyPCH4kegl/fGYLH9qPv8KdoHuqATQN3QpZ7ym/1hoII
 xi7q9+y4E822cZwNgIuHLv4/h9AtzUVOqjvQCv7J5OTD74hcx5NcQV5C+5dI3DjuDnsC
 7dfT3qbNQqxL/1r3SCq6R+O71XFD04OVTRMPLjEpw2fPDvOgxFTrupLjy8YXqGAaYzZS
 5CKuvAGs71HRGAZofCLQQJTRlcr8hboN1PE2R6DhQf93L1k/6bCwR191SRvCwfiXMfC0
 jdSw==
X-Gm-Message-State: APjAAAXnRPqtyn1ULuO7Z8SjnnUGO3+7slNDUf+LGqrmIH5JWPI7+oEZ
 r5+BRI3FGqw3jeiB46t0dKUrEeJsSu8=
X-Google-Smtp-Source: APXvYqwCIwCEZH1v56iNfBMplyGbmW258sTFaNrj4KSiuHRMRKFmtSHe/tgAFjW9N9fvVByeMaHihQ==
X-Received: by 2002:a17:90a:fd86:: with SMTP id
 cx6mr2368480pjb.61.1569360797611; 
 Tue, 24 Sep 2019 14:33:17 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id z13sm6310653pfq.121.2019.09.24.14.33.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Sep 2019 14:33:16 -0700 (PDT)
Subject: Re: [PATCH 3/7] target/ppc: update {get, set}_dfp{64, 128}() helper
 functions to read/write DFP numbers correctly
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pc@us.ibm.com, david@gibson.dropbear.id.au
References: <20190924153556.27575-1-mark.cave-ayland@ilande.co.uk>
 <20190924153556.27575-4-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ea275839-b588-57db-2755-90fc9f01f2c2@linaro.org>
Date: Tue, 24 Sep 2019 14:33:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924153556.27575-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.195
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 8:35 AM, Mark Cave-Ayland wrote:
> Since commit ef96e3ae96 "target/ppc: move FP and VMX registers into aligned vsr
> register array" FP registers are no longer stored consecutively in memory and so
> the current method of combining FP register pairs into DFP numbers is incorrect.
> 
> Firstly update the definition of the dh_*_fprp defines in helper.h to reflect
> that FP registers are now stored as part of an array of ppc_vsr_t elements
> rather than plain uint64_t elements, and then introduce a new ppc_fprp_t type
> which conceptually represents a DFP even-odd register pair to be consumed by the
> DFP helper functions.
> 
> Finally update the new DFP {get,set}_dfp{64,128}() helper functions to convert
> between DFP numbers and DFP even-odd register pairs correctly, making use of the
> existing VsrD() macro to access the correct elements regardless of host endian.
> 
> Fixes: ef96e3ae96 "target/ppc: move FP and VMX registers into aligned vsr register array"
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/cpu.h        |  1 +
>  target/ppc/dfp_helper.c | 80 +++++++++++++++++++++--------------------
>  target/ppc/helper.h     |  2 +-
>  3 files changed, 44 insertions(+), 39 deletions(-)

Yay!  I really was getting ahead of things.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

