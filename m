Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C1EC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 05:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCBEE207D3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 05:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDNGXeOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBEE207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKEcG-0003L2-LC
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 01:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKEbd-0002uO-Bf
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 01:43:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKEbZ-0006SZ-Rk
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 01:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600666991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NFitjjwCubQkdC/d5pPpMUn1adD/EfgK0bfxpSzq0Vc=;
 b=RDNGXeOnkSgb/pidHC1W6yHZPNbgWoc4nmqnkCC3p7fCS/kGghoEywcBwj+psWMd5Lw38B
 8+46b67mrIruSwk/fyQRQLB9PDbFImwkbbDiWZdSSBsLRweboFfB6nlXk7Pj61nFlsM3PY
 bTm9967fEek8XudBmBi8PMCbpg56r2A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-pi_t8kqFNAytcDkENWETpA-1; Mon, 21 Sep 2020 01:43:09 -0400
X-MC-Unique: pi_t8kqFNAytcDkENWETpA-1
Received: by mail-wr1-f69.google.com with SMTP id r16so5381675wrm.18
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 22:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=NFitjjwCubQkdC/d5pPpMUn1adD/EfgK0bfxpSzq0Vc=;
 b=kQMrAPT8rL5gSYRQyQaaclyqL/sGSqb7pcjCA7S8GrOdJnUlR4q01Ke1dZDS78s+jd
 pe40XPk0C7Ze/kqA4EImA+qiztrrmXAyog7r4vOz9HEidFIir/W0UTIn3Ww7/QyiNFdQ
 V++kD5Q3NiAvuIcCqhjK+cWmgYU5vtegDssRqQUkgNE4PIzUpKF8lhwLMTUuqlxKhJp+
 Jq3THBg8O1Nq+DjQfZhpPKecU9pFBsMM5TEAW+YUkLYIlIVjzG37/1EKEpCVU0Ems1QV
 6SgVc1EbxH5+zfDAnmW9D2pcXYLkYqiv40nRJDkKPK0cwbFJGFKMG95oXyFmbhmVRnZ0
 eW4g==
X-Gm-Message-State: AOAM532GyTPjNsXZVCMw809PzbjfwxZoiVFDIoeuA4gNTmN4OSWO0tSB
 CwohaUTXxqAPx1VTc7a9LGHuJPFz4uvO0wU0NRPqxcs/rrcCcrYNrGimPMrRtpOF++W6wKJQBWV
 Nj1IZf6/ZThL6uJc=
X-Received: by 2002:a5d:67c2:: with SMTP id n2mr48199195wrw.4.1600666988045;
 Sun, 20 Sep 2020 22:43:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAJ9qAo6sQ9xvdGY4vCTpSnKcTPgGvU+w9gsEFq0xQ1N4shpIJWtgC9ZMuC+OfckI8bzrVUA==
X-Received: by 2002:a5d:67c2:: with SMTP id n2mr48199158wrw.4.1600666987534;
 Sun, 20 Sep 2020 22:43:07 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id w81sm17860113wmg.47.2020.09.20.22.43.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 22:43:06 -0700 (PDT)
Subject: Re: [PATCH v3 02/16] fuzz: Add general virtual-device fuzzer
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-3-alxndr@bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <63ca7622-557b-4217-f15e-ee9b024fbd77@redhat.com>
Date: Mon, 21 Sep 2020 07:43:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921022506.873303-3-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alexander,

On 9/21/20 4:24 AM, Alexander Bulekov wrote:
> This is a generic fuzzer designed to fuzz a virtual device's
> MemoryRegions, as long as they exist within the Memory or Port IO (if it
> exists) AddressSpaces. The fuzzer's input is interpreted into a sequence
> of qtest commands (outb, readw, etc). The interpreted commands are
> separated by a magic seaparator, which should be easy for the fuzzer to
> guess. Without ASan, the separator can be specified as a "dictionary
> value" using the -dict argument (see libFuzzer documentation).
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/qtest/fuzz/general_fuzz.c | 498 ++++++++++++++++++++++++++++++++
>  tests/qtest/fuzz/meson.build    |   1 +
>  2 files changed, 499 insertions(+)
>  create mode 100644 tests/qtest/fuzz/general_fuzz.c
> 
> diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
> new file mode 100644
> index 0000000000..bf75b215ca
> --- /dev/null
> +++ b/tests/qtest/fuzz/general_fuzz.c
> @@ -0,0 +1,498 @@
> +/*
> + * General Virtual-Device Fuzzing Target
> + *
> + * Copyright Red Hat Inc., 2020
> + *
> + * Authors:
> + *  Alexander Bulekov   <alxndr@bu.edu>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include <wordexp.h>
> +
> +#include "hw/core/cpu.h"
> +#include "tests/qtest/libqos/libqtest.h"
> +#include "fuzz.h"
> +#include "fork_fuzz.h"
> +#include "exec/address-spaces.h"
> +#include "string.h"
> +#include "exec/memory.h"
> +#include "exec/ramblock.h"
> +#include "exec/address-spaces.h"
> +#include "hw/qdev-core.h"
> +
> +/*
> + * SEPARATOR is used to separate "operations" in the fuzz input
> + */
> +#define SEPARATOR "FUZZ"

Why use a separator when all pkt sizes are known?

Can you fuzz writing "FUZZ" in memory? Like:
OP_WRITE(0x100000, "UsingLibFUZZerString")?

> +
> +enum cmds {
> +    OP_IN,
> +    OP_OUT,
> +    OP_READ,
> +    OP_WRITE,
> +    OP_CLOCK_STEP,
> +};
> +
> +#define DEFAULT_TIMEOUT_US 100000
> +#define USEC_IN_SEC 100000000

Are you sure this definition is correct?

> +
> +typedef struct {
> +    ram_addr_t addr;
> +    ram_addr_t size; /* The number of bytes until the end of the I/O region */
> +} address_range;
> +
> +static useconds_t timeout = 100000;
[...]


