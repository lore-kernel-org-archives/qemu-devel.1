Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8F5C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CAF20651
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXrB/cm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CAF20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43235 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMarL-000188-TI
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 12:16:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMaqN-0000jB-F0
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMaqM-0000Et-JP
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:15:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMaqM-0000DR-Bk
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:15:26 -0400
Received: by mail-wr1-x442.google.com with SMTP id h15so2871560wrb.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=ftJbzGUvg1FbdYGhWPO6M3zPgFc7vhBM90T5GZNFruA=;
	b=GXrB/cm8IzSudoySkedgGKkpByfqDn30hCYc3G5hB7FNQROciLfuMssJV2adhTYS2S
	ulvSF07RHzsIbTESCjB0rd9Dd3jQh/UbQmremGRLoFKp0XDa/plG+WJnj/qxPv99nB/K
	NBTXEwQ+4u/t/YFbINPE5tH9ZiebLVEXs97BN2b702tELCz6Pl54LGcMrm2sVIH9Ezkq
	7yyKRmNhdEKxrEz+l6RPy1kRG4bLpI1qfiYc7utq8PB/2lVocJCKpr9YaIDcUZRPNiNs
	0V3NOJv8y1gd8zwOABbSYCkj+pxk5nZW8O0aSp3l4ErC7Nx3zc6B2Zcmg4UuPvLaHklx
	ph4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=ftJbzGUvg1FbdYGhWPO6M3zPgFc7vhBM90T5GZNFruA=;
	b=X/GTrTa0wvthV5/1dp2VCesXRNRXCPS19slE+Se54kS9Wg/3zMgaozwkp/qfbzzhHE
	ObGz5nW5HLWO8Inf2rZMskG8Frnd+Lg5SVSgbDR/Q9e1NcsQvY6+ojgFCFPRmro1BK3n
	9ZMxOMt7p7P/XW6Xqep2IxFVeXMsJltOz6aMGg60yHWYjJZ0zTyWTgrOOUpd0waPfB/V
	maIebzpSVHX7Dple5wyiXnwLKx6ZWG2L77tWaua4RI6+mAzoTLy/7GB8KxyVqx3ZDeLu
	9svO1uNWPIFnQpD3+CDL1GvuiFUf0IMZ74saD71MDdELilRawPRbd5lkLTwVNk0M96hB
	DwDA==
X-Gm-Message-State: APjAAAUXn3VBn16YUKY4yAYrhDUDom7dFhEgd1CV9uDBZgzrwQYyyQou
	LQ4fvPB9z6CTB9CCPAKfCjNw7A==
X-Google-Smtp-Source: APXvYqzILbXqIdLhWzBKMn4Cw9jH0BLByrpvwUyVV18HBpCEHKO54iKnUGDpb2MEt2rC3jzt+GABOw==
X-Received: by 2002:adf:dc82:: with SMTP id r2mr6314301wrj.205.1556900124980; 
	Fri, 03 May 2019 09:15:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id t6sm2880463wmt.8.2019.05.03.09.15.24
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 03 May 2019 09:15:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id E1DE81FF87;
	Fri,  3 May 2019 17:15:23 +0100 (BST)
References: <20190503143904.31211-1-alex.bennee@linaro.org>
	<98cd84db-2aed-4aa1-1f2d-eaa7ac63b72b@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <98cd84db-2aed-4aa1-1f2d-eaa7ac63b72b@redhat.com>
Date: Fri, 03 May 2019 17:15:23 +0100
Message-ID: <87d0kz4iqs.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503161523.b_4a3m-_2-GBFjZO5kmMk9xjWyB3cYFktaSanwh9oco@z>


Thomas Huth <thuth@redhat.com> writes:

> On 03/05/2019 16.39, Alex Benn=C3=A9e wrote:
>> This attempts to clean-up the output to better match the output of the
>> rest of the QEMU check system. This includes:
>>
>>   - formatting as "  TEST    iotest: nnn"
>>   - calculating time diff at the end
>>   - only dumping config on failure
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/qemu-iotests/check | 71 +++++++++++++++++++---------------------
>>  1 file changed, 34 insertions(+), 37 deletions(-)
>
> Thanks for tackling this! The output now looks nicer indeed if you run
> "make check-qtest check-block -j8". However, if you add a "V=3D1" at the
> end of the command line, the outputs look quite different again...
>
> That's why I thought that having a TAP mode for the check script could
> be a good idea, too. Then we could pipe the output through the
> tap-driver.pl script, too, so we get uniform output for all tests...?

That would probably be a cleaner approach. What would be even better is
somehow expanding the list of tests at make time so you could run your
tests in parallel.

I did wonder how useful the timing stuff was to developers.

>
>  Thomas


--
Alex Benn=C3=A9e

