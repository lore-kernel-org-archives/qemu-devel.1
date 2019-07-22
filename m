Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3C5C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAB87214C6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB87214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60375 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpVrB-0007iR-2M
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 06:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38590)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hpVqz-0007HW-2a
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hpVqx-0003Dr-VX
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:47:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54613)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hpVqx-0003Ck-PN
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:47:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so34631982wme.4
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 03:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=krefzyTfc6K8Du0u612V9fpyYpCQbPMpB44pGU/3HcQ=;
 b=fEawCx4CiKgkCcU2SafAQfViM4I92snJNnVuocAeLlwhFTSwFkUGUeo9yERw5Bo/gR
 scRD3st/Gf6klQ27uTuo1PBXKLWgfGvil4S2IZ0QPEQg9QdgmaL4GL2/ZNebTJ3hj1ZQ
 1yoVNy6wiZkq38QO3sPolEaz/5jjuMK/VY6yCbsfG0lYnGWRIN31pJ/Y4PUeipiU9pDN
 +NyNZvU8wWmCJthLvyCMuRHS3ARhTIiKsusWem+92GFKHhKwbPaEkC6KvSQ3DRhSRLx4
 z+yOirrAUTTKeEQ4YX0VWRM3774E+0tCulFkUNPyWAN9x3k7dySYYHQRQTGiM7xC0A7/
 zAmQ==
X-Gm-Message-State: APjAAAWy1wPkDJUKmSljQ3njl2KR2/0PTxiX7vuXbidp+/Oa6484PDN+
 X6UoCnKx+5xo0jl8emIWZNiqpw==
X-Google-Smtp-Source: APXvYqyKwV0HS4MYMKug+lAS5jADYn0d+k1qNUmj7WLm/jONYHYmt9YM5yMtzqm3MQtM5Jyd1jEmog==
X-Received: by 2002:a1c:a7ca:: with SMTP id
 q193mr67441417wme.150.1563792454045; 
 Mon, 22 Jul 2019 03:47:34 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id u18sm32183387wmd.19.2019.07.22.03.47.33
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 03:47:33 -0700 (PDT)
To: qemu-devel@nongnu.org, no-reply@patchew.org, alxndr@bu.edu,
 stefanha@redhat.com
References: <156358440084.15703.2910927682706007476@c4a48874b076>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <187cb20d-e6ee-4598-b2d7-db97eb2db1ec@redhat.com>
Date: Mon, 22 Jul 2019 12:47:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156358440084.15703.2910927682706007476@c4a48874b076>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 0/2] Avoid sending zero-size packets
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
Cc: pbonzini@redhat.com, bsd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/19 3:00 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190719185158.20316-1-alxndr@bu.edu/
> 
> PASS 18 test-bdrv-drain /bdrv-drain/iothread/drain_all
> =================================================================
> ==8150==ERROR: AddressSanitizer: heap-use-after-free on address 0x6120000306f0 at pc 0x556fc74a74b6 bp 0x7f662dab7680 sp 0x7f662dab7678
> WRITE of size 1 at 0x6120000306f0 thread T11
> PASS 2 ahci-test /x86_64/ahci/pci_spec
> ==8165==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>     #0 0x556fc74a74b5 in aio_notify /tmp/qemu-test/src/util/async.c:351:9
>     #1 0x556fc74a90eb in qemu_bh_schedule /tmp/qemu-test/src/util/async.c:167:9
>     #2 0x556fc74ac2f0 in aio_co_schedule /tmp/qemu-test/src/util/async.c:464:5
> ---
>   Right alloca redzone:    cb
>   Shadow gap:              cc

Stefan, another hit.

> ==8150==ABORTING
> ERROR - too few tests run (expected 39, got 18)
> make: *** [/tmp/qemu-test/src/tests/Makefile.include:904: check-unit] Error 1
> make: *** Waiting for unfinished jobs....
> 
> The full log is available at
> http://patchew.org/logs/20190719185158.20316-1-alxndr@bu.edu/testing.asan/?type=message.

