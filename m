Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41ABC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 837EB217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837EB217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38544 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCKsf-0005lB-NQ
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 05:11:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKrV-0004xb-Bv
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKrU-0003j3-IE
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:10:13 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:45838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCKrT-0003av-Mu
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:10:12 -0400
Received: by mail-wr1-f48.google.com with SMTP id s15so7012789wra.12
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 02:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=HkhuQwX2V5/lz6fSjvcBWDhZxibpAaLsjWYqfsu8MCQ=;
	b=dMzvoWwmEYH9X+XqQJK1zdScJmFdHpo/mhTV40IzfyQrh2qMPz7lCHfjHNIo5zsVIV
	FcxRMHiOvGSr6Itk3Nf40AYysumPVbmzr7aCJlCWQsfJkQfGOJmN7VPn6x/T3J+DVWlN
	appqITwkY6s5Qx7AWw5gmEtSHlXgQhpf7VCiMfl+r1NgjGaEoSX7CqTnKgsm1Fu0d+Tf
	fSYNlIJZEo7lCi7BYwjBWsBV8BfUxGzmbpSZtvdazztvOn8CSBnl7KhxjB4cJIa3PWF0
	kTCz/mVGa9LEMMtDVQK9t7g3T8IUqLelFX9Q07pTbSFi8m400dkYWUTqhiIY/4VPt+eb
	OnJw==
X-Gm-Message-State: APjAAAVJl1qj21r2jFMj4+Rm8vQtVHSqz7Js9o5o10YsZByadJOVshuq
	hx/FUbekJrUQHucHgBw8gKNDYsLO7wY=
X-Google-Smtp-Source: APXvYqxu/Gkv/bPlMHDY6DvrZOmisBS4FCqZw5VgQRkrmayJnW81InErThuwae87G+5dyBt9pLB+AA==
X-Received: by 2002:adf:fa47:: with SMTP id y7mr7951315wrr.27.1554455410314;
	Fri, 05 Apr 2019 02:10:10 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	g10sm14705379wrq.2.2019.04.05.02.10.09
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 02:10:09 -0700 (PDT)
To: Helge Deller <deller@gmx.de>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
	<berrange@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
	<20190405082613.GC6105@redhat.com>
	<457ec791-3691-2ebb-e225-bd42a7aee627@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5792aea8-c510-9f18-2d64-49a7f24f90e6@redhat.com>
Date: Fri, 5 Apr 2019 11:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <457ec791-3691-2ebb-e225-bd42a7aee627@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.48
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405091008.vpv6AR8C38e-5u_MgR4uNiBL0oycYWJ0724BTYrCZPE@z>

Cc'ing qemu-block.

On 4/5/19 11:02 AM, Helge Deller wrote:
[...]
> As another example, even if I only want to build "qemu-img", I still need
> to manually give the --enable-tcg-interpreter configure option.

You found a bug :)

