Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D52C3B1B9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 583382086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="slY6dGRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583382086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fex-0006Yq-KV
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fYy-0002pZ-KK
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:19:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fYx-0003i5-Ng
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:19:40 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44239)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fYx-0003fF-H4
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:19:39 -0500
Received: by mail-pf1-x443.google.com with SMTP id y5so5250960pfb.11
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FvgYBtlDs9Ea4Ci/VnkBpXklHaO5FyyPLfQ7wslDhd8=;
 b=slY6dGRov/L9nHQlCiIi3LXfEM59+ofAKWz0o78ftdf+oC+J5ZfBf9PKNBA1IS7NFQ
 HMkl9a0bzk0YDlk47T2qGRFpLhWiIzRf6g93G55CyGZpzH7MR/jW9DL5udhaTrBrKRBo
 e8Ru+zKLs5H4+M7vNMuKUqRC1IjZs3ofc3Bse2BNlzmumZ7v0QJV/1gtza/AJ3M3njmN
 HXNpO6LgUD6U3H7xmLzutdRj4qY6rLef7mJB9Q7rPaA/+F/eD0ervrMsaH9gqX4866KP
 gzs8s33GCniGVNdmJNzKeZKmxu7wKGyPAI5zwd/CoqfhqlBBskozxfIwZwfeMhjQQVdL
 lz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FvgYBtlDs9Ea4Ci/VnkBpXklHaO5FyyPLfQ7wslDhd8=;
 b=oxT0K23vceiZD+WsEckqjqlj8vfmjRxNyQm+FsHSdx29r0nlwo+Pz6245w67AmTRNv
 jX/DZW1DpbdfZBBq/A3/yFNeJl4OZkhuNfMDo9xzAtB+I3z73zsaSxFhzDjjTixLFyH+
 4561Q7JSN/tTNuRr2vGIzDQakB3k0vUEQKMSLF+tpDpDeJFBqYh9aN0+f1VIa62rxQfZ
 En8pb3wneeRfSsbufoxg5Hg6Pq9SITCwFLWSMWF9W1kmWkgDH9p/TMpUinhoqnFF8Yqm
 VJQeqXm9AnFoUUKKzadASQIF0pt1wYN9QA6UhVIs+AWVHAddJGxnNL9oK5XQWQ7cKiQ5
 lpng==
X-Gm-Message-State: APjAAAVi19AgvWAjRitgQh7iJGZGgebV3UeoBGBU9NQ3x+oRuGulmnP8
 H3vmN8rQ4c9LHbKvPXZ0FAxf0Obhd8Y=
X-Google-Smtp-Source: APXvYqy/+qJ3w6/humvgQEvAjUvE9JPUpnAnHCsEJ70AeauEzJNqUXrDgLJeezbFTjvQfm3gXvGVpQ==
X-Received: by 2002:a63:e755:: with SMTP id j21mr4897680pgk.330.1581704378161; 
 Fri, 14 Feb 2020 10:19:38 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 u6sm3443545pga.30.2020.02.14.10.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 10:19:37 -0800 (PST)
Subject: Re: [PATCH v4 03/20] target/arm: Add isar_feature tests for PAN +
 ATS1E1
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200208125816.14954-1-richard.henderson@linaro.org>
 <20200208125816.14954-4-richard.henderson@linaro.org>
 <CAFEAcA-ffaK7e2ACZvqXs3fcx22O3cyWHdKqoddmYu8z2ezJ1Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <87fa1479-0ac3-002f-7059-f37ee6630348@linaro.org>
Date: Fri, 14 Feb 2020 10:19:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ffaK7e2ACZvqXs3fcx22O3cyWHdKqoddmYu8z2ezJ1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 3:28 AM, Peter Maydell wrote:
>> +static inline bool isar_feature_aa32_pan(const ARMISARegisters *id)
>> +{
>> +    return FIELD_EX64(id->mvfr0, ID_MMFR3, PAN) != 0;
>> +}
>> +
>> +static inline bool isar_feature_aa32_ats1e1(const ARMISARegisters *id)
>> +{
>> +    return FIELD_EX64(id->mvfr0, ID_MMFR3, PAN) >= 2;
>> +}
> 
> Didn't spot this before it hit master, but these feature
> test functions are looking at id->mvfr0, which is MVFR0, not
> MMFR3 !
> 
> Also they're using FIELD_EX64 on a 32-bit register: is there
> a reason for that?

Nope, both mistakes.  Will fix, if you haven't done so already.


r~

