Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA35C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB0D206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sW3t/Wvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB0D206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46172 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTNw-0000dw-6S
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 11:42:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTTLy-0007KC-9z
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTTBp-0000Ma-0t
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:30:02 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTTBo-0000HB-PZ
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:30:00 -0400
Received: by mail-wr1-x442.google.com with SMTP id t7so2494285wrr.10
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=HMudpCBX/pvuCUsTdfc0OSwBlwUR25ZKprnb/jj3Lmo=;
	b=sW3t/WvcBdXbtseN+JNUZlCJ6QfNd58vIHQLValuQi8qlVmWeU4cFHzqkWd5PRO0/A
	MI2pU+xi4Qwzndj628hdOPbw94RVUXJHB5IUay/SNjeiYBwmwNS7nQjYve4Ii12QwodU
	o1RE3lrx0tXtKk3XKSOC5rtdD0Sd0gLuSFhFplRiYwwdo8serCQs55pHfpPzavewWqhW
	wfkC2vgGGJW8skKEQevpML+PL27C7chpIRV+IvhB4dDb1NL2iHVrgRixKTcVe52Kjh+z
	RuLlzN4wklGrcO4MU7UfViSuHA6TS1g8wEW+EzDxjpadnq/V12WlsEWekZIh9MQMdHeT
	tdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=HMudpCBX/pvuCUsTdfc0OSwBlwUR25ZKprnb/jj3Lmo=;
	b=Vm8nn0b2rLz9ayeeZ1P1tsM+AL88kXc8J9f9ei6Vv6ibNtECi6xJ4FqqN+wQdyH+8y
	5GOeYY+x0vNb5ia4OsBl1tWUI6rYzD/SG1bSNivDe8ywxjCzW9JJVuKGWqpK9Paq8++k
	aVQFCUkVstKRGXGHcseQXMzMBB3EcOai7QJbeDDrOB8hu/YPGp8h/oAz5K7WFPAPqGrZ
	lV95Siv57NXFY8pj7G6QZfAIdoe7YxLuxu0MIf0SSaOwTR80Xu9wQCsLFGzf1xf3ea6R
	+/cop+zfTqyVAEt5PT6aOXQ0fWHol0htuUI3n6wVFRTq24w3W4Q1uWUfwxHnEy/HE992
	MQCA==
X-Gm-Message-State: APjAAAU+xpH4kKzzLRU+F/5U4nwQH01O/VmFDXeL1mVrbvehM1BlWqxh
	vfipWjCpaX3z0mQmc+bVGYn1kg==
X-Google-Smtp-Source: APXvYqyr8MVguYNrFhA28w20IWqZITfmKrbjuXZLpEz8dAULCY7HDTGH1dFyTm5s7QMHGRSV8kzXvA==
X-Received: by 2002:adf:f841:: with SMTP id d1mr19564032wrq.62.1558538998963; 
	Wed, 22 May 2019 08:29:58 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id s62sm122127wmf.24.2019.05.22.08.29.58
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 22 May 2019 08:29:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id D8AC41FF87;
	Wed, 22 May 2019 16:29:57 +0100 (BST)
References: <20190510102918.2705-1-alex.bennee@linaro.org>
	<20190510140726.GB5887@localhost.localdomain>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Kevin Wolf <kwolf@redhat.com>
In-reply-to: <20190510140726.GB5887@localhost.localdomain>
Date: Wed, 22 May 2019 16:29:57 +0100
Message-ID: <878suyh5hm.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Kevin Wolf <kwolf@redhat.com> writes:

> Am 10.05.2019 um 12:29 hat Alex Benn=C3=A9e geschrieben:
>> This attempts to clean-up the output to better match the output of the
>> rest of the QEMU check system when called with -pretty. This includes:
>>
>>   - formatting as "  TEST    iotest: nnn"
>>   - calculating time diff at the end
>>   - only dumping config on failure (when -pretty enabled)
>>
>> The existing output is mostly preserved although the dumping of the
>> old time at the start "Ns ..." was removed to keep the logic simple.
>> The timestamp mode can still be used to see which tests are "hanging".
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20190503143904.31211-1-alex.bennee@linaro.org>
>
> I played with it a bit more and ended up with the following patch to be
> applied on top. Maybe you like some parts of it.
>
> I'm now printing an \r at the end of the line that is printed at the
> start of the test case. Normally that will be overwritten by the result
> line which contains the same information again, but if you're running
> multiple tests in parallel, it will be overwritten by something else -
> which I think isn't a big problem because at the end, the result line
> will still appear somewhere.
>
> I fixed some bugs, too, like the "not run" list being broken.

Thanks, I've merged those changes in with a few minor tweaks for the
makecheck version (single phase output, dropped the defunct -T option).
I'll send out testing/next shortly.

--
Alex Benn=C3=A9e

