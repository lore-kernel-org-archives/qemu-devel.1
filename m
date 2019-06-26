Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1228C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0F2020663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIB5sUkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F2020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg3Lh-0005l4-UN
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 04:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46710)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hg3KC-0005EL-NS
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hg3KB-00071Y-OU
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:30:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55174)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hg3KB-00070P-GN
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:30:39 -0400
Received: by mail-wm1-x342.google.com with SMTP id g135so1128350wme.4
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 01:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=x95I5XIyWaxdtAMUUb7Ziz5yTxqF7tt1iEC+xwVz9Ks=;
 b=LIB5sUkl3Tf6N1J0CQK8+DTuVQSBulwMNfs/nR8TfvVF9wMq1XJ5Powz39oz04WpF6
 GNxEDhMYA2v2rO2m5nKn+y+AIny+wFcFbdxtTMLYSKYokXarQvWGyk4Ws+6gS+sgUsnV
 Ogz8yweazMlNa1dLscs6UdoXsMPsvlap0S7arfkgmqH1+oD070pcZu5iycCk2p9eq1Wb
 PN60aCRuF0sUIacADnI+3JaO9j5FBO+IyvcG46RLwRQyRwrs3IXTMIY6LA3aS4Yp8RdY
 qxhib52M4cjxKBnIZLWjqrRhXJU2AwOgn8LcQeM2sNFRgecFZohH2UxPIgGEdyM1fjJY
 1q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x95I5XIyWaxdtAMUUb7Ziz5yTxqF7tt1iEC+xwVz9Ks=;
 b=HrjUlb6uATzIUZshnwewJ6m3fqGUXIPdEr2i7xTKM+mtastUQ/yrLniDQbr8dnWico
 n8QbrPjrSuEm/n8r7rPEcGoR6Q38P+MjJFW156ijNIbWT2So9TPG+H6cqcRJkp8z8qoV
 +KuLQ8gzLncBspNQKxcJtABbajiWIX/viU98x2EitrwklhjRFT+R4KQgSqUKKtjhvk67
 nczjfq0+H5Z3Au4nrAIx5uO34TC1zZzwTllUIHCAxVCaLuxqzS3xhLBGW1IgnD/DZeGz
 18g1mnJ2VxwcGKHE3tXo7mgI+w4ke537NA8Y/p8oLQl0lb4ub8gio8s9KxfzfHX++MM3
 ZjlQ==
X-Gm-Message-State: APjAAAViCEDdKBGX4hTxev45U+21n3YPUye0Ermlf3w6gbUrCQYM10MC
 4O6qxYEmXIFo5b+mjmWu4bApkg==
X-Google-Smtp-Source: APXvYqwICU+2ZOfTuVgg7zSTzL7Cm9EWj/Jsp93qOnYWTz6uReNgfp0Ej1Tw/sj0dMgbg4gRX05yiQ==
X-Received: by 2002:a7b:cb08:: with SMTP id u8mr1747204wmj.167.1561537837835; 
 Wed, 26 Jun 2019 01:30:37 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id l12sm1069154wmj.22.2019.06.26.01.30.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 01:30:37 -0700 (PDT)
To: Palmer Dabbelt <palmer@sifive.com>
References: <mhng-c3bf2d26-25cd-4f80-bfe9-741f9a969b3f@palmer-si-x1e>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <77792d70-b438-df37-6fe4-b5723f7da99d@linaro.org>
Date: Wed, 26 Jun 2019 10:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <mhng-c3bf2d26-25cd-4f80-bfe9-741f9a969b3f@palmer-si-x1e>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] atomic failures on qemu-system-riscv64
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
Cc: me@carlosedp.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 joel@sing.id.au, Alistair Francis <Alistair.Francis@wdc.com>, marco@decred.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/19 10:25 AM, Palmer Dabbelt wrote:
>> You misunderstand.  The code is exactly correct as-is.  The alignment check
>> happens implicitly as a part of the softmmu tlb resolution.
> 
> Sorry, I thought you said it wasn't happening for linux-user?  If it happens
> for both then we're good.

Oh, that.  No, there's no better way for linux-user.  Though honestly, if we're
going to fix this, it should be done in tcg/* rather than adding hacks within
target/riscv.


r~

