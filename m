Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BC5C06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 12:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0512064A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 12:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0512064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj0pi-0007jH-Pr
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 08:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40359)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hj0oZ-0006ro-Vh
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hj0oY-0001bv-Uj
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:26:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36913)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hj0oY-0001ay-Nd
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:26:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so5960287wme.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 05:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QQwRpMMrJfYO8143GKfLP5w/nwUehuI9LxF7b29DHDY=;
 b=UWgY7qjXk/GTtNKPCcTI+onBeV9jbf9hXixxTIhmObm0htUxAy8ucKmxHuINdcH5zx
 dFlekVGa4AO1j+SQavvme0mEAAN6vUBKTr3Ll9LYdGRjSx9D1wUbwDWLNh5ocaWxqUAT
 JBIHaedl96hBzpEqGbFwlgsfV0HS9EPIhHUTXclLUXARM0O1Efy+FuhzGAVIt+w8olAS
 uLc1RWOU8yMG06j7cGAmxSkkKXTkST2u4kKApPwxuf3bgSIZT46O1AT77GMjGi4HOgsV
 Z3jJiLt14M50wchxqW/SyEZhHyLNupo6HMDf3qpwn4J94a147doDkHhFHsgt4z3xcFLO
 yyvQ==
X-Gm-Message-State: APjAAAW8+s3L+xYpbajQMpcg2rCfzSFuETJXxABlDJUC0fhKn8trcmC1
 OldJMWe1fTXuNQMO17NTr2vEsw==
X-Google-Smtp-Source: APXvYqxmm1Y+I7Obxqups7a9aS9879BbMBBjJAIjJiFdKS552LjBLmu1et3ZJ5GmTKKMQO0rJoYWYQ==
X-Received: by 2002:a1c:4b1a:: with SMTP id y26mr12416906wma.105.1562243173584; 
 Thu, 04 Jul 2019 05:26:13 -0700 (PDT)
Received: from [10.201.49.68] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id p11sm6289374wrm.53.2019.07.04.05.26.10
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2019 05:26:10 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190704055150.4899-1-clg@kaod.org>
 <cd1f8a48-27cb-5cc5-1fd2-46f1597a7094@redhat.com>
 <20190704101345.GC1609@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b304e4bd-1315-b1be-6c48-add99df92626@redhat.com>
Date: Thu, 4 Jul 2019 14:26:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190704101345.GC1609@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH for 4.1] aspeed/timer: Provide
 back-pressure information for short periods
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/07/19 12:13, Stefan Hajnoczi wrote:
> On Thu, Jul 04, 2019 at 11:26:53AM +0200, Philippe Mathieu-Daudé wrote:
>> CC'ing Stefan & Paolo for a non-ARM view on this...
> 
> I'm not familiar with the various clock smoothing techniques implemented
> in QEMU and KVM, but this looks okay given that Linux guests expect
> this.

Yeah, even KVM applies a minimum period of 200us to the x86 LAPIC timer.

Paolo


