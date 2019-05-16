Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F316C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 11:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D174A2070D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 11:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D174A2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52114 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRE9s-0003os-1O
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 07:02:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hRE8z-0003VC-5I
	for qemu-devel@nongnu.org; Thu, 16 May 2019 07:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hRE8y-0002uL-37
	for qemu-devel@nongnu.org; Thu, 16 May 2019 07:01:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hRE8x-0002qU-S6
	for qemu-devel@nongnu.org; Thu, 16 May 2019 07:01:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id t5so1651443wmh.3
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 04:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=TsY7QTJOtCc+BxBvNXl4oredYNBn+PUw5zscj0+qkeg=;
	b=HWPVMzOxzNei59RJRDPe9o8xBsmTM34DMsxHn0k6728OGueL8MRgczLKGnXzQIwvZK
	mZp11d9iTulWeknMjrrvw7HBikyKSEAz4Nb/8l3kSLtGtB61EpOKKt/L75s1l1dXfo+w
	sVYux+/Yzv4ncWve8R62yfla4CCbVeRr/4YHXCeo8wBJAXNa6Wa0cOto4VlE4IYz0Qcd
	U182rgKNnu7ue0dp63UCrsmQbwJSsVBUU3xTTIx7muW6OIgxZHxeyj1ea7bOM+Dz2eow
	6ALehSjjIDbHd+ayEJ8wmIyJbF3q5VsgTTQH5pwr5rxIuTF9v5tzFYRJ8sVGLyWZsZsI
	/KWg==
X-Gm-Message-State: APjAAAXuoqFaYH4oLiyiV+dUxKpzmafXHawFtLh6rb2l80vcXow8hybC
	JhduFPcVDp77NxoT5sHUiss9z/eX2UAw1Vc4yHpz1A==
X-Google-Smtp-Source: APXvYqwKxL04NZKOeQ68lWbQw1fDOkfJ+z17k0iLftcFKekM3GpXz+5iFbgfnGIO8iOkWBMfkPGWfsx/8L9FNBeq6oQ=
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr20936116wmk.56.1558004502491; 
	Thu, 16 May 2019 04:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190419003053.8260-1-richardw.yang@linux.intel.com>
	<20190419003053.8260-7-richardw.yang@linux.intel.com>
	<20190514211015-mutt-send-email-mst@kernel.org>
	<d9d265e1-1052-9d8d-c749-5d1e5901f567@redhat.com>
	<20190516074110.GA11938@richard>
In-Reply-To: <20190516074110.GA11938@richard>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 16 May 2019 13:01:31 +0200
Message-ID: <CAP+75-XHpLkekrmSxK8FFGkpPJQH=V0+2d6RonQTyJNcSHGaEg@mail.gmail.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v4 6/6] acpi: pci: use build_append_foo()
 API to construct MCFG
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
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 16, 2019 at 9:41 AM Wei Yang <richardw.yang@linux.intel.com> wr=
ote:
>
> On Wed, May 15, 2019 at 07:29:17AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> >
> >Thanks Michael for testing...
> >
> >Wei, can you add a MCFG test in tests/bios-tables-test.c?
> >
>
> I took a look into the test, current q35 has already has a reference MCFG=
 in
> tests/data/acpi/q35/MCFG.
>
> And there would be a warning message when reserved[8] is missed.
>
>     /x86_64/acpi/q35/bridge: acpi-test: Warning! MCFG mismatch.
>
> Is this enough? Or what more information prefer to add?

Well, the test has to fail for any mismatch (not a simple warning).

A mismatch failure seems to be enough IMHO.

> >>> -    AcpiMcfgAllocation allocation[0];
> >>> -} QEMU_PACKED;
> >>> -typedef struct AcpiTableMcfg AcpiTableMcfg;
> >>> -
> >>>  /*
> >>>   * TCPA Description Table
> >>>   *
> >>> --
> >>> 2.19.1
>
> --
> Wei Yang
> Help you, Help me

