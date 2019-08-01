Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3D7C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0026420B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0026420B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htDre-0000QP-93
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 12:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52357)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1htDmm-00068l-8C
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1htDmk-0003cr-G9
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:18:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33232)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1htDmk-0003bc-A5
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:18:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so74343691wru.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 09:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zbVGYeJTpiD2V2lSOOlCUUtZa8Gr4A8te7FhbkYlKws=;
 b=UEfso/qHgVn/q69cqIcCpq/xCsyYQkgIfbkBAQA0hthJx8Rd1Fs/0UTPtYhVtNRVgn
 f00E1uF4sqbObEm2U+sHvFROfLq9sDZtdvrEnz0xW5MDkvC6fv0cICg2zD7PcuEl067o
 jTMa1aRgEfJOUhpI9JwQ3rdzf3V7xC+pnfWSHPlX0PZ1eQAElf4N4J7YCQBkvjnCG+UK
 AWtipDKYWinA0nGgDv6VVNXGjawq+tU9iCwPUyuRUXDvkl2itnYAzk4ML6JIQ+x0xDGV
 B9sUuS6buS6oOLGkMzTs1vuP6yrIlbcOnOgozx3dxiz4HysDWibvc6Hn9dq0a/ySvXfH
 2bVg==
X-Gm-Message-State: APjAAAXXRaJlmH3aU7npT7HSxbX2sugxxGouLKMkh0CTO3mE1i5xe+E9
 a/q6hA8GC85+spps9fUV9/OAbA==
X-Google-Smtp-Source: APXvYqzFiA453irCmPsLrzU9CSz4bzDnJQu5Z6/Rtqy1rhhR4GtkmZqmNS+HuPfDQE1EVlHDS3147A==
X-Received: by 2002:adf:f042:: with SMTP id t2mr8160861wro.139.1564676311586; 
 Thu, 01 Aug 2019 09:18:31 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-57-175.dynamicip.rima-tde.net.
 [83.57.175.46])
 by smtp.gmail.com with ESMTPSA id b2sm94346246wrp.72.2019.08.01.09.18.30
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 09:18:31 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1564514832-29482-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8f13328e-cc0a-5bd9-9a66-ca1b239b1099@redhat.com>
Date: Thu, 1 Aug 2019 18:18:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564514832-29482-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH for 4.2 v4 0/6] target/mips: Misc patches
 for 4.2
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
Cc: arikalo@wavecomp.com, sw@weilnetz.de, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 7/30/19 9:27 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> This series includes misc MIPS patches intended to be integrated after
> 4.1 release.
> 
> Yongbok Kim (4):
>   target/mips: Add support for DSPRAM
>   target/mips: Amend CP0 WatchHi register implementation
>   target/mips: Implement Global Invalidate TLB instruction
>   target/mips: Add emulation of CRC32 instructions

I'm interested in reviewing Yongbok's work but I won't have time before
next week.

Regards,

Phil.

