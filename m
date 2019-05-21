Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107AAC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02272173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y2JmIN4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02272173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56861 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT7y6-0007l9-Tx
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 12:50:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hT7wv-0007A9-UM
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hT7wu-0002MF-KK
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:49:13 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:39654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hT7wu-0002Ld-FI
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:49:12 -0400
Received: by mail-vs1-xe42.google.com with SMTP id m1so11539779vsr.6
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 09:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Tvjwi9swX6TWtDptMOUpngyCBnFCBl9HdxEdhWw3Tug=;
	b=Y2JmIN4X9C2QM05e4Oa9iy10Yrrpln2jwtri2XtyQrxCRRgf5BzJYjOdUuuWGXC6BS
	ap8mKzdOfK2ZAVi4YRFbQm/qJWvSVxVXPLP9nzL2viD3LI4Zi9R+Ws+ES1l0kkaUk7ea
	IxO7tsSDi84MomFML16qkDuPbKHsqxGk8vdyN5tF0zOr9848QBh4Lm51Rlr6HnpmE+B/
	tFXAZSS6zwYpZ48H+GVyTP7+bydxyUe6E+Foyt+HloihYc61WQOjnzbS/A3zOdVnibNV
	ZUC3PKtOOnkpl0EWZ6jlqL4sR5yAZsOoMRVHdlDh/RotABsmxkjskQQBI4oGh2TZeJFr
	S96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Tvjwi9swX6TWtDptMOUpngyCBnFCBl9HdxEdhWw3Tug=;
	b=iuGFOeKGOuxQrydhRWsVUcn3Db+ttTOni2FZa1r4dZ8GzM6u31w25KQ/srW8Wzzcpg
	j0umi8WN0a0B6WoZpVVAVAYx86v+48B4eYs1BcAd1PV9EGxp3bzGamaNGvOF/LQW+pnV
	nAz5aDNQ+1Ei2VXAc9WyUeY7k6GCqPhTbDXvVyRjdDrqaz920fEXcho5+r1r9VVAgr2t
	kemab58bXFD/lkwAqcK7XYQ8ncFUi3Vo1N8EM77bSh4rDo9qPByH1BpGgGh8Fq1pl3Nr
	gdBbeMWU1S1s4IWfMHO5DycCkLeQt+9dDmlUVmLA/n6mfSois1iO9dKIkCs5hZRTzv+b
	jcvA==
X-Gm-Message-State: APjAAAXPHCPT/d7mG+Tlx5Fn7FT6dlzRKziw5dyKSV8iKS8KREXVRGsn
	XJFDza+Okovo3wYu3sfj/hLDl3DhjKI=
X-Google-Smtp-Source: APXvYqyMx7aNpJw3lLrRf7Um5X9Y0BLJH/TRyTDh4czUOpioLfiwyro2djq6dkutrdyoTTIVq45o9A==
X-Received: by 2002:a67:dd8e:: with SMTP id i14mr34690132vsk.149.1558457351222;
	Tue, 21 May 2019 09:49:11 -0700 (PDT)
Received: from [192.168.42.31] (ip-173-130-239-11.orldfl.spcsdns.net.
	[173.130.239.11])
	by smtp.gmail.com with ESMTPSA id j8sm3053130vsd.0.2019.05.21.09.49.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 09:49:10 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
	<alex.bennee@linaro.org>
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<87v9y5gvfq.fsf@zen.linaroharston>
	<233da7c2-baed-face-16e8-af7a06d642c5@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0d863686-435b-e3f6-e358-926591bbd7d3@linaro.org>
Date: Tue, 21 May 2019 12:49:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <233da7c2-baed-face-16e8-af7a06d642c5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e42
Subject: Re: [Qemu-devel] [RISU v2 00/11] Support for i386/x86_64 with
 vector extensions
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/19 11:28 AM, Jan Bobek wrote:
> On 5/20/19 8:30 AM, Alex Bennée wrote:
>>
>> I'm not sure where my test went wrong but I guess it's around xfeatures.
>> The code says required argument but risu doesn't seem to stop me not
>> specifying it. I suspect we should default to the most minimal x86_64 we
>> can and explicitly enable extra features.
> 
> The argument is indeed required, that's taken care of by getopt: to
> test that, one can simply specify --xfeatures as the last option on
> the command-line. However, we don't check if the value successfully
> parses into an integer; is it at all possible that --xfeatures
> inadvertently swallowed the next part of your command-line? I shall
> add this check in v3.
> 
> In any case, we currently default to SSE; this seems reasonable given
> that it's an extension dating back some 20 years and pre-dates x86_64
> by 4 years (1999 vs. 2003). Opinions?

SSE2 is a mandatory part of the x86_64 ABI.

I sincerely doubt we care about testing 32-bit that does not have SSE, but even
then this patch set will not fail, as the kernel will not include the SSE
registers into the signal frame.  It would be the actual test cases for SSE
instructions that would SIGILL when run on a 32-bit guest w/o SSE.

>> Storing xfeat in the stream is a good idea so people don't mix up their
>> dumps but we probably need more validation when running in master mode
>> that the feature you have enabled is actually available on the
>> processor. Otherwise you'll potentially end up generating test streams
>> on HW with no support and just get a bunch of undef noise ;-)
> 
> Correct me if I'm mistaken, but I believe this should be enforced by
> xsave_feature_buf. There's a call to __get_cpuid_count to retrieve
> location of a given XSAVE feature in memory, which is asserted to
> complete successfully. I assume if the feature were not present, the
> assertion would fail. I guess there's a point to be made about
> release builds, in which the assert may have been optimized out; shall
> I turn it into an error message instead?

No, the assert is really an assert, because we have also masked the --xfeatures
value against the set of features stored in the signal frame.  If the kernel
reports a feature in the signal frame for which there is no cpuid leaf, then
something is very confused somewhere.

I am not sure that we can validate that the features in the signal frame match
the --xfeatures value, because I *think* that features are omitted from the
XSAVE data structure when they are in init state.  E.g. when we have not yet
exercised the feature.

This caveat is definitely true of ARM SVE, and I found that if I asserted that
all of the SVE state was in the signal frame that the generated RISU test which
uses memory would fail the 1st checkpoint, because no SVE instructions had yet
been executed.

A careful reading of the XSAVE documentation, plus some experimentation, is
definitely required.  Maybe hand-craft a test case using XRSTOR, giving it a
save area that specifies all features to be reset to init state.


r~

