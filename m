Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE11C04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 08:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 685FA25722
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 08:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685FA25722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59396 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXi6r-0006IS-Fz
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 04:14:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hXi5W-0005dc-Vc
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hXi3k-0003t4-B9
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:11:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hXi3i-0003qO-Eb
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:11:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id d9so11005412wrx.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 01:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=UJY43iiuLGtmLI0s9YlpkwQjhF7g9c5cS45Lq4hmJnE=;
	b=fz39pCav8Gras7FIDiPGxJjVUwoq89Rhxz0j3xmvHDMj9C25v9mmWo0tVDRBJ1zXZ+
	Cw2lI8mJOT1IZSwDxpTUnbI9+7axyUj2Xcv5tVusd/Rez1VxJleBy6UsfqsK3n55HABi
	8GSHJ+QYa2nlABvIqAxnkN1znuYEATvSL6JN8NaSiWCVL7ltnmq4YHOKr7ODP7IBRhbd
	yEoPiXdzXXQJ/Nfs67m6V5jmCvq5Hwzbc3dIUOKdaZaJW4RBKz/gSEax5HqUUZaD6yYL
	bc4dnAcJ9wJSqzXkJz7rBvhrIRzUfAOMTi5xRTH3KWn1X/GcNZOdz43tfW3lZCkXq1dm
	zMgA==
X-Gm-Message-State: APjAAAWdqTljkJyFZwSiAcez4xs8qHIXlJWbrpaWNIPZfhtS1VyDSgpy
	pvnD94yzowccvUtSsit3aB2/Uw==
X-Google-Smtp-Source: APXvYqzIkWSBt3a3x6Fd7cci1WOIE6fuJsWd8C/7qzTELH7Ug5siCZKyCvPNoEHd/5y4drNPwQg3PQ==
X-Received: by 2002:a5d:6207:: with SMTP id y7mr1434687wru.265.1559549469219; 
	Mon, 03 Jun 2019 01:11:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d43d:6da3:9364:a775?
	([2001:b07:6468:f312:d43d:6da3:9364:a775])
	by smtp.gmail.com with ESMTPSA id w6sm3410528wro.71.2019.06.03.01.11.08
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 01:11:08 -0700 (PDT)
To: Miroslav Rezanina <mrezanin@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190531154735.20809-1-philmd@redhat.com>
	<CAFEAcA9TJGq-8fMv2amQEEGz9QKCNWYwJxCXrjqSh=Yc87yTww@mail.gmail.com>
	<947e851b-4b95-3126-2eaf-d5d16f8b831b@redhat.com>
	<431872249.25606899.1559321648368.JavaMail.zimbra@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a3cbd83c-a942-25f4-d424-bbbc0013acec@redhat.com>
Date: Mon, 3 Jun 2019 10:11:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <431872249.25606899.1559321648368.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] target: Build with
 CONFIG_SEMIHOSTING disabled
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
	Samuel Ortiz <sameo@linux.intel.com>,
	Rob Bradford <robert.bradford@intel.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/05/19 18:54, Miroslav Rezanina wrote:
> What about CONFIG_ARM_VIRT - can we use it to introduce dependency on
> CONFIG_SEMIHOSTING or is there valid scenario of qemu build with CONFIG_ARM_VIRT
> enabled and CONFIG_SEMIHOSTING disabled?

If you are not really going to use TCG, disabling SEMIHOSTING makes sense.

I think Philippe's patch are the right way to do it.

Perhaps CONFIG_SEMIHOSTING should be made "default y" and added as
"#CONFIG_SEMIHOSTING=n" to default-configs/, but that's just cosmetic.

Paolo

