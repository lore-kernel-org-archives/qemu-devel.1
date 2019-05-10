Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D212AC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97CCE20989
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dcvFpyR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CCE20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41856 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP4BV-0001C5-Rx
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 07:59:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hP496-00085Z-Ft
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hP495-00019P-Mo
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:57:00 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hP495-00017L-H2
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:56:59 -0400
Received: by mail-wr1-x443.google.com with SMTP id l2so7552321wrb.9
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 04:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=ft+/1Fmo2fKzbbcBOYigLmMl0lRnapKdieGqd1xvaUQ=;
	b=dcvFpyR3pzJLJ4BBTYi9WG5N24kNHm3l9GNetmghOBznZg+8UK3hnI/ziblWVyQUVL
	wPBca7VEmeZxmDfsanqZcjCrpqsthTeFMErf/HeCYT1yUiDPZSz/m6W6z/Zvb5O7wJ9i
	JwD/8MHJ6+NgiTU1gl75llRjvoebKMmxdFZfXTlFIbAQ5pZEyB+6G//Tpx8OpmUwQDun
	XQ02WPK+PXajcauXu/dpJArGg5XEQ0IHA9GlX4ak78Z5L5J03d+WVJVEUiquQ36I260h
	eak4CG6rkMzl/lpEEIfiW1G5ec9N/sNvM3PRDStIHh0n1ccY5gkhut+Dc810W3DKPmsi
	MRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=ft+/1Fmo2fKzbbcBOYigLmMl0lRnapKdieGqd1xvaUQ=;
	b=rhxiNHQZSVOkfz3fA7orn8t6IU3gwVnmfOO8DVpDFbesSNy7N0JDisyOXZ3UDSQKbY
	m3Bh9sV4IzNi9S71CZ89rLTPI9QAt4nOIH7weceuZnYbItl6ed8csvIJsfV8KI8Jvfst
	VI5HhQVqyAchzDqD05WV2yZIJxFmAYWfwTsIzMT6XaQJLnS/E/Id4oii2SS5EPHanM4Y
	kEQIDKG2CRRUV2kuYud/W+zYMO2EcMDQ7hTN6CKx/VnicEugLcWg74lkBBCux3yTEYJT
	ivsl7GXFFtJoyoeTUwsecEYsVsfhF0RbAgvrzhllIKGzhU3GV/0uKh1+3OI5oX1TifwY
	iHEA==
X-Gm-Message-State: APjAAAVGsTxz5i6dUv0248Dv7nGpbKy4492IhtIVArkF0hNWKYxK1aHz
	M21P6IFxRycJlvWa3LGCH4eWvQ==
X-Google-Smtp-Source: APXvYqyQNiAvbi/HAbFbCRq5284sFiHZ+irrw5sKs3ecW32lJRlup7qQekhiZBIWRfRZvIzjcYuNjQ==
X-Received: by 2002:adf:ee8d:: with SMTP id b13mr7124954wro.219.1557489417978; 
	Fri, 10 May 2019 04:56:57 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id z7sm6410263wme.26.2019.05.10.04.56.57
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 04:56:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id F3B0D1FF87;
	Fri, 10 May 2019 12:56:56 +0100 (BST)
References: <20190510102918.2705-1-alex.bennee@linaro.org>
	<55dd9cf4-cb06-48b1-0cec-ff03113c7c17@redhat.com>
	<b8b1c003-ed0d-d6f2-f970-9fb36165afb7@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <b8b1c003-ed0d-d6f2-f970-9fb36165afb7@redhat.com>
Date: Fri, 10 May 2019 12:56:56 +0100
Message-ID: <87k1ey4j5j.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v3] tests/qemu-iotests: re-format output to
 for make check-block
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 10/05/2019 12.48, Thomas Huth wrote:
> [...]
>>
>> I think the "make check" mode should only print out one time for each
>> test, preferable at the end, like the other tests (like qtests) are
>> doing it...?
>
> s/preferable at the end/preferably at the beginning/
>
> ... I think the makefile rules for the other tests are printing out
> "  TEST xyz" *before* the test is started. And the iotests "check"
> script should do the same.

That mean dropping the execution time (and previous execution time and
possible failure). We could just duplicate on failure modes so you get:

  TEST    iotest: 007
  TEST    iotest: 007 [not run] not suitable for this image format: raw

when there is something other than a passed test to report.

>
>  Thomas


--
Alex Benn=C3=A9e

