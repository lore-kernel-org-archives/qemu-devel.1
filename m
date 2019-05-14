Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6150AC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CBC2205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPD7tiTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBC2205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51830 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQbWl-0006wA-JF
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 13:47:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQbVz-0006YX-39
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQbVx-0002A9-98
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:46:59 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQbVv-00028v-Mp
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:46:57 -0400
Received: by mail-pf1-x442.google.com with SMTP id v80so9521024pfa.3
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=0aDdQSIEDE9Em/3eeFbuHchgxpJarTZwu7rBzM2BglQ=;
	b=LPD7tiTPVfRnt5JbRZ7Lcgxq1QmBY/9k1xD/ZTmhE2bwK2kJY/Zdk+8MwivcRB927h
	YPWn9IKiiuLrC8OAU8xMeUlW/pjzCru9LPytU5iByAPGaSmA9IaUnDr3+mHQT+xjxgWy
	u7XCCc2khJ9ocWbFYpPvpYfAglfo6mqHtjTwwzY0D79FF21VWqVRog8rJxtQVZvmKJMV
	Q7utUukIUBn5/QgqJ9bwtZ+WUTGfQoS9mbKL/Kp4Wg0uEC+bdmMt3tfOZsCmvixJMEJZ
	bJOB+pf851mM0TNeNHDy7PIm8hnc54uJhlbKBZTgiT1rmHSiMaHrqe1gjHoLtFIfbHNE
	CNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=0aDdQSIEDE9Em/3eeFbuHchgxpJarTZwu7rBzM2BglQ=;
	b=raiqVDoCva0m4xerHFLpXPdPoF1SpIPueTed250x1YrPrvbd/7k3vZGFO9fy7U5CDV
	0V78HUtqb0serR5ijWaJxVOIzrEITq8R2Q3r3cawf4sG1w6+mMVTV6kyPy3VZcrBfol+
	ZiwSDo32HZm1fd62SJm8KfV/MeM6YDjCIPybQ1p0AEfB49HT51Fxda19gFC4dTd1lfbB
	k0qTXWOqL6q8F5gXDWeQ3mC8VMjti/OzFBCQ/0Nd4eFlrabDYGgUvEX9/HOWJLYM6dkK
	Ol2xiAJgQV+bXqV09+QAYZo+xCNBgcr1LdtS5fxI55mv6bhP3GAqYXqYtNbjQd4s06+E
	ZVCw==
X-Gm-Message-State: APjAAAVQfhxJbwBkLODOkbw2QyWoRvAAFmemzVsMHw2SXtvCRYYLU4KM
	zP+tRVqDWAf/SzsuwgmNZl0fW37Jrcg=
X-Google-Smtp-Source: APXvYqwTxMX1fYAU/34+Nkh1iq/q0hU/VEx1BcoLLBhXlngdRZhuMlhKQEN0XtKNH6TJvoJx4aPkDQ==
X-Received: by 2002:a62:5bc1:: with SMTP id p184mr3882253pfb.154.1557856013206;
	Tue, 14 May 2019 10:46:53 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	m6sm8889203pgr.18.2019.05.14.10.46.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 10:46:52 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
	<877eatdq3w.fsf@dusky.pond.sub.org> <20190514152331.GJ25916@redhat.com>
	<d050fa9d-8e4b-7b87-31e5-05a7fa78feb9@linaro.org>
	<20190514165036.GA7680@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f0da55b5-e14d-e718-0608-fa37d1cb6c2b@linaro.org>
Date: Tue, 14 May 2019 10:46:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514165036.GA7680@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v6 00/25] Add qemu_getrandom and
 ARMv8.5-RNG etc
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 9:50 AM, Daniel P. Berrangé wrote:
> On Tue, May 14, 2019 at 09:14:57AM -0700, Richard Henderson wrote:
>> Yes, that would do it.  We would need something in the test that forces the
>> objects into the link.  Without having yet looked at the test cases, any ideas?
> 
> I don't think this is only the test suite. I think it will affect all the
> binaries we build

You're right, it does.

$ nm aarch64-softmmu/qemu-system-aarch64  \
  | grep qcrypto_tls_creds_x509_register_types

comes up empty.

It didn't occur to me that there was nothing in the object files for the
reference.  I'll have to drop the crypto-obj-y patch and come up with a
different solution.


r~

