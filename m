Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4561CC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1845622BEF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1845622BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqbpz-0005mP-94
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48076)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqbpp-0005OB-BE
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqbpo-0001oW-GV
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:22:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqbpo-0001o0-9P
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:22:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so44370384wme.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 04:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oZsNnsvAODwlHBRRfmMNBjVhgtU045UHyoZAlh8lCq8=;
 b=HXsvhKyUVzPwHOCrvPL3ZNBXPJK4F4f0E88pjwZdjN5gBwPsyIgEkniMI4omHBIcg5
 9PDEKosSbMZ5IllZ+p2HHFA8e3wIF38+QN/gZHx2ea5hvM0Dk7l8H/60uTndie7/IDAO
 WKEAy2kbkjkCr36o/AtLHhqcMo2fv4PbIo0f1i//8gXVngh0bjIBbRD4+y5MR+ZBvcEq
 40t/Kt+f0UlunQFQ8tWb1pwVyW9JsswPtGjF+Lfhw1pamkmpg1+egaH2XuJON7lNrMz7
 09z0mDt6yXoHpS/gNdMFeL5xED5cS2hpEQYkCwOSptZ3ZqCCLX1FtunRlBWlIAFOoS7P
 5U4Q==
X-Gm-Message-State: APjAAAURunPG4Wdt/16OWb2VEyRvI2gOd8kipClDzZPjwsjPBdkcWBCg
 6El+vtlu3E6bt2Xrq450/WEwQQ==
X-Google-Smtp-Source: APXvYqz/o8lwwN9iMttawh4vwd7Rm3+WCzcxF6XChAIxVCDkHvno4T7pDtrYuwwtVZqc6eh+7ddwVw==
X-Received: by 2002:a7b:c106:: with SMTP id w6mr83639997wmi.80.1564053774668; 
 Thu, 25 Jul 2019 04:22:54 -0700 (PDT)
Received: from [192.168.1.37] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id t1sm59251442wra.74.2019.07.25.04.22.53
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 04:22:54 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190725101836.1273-1-pbonzini@redhat.com>
 <CAFEAcA-ta49Qe29zoSzW52OWXYHf+c5t+X3t27Qc3n=harDT=Q@mail.gmail.com>
 <821f0761-a159-3cab-7608-ff09705ee4c1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <08e92514-c78a-da87-5ae9-d0da78d5013f@redhat.com>
Date: Thu, 25 Jul 2019 13:22:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <821f0761-a159-3cab-7608-ff09705ee4c1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] 9p: simplify source file selection
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 12:29 PM, Paolo Bonzini wrote:
> On 25/07/19 12:21, Peter Maydell wrote:
>
>> Patch definitely looks like a good idea, though -- those
>> nested land/lor calls are pretty ugly :-)
> 
> Yeah, FWIW this patch came out of Meson conversion, where the sourceset
> mechanism supports "and", "nand" and "or" very well but has issues with
> "nor".  While I'm open to adding "nor" if it is really needed, it seems
> to me that in general we should not transpose our Make mess to Meson,
> and rely on Kconfig as the better tool for this kind of job.

Agreed, good idea.

