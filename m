Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622C8C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 06:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D779C20731
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 06:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5nHgZp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D779C20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGz1d-0006UX-Ox
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 02:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGyzS-0004J9-22
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 02:26:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44065
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGyzQ-0004Uf-1o
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 02:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599891983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yEeFWyQ9AVeILtZK455MB3sTX4qF6dQXvlJ3OKqF2YU=;
 b=Z5nHgZp64HesMFYAoKCt+hUIp/WUjCQd+N3HWRvIH3qfILPFGFtLOL5iH2HE++7/VehGGP
 yUUg8RzzMMr6TRwe/lpxRuvAIq9nAbTmChXqYbsrnO3JSrdcLkFcw0hcQv+andulAXpt6i
 /m0vypjzzjpcwlsHpLmIgtshNCgsF8U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-BD5aigPkPgmYztP1HtqLJw-1; Sat, 12 Sep 2020 02:26:21 -0400
X-MC-Unique: BD5aigPkPgmYztP1HtqLJw-1
Received: by mail-wm1-f71.google.com with SMTP id d22so2297030wmd.6
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 23:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yEeFWyQ9AVeILtZK455MB3sTX4qF6dQXvlJ3OKqF2YU=;
 b=ClWHzF3x9nt94ke7fYTM7bOTavLz1g3CHE8AvsM/5jVC/vWoAAHY5C8VeElhI/JLkj
 erHTV53lA8mFnghowo/KJxjP5VO5XgwOreuzkCy9USk4Orzug1fFIdUzbDR00Pkdghi2
 YsJVmQ3kUlI6XiH6uQtYpcosaLQY7hVG21mI7F5hl3jAnJ0nJi1heI11e9wc0Qd9MtSC
 Yij7AzFj/eoWoqPJ5EUqnP+KBp3R35Xag7/3RAN6z7qSDXAoCeuP9zI01XdD7oZ6onA5
 U8eR2ti7SxYs1pt0Rl0RfH0J/F857ZM6X/t1YeMJzC25j9+p3F+6Tk+NgrDaKFuduF0Z
 9U/Q==
X-Gm-Message-State: AOAM532xuhzuHVUuwFuURKyD9bfWvKvFnxji4EvmLEpC2TwC7KnMKO8p
 m5C2sPJ5DnnmIKyzYqvtwVOZMOkqldAP6rPxGIq6VwP2+5amXOq3LXtORzvJurzew7UpqXJHWpm
 MGOGoEtt3qzqDbws=
X-Received: by 2002:a5d:4cc1:: with SMTP id c1mr5437439wrt.122.1599891979931; 
 Fri, 11 Sep 2020 23:26:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoxT2tT+vwAkCsV3eq58P4KSEXjvy43+JNih+RGslho12F6ARU4hMmvvNSg2GI3GCXRObP3w==
X-Received: by 2002:a5d:4cc1:: with SMTP id c1mr5437420wrt.122.1599891979763; 
 Fri, 11 Sep 2020 23:26:19 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id a17sm9092335wra.24.2020.09.11.23.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 23:26:19 -0700 (PDT)
Subject: Re: [PATCH v5 0/2] hyperv: vmbus: ACPI various corrections
To: Jon Doron <arilou@gmail.com>, qemu-devel@nongnu.org
References: <20200715084326.678715-1-arilou@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7c78237-6212-ff45-33fd-ba2f5fcc8fdd@redhat.com>
Date: Sat, 12 Sep 2020 08:26:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200715084326.678715-1-arilou@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 02:01:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: rvkagan@yandex-team.ru, imammedo@redhat.com, vkuznets@redhat.com,
 mail@maciej.szmigiero.name
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/07/20 10:43, Jon Doron wrote:
> After doing further tests and looking at the latest HyperV ACPI DSDT.
> Do minor fix to our VMBus ACPI entry.
> 
> v5:
> * Rebased on latest master
> * Added a patch to fix 32bit compliation on VMBus
> 
> v4:
> * Removed the patch which adds _ADR definition to the VMBus
> * Correct the change which moves the VMBus under the SB
> 
> v3:
> Removed accidental change for the dct submodule head
> 
> v2:
> Renamed irq0 to irq now that there is a single IRQ required
> 
> Jon Doron (2):
>   acpi: i386: Move VMBus DSDT entry to SB
>   hw: hyperv: vmbus: Fix 32bit compilation
> 
>  hw/hyperv/vmbus.c    |  3 ++-
>  hw/i386/acpi-build.c | 12 +++++++-----
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 

Queued, thanks.

Paolo


