Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AC1C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 17:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26F5205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 17:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26F5205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40056 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGRqL-0004uu-PN
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 13:26:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hGRpZ-0004W3-QL
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hGRpY-0007jX-Q3
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:25:13 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:33666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hGRpY-0007hx-GA
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:25:12 -0400
Received: by mail-wr1-f42.google.com with SMTP id q1so28236751wrp.0
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 10:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ctpGN4ABDiNMebAvgp/JwumB24sB3n2gJMJCBkr7d64=;
	b=a5sLtSj8iULrUcaVt1Fewi9doKeKooebAsdHBTwmLJzV2CdZxnIu6sT4Gqpd9dTRBS
	igb3myllASEhs+Y8JnMXEveSXTcsdIraztQAlfyXkT2bE8OC+6Z3YMhok1idj7Ap4CLN
	Z8Gij7CILMjeeMq8JIg5Q0mK35h2B8CU6YE1BuILoBaxO46Pj7SCkL7sf4EC46L46hLu
	kCdkaR43msnDZncs6MLqN8zmshgzb8Cy0G9Om09P3kqsKVRaHMaEN6Err5gBWP2TYnFu
	rxSsZDU1EegFmH1RpQ9G01QEfKAyTxk5d1q7QGH2VLyAPQ6aH3sOL7b55be+PCk1APFv
	l+qg==
X-Gm-Message-State: APjAAAVwScVlnh0WCqdMeA60Yd2iGz3knpb56+Xo6C+VvqPaVM9PkZDi
	XzJ3TsNmsE+rqBwZoDGbQCrtlQ==
X-Google-Smtp-Source: APXvYqy8Ch1l43rAzGjAvZqHtHG2z8szMIosPOr2NQD2tATK72u2E3xnUQf8vPq7zJTRRJOiK39wkg==
X-Received: by 2002:adf:e74f:: with SMTP id c15mr3833833wrn.23.1555435510702; 
	Tue, 16 Apr 2019 10:25:10 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	7sm182391755wrc.81.2019.04.16.10.25.09
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 10:25:10 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190416083150.19649-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e16e0501-fe91-9cf6-efd8-eb5696fb26fb@redhat.com>
Date: Tue, 16 Apr 2019 19:25:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416083150.19649-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.42
Subject: Re: [Qemu-devel] [PATCH 0/2] tcg: Fix launchpad 1824853
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
Cc: peter.maydell@linaro.org, 1824853@bugs.launchpad.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416172509.wFo7MIASQymgfmO2WqSqgDpMF1ETPHHdub3bNeNLnYU@z>

On 4/16/19 10:31 AM, Richard Henderson wrote:
> This is a case where we generate more than 64k code for a mere 231
> guest instructions.  This hits some assertions within TCG that we're
> not overflowing the uint16_t that we use for representing our
> unwind info.
> 
> Fix this by returning an error indication, rather than asserting.
> This lets us try again from tb_gen_code with a lower max_insns.
> 
> This should resolve the problem for x86 as a host.  There are other
> failure modes wrt out-of-range relocations that might affect the
> RISC hosts.  I'm going to leave those for a different patch set.

Very clean way to solve this. Nice cleanup in patch #1 (interesting
Nios2 case), Simple fix in patch #2. It would be fun to trigger the
assert(max_insns > 1) =)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Richard Henderson (2):
>   tcg: Hoist max_insns computation to tb_gen_code
>   tcg: Restart after TB code generation overflow
> 
>  include/exec/exec-all.h       |  4 +--
>  include/exec/translator.h     |  3 +-
>  accel/tcg/translate-all.c     | 54 +++++++++++++++++++++++++++++------
>  accel/tcg/translator.c        | 15 ++--------
>  target/alpha/translate.c      |  4 +--
>  target/arm/translate.c        |  4 +--
>  target/cris/translate.c       | 10 +------
>  target/hppa/translate.c       |  5 ++--
>  target/i386/translate.c       |  4 +--
>  target/lm32/translate.c       | 10 +------
>  target/m68k/translate.c       |  4 +--
>  target/microblaze/translate.c | 10 +------
>  target/mips/translate.c       |  4 +--
>  target/moxie/translate.c      | 11 ++-----
>  target/nios2/translate.c      | 14 ++-------
>  target/openrisc/translate.c   |  4 +--
>  target/ppc/translate.c        |  4 +--
>  target/riscv/translate.c      |  4 +--
>  target/s390x/translate.c      |  4 +--
>  target/sh4/translate.c        |  4 +--
>  target/sparc/translate.c      |  4 +--
>  target/tilegx/translate.c     | 12 +-------
>  target/tricore/translate.c    | 16 ++---------
>  target/unicore32/translate.c  | 10 +------
>  target/xtensa/translate.c     |  4 +--
>  tcg/tcg.c                     |  4 +++
>  26 files changed, 93 insertions(+), 133 deletions(-)
> 

