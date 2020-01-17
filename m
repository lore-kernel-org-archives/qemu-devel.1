Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB01BC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC124206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SB23o4Sh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC124206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isWTE-00011U-Kf
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 13:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isWSA-0008ML-I4
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isWS9-00055N-LG
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:34:42 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38324)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isWS9-00054W-FE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:34:41 -0500
Received: by mail-pl1-x642.google.com with SMTP id f20so10188301plj.5
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 10:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Fi/4zECyDLdhCHNUlZoEtfCfmIPyNs6Jny7yykCDd/E=;
 b=SB23o4ShMKM7Q2/1GuZTgfm1CumZu79htxUGovO6tyPxiWfvQveUPOugpzHwCynLab
 hGqmPR15AVTzjWpeJTcnwLAgQkVz7uSPd8Nn7yugpQ6ggch1XpCH6E60zTVP9Jfpwfhw
 FtyJSi755NbPpBfXLngFWNjLCAXQVweJSf28GDFLNNuzJlLd0DHEuB3oy4FbC4YGa9Ht
 bcbk4yGUxRPSNacdvV8VGosl48wfkFQC9+WY02wQsl1zNRVvRlChhqlVsuXVkx4zQq9z
 mLjkRAZXciBgZ25fkb7DcHqTM4TT2j9P7E1Z5AXGjceS21ujMPAWFMI9qxrhRrkLYtuj
 THAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fi/4zECyDLdhCHNUlZoEtfCfmIPyNs6Jny7yykCDd/E=;
 b=SoIv5yIyRrRcvavRjaSVu2issq8pmHF+EbUdwqsgDdr1/tIycaO+1ArHzFcNmTaOeh
 snzhGKGNHV/UxrWKDSYB/ZE96oStu0WVqmPMnRxArju1DqtnNSCma5JixA893TtzRNKW
 zxdqz6bP2CO8BCnvLV/D2g3O2RVwDqAAgZPD9En8PTgj5IpMjvGRe3fdI1Q/yzKfs8Vf
 igkZyZAoyiIiSMxOWxtYJWckH/YdIF0Zsv+OzBNCGid2axRagOtH221EJt8ifKzwMMUo
 acbmlj7/IX0FvcPZ8lkFV17Jaz2IA7G+ci1MHT6h9iOk+LwgQg6X19wtekfpRRfwZ217
 6xVQ==
X-Gm-Message-State: APjAAAV3oQAnfU/sJm89DZ1bZYcBybjiU7vhc2L4E4FAnEaIgWuvdskn
 RoUCu8y3sZ70B+BUTvSudBHjVg==
X-Google-Smtp-Source: APXvYqxmbRZv9d/RQQugm9Exc4nfDSkoURvKx3hsfx8HAcOSG2cIDN9VuxQYDkalY3IqhZINXNpKlQ==
X-Received: by 2002:a17:902:fe8d:: with SMTP id
 x13mr465322plm.232.1579286080317; 
 Fri, 17 Jan 2020 10:34:40 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id s25sm565512pfh.110.2020.01.17.10.34.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 10:34:39 -0800 (PST)
Subject: Re: [PATCH] target/hppa: Allow, but diagnose, LDCW aligned only mod 4
To: Helge Deller <deller@gmx.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, qemu-devel@nongnu.org
References: <20200117015322.12953-1-richard.henderson@linaro.org>
 <7b14c840-0d3f-0c67-06be-81b058c727fb@gmx.de>
 <08c4bdcb-b07d-eb30-a38d-f27ed6400952@redhat.com>
 <2c0285e8-5919-e768-c191-f22b9c296208@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0b66c5dc-3a8f-1102-0be9-3b31849f3160@linaro.org>
Date: Fri, 17 Jan 2020 08:34:34 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2c0285e8-5919-e768-c191-f22b9c296208@gmx.de>
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
Cc: dave.anglin@bell.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 7:01 AM, Helge Deller wrote:
> Maybe adding something like (if TARGET_32BIT...) now would make sense, so we don't get it
> wrong when 64bit gets added?

I'll add a "TODO: HPPA64" comment.


r~

