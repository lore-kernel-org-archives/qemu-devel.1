Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E2BC43218
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 14:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66617208C2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 14:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66617208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32904 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKObj-0007Gc-KQ
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 10:47:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKOZk-0005dm-NK
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKOYN-0000uN-Np
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:43:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKOYM-0000lA-3M
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:43:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id a9so8649456wrp.6
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 07:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=myvxdpIz6Bf/uHazotd12k+Gu63g/6u5sqwMkEzhSBY=;
	b=amJEIEQQtG6sqp5++htrRFtckR2Fj01kelLlRrD7ectf/nw2xHD/tuYgZPQMoSRb9i
	VjxthkevANPbML/lc2IUd/rRVlQ++8vQzXdgrRF/cnW0j1yWKzAjR4wphBZ0GCk1/6Pg
	C+QGNCxC+nvQjD437f9tyXv9aCo1MolY3/txT3Veg8ZSwMW2axyZ+SiKh8UVtd3Gy7je
	Z2xDqHlgDX2pFKnUXtlRDi69czBOnMnKbznFcRICgyZ7gl5Nn/buc7XV4Z++7onEWddE
	iLW5QckXzftAhDOQpp7dq/U82UPtJG/ec2Aj895FEEb9pHek4kuEZ38dOqLpkWc89Nog
	6WcA==
X-Gm-Message-State: APjAAAXuPmehAD+TUB3f8FdNx8Uret+GwY5DXpB2S9ycXW27/T/FWeOD
	KUlvtwrDfHSV/hMbInJoIvmE7A==
X-Google-Smtp-Source: APXvYqylhb8woQIKj5mvF/g9lqF1ZoXKl4cW7i00YEPc6x01JU9Mt2y7bYRmcU4/Gf53bZbW/8Sieg==
X-Received: by 2002:adf:ce0b:: with SMTP id p11mr30468380wrn.196.1556376221111;
	Sat, 27 Apr 2019 07:43:41 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	u189sm38011370wme.25.2019.04.27.07.43.40
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sat, 27 Apr 2019 07:43:40 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190427144025.22880-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6e3003f3-3d96-c1be-6890-baa2c61d34dc@redhat.com>
Date: Sat, 27 Apr 2019 16:43:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190427144025.22880-1-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 0/3] hw/i386/acpi: Improve build modularity
 (isapc/q35/...)
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
Cc: Yang Zhong <yang.zhong@intel.com>, Thomas Huth <thuth@redhat.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427144339.2lVtzQULMl8lNdcfYxdtNqzUBXQtaFYm686QDGgkjFM@z>

On 4/27/19 4:40 PM, Philippe Mathieu-Daudé wrote:
> This series allow to build the ISAPC/Q35 machines independently.

Oops I guess I forgot:
Based-on: 20190427141905.20393-1-philmd@redhat.com
(i440fx is not a machine)
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04673.html

> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (3):
>   hw/acpi/piix4: Move TYPE_PIIX4_PM to a public header
>   hw/i386/acpi: Add object_resolve_type_unambiguous to improve
>     modularity
>   hw/i386/acpi: Assert a pointer is not null BEFORE using it
> 
>  hw/acpi/piix4.c         | 13 -------------
>  hw/i386/acpi-build.c    | 22 +++++++++++++++++-----
>  hw/isa/lpc_ich9.c       | 11 -----------
>  include/hw/acpi/piix4.h |  2 +-
>  include/hw/i386/ich9.h  |  2 --
>  5 files changed, 18 insertions(+), 32 deletions(-)
> 

