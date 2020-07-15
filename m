Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01762C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 08:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF9472064C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 08:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="khI5PL4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9472064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvcNN-0008Bx-1z
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 04:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvcMl-0007l1-Fz
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 04:02:11 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:34972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvcMj-0007ch-PK
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 04:02:11 -0400
Received: by mail-wr1-x429.google.com with SMTP id z2so1430185wrp.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 01:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=vatdIEatc+WTbDanMs/9GqtyLIAZhq5TNOKBqow0ad8=;
 b=khI5PL4Me5Kyc7v5EvcW1kuGOHqt6/IbNqAl5uTso57Z9stUIUfHuN2852aghzsh15
 M/HMu5FVq/0oXipL31+VXjFwuHjJRtwtWYG6+omP5hpgOCleDPI50WWwJA6oXui6N1qT
 RiPvMM1nE07TD0L0yrXXQvL2yLKcXa5gV34/UnqWfJocnuGXG8oKcVc9PX45Lz228teX
 B1b6qOMjCGHmPqAERKpsc3cGZcW8n8NcJajyeXaC11RI+4qOLI9gHoTdK8ZpvmHDdaeo
 Ayka5r61IguiKVbkGPCDPjid4JVCzPKBskTPT+p+XJnTj0W2DZm25dDwhU43OQRaTpaK
 mFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=vatdIEatc+WTbDanMs/9GqtyLIAZhq5TNOKBqow0ad8=;
 b=NE8WsSHkOtdmJ1ns++vqeZghOlCJ9dSNVP4NpwUidtpx2DhS+mPjQVfJFq2IKYWlHK
 zM5HJ7hB5zUmT0vG0OSTEJfRaTsrLWqtkJuSlPOZoNhdeOK879DOw5l9yNSakfHrYyn9
 B+dzFtFVxNZ6NMuSMHmOv8fIdGBAZ2FcQTB3MXLfSQLapv2zXGi4ziwrLebBLn7OcEen
 pZF5A/fLz7/aT02swexqY6eLhXw9ft9UXkOaEhfRwVsWnPD1VKaEGo8IH/5DqT2JlXP8
 OqzZgPGaOtna9OmmoiaBWGejQPLtih3wgzm37ef+pk35UYGp7OZVToG/zXRwdOcBNBsu
 7dLQ==
X-Gm-Message-State: AOAM530qWplQTrYmSmt9so6uAZ49dH+3SNDTxe/TYp9nlDCOLBbtUN3b
 FsL39RxNQg1Y6haIkYE2gYU2Kg==
X-Google-Smtp-Source: ABdhPJxQcnqT2qyavdlDHPf8F12dJkecjGryNCiDJenVSTO92fNx4W+0y1qrsUZtI2Q+bLu7jJNPvQ==
X-Received: by 2002:a5d:4707:: with SMTP id y7mr9725435wrq.261.1594800127736; 
 Wed, 15 Jul 2020 01:02:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g195sm2217627wme.38.2020.07.15.01.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 01:02:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BEFA71FF7E;
 Wed, 15 Jul 2020 09:02:05 +0100 (BST)
References: <20200714175516.5475-1-alex.bennee@linaro.org>
 <20200715040619.GG93134@umbus.fritz.box>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] .travis.yml: skip ppc64abi32-linux-user with plugins
In-reply-to: <20200715040619.GG93134@umbus.fritz.box>
Date: Wed, 15 Jul 2020 09:02:05 +0100
Message-ID: <87o8ohxl36.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Gibson <david@gibson.dropbear.id.au> writes:

> On Tue, Jul 14, 2020 at 06:55:16PM +0100, Alex Benn=C3=A9e wrote:
>> We actually see failures on threadcount running without plugins:
>>=20
>>   retry.py -n 1000 -c -- \
>>     ./ppc64abi32-linux-user/qemu-ppc64abi32 \
>>     ./tests/tcg/ppc64abi32-linux-user/threadcount
>>=20
>> which reports:
>>=20
>>   0: 978 times (97.80%), avg time 0.270 (0.01 varience/0.08 deviation)
>>   -6: 21 times (2.10%), avg time 0.336 (0.01 varience/0.12 deviation)
>>   -11: 1 times (0.10%), avg time 0.502 (0.00 varience/0.00 deviation)
>>   Ran command 1000 times, 978 passes
>>=20
>> But when running with plugins we hit the failure a lot more often:
>>=20
>>   0: 91 times (91.00%), avg time 0.302 (0.04 varience/0.19 deviation)
>>   -11: 9 times (9.00%), avg time 0.558 (0.01 varience/0.11 deviation)
>>   Ran command 100 times, 91 passes
>>=20
>> The crash occurs in guest code which is the same in both pass and fail
>> cases. However we see various messages reported on the console about
>> corrupted memory lists which seems to imply the guest memory allocation
>> is corrupted. This lines up with the seg fault being in the guest
>> __libc_free function. So we think this is a guest bug which is
>> exacerbated by various modes of translation. If anyone has access to
>> real hardware to soak test the test case we could prove this properly.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>
> Honestly, AFAICT the ppc64abi32-linux-user target is pretty much
> entirely broken anyway.  Many things about it appear to make no
> sense, it's difficult to work out what it's even supposed to be, and I
> strongly suspect no-one's actually used it in like a decade.

Should we think about marking it deprecated for 5.2?

--=20
Alex Benn=C3=A9e

