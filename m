Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A85C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 18:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28B020830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 18:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T1UV2ImA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28B020830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60869 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNilO-0007Pp-Q3
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 14:54:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hNikU-00074W-K9
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hNikT-0003xW-CH
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:54:02 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hNikT-0003wU-6O
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:54:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id v10so6393349wrt.6
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=+c8rDKUIEhm/78lkVSwz/fAPCO+vlgxdTv4ObKon0v8=;
	b=T1UV2ImAJQbbWwPPD+xR7GYNMnX/kpnEJe7DrgvhPzYCLVMLSaafRPx/4Xl+1KHWmH
	obwG2eY4pfdZI3zdX2L80ONt02QH6etcRp0LzhUW9W+l5NhWSve4Mbi/dJzB1X+7Weab
	mLIhJY3kncpkS2zhTBrqqP10kku50sf9qDESbmtnzCE3IdgoaQbXl2eAUe1ioZfJYLPa
	dNR7AfzBHyR+I5NjDvNVq+kWB2VfuuyHpqiQRm88jtklrd2EscE6XDAatN3NE3V9DglO
	DbsAeAN1PjEqZ9T8fB0787zj2ptqoU9cIFPR1qlXfugkVEW+mds0wxglsLt1lK3xSx7b
	tCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=+c8rDKUIEhm/78lkVSwz/fAPCO+vlgxdTv4ObKon0v8=;
	b=dgOS5AmrDRAPzYvBvIRnJ+dMPzoz5MJUkmF50dxUkc9hd3GVOcuHz7qbz4TFAzA+/x
	33oGVDzN6Q3WUmF0HP7PDXFS1raHR6zvbtOlC52hl904Abj1OiNUTJDiIkJHSbjH+8fb
	D4CZIzsrj/wnaZ/KKxYoJ1MwNOqZoBOmwp4um9/0JHER4WNyvAXMWSO35/XgxRinzjuP
	Y9RcDeuyOo3gKAnzD/REL7QyAZrzhowWkT1ro+kfmT1QAhOZKP7z5H4OjCZNodaYp/eg
	nYnHPAW7rNpUaAjrOp/soxEayLo3xMhPMo7HoSumfHslMFjnDHTXWDeuz5QPqjVgasGu
	CLRg==
X-Gm-Message-State: APjAAAV2pvOR/ESlotBTgfRmjscZ0YGNFBv4QwIExIvVVBoo9XcobbUC
	ybKeH9CVqO3l524cBtTLVlF9PA==
X-Google-Smtp-Source: APXvYqyhix+Msz32FxBBxlKCXyUOGPiKZJJ+UjpgEs2r9ipZXXZdnA/5nc4nDiKWSRc3B9JM9TnzSQ==
X-Received: by 2002:a5d:6b04:: with SMTP id v4mr17347749wrw.69.1557168838262; 
	Mon, 06 May 2019 11:53:58 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id z4sm9839635wmk.5.2019.05.06.11.53.57
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 06 May 2019 11:53:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 2E2691FF87;
	Mon,  6 May 2019 19:53:57 +0100 (BST)
References: <20190503143904.31211-1-alex.bennee@linaro.org>
	<98cd84db-2aed-4aa1-1f2d-eaa7ac63b72b@redhat.com>
	<87d0kz4iqs.fsf@zen.linaroharston>
	<0badc17e-90bc-1a09-89c1-20f88ff75d3b@redhat.com>
	<ce754049-a871-b45c-9264-4de9178de62c@virtuozzo.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
In-reply-to: <ce754049-a871-b45c-9264-4de9178de62c@virtuozzo.com>
Date: Mon, 06 May 2019 19:53:57 +0100
Message-ID: <874l67beii.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [RFC PATCH] tests/qemu-iotests: re-format output
 to for make check-block
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 05.05.2019 18:54, Thomas Huth wrote:
>> On 03/05/2019 18.15, Alex Benn=C3=A9e wrote:
>>>
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> On 03/05/2019 16.39, Alex Benn=C3=A9e wrote:
>>>>> This attempts to clean-up the output to better match the output of the
>>>>> rest of the QEMU check system. This includes:
>>>>>
>>>>>    - formatting as "  TEST    iotest: nnn"
>>>>>    - calculating time diff at the end
>>>>>    - only dumping config on failure
>>>>>
>>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>> ---
>>>>>   tests/qemu-iotests/check | 71 +++++++++++++++++++------------------=
---
>>>>>   1 file changed, 34 insertions(+), 37 deletions(-)
>>>>
>>>> Thanks for tackling this! The output now looks nicer indeed if you run
>>>> "make check-qtest check-block -j8". However, if you add a "V=3D1" at t=
he
>>>> end of the command line, the outputs look quite different again...
>>>>
>>>> That's why I thought that having a TAP mode for the check script could
>>>> be a good idea, too. Then we could pipe the output through the
>>>> tap-driver.pl script, too, so we get uniform output for all tests...?
>>>
>>> That would probably be a cleaner approach. What would be even better is
>>> somehow expanding the list of tests at make time so you could run your
>>> tests in parallel.
>>
>> I agree that this might be the ultimate solution ... but I'm not sure
>> whether the iotests are really ready for being run in parallel yet, so
>> it will likely take quite some while 'till we are at that point. With
>> that in mind (and thus also not sure yet whether my TAP idea is really
>> the right approach), your patch is certainly a good interim solution
>> which we should try to get merged, too, when my "make check" series gets
>> accepted?
>>
>>> I did wonder how useful the timing stuff was to developers.
>>
>> Yes, me too ... maybe the block layer folks can comment on that one...?
>>
>>   Thomas
>>
>
> Hi!
>
> It was useful to not miss performance degradation (1) and
> to understand that test hangs (2) (if you know that it should
> finish in 1 second, but 10 seconds already passed, the test
> most probably hangs)
>
> Run tests with your patch:
>
> first run:
> # check -qcow2 -T
>    TEST    iotest: 001 [20:00:30] -> [20:00:31]
>    TEST    iotest: 002 [20:00:31] -> [20:00:33]
>    TEST    iotest: 003 [20:00:33] -> [20:00:34]
>    TEST    iotest: 004 [20:00:34] -> [20:00:35]
>    TEST    iotest: 005 [20:00:35] -> [20:00:36]
>    TEST    iotest: 007 [20:00:36] -> [20:00:39]
>
>
> second run:
> # check -qcow2 -T
>    TEST    iotest: 001 [20:00:41] -> [20:00:43] 2s (last 1s)
>    TEST    iotest: 002 [20:00:43] -> [20:00:44] 1s (last 2s)
>    TEST    iotest: 003 [20:00:44] -> [20:00:46] 2s (last 1s)
>    TEST    iotest: 004 [20:00:46] -> [20:00:46] 0s (last 1s)
>    TEST    iotest: 005 [20:00:46] -> [20:00:47] 1s (last 1s)
>    TEST    iotest: 007 [20:00:47] -> [20:00:50] 3s (last 3s)
>    TEST    iotest: 008 [20:00:50] -> [20:00:51]
>    TEST    iotest: 009 [20:00:51] -> [20:00:51]
>    TEST    iotest: 010 [20:00:51] -> [20:00:51]
>
>
> So, in first run delta was not calculated and on second - calculated.
> Could you calculate delta in all cases, to make first run look like
> # check -qcow2 -T
>    TEST    iotest: 001 [20:00:30] -> [20:00:31] 1s
>    TEST    iotest: 002 [20:00:31] -> [20:00:33] 2s
>    TEST    iotest: 003 [20:00:33] -> [20:00:34] 1s
>    TEST    iotest: 004 [20:00:34] -> [20:00:35] 1s
>    TEST    iotest: 005 [20:00:35] -> [20:00:36] 1s
>    TEST    iotest: 007 [20:00:36] -> [20:00:39] 3s

Sure that seems easy enough.

--
Alex Benn=C3=A9e

