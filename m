Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C6FC33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 07:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44CA42087E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 07:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VPvN9Sut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CA42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irzik-00049m-EG
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 02:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irzhl-0003Iz-SO
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 02:36:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irzhk-0005Iz-Jc
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 02:36:37 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36591)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irzhk-0005I3-BH
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 02:36:36 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so2645263wma.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 23:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=V5mVA6suySRYHok3SDSakAINLBQvrJbiOL2GBoZa2TU=;
 b=VPvN9SutKKl2O34x9cV4MWdXaOfLRnduSqg2ClNDefDvUICdR+kHEnNyC/5k6y6kPh
 b2E+rOpWtzK2VA55piT1Iyi0H9xxFW7fxtM575/oLGQVMMH2ufrunSwKEOkrwYSej8yU
 1tK5+Vjn27GadgftGITDjU4QNPWzB8qBc7elC+sjmlTT9MzsvPdEgxkzg0ne+T55i4Vj
 9cSbNoBrDDFk3OU0ht5MTfonQ8PzFuL8gsFu/HW5BpgrOVUAw+8RiHJaE8yoO2w1iWQF
 Ou7pfnZkKlTqCUJn1cxIcvQOeSiqdq07/XBDLqUriO8xxL9IYqKmTIKzSW8nalRxgXAj
 08pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=V5mVA6suySRYHok3SDSakAINLBQvrJbiOL2GBoZa2TU=;
 b=RqOrUgy2BExRYED3Rjx1Gv77AyrsxC4iko6MQWlfcDnQIpLyCQ6HBUUSDJNw0skpqW
 dXORp8qRJcGdvz9ZAHU5Ga260cnRjJoxQ64PVDbN5Fgos1FWJJ455nTjGJmpwQROx5vy
 RtokMA0nsdY53a+Dp3Ofty240U9Qjhaz8J68m1GFsd1isgfUuAj1+3K2L/DQbD4fJ8c5
 tbgHrXhFmIa4jJ2mQE9v1HjlyXWDb9uKEcmvJJ7i2+01pzGYYfYjiiDRddpFMSk4Izi8
 KVa5jZjv0GCLO3cXCRhKCWOHgrhKmIs+gvyki7DOOlsTaTfe0Wb8gn/aOM5xOuGMGcsw
 +QSA==
X-Gm-Message-State: APjAAAUE77Lx49qHIQjaizbGpcrJAdlDhzupryoWwlcUVSdjIAaw8dDd
 GNRZUjJ4vOT6wIk5RBdFZd6Raw==
X-Google-Smtp-Source: APXvYqzfmcyI8G44OQpnUq42YK3g6tiH8xHFuIqMdiHVhbF5iz0yepD/tDbth9mxy6pLzERoAN5qJA==
X-Received: by 2002:a1c:964f:: with SMTP id y76mr4536339wmd.62.1579160195009; 
 Wed, 15 Jan 2020 23:36:35 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m3sm27162357wrs.53.2020.01.15.23.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 23:36:33 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 33CA71FF87;
 Thu, 16 Jan 2020 07:36:33 +0000 (GMT)
References: <20200114150953.27659-1-alex.bennee@linaro.org>
 <20200114150953.27659-19-alex.bennee@linaro.org>
 <f31669c6-ee62-6019-a09a-85a133eb68ae@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 18/22] tests/tcg/aarch64: add a gdbstub testcase for
 SVE registers
In-reply-to: <f31669c6-ee62-6019-a09a-85a133eb68ae@linaro.org>
Date: Thu, 16 Jan 2020 07:36:33 +0000
Message-ID: <87tv4vluny.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 1/14/20 5:09 AM, Alex Benn=C3=A9e wrote:
>> A very simple test case which sets and reads SVE registers while
>> running a test case. We don't really need to compile a SVE binary for
>> this case but we will later so keep it simple for now.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> ---
>> v5
>>   - properly plumb in
>>   - skip if fails to connect
>> ---
>>  tests/.gitignore                      |  1 +
>>  tests/tcg/aarch64/Makefile.target     | 15 +++++
>>  tests/tcg/aarch64/gdbstub/test-sve.py | 81 +++++++++++++++++++++++++++
>>  3 files changed, 97 insertions(+)
>>  create mode 100644 tests/tcg/aarch64/gdbstub/test-sve.py
>
> I don't understand how this is working.  What's the process that provides=
 the
> container for the register state?
>
> I would have expected *some* binary to be used, even if it is only "int m=
ain()
> { return 0; }".

It is, it's using the sysregs test:

  --bin $<
=20=20
>
>
>
> r~


--=20
Alex Benn=C3=A9e

