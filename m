Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F877C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1618120863
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1618120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44209 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTSBv-00066I-B9
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 10:26:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTSAI-00056a-OP
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTSAH-00075W-OO
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:24:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hTSAH-0006yW-He
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:24:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so2428598wmk.4
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 07:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=JQHA9m7Hq5lUeiEqZ76DSrC9jbzemfxPph3gN3cimlY=;
	b=G3vr9HPakDxvotMYy9u459nHcOUZPkoHgvUyR+lC/G6hK03B4+cGSetZUPlEW43rOH
	jhTBa4kSnqZc3Qpf4mYijjQfs/M6VXDQ9eiuzAhWMHJIb5QMD6LKc/Ux6SLNWkd1ImNC
	a4lFfWZmwWdQopLELLDuFCUTi9wQhcCY85M6JFOUo7+1sJH2EIrpo2OkPBUTd9T98Qy7
	DhDH65/P1xz2wLOdtqtz9k9V/6BEs5zsrJIcb0mJCKosLWa4u7cJpab7jCdMTDW2hOAm
	E/ZA6xgkhAEMuso+e8eBP410YCzLFqaII1ezxtZmy10xVqHv6QPVHK1TRcJkW6I1L596
	vQmA==
X-Gm-Message-State: APjAAAU7CK3UbWpsW8N21V1R45GUH9OC6ULoMzAuSwB79dkOeyqnLsaZ
	F1Ex0fs3hd5Bq2hA6D0y28GQ6A==
X-Google-Smtp-Source: APXvYqyl0yotFzi7lUvtas2xLps3eHJggc5jAseJGFom4A5amXGe5FEAPnqHs7PRQ5ePIfC0XE9InA==
X-Received: by 2002:a1c:ce:: with SMTP id 197mr7834954wma.48.1558535060570;
	Wed, 22 May 2019 07:24:20 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id m17sm8054684wmc.6.2019.05.22.07.24.19
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 07:24:20 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190422195020.1494-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <139be15d-4063-5e42-0840-37ae022e2b68@redhat.com>
Date: Wed, 22 May 2019 16:24:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422195020.1494-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v3 0/7] fw_cfg: Improve tracing
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Laszlo Ersek <lersek@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/19 9:50 PM, Philippe Mathieu-Daudé wrote:
> Trivial series to improve fw_cfg tracing.
> 
> Regards,
> 
> Phil.
> 
> Since v2: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02522.html
> - Split arch-specific code (1 patch per arch) (requested by Laszlo)
> 
> Since v1: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01598.html
> - Added arch-specific keys
> 
> Philippe Mathieu-Daudé (7):
>   hw/nvram/fw_cfg: Add trace events
>   hw/nvram/fw_cfg: Add fw_cfg_arch_key_name()
>   hw/i386: Extract fw_cfg definitions to local "fw_cfg.h"
>   hw/i386: Implement fw_cfg_arch_key_name()
>   hw/ppc: Implement fw_cfg_arch_key_name()
>   hw/sparc: Implement fw_cfg_arch_key_name()
>   hw/sparc64: Implement fw_cfg_arch_key_name()

Queued, fixing the typo reported by Laszlo, documenting the PPC uses.

