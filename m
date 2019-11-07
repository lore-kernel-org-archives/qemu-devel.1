Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A33C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0AA4207FA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMih23MW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AA4207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSiiL-0001I4-27
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iSifw-0006gT-UN
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iSifv-0002eW-RI
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:22:16 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iSifv-0002cV-2c
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:22:15 -0500
Received: by mail-wm1-x344.google.com with SMTP id c17so2692346wmk.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 06:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FB83B/msSpEQMUMSHDK1Di6BMwtdoUpPgdtCKrsCAKw=;
 b=WMih23MWgyNNxphkvqgBUocepVyZmlAJkdU263FZkxcnnzbLWO3fRIOuMdQU3npy8k
 GLZkEZxe/ROrKSVmcX34sbjJZVwimHNxmXEm3wxI1MfFdjtDt52timawUbxuv9UFcSnb
 Fks7uIdje+VGbP7eQ6zdLosZwDJ0XcSus/eTMUUQAhYvhw8eVTEivMvAzRB1IsEyjbnP
 2m9YaFoAFI1FVlW2rexxE0pyRNwOUZ2ObDCaAtlzRTeXoEFn2ckSmlVUh1W5n4HaSrYY
 qPJkjWKi+shE+Vicp6668I8zMOx6UViHliQcZVCCPdNRXfDSng1kaavHs72yQAuIFqlR
 vU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FB83B/msSpEQMUMSHDK1Di6BMwtdoUpPgdtCKrsCAKw=;
 b=pYFt2ENqwRFu+D31cIrKF8gMS+2lncc/ypXXm6Y7sLF7/9fq4SINGwAqVFVvFsLka6
 /VXnIcWFuSZI0+uVzibslCJ7nruzci2n+invdEXkT0tPoDN4Ul1SbHzPP6MX6bxRXTHD
 SPXa7R1Zc+uJoSUmVejl5d4fGS5MkZBzkmXedozC/X61i7teF3ck729EvjDVeAIEWzfI
 l8Wzj4Qfa+GURq2zqfbtyrBk6/A7b5Wmw1SEG3ZapwEsjID1nAPByvxnD9EJJI0LsW8Q
 zl5B+kmWLIJzdRRAqxcvpVyKuV2r24lNDALfLV0UCzSoC+VQtLG5MdvjGtLIiQjoGpfi
 10zA==
X-Gm-Message-State: APjAAAVZFpP4JnbCl1slykK2w1fOXo8mQhvo9jckTeheW1LfdW+3x/34
 +ZNKXG4sQYFp8tKYP8wcdIn+9A==
X-Google-Smtp-Source: APXvYqy1cGnoxd3NiXo/qNcD7Shm4heE1gV5V85kIVtbcOHj1k2KOC58eiDAheUcXN5BfCK1SXlubw==
X-Received: by 2002:a7b:c10c:: with SMTP id w12mr3339057wmi.114.1573136533652; 
 Thu, 07 Nov 2019 06:22:13 -0800 (PST)
Received: from [192.168.8.102] (141.red-79-149-50.dynamicip.rima-tde.net.
 [79.149.50.141])
 by smtp.gmail.com with ESMTPSA id q15sm2419616wrr.82.2019.11.07.06.22.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Nov 2019 06:22:12 -0800 (PST)
Subject: Re: [PATCH v1 3/3] target/microblaze: Plug temp leak around
 eval_cond_jmp()
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20191106141424.27244-1-edgar.iglesias@gmail.com>
 <20191106141424.27244-4-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <be1be051-2486-2670-42b7-12ef79a99f8e@linaro.org>
Date: Thu, 7 Nov 2019 15:22:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106141424.27244-4-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me, frederic.konrad@adacore.com,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/19 3:14 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Plug temp leak around eval_cond_jmp().
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

