Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13097C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A9A24485
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A9A24485
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY26F-0003vw-MD
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 01:35:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY24w-0003C8-Bs
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY24v-0004kq-EF
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:33:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hY24v-0004kA-8M
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:33:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id f204so9393092wme.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 22:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=+ydj4qIWMlLK6gRZbKJ3ShQwKsXV7ozQQVj9eJlS6C8=;
	b=nnnmfBmwWt1RIifc5z3mLGcncasPFL1bt0wwZpGaGUV9KCdTPu6RzrCes7qlyyLkT6
	X8LxdDi1LPhrtvdFh2cClLaL3+pmz+gPRawet0Mn7CiLUxjO3Ro4panBD+IjWJbH0D0b
	SdIf6/DcHUHaBk7jbesi45CvEdacNSFNKVay6bHOm4BGClD1cd+a/ywBO48Lfo48SizN
	BKHe5ADdfjoI1dS7aNBcyB2KrJ2TdOd/pKrioa/GR1k8bU2VO87+8y5GIWwKypVgOxV3
	xUpQvtlo2Ve0rY+tGj45EANi2gjnty4wtSTpX+mIb7fZfk1M6OXEhqUwPf47EDNf4qQL
	xX/Q==
X-Gm-Message-State: APjAAAXV1VPGbcip09I6taGbCNdx7yNLwiYjVhqNrrK5zKgN6f4EtGgE
	XIKIq+0riovYrkh7k+4dC5Pt0Q==
X-Google-Smtp-Source: APXvYqz7siM8r3qvWMxl7O+s+us+HfCTlmqhBJnfddeFHdnoSCMvcQpW1M4UrM2q9zEpofOEjCc2wQ==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr16751478wmg.48.1559626424103; 
	Mon, 03 Jun 2019 22:33:44 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	l8sm12228231wrw.56.2019.06.03.22.33.42
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 22:33:43 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190531134315.4109-1-richard.henderson@linaro.org>
	<20190531134315.4109-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <518c80ec-c0b9-6305-ca5b-e5a35131f043@redhat.com>
Date: Tue, 4 Jun 2019 07:33:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531134315.4109-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v16 14/23] tests: Add rx to
 machine-none-test.c
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 3:43 PM, Richard Henderson wrote:
> Fixes check-qtest-rx: tests/machine-none-test.
> 
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/machine-none-test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
> index 4c6d470798..80df277357 100644
> --- a/tests/machine-none-test.c
> +++ b/tests/machine-none-test.c
> @@ -56,6 +56,7 @@ static struct arch2cpu cpus_map[] = {
>      { "hppa", "hppa" },
>      { "riscv64", "rv64gcsu-v1.10.0" },
>      { "riscv32", "rv32gcsu-v1.9.1" },
> +    { "rx", "rx62n" },
>  };
>  
>  static const char *get_cpu_model_by_arch(const char *arch)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

