Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188E6C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 17:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D992420879
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 17:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmtpGy/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D992420879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60536 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQEJK-0003bF-39
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 13:00:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQEI4-0002r0-TW
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQEI3-0002qi-VK
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:59:04 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQEI3-0002pg-Lz
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:59:03 -0400
Received: by mail-pg1-x541.google.com with SMTP id t187so7055470pgb.13
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 09:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=fwJ2C32JschXyEWG3/I+al1N63kx8GG/SRmKe/43SQs=;
	b=GmtpGy/2KtbMGngVbVBENYz+Cx6aqd+3HN1mgmRGlbRDkN3DoSymJkE6Ln7EMIEa+y
	b4DQAZH6rR9MJWdx6yG7QK9B6yfGUKXlMAFghWF3kmY0wIjKyRg4s+3gMuv+KT6pavoe
	6Q+JvrS5sC16UCechxrh07DIHrhKzNGCGkklp8PyDB0YTIdeQW6N6z1I+hUXYvJ6C89W
	oXwbJTp5WnSWmyevFSUW2bF1pQHHDy3rSEKx4mJxRqAg7rpMB26OEms4lAoPjCAQzjTT
	VgBSmyU28ducDcDTCHAIj909CouyNeeFOhnsQ/e0FZZ1VoZfjqw/oks8HlarRAz+tgWt
	Hvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fwJ2C32JschXyEWG3/I+al1N63kx8GG/SRmKe/43SQs=;
	b=aHRfePlODwdfqu3WxnST0O+uQLYttsais/gs78fch87UzLNWxxKhVt4+iW5Hu1zPbC
	e/aK0pLQggmQdjO8/4HXrvtP/SSlDxbOrQCbBU1UK9YwF1EHkRKwGFVzvfhsIPhg6SJs
	broSl/qbaHsCpCv7jCsl2jEAUFKBKSM+zN+wLEKvtbTCGmF1FIzcmhoN4bYeWDvnnc6Q
	/J5eNmahk6VnKpe2v8Qy14VH3aVyLj525FDFg+OKYIdb/Q3Hms0IE/6GmvB9MCNPiDOc
	9jQ6ZUBi7UHf1QYC8URPjaTrAge3DOIWTDsgeG1dvjxW7oZAfVkM8bh6vLns2zKFC+Ey
	hKKQ==
X-Gm-Message-State: APjAAAWL0DRYcJPGcK8zyLk7nyG6A4ZEYX5j5GQpawg2GCAN0GCD2rfV
	2xdThdLhYBveG5TUofDLa0tVig==
X-Google-Smtp-Source: APXvYqzq4WH0pBu+B24p6c7VD6a7p+9rdSBosNVb9miIviDqWN/+t3szaWb8HFvn3V8TWD47aLZgTQ==
X-Received: by 2002:a62:2703:: with SMTP id n3mr34812141pfn.199.1557766741986; 
	Mon, 13 May 2019 09:59:01 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	u38sm22934299pgn.73.2019.05.13.09.59.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 09:59:00 -0700 (PDT)
To: Dave Martin <Dave.Martin@arm.com>, Andrew Jones <drjones@redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-6-drjones@redhat.com>
	<20190513124356.GG28398@e103592.cambridge.arm.com>
	<20190513140726.vpmenrfw4uocmtnc@kamzik.brq.redhat.com>
	<20190513143929.GK28398@e103592.cambridge.arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <956f9bc9-1024-b02a-e792-98b01d016ef4@linaro.org>
Date: Mon, 13 May 2019 09:58:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513143929.GK28398@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH 05/13] target/arm/kvm: Add
 kvm_arch_get/put_sve
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"armbru@redhat.com" <armbru@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"abologna@redhat.com" <abologna@redhat.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/19 7:39 AM, Dave Martin wrote:
> On that point, could TCG easily be made to expose a larger vector length
> to the kernel?  I'd be interested to see what happened.

It would be easy enough to extend the maximum vector length within TCG.

Increase ARM_MAX_VQ.  Alter the couple of places where we manipulate ZCR.LEN to
extend the current 4-bit mask.

How large do you need the max to be, for testing?


r~

