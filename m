Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00517C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 21:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B89A82086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 21:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YhVVt6NH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89A82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hukVF-0004Px-3U
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 17:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39474)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hukUl-0003sJ-UU
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 17:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hukUk-0004lO-Ib
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 17:26:19 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hukUk-0004kv-CB
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 17:26:18 -0400
Received: by mail-pf1-x443.google.com with SMTP id p184so40272656pfp.7
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 14:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BydVPCjD1vjZ2yCfy4ARVcwydaEZbDk/OpmIhvLBID4=;
 b=YhVVt6NH4qI9WqnI90LpkV433+15Q2Eenv0hFUMEY9Smm+8ldvJo3gLTtfc9GuiwZy
 WOhBS5sGi21CWHdd91GsHmZsuhVPTmUTmq9ZKCdnxjUZw+qvGYWY6emtyytXRC+s6Dd1
 pGiNA4RpUg074/kMoHCAEAr3zETZPzTG+x2pBsOotAkzZxY7E8cgBD/cD99igpvTnf9d
 BQbkmT1xFvCpjiMB79wQ4IgukBX81G/7KgiygWte5ycFNRYxd2G0EqJ5RrBEEV22R42B
 bLTwT3CKmHriwKskaWpc105ymxZcCpJlpfz7Hb9DeYTnMYuvrl5AhMK0dx5YmPK3PZz/
 WgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BydVPCjD1vjZ2yCfy4ARVcwydaEZbDk/OpmIhvLBID4=;
 b=PywZcItKA6zGmRlrvn0YHDs5qhopYSV8uxppIGF+YOiC5j24Q/78q3t1JPRBE8MmqR
 X2Hsi5tkrU+a/YpihNydZMFmaAmU73juaMFSzsWrd92fzSX0DsN2y7Pa+dQ1DBy+3XDM
 PBUuBiA4ubPkedm63Z6gKrZ7fi2R/np/Y2b9gman4YjgHGpBku6qSQJtq063z11iRaWW
 +jOLySXT5tgVEjkiNEOxU5YOEzGQBOYzaRaDcqWAsQYt62nHErv/0YLLp6jKCiIDwP+N
 RjXIWibYEX6/z8Puzjfk2nfbl/GTN2SBMRcHvwgbiHECbn8BO4lEhRNHO3HLDh5cY8Xs
 4MZg==
X-Gm-Message-State: APjAAAXhPqmPpG5LWUiz+n0vQNHEJ3QYY/V6VOVZwqn1GMWnD3J18Tk0
 0UuirPqEZ27UkO2WuYjVWn7Xkw==
X-Google-Smtp-Source: APXvYqzW+XjEhSCDkGlKqV0c2eoAw4OJ43mLpwmq9+Q+4zEIfR1jZ9PcbzuOypZs/4zxDsPrjb0Slg==
X-Received: by 2002:a63:ea50:: with SMTP id
 l16mr140696808pgk.160.1565040376641; 
 Mon, 05 Aug 2019 14:26:16 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q19sm90045666pfc.62.2019.08.05.14.26.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Aug 2019 14:26:15 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <CAFEAcA_JDfN+Njo8J0EhbtECWEW5_LcCVehbxmpY6AX3BLbOsA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d2b6ae73-6f48-1808-fb95-631bc12834f0@linaro.org>
Date: Mon, 5 Aug 2019 14:26:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_JDfN+Njo8J0EhbtECWEW5_LcCVehbxmpY6AX3BLbOsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 00/67] target/arm: Convert aa32 base isa to
 decodetree
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/19 8:44 AM, Peter Maydell wrote:
> On Fri, 26 Jul 2019 at 18:50, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This unifies the implementation of the actual instructions
>> for a32, t32, and t16.  In order to make this happen, we
>> need several preliminary cleanups.  Most importantly to how
>> we handle the architectural representation of PC.
> 
> I'd be happy to take the preliminary-cleanups part (subject
> to the various review comments) without waiting for the
> rest of the series to get respun.

I had an outstanding question re patch 4:
Message-ID: <c7a3ef78-d541-aa0a-21a5-8b4f48db1fd7@linaro.org>
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg06520.html

and another re patch 6:
Message-ID: <09b930e2-0a92-25a3-4e26-8bea1f437039@linaro.org>
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg06508.html


r~

