Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2E7C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B252087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B252087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46619 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRakw-0001Pc-3i
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 07:10:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRaA3-0001c8-K0
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRaA2-00039d-D3
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:32:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRaA2-00038a-5u
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:32:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id y3so6447127wmm.2
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 03:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=dz4geg7a/h3tNwmHON1BqrdrORqh70EUe9jtwjNR0x4=;
	b=iFTXcwp4yn9j24MggkrML5dQYAkOp/kEKR/dczpycd2jSLtrok11l/O1YSBooUr8Fo
	DEj9pg/I9gjHOnP1ES6VyFlyvvJBsvVoJvb4HG2up7rkLTkn4ljBpHgXd0KdnE8oZMlY
	kNvUJZ/yNyByow+lV8Q/4D4/hwywyplJ7But8qcA5NSv/5J+nhxjf6xelbMVjJk2RnAC
	MucsGKKy+48OETwJcgwbfzhDQlBpRnRJcqi//Uc4lIcKjh9b9xQwKIgvbHum/GLnzCjm
	/ysbczfl93tVocIIEteG579LjECW488J1mJJlqp7Fwkoi8G+KSjuC9c8MkN3XIu0e1J3
	1nzA==
X-Gm-Message-State: APjAAAWP+VsxcJcqcmd2dhm48uKkMjKuWf59PQqOj4BOTIWUDHervpJX
	qyckfUZ5fB9b1LroGhj1IhbwKw==
X-Google-Smtp-Source: APXvYqzkp59ae/lRqeariaiC63dgDPTPX8nDwwweywt/hKz+vUTRsArKyDZ8ey/77egjgjUi3zYQJA==
X-Received: by 2002:a1c:9c42:: with SMTP id f63mr1773551wme.23.1558089141116; 
	Fri, 17 May 2019 03:32:21 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	q16sm8567530wmj.17.2019.05.17.03.32.19
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 03:32:20 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
References: <20190507163416.24647-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <cfd72da5-720a-0684-f3c5-e0ea1360bef3@redhat.com>
Date: Fri, 17 May 2019 12:32:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507163416.24647-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 00/16] hw: Use object_initialize_child
 for correct reference counting
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
	"Michael S. Tsirkin" <mst@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Paul Burton <pburton@wavecomp.com>, Andrew Jeffery <andrew@aj.id.au>,
	Alistair Francis <alistair@alistair23.me>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Joel Stanley <joel@jms.id.au>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-arm@nongnu.org,
	Peter Chubb <peter.chubb@nicta.com.au>,
	=?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Aurelien Jarno <aurelien@aurel32.net>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eduardo,

On 5/7/19 6:34 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This series looks at Eduardo suggestions from [1]
> and Thomas commit aff39be0ed97 to replace various
> object_initialize + qdev_set_parent_bus calls by
> sysbus_init_child_obj().

Do you think you can take this series?
Else, via which tree it should go?

Thanks!

Phil.

> 
> Important comment from Eduardo:
> 
>   It's possible, but we need a volunteer to review each
>   hunk because the existing code might be (correctly)
>   calling object_unref() (either immediately or when
>   parent is finalized).
> 
> I tried to split it enough to make the review process
> easier.
> 
> Regards,
> 
> Phil.
> 
> [*] https://patchwork.ozlabs.org/patch/943333/#1953608
> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg05931.html
> 
> Philippe Mathieu-Daudé (16):
>   hw/ppc/pnv: Use object_initialize_child for correct reference counting
>   hw/misc/macio: Use object_initialize_child for correct ref. counting
>   hw/virtio: Use object_initialize_child for correct reference counting
>   hw/arm/bcm2835: Use TYPE_PL011 instead of hardcoded string
>   hw/arm/bcm2835: Use object_initialize() on PL011State
>   hw/arm/bcm2835: Use object_initialize_child for correct ref. counting
>   hw/arm/aspeed: Use object_initialize_child for correct ref. counting
>   hw/arm: Use object_initialize_child for correct reference counting
>   hw/mips: Use object_initialize() on MIPSCPSState
>   hw/mips: Use object_initialize_child for correct reference counting
>   hw/microblaze/zynqmp: Move the IPI state into the PMUSoC state
>   hw/microblaze/zynqmp: Let the SoC manage the IPI devices
>   hw/microblaze/zynqmp: Use object_initialize_child for correct ref.
>     counting
>   hw/microblaze/zynqmp: Use object_initialize_child for correct ref.
>     counting
>   hw/arm/mps2: Use object_initialize_child for correct reference
>     counting
>   hw/intc/nvic: Use object_initialize_child for correct reference
>     counting

