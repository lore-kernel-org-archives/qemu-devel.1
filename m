Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B8BC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FCEE2085A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QMGXypMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCEE2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37393 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLswm-00038f-NC
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 13:23:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hLsvP-0002XU-Cv
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hLsvL-00054B-MX
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:21:42 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hLsvJ-0004ox-NI
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:21:38 -0400
Received: by mail-pf1-x442.google.com with SMTP id v80so4298110pfa.3
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
	h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
	:content-transfer-encoding;
	bh=VEK6fPbStjVr3d8WdWqHY6GUEzrTGGhJzYswDHuTK/o=;
	b=QMGXypMHXjkMUyRSdwZPgqx6Cx5BdiFV7yPWrFYGtotQiVkQ272hgCy7rM2I/uqLJ8
	ZyliiQD1CdjCzJ4OGLA6oL5s4EWE+ghyaH8TInipxTRSOC3Ge3TGGr75HPCpXfbLcnFc
	GfiDrfdUdhoLF9CamhFx67e9GOaLAv2ORN6hHfssqOsJOry+Uq2YrfTIuMzRZHSj78Rj
	fh1aKCOkZIPUAL/HEnewRwSUb1CcRiFGO1dYtLi1YoMp1S21DojF+A88Y6ibh5WEEuZa
	fQsbxpaVVkdSuAHkGz4gfYEsYsmoh2IObPz55kbI5Ejqhgxd7mo0fXoYPN/TfVqar1qc
	G5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=VEK6fPbStjVr3d8WdWqHY6GUEzrTGGhJzYswDHuTK/o=;
	b=R3lA+qa74751bpLtE0/varVzmQjLkXPkl+nzPozT6AcuRPGWJ62aNTFYKK1SCcJN8t
	0esXRXcHA4nqR9/BhA/LKnJxNsarB+WjLpEXOHASwwJNz3aSb3Ho9gGhcy9cE7M7TUss
	pn5E9xhmJsSQ/3+rsIH3uwW/H6+QGRT0+h9PpukN6QKI6o2HMYkS3RYLgcJfixe25tbD
	Ou/59dCxHAnQoJa2tI0aHqXVP8Op4Pwm7bf0wfCeU84/aLQH0CB/4WNwnFDG9psWTrCP
	T/hwZZQlQv698TxvxSz5BxFnwVAZlMmJLe/TBG+3P2DrCM3IKdPuKnxLk2+ZjZrp2v/N
	hdww==
X-Gm-Message-State: APjAAAU1A97eY+IKg5ri7dOGDtqy/67a9C1tUn830mN3dP57/al2rHCe
	mt8evNmoZO8IhXKBvoBqBtSqxdxU8qgKpQ==
X-Google-Smtp-Source: APXvYqzKuil9Gjy/z+zgQsNkf22G+Zk4j1CFXqTspB133czFz0R18OqGCrmiCNnGt3Vh0XORWW0dUA==
X-Received: by 2002:a62:2fc1:: with SMTP id
	v184mr47411520pfv.258.1556731290602; 
	Wed, 01 May 2019 10:21:30 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	u7sm13580784pfu.157.2019.05.01.10.21.29
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 10:21:29 -0700 (PDT)
Date: Wed, 01 May 2019 10:21:29 -0700 (PDT)
X-Google-Original-Date: Wed, 01 May 2019 10:19:45 PDT (-0700)
In-Reply-To: <03ac8b9b-20ae-e6ec-5647-f679471f4d3b@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: richard.henderson@linaro.org
Message-ID: <mhng-c095a304-dace-4b99-8dc6-7a179a3f80bb@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 2/2] target/riscv: Add checks for several
 RVC reserved operands
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501172129.ACyfQxhkpl36Wk-xvqFucfYTeXGmVQ67Hwg7_2UwNpw@z>

On Thu, 25 Apr 2019 10:32:43 PDT (-0700), richard.henderson@linaro.org wrote:
> On 4/25/19 10:26 AM, Richard Henderson wrote:
>>  {
>> +  illegal         011 0  -----  00000 01 # c.addi16sp, RES nzimm=0
>>    addi            011 .  00010  ..... 01 @c_addi16sp
>>    lui             011 .  .....  ..... 01 @c_lui
>>  }
>
> Bah.  I just realized the comment should be more like
>
>   # c.addi16sp and c.lui, RES nzimm=0
>
> Otherwise one is led to believe that rd=2 is missing
> from the illegal pattern.

OK, I went ahead and squashed in that fix as well.


