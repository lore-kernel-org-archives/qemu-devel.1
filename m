Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ABFC004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 21:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D3920675
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 21:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ykzrsV7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D3920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45951 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNOXW-0006Hr-74
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 17:19:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hNOWj-00061A-9s
	for qemu-devel@nongnu.org; Sun, 05 May 2019 17:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hNOWg-0003aq-71
	for qemu-devel@nongnu.org; Sun, 05 May 2019 17:18:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hNOWd-00036Z-0D
	for qemu-devel@nongnu.org; Sun, 05 May 2019 17:18:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id a12so4595511wrn.4
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 14:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=JvzzaxwYLcZ26soax686E3OBUSdDDsgzlwNdfqH3BvM=;
	b=ykzrsV7a9YNhkwQyu06P4jGqtCDU7tq1ZoDrWSAPmrcw5IJZ3qVbI8IJAjTqNDbyy7
	NDQpv2ujjnYyxg54cncDWMzNsIjQKIEb37m47/OA7lOXAf7mr4jmAEKWtsCEAQ26y/uU
	ckOMThXu+XUQLshGTKPqwNvv3KOCCSSNYFwoSaKK8PbloCHvRTOI7zB1In7TKz0m8kl9
	FUgZ/VONC0jglK3/qtObYtlc7Subk1DJ8zMe23PgLWZz+mKEjRZ4PLAwXg1sJVEyPP0C
	V0gdk9Nwqc0v8Ga70huXWt2E9qAHAvpSAq3bnKFN2QC/4Ft2hddQwavshLPARkBORcWB
	ekhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=JvzzaxwYLcZ26soax686E3OBUSdDDsgzlwNdfqH3BvM=;
	b=M8+yiiALCEbyVSrMiSa35UDjBUfTUZiItrN6JlSYdsJBNlSkbrUlI7hJwQWuwT11P+
	tdS3vOZca6VoUraRD/tuunsqJKDGnQBdXLRAgC3cXe9EqrWleMhmJRvucGkaXvR0AJD1
	f+yWGDRUEY3pkFFqgYpn23IeL/xRd4YQFQFHnAugRJstsLdueO9uySnS+QDTHWvS33s9
	BoKGQkvzd/Om90mAvIuZW1l3wOysRiRFyFzqU4c8ZgPsUsGWNA6PusiAtGYeDtVMtcLT
	aRIAAU9JOw4FleFkp2fjifV6v/lA14dzVaIdZdZTf/DseRjVVZUxaMn8MWMBjJhXIwuC
	e0Qg==
X-Gm-Message-State: APjAAAVmO2e4rjHRM9o3R8gR4KM/EnCQyzuS4Np2yvgrtZgi58f+FhIY
	7OAuDOFk998d3Y5LnnHwOfPq2w==
X-Google-Smtp-Source: APXvYqxScAFZCA1frM7c23snQeR5qFEHnqmN+Zk1K/61hHzBBWHB92PCjD//aojGrFtWdl2aDit87g==
X-Received: by 2002:adf:9e86:: with SMTP id a6mr16536871wrf.178.1557091098274; 
	Sun, 05 May 2019 14:18:18 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	o6sm15277211wrh.55.2019.05.05.14.18.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sun, 05 May 2019 14:18:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 365201FF87;
	Sun,  5 May 2019 22:18:17 +0100 (BST)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-13-ysato@users.sourceforge.jp>
	<87muk34kym.fsf@zen.linaroharston>
	<3d73dc0e-dd08-9900-481c-232ad303a6f0@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <3d73dc0e-dd08-9900-481c-232ad303a6f0@linaro.org>
Date: Sun, 05 May 2019 22:18:17 +0100
Message-ID: <875zqobnxi.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH RFC v8 12/12] hw/registerfields.h: Add 8bit
 and 16bit register macros.
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505211817.g3ffuQQteS9TbeDgXWLFiJpXINnD8FXtuTjgscbDy24@z>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/3/19 8:27 AM, Alex Benn=C3=A9e wrote:
>>
>> Yoshinori Sato <ysato@users.sourceforge.jp> writes:
>>
>>> Some RX peripheral using 8bit and 16bit registers.
>>> Added 8bit and 16bit APIs.
>>
>> Doesn't this mean the build breaks at some point? Features used by other
>> patches should be introduced first so the build remains bisectable.
>
> The only bug I would fix in the ordering is to make the change to configu=
re
> last, so that the target/rx is not enabled while the patches are
> staging.

That will do - the key thing is each interim position in the commit log
can build on it's own.

--
Alex Benn=C3=A9e

