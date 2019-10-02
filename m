Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F66C4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 23:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5573221A4C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 23:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJG41Uls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5573221A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFnkd-0001gO-Gg
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 19:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFnjX-00013b-Tr
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 19:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFnjW-0000u3-Oh
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 19:08:35 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFnjW-0000p0-IQ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 19:08:34 -0400
Received: by mail-pg1-x543.google.com with SMTP id c17so535373pgg.4
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 16:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DaO6bq36RSNja0H9UehPx0sTvcNKofrMBZiI0r699aU=;
 b=XJG41UlsPkpGWlwmyvPOXWcYxasDgLtpxQuQjEwRzayWLLCCs+htdrAeF6i0UU7CM7
 1QFdkEa7insbu17ABqbf+yr87p/Wf9zAWjVM0gkcCR529giASbIxc3KCfNqKN+ycroJ7
 nFRwVgL92uqbMcrmU+INA+YGSsQKBkwztlNaj8Gp5Lxa2B/iK0xo9dweDuh6H7OtDpLu
 PEMLkQlrg6ixtebd4sMjuskQVXNEuCGDNQIYqd7SZLvWUPDyCm3dV+Ylrp4WlP7bmRcE
 r4XSUM0JzuvPWMYFm5/HXfd789/1pV5lpk7dSpqnEeaXaQbPKnhKcswxBaPZGysAQzVQ
 7g/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DaO6bq36RSNja0H9UehPx0sTvcNKofrMBZiI0r699aU=;
 b=WhCPtxG2MhM63r6HaOFrcCUm31ZzdTM/sRfC4ZC6RyKV1rQgYKMPnFru/mUskpnLlF
 Cftm6AlzqdB00+eUiUbVxn4GsLuxyjufVnUYDz4arLjI7/fiXMuAf9KWl3CKTq9x+fSM
 RrAodDsg8k1j3U9U9/fliI6MiwNvRZcZn5KIu4tg75kJKbzgaWKht8ReKaEaTlNWtzzz
 WGSQN1Py0AOXNPdlOpsvNfkmET/ErxZIVcdNigTIk2b5sHnyTMfW1eyl1aHoq6KaJ771
 +DL1BYhzzeG+iQyLwiF/8q2HZarS0F+TAsoQ/wPc6ZyTIZ+kBfvYhPI0sqEIWd+COov9
 bMPg==
X-Gm-Message-State: APjAAAWowJ0J7DuebaVLGRFRAEEhKPliDZBj+tjXyrjY+1xIStlsDjLi
 ZqBAKVqtrLAU+VJn9Ff0JcQ7Xw==
X-Google-Smtp-Source: APXvYqwRurITgKIo+itQiVtkEYl8lwaBwfHF9UDrn9LsazOBHoyp2yHvdWaMSZPCsNTMsOCRYgzdAg==
X-Received: by 2002:aa7:8f03:: with SMTP id x3mr7447832pfr.91.1570057712526;
 Wed, 02 Oct 2019 16:08:32 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id o60sm307115pje.21.2019.10.02.16.08.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 16:08:31 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] riscv/boot: Fix possible memory leak
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <4cba4d80e570372183b6685a26c72fa3e907bb51.1570051975.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fe84f682-f38b-4587-09fc-10f95d813a43@linaro.org>
Date: Wed, 2 Oct 2019 16:08:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4cba4d80e570372183b6685a26c72fa3e907bb51.1570051975.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: peter.maydell@linaro.org, alistair23@gmail.com, palmer@sifive.com,
 bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/19 2:34 PM, Alistair Francis wrote:
> Coverity (CID 1405786) thinks that there is a possible memory leak as
> we don't guarentee that the memory allocatd from riscv_find_firmware()
> is freed. This is a false positive, but let's tidy up the code to fix
> the warning.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/boot.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

