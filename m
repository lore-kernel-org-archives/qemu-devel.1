Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EAAC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905FA20685
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905FA20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33404 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJinZ-0000VJ-3p
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 14:08:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJimI-0008Ki-Hz
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJimF-00071G-Py
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:07:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJimB-0006e7-Se
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:07:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id b1so679645wru.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 11:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=UxMNW3v3XkJRw4c3jaxUPZIB89NNTNyXaxEAjyuDd60=;
	b=WlPQzpusol7XQ44xRJlBCYMLo4af3BW7sADTipuEvfIuM1qV7ROElSrapzhJ/rd8ij
	od4mPbFiAcEVRKggysoiCFdLukFhHPQPHFx8K/CpU8Wxn7G0dJknqF4ACjiyki8TQifK
	mThKYZqZI/PqW/LBlCMGqN80f2vPDotVEo42eUf3Y6Ayj3IfTeKT8nsOLwQPH6yEGlq6
	55o8ZeLND8iSQD+URu2d75E7+fm2eDB6dsuxdHvXLk8hgATlf5nSkYnCFEIfE1W8uQn5
	/ox6YtvoTWEU7DOzh9S4CK93OtH4OBYZ4o9LkTxpwHX6uYyQfierAOnwM0zWVge0Xft1
	ZoCQ==
X-Gm-Message-State: APjAAAXc5N4IT7X1ylKyQuKTu/vlm7S/w4cVkwBroNsAx2gAPZJdCWwN
	uMIWrWCZObl8IGgglyBhZJ0u5g==
X-Google-Smtp-Source: APXvYqxFbWrwazF8P3W52byqzrxEbZhvyUO79ej+ZkbdKbAhuRV13PFUwRDMJvRqjeU5lovcC74zPw==
X-Received: by 2002:a5d:4942:: with SMTP id r2mr6149415wrs.159.1556215628402; 
	Thu, 25 Apr 2019 11:07:08 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	u6sm42307131wrg.72.2019.04.25.11.07.07
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 11:07:07 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
References: <20190103144124.18917-1-stefanha@redhat.com>
	<CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
Date: Thu, 25 Apr 2019 20:07:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
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
Cc: Jim Mussared <jim@groklearning.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Steffen Gortz <qemu.ml@steffen-goertz.de>,
	qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
	Thomas Huth <thuth@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425180706.W9hn6DelszL_wVcpV6JvTINPI4qJQLZDak-rDJMJalQ@z>

Hi Peter, Stefan,

On 1/4/19 4:16 PM, Peter Maydell wrote:
> On Thu, 3 Jan 2019 at 14:41, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>> This reverts commit 01fd41ab3fb69971c24a69ed49cde96086d81278.
>>
>> The generic loader device (-device loader,file=kernel.bin) can be used
>> to load a kernel instead of the -kernel option.  Some boards have flash
>> memory (pflash) that is set via the -pflash or -drive options.
>>
>> Allow starting QEMU without the -kernel option to accommodate these
>> scenarios.
>>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Previous to this commit (v3.1), we have:

$ qemu-system-aarch64 -M netduino2
qemu-system-aarch64: Guest image must be specified (using -kernel)

Now (v4.0) we get:

$ qemu-system-aarch64 -M netduino2
qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)

R00=00000000 R01=00000000 R02=00000000 R03=00000000
R04=00000000 R05=00000000 R06=00000000 R07=00000000
R08=00000000 R09=00000000 R10=00000000 R11=00000000
R12=00000000 R13=ffffffe0 R14=fffffff9 R15=00000000
XPSR=40000003 -Z-- A handler
FPSCR: 00000000
Aborted (core dumped)

This is confusing.

(same happens with emcraft-sf2, microbit, musca-*)

Regards,

Phil.

