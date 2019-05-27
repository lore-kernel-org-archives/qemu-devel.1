Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB3AC072B1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 18:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA96520815
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 18:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA96520815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49428 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVKbf-0005xl-7w
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 14:44:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVKal-0005cr-SI
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVKal-0000MW-2Q
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:43:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hVKak-0000LW-Tf
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:43:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id d17so344549wmb.3
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 11:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=UP8WzIlgEk5m8Eo7I18QMvjlHTepqvVJMK3l9mKAlxE=;
	b=ZdP+OoyfawaS1nXmsAQoA3JDGrD/Rcc686UVxx1PDGYRX8/u7iO7TTCpR34L83PdMy
	G0NeKP4xPtzAbMFswoGHBOAv+7fX4SDHmfygjsXbHYhi1JOh4kFxi1tPitMHRgvSeBNW
	ASuQ12ZOKxnexg1K55eVnWaitEy7jCBQ6kvYbfbzOAJbqmLctRQBgmkoI6TIAepXpRir
	CtYNBvg6a7hBeCcALJslx7BL7B1OMc5RTELXUqRl0AZMr/vTwXciCADIT6UDadEReV64
	nNBfctT2l7bYGkDwg3cUvOtnxCCC6XAD//wO88Ho3E7nUe6N5eEXnQI6DFtBo6J0kKVI
	XnKQ==
X-Gm-Message-State: APjAAAXeymGqMIqex6chuC90z/Bq5Z5kq3/SelG1gg1hab32S6C+HYzK
	xynoENSpXZjhPFNGaYjkHkHZKw==
X-Google-Smtp-Source: APXvYqyd8imGissdHN2PdZ5FBwfsWlDqnTMHMb2FwfB3joOeExc/k7MOmmKgk/A+0qMlKZU9/j/+lg==
X-Received: by 2002:a7b:c844:: with SMTP id c4mr287182wml.108.1558982605727;
	Mon, 27 May 2019 11:43:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c92d:f9e8:f150:3553?
	([2001:b07:6468:f312:c92d:f9e8:f150:3553])
	by smtp.gmail.com with ESMTPSA id x22sm511301wmi.4.2019.05.27.11.43.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 11:43:25 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190427141459.19728-1-philmd@redhat.com>
	<dadba93d-fdf3-25b8-b3e2-5b43a4618292@redhat.com>
	<CAP+75-UKFxtHrfzAF4G=YD6XDGcDVyvTeHdzYTvOD4vecT0feA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <08f3e1f4-8a4b-2115-d042-965a6978ea3e@redhat.com>
Date: Mon, 27 May 2019 20:43:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAP+75-UKFxtHrfzAF4G=YD6XDGcDVyvTeHdzYTvOD4vecT0feA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 0/3] hw/microblaze: Kconfig cleanup
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/05/19 18:10, Philippe Mathieu-Daudé wrote:
>>>
>> Queued, thanks.
> I don't see these patches in your queue merged on "Fri 17 May", are
> you planning to include them in your next batch?

Yes, thanks.

Paolo

