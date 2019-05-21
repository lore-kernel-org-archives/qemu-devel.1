Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3C2C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07108216B7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMXwHtki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07108216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT0mt-0003a0-8G
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 05:10:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hT0lU-0002r8-So
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hT0lT-00058R-RI
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:08:56 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:36698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hT0lT-00055K-I0
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:08:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id j187so2037210wmj.1
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 02:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=HwkUIvUVtvuldkK/StId1UTjBiDyFsrQ/7V5dZVIYKo=;
	b=aMXwHtkiTK+3Oiv1QDPygqN2Yvqnneb6nYrYaDoBbO2T17f6qRA9vR7r6t8/dtKxNl
	tsfcOCz0xez3YhOscTxo0iq1rihJzytkjd3rVahHA3YVOgnm/+ex2NftRxIi9q429LQd
	1aBI8AJ1OuwIHQrJyYJw9OOrjIkqadnNhwlV4nmPZshKTrPBXyiyg8tA4QrC1D4Q+aYZ
	YksWae4d/I4iRj+Wd+4E+0Cfb05sZu37f8P6cPpplKOy+q7SEhcDoSF1XiN5aDyQggQl
	ueDrCA26Z/R+HywWGnB7DwVeVOT9/WqpkHYcbUebjIjxqQEt7ll0p77RiWRLQ0A3B30n
	k2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=HwkUIvUVtvuldkK/StId1UTjBiDyFsrQ/7V5dZVIYKo=;
	b=UynGoY/MATub3r2NL5meU5/pQR00o3JBtMaGpVE5TIUQzLdV7YsST9kQ4Dgf39Vz3O
	brvWCQlfYX6KvbzfIuc9AStTTI47BaH9nFwmwKAWtymzyXd//mDhWF4amI0upMOZLezr
	zqxNK7NsTyG76Ce8It+eTCOJMEjAvt2+2woz+MGY4uGJF/MjrObiDUdTxEnbgxnKAp3A
	th4IEVnSSdZ7eCwSoizAxlrwNaPxad+7UaEJdsYTjxFscg7OPmKfbro5dbfsXrbSCyB5
	LIiUK4woLVCoJj1X0Xcl2wbkRf58u1y+GpsiL5qTp2y8Dj4OJzfrQqM2Rpt+glHbf2x0
	5taA==
X-Gm-Message-State: APjAAAXN+4PYjjqdpIYuRvIrdkxgBVudJP2l65194Wm4djCDcxXENmcA
	Hdv75lA/5ZprA2TDKUG0TF2fIQ==
X-Google-Smtp-Source: APXvYqyshgy0AJNKlQyIeszOet8eoElWmXQVKhUgm/b8cCSdCZ0zlq1PsgShCvZ0ZUziyhZG/3xwKg==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr2415213wmg.64.1558429731000; 
	Tue, 21 May 2019 02:08:51 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	d17sm14111726wrw.18.2019.05.21.02.08.48
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 21 May 2019 02:08:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 032AD1FF87;
	Tue, 21 May 2019 10:08:48 +0100 (BST)
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-8-jan.bobek@gmail.com>
	<87zhnhgw1c.fsf@zen.linaroharston>
	<CAFXwXrkiShudOkAKks7VwB5-tUskeY1pfSeftvS8n=ez8Zgeog@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <CAFXwXrkiShudOkAKks7VwB5-tUskeY1pfSeftvS8n=ez8Zgeog@mail.gmail.com>
Date: Tue, 21 May 2019 10:08:47 +0100
Message-ID: <87h89ogoo0.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: Re: [Qemu-devel] [RISU v2 07/11] test_i386: change syntax from nasm
 to gas
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On Mon, May 20, 2019, 08:17 Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>>
>> Jan Bobek <jan.bobek@gmail.com> writes:
>>
>> > This allows us to drop dependency on NASM and build the test image
>> > with GCC only. Adds support for x86_64, too.
>>
>>   ./risu --master -t run.out test_i386.bin
>>
>> and then:
>>
>>   ./risu -t run.out test_i386.bin
>>
>> Gives:
>>
>>   loading test image test_i386.bin...
>>   starting apprentice image at 0xf7f07000
>>   starting image
>>   finished early after 1 checkpoints
>>   match status...
>>   mismatch on regs!
>>   this reginfo:
>>     faulting insn fc0b90f
>>
>> Because:
>>
>>   Mismatch (master v apprentice):
>>   xmm4  : fe76ea16f7d9c58c 000006fc00000000
>>        v: fe76ea16f7d1a58c 000006fc00000000
>>
>> We probably need to zero or reset the xmm regs both in the test and when
>> risugen dumps it's preamble.
>>
>
> That gets fixed later in the series.

So it does, but I'm still seeing the test fail when played back :-/

--
Alex Benn=C3=A9e

