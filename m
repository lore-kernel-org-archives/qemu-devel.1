Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB87C76195
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 18:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07B320693
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 18:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsDXqixy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07B320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpdWM-00062N-Tl
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 14:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50832)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rth7680@gmail.com>) id 1hpdWD-0005co-4q
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 14:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1hpdWC-0000HL-5W
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 14:58:41 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:34777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>)
 id 1hpdW4-0000A3-Vt; Mon, 22 Jul 2019 14:58:33 -0400
Received: by mail-pg1-x533.google.com with SMTP id n9so11877479pgc.1;
 Mon, 22 Jul 2019 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=778redPwBop63aanqBNZExbsIMOCHcXFJM54Q15/E4k=;
 b=BsDXqixydvvsC5MKoaFT8ng6kAg/l3wZltQT5aHjY5FT4BpTxlORcjFXsE9DaH4TEn
 jLJPsHNbK6lJCqRwWc1fuS5GT8laMFv3CTBgAPdl7auHJ/J1PUGxzydNP+D03THsLWhY
 +DzyMmtyrLSUYfSa8l8wC/1C7fEbSajyj8iySkqQXzn1ATP9HtGK4vd2tkU9QExdA2lG
 0iZgn5i4cEWbe0NxwguxVn0H7rcLMXqjkGAoY19B++9EhWhUSffdjiY+ttEigvUviGgG
 kRjVcf7I/+CQGbrJ6djW23/pnljdhILRmC7cQITx0OLp/sYda7BakBry9DdBDUV4+jNm
 7kZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=778redPwBop63aanqBNZExbsIMOCHcXFJM54Q15/E4k=;
 b=lA7OTR0VYTeEE7W/R3iLSkB4tg6AGb/SSZ4hFyXiZZisZSPju4XYq8B1VLI/15AOqL
 x9RJhtxRDYari78bAjrhyEGk5LVkLViCx26HfSfCVx0UrP9cmMruec6ERjKzJoJSbqtQ
 yTFtLa7QEPp27Cz/jNuybUeZJRLMLQOqSDXE+Yh5Bsc2z99LxyzdCLCZPn/t/uGKAKu7
 ygXJ24nqnO4pePHss1gHhcrNTdD0gBIsw7oErmOCAGyOJmdWx/RhaNjR4KzJ47S7E/SA
 Yv3QBXsKPfXGF8hbypVAvFiAhzVJZkfYlY8B45hzd2xmCQhcKpWMaE05Nlz4/hPQ53cW
 b9Aw==
X-Gm-Message-State: APjAAAV6pHvHr6qA0lbRUE4YF9PwK6zNxMr1+IrmhZ0G9DJYzlrw/fMh
 H67QFByG9891vHYB3a3QTqY=
X-Google-Smtp-Source: APXvYqygMZtF0TDKR4T2Nj6XsQSkba5WVd5bcXe/HTb6kifQvZ8twT3QAcMGcl6LJpUZM1gv8EiD4A==
X-Received: by 2002:a63:6eca:: with SMTP id j193mr71432686pgc.74.1563821911378; 
 Mon, 22 Jul 2019 11:58:31 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.googlemail.com with ESMTPSA id u6sm35921093pjx.23.2019.07.22.11.58.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 11:58:30 -0700 (PDT)
To: tony.nguyen@bt.com, richard.henderson@linaro.org, qemu-devel@nongnu.org
References: <e9c6e5310b1a4863be45d45bf087fc3d@tpw09926dag18e.domain1.systemhost.net>
 <2b6eb033-4b6e-4d64-c57e-a3257088d0dd@linaro.org>
 <1563812889499.73128@bt.com>
From: Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
 mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
 n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
 rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
 Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
 n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
 AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFBBBMBAgArAhsDBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUJC7UHogUCWaDNVgIZAQAKCRCtEnDMTdAnm9N5CADO
 cB8F/SudJ72IupxQf40hbJdBK176+gb3sHMsixyLtrU59lee+lIM1OZmlNjsnCYmiSnbA5ks
 Q7p0HfO7DgdmfLzcK6xsHZukqSZy5LByw348Y913ZyjOrJZFdPP7kDg1MnqRqH4+3ZdzxV4y
 eYBWFU9GYMIF06JbUubossOOO4ArNVZbnIPu8Vn2tDZVVqsCBqkoCSBMj519xrvyOu5z4mHS
 LkCglXmVDOXMbqLuNAC3rfNXSnyM4hYkLUyfALJlAAy1Ro+jUqYhu7XUFV/MiwRuFMh5GbtY
 Urkx7tqsWQXLT3GeDk/LqvpWJQwk4cHHckYjRih+70CHIenm81PVuQENBFGuLC8BCACyEx3x
 94HIkTX0CHu2sA0w75+h9wuoA8ggJ7+S4ri0y2YsijWad5TTt6z6MMiqxk9kSA5bppaj4HXh
 86hBF/dWCtMpNr3Rb8FNOKyeA/qkYHVD6HiAiw9c6D8Dr9hWmOk3/HSmGrNURxeUFOckDXsv
 I+yGGKBNshj59j7QZr7ZiuIi2rWlBL8dFN/OWa/o3x7HKsE4k6K8ngwvCKP/QbDLwLLBOWH+
 VEUtpyeyxTr3OJ47ECTxdYvXoAV2iJaKr+6doVQiiR5eVFiMYrUPUECJeolOCwqc/JlWE18L
 +PCAFaW1H+/mpPVfSpN4wnkJ5cQiQVB41IaCM4p20iRzx7ZJABEBAAGJASUEGAECAA8CGwwF
 AlmgzYEFCQu1CEoACgkQrRJwzE3QJ5s7rggAwABzDAGrZ6uWsMxg5PeiiAYPy6LBnCBJSpB5
 Tfy5jH8QTmLfXW+u4Ib4sWXG7PYNR7sIrtqUHjRqXLVXrSnBX9ASGcYw/Xil45khW6LsRpO1
 prHv9gkwQfa6fTiWXVfSfm2Nant6u02q+MaYtQpCVTiz/9ki4FfftUwUHFLU0MhIQogjd11y
 /E08RJsqBwaHQdt14PwU1HphDOzSkhOXRXQLSd3ysyeGUXvL+gqQoXl5XYdvk8IId4PoJRo4
 jcyJ4VbnldvXh5gdGhFA/f9JgkLk9tPW+C3wNtNWyRUq8azR9hF2fg2HJUf4IXQlIu8OOgh1
 VcROBqvtH3ecaIL9iw==
Message-ID: <87eacdfd-8ad9-c08d-33d1-adb2bd989267@twiddle.net>
Date: Mon, 22 Jul 2019 11:58:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563812889499.73128@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::533
Subject: Re: [Qemu-devel] [PATCH v2 00/20] Invert Endian bit in SPARCv9 MMU
 TTE
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, mst@redhat.com,
 palmer@sifive.com, mark.cave-ayland@ilande.co.uk, Alistair.Francis@wdc.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, atar4qemu@gmail.com, ehabkost@redhat.com,
 sw@weilnetz.de, alex.williamson@redhat.com, qemu-arm@nongnu.org,
 david@gibson.dropbear.id.au, qemu-riscv@nongnu.org, cohuck@redhat.com,
 claudio.fontana@huawei.com, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 amarkovic@wavecomp.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/19 9:28 AM, tony.nguyen@bt.com wrote:
> Do you prefer the v1 implementation of making TCGMemOp -> MemOp?

Yes, I did prefer moving the entire enum.

The use of MO_8 etc instead of MO_UB often emphasized that we were dealing only
with a size without a sign.


r~

