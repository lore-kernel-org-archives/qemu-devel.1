Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57729C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2185524695
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdXR/b0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2185524695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46790 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWl8k-00067U-7j
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:16:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWl7X-0005Ja-Vo
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWl7W-0008L2-Ng
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:15:11 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWl7V-0008JP-Uv
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:15:10 -0400
Received: by mail-oi1-x241.google.com with SMTP id u64so8302611oib.1
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 10:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=2/opz3OvrYweEyAOsIkfg8h0whFeWD5ZDzzK9aN6D+Q=;
	b=OdXR/b0Ey8wVGL5i0+lkCZy5QVy53ep6RFKZixxBFxbdN48e9p18QSiR46e8uCzpw+
	KsNJh/KyOWP+j9m6uhvJTSZCPuODz7E0Ng9g5o9rY1eP+ZGWHodBp3lVu/Z2inPQIfMA
	ck70wCfmi80EcGsj9X+QyJvkpVXmAgBOcBvBO1DazoE4BIaT9fv2R1RM5Yt4Q57ZjgtR
	EMxyGQbdsOBVii0wCb34o6TrRj3o3QPFTg24wpCXoNg1mqjDIHVQprwVirqybVeNHJeU
	n8INsK7tt41Jb/+EDokswmCpx7hN/Y+zupMmHrQsvt93RNNlRDs5tnscK1Uug4DQoyaw
	lO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=2/opz3OvrYweEyAOsIkfg8h0whFeWD5ZDzzK9aN6D+Q=;
	b=juCrQaKMzyJZ7WOopVTVAviAbTjldGN/eiAqT/YxiBa3rfU5a+9RZG7vTl+0A37Jz2
	ZXbpoSrsbxdYsF28gIPu116g0xuCELkK0PE0DxOijxsavMjI8+6AKhw1cQEScMtz17ke
	V9Kx4BJkl7DHLH06wZyvP1j6CQDfWSfX3taTAiBH3cOncbauP1ADU/3RQnQ7Rjnf7fPO
	4ZSxg2LuhZMwnFQSqkfsiKZ+7OGLP4VSMhGJ4cC7052Tk1MSqi8/M+Svo5AW2IZK3nkd
	mkziMizV5LTvfbvuz6+DMpHmh8xaDGzEXNLoYGVYVSHZES99ByXgL4v1Cf+4uepIm3Ge
	2J6A==
X-Gm-Message-State: APjAAAWrm7D4qbVIxXQk2MzkI61y3Jzskzb9GV+wfdRPmlWNO+2eCb21
	uyZg7W9TSJN7uqm2zobEkYrLJg==
X-Google-Smtp-Source: APXvYqy2KqQdhP5o4YzCOOtVURYY2umh/qpIcxicGppDBJ8R4t/tBgu5nOvmzXpkOMEHfHmV2sxszA==
X-Received: by 2002:aca:bbc3:: with SMTP id l186mr4808108oif.44.1559322908125; 
	Fri, 31 May 2019 10:15:08 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id d9sm1936716oia.32.2019.05.31.10.15.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 10:15:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-8-david@redhat.com>
	<f984c5d3-2a30-2bb9-468c-5c8bb94b6ebf@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1225a07f-4997-76ad-e9d4-d476980f6c52@linaro.org>
Date: Fri, 31 May 2019 12:15:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f984c5d3-2a30-2bb9-468c-5c8bb94b6ebf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v1 07/23] s390x/tcg: Implement VECTOR FP
 CONVERT FROM FIXED 64-BIT
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Denys Vlasenko <dvlasenk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 12:10 PM, Richard Henderson wrote:
> On 5/31/19 5:44 AM, David Hildenbrand wrote:
>> +static DisasJumpType op_vcdg(DisasContext *s, DisasOps *o)
>> +{
>> +    const uint8_t fpf = get_field(s->fields, m3);
>> +    const uint8_t m4 = get_field(s->fields, m4);
>> +    const uint8_t erm = get_field(s->fields, m5);
>> +    const bool se = extract32(m4, 3, 1);
>> +    gen_helper_gvec_2_ptr *fn;
>> +
>> +    if (fpf != FPF_LONG || extract32(m4, 0, 2) || erm > 7 || erm == 2) {
> 
> Please split out the erm validity check.
> We have fpinst_extract_m34 doing some of this now;
> it would be a shame to replicate it more.

Hmm.  Or perhaps you aren't replicating it because it's only used by these
conversions, and both signed and unsigned go through this same function?

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



