Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCD5C04AB2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2751B217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJwyT15n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2751B217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60675 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOppI-0002PJ-Bo
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 16:39:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOpo7-0001up-8Q
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOpo4-0007Fu-0V
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:38:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOpo0-00070u-9U
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:38:18 -0400
Received: by mail-wr1-x443.google.com with SMTP id e11so4852423wrs.0
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 13:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=gBnnSw8DDjHftfLOZf/DfW7ZTaTXiUnNoR2RNfDvnGU=;
	b=VJwyT15nNP33wOJ2eYfAnKXbRPpRMICm76hs5qT+Jqof9nfjkTHQI1U9ee9hTmqJUc
	EDIv9QSr17f20EjMB0SZSu5K4y481ZNGlllgBA3iw/K/r+JPHvKrMY/gqZDoJK2yKD2Z
	cLN4C5FBuEWr6WuQRkXxJTqMOy1apcsBDm5WPV9iuJXcWuYRp3Nq7VoWbZUj3Mu+BIrd
	3xPO10dvZtqPTYbUgSJN06FxWI7ICqM2rqnGRa9UN85arlG0DWww/cYvhm6PJqZI9ha/
	appu/JG9Tb6XXNfLiWqL2AK3KZuLR7GaNZQOoKTg7H8eMWlJi7S1LHdnHwZNbEvpYicK
	VgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=gBnnSw8DDjHftfLOZf/DfW7ZTaTXiUnNoR2RNfDvnGU=;
	b=cWWaMXHeZj+t5bnv5Be30z0fwj6gGHIwDRdkyD5gjDqLsNS8y2jX/hLFi7fDh/Scw1
	GPfaveECI4NhJ0S+/pt6h8ESnhXbqKi9IfojLrlEkhlbkUiwiiehLFbs7/D42m6IZoBS
	iZDWEqV0GcUtyFvEGaJU9C+pWST43IZaZp54jl1aMidclnAprCKaXaJZWKaEXelPpA4M
	Ql3tch4BDuS0rI9ooTk61DsEsi9bdQk3guQySuDdlUux0ZGxlxVifZSLkr5NoaL3BPUj
	Xi1vpQsAI8zfthoZJGZjbm7cZw2FC+jRT6iQgvR2c/jvQvZKEZ3tQWBZngq8YQY1qT9r
	I+FQ==
X-Gm-Message-State: APjAAAUJLRY8GNsnHK9mCqRBA8QgVbEH/H8xCN8qE5mV3Hf+fM2RFh6R
	qwDVhMohrzEZO+xkw7Vy6i7MHA==
X-Google-Smtp-Source: APXvYqzB0UVCTy7nJWyE5canFTLuDG252MRztirUBpkPmCCwjn6FAmEbci+IpOGdZrl5OPm+7X7BBQ==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr4528430wru.312.1557434290714; 
	Thu, 09 May 2019 13:38:10 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id y6sm2262008wrw.60.2019.05.09.13.38.09
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 13:38:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 7EFE11FF87;
	Thu,  9 May 2019 21:38:09 +0100 (BST)
References: <20190509165912.10512-1-alex.bennee@linaro.org>
	<20190509165912.10512-23-alex.bennee@linaro.org>
	<2dcd2689-ca10-b014-e7f0-1967f4901fe2@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Max Reitz <mreitz@redhat.com>
In-reply-to: <2dcd2689-ca10-b014-e7f0-1967f4901fe2@redhat.com>
Date: Thu, 09 May 2019 21:38:09 +0100
Message-ID: <87r2974b4e.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v1 22/23] tests/qemu-iotests: re-format
 output to for make check-block
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
	"open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Max Reitz <mreitz@redhat.com> writes:

> On 09.05.19 18:59, Alex Benn=C3=A9e wrote:
>> This attempts to clean-up the output to better match the output of the
>> rest of the QEMU check system. This includes:
>>
>>   - formatting as "  TEST    iotest: nnn"
>>   - calculating time diff at the end
>>   - only dumping config on failure
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20190503143904.31211-1-alex.bennee@linaro.org>
>> ---
>>  tests/qemu-iotests/check | 101 +++++++++++++++++++++++----------------
>>  1 file changed, 61 insertions(+), 40 deletions(-)
>
> Hm, this makes every iotest print two lines:
>
> $ ./check -T -qcow2
> [...]
> 001 [20:06:27] -> [20:06:27]
> 001 0s (last 1s)

Yes - it was a compromise to ensure we printed a start and end
timestamp but I guess we can fix it up with a bit more shell ugliness:

--8<---------------cut here---------------start------------->8---

Subject: [PATCH] fixup! tests/qemu-iotests: re-format output to for make
 check-block

---
 tests/qemu-iotests/check | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index fb239967a32..9f083f06b46 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -726,7 +726,11 @@ _report_test_result()
     if $pretty; then
         echo "  TEST    iotest: $1 $2"
     else
-        echo "$1 $2"
+        if $timestamp; then
+            echo " $2"
+        else
+            echo "$1 $2"
+        fi
     fi
 }

@@ -793,7 +797,7 @@ do
                     $run_command >$tmp.out 2>&1)
         fi
         sts=3D$?
-        $timestamp && echo " [$(date "+%T")]"
+        $timestamp && echo -n " [$(date "+%T")]"
         stop=3D$(_wallclock)

         if [ -f core ]
--8<---------------cut here---------------end--------------->8---

--
Alex Benn=C3=A9e

