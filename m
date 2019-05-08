Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE9CC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84EB208C3
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84EB208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40148 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOPSe-0000Vb-4x
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 12:30:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOPRm-0008Us-Kz
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOPRk-0004lO-SE
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:29:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOPRk-0004l2-Cj
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:29:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so2790156wrs.11
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 09:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=PXRRbqGY8iAEwchgmbad1wrs6XK5QE6UUUOJS0v6w+0=;
	b=Zr+cVgrHaoRD67BdntQ1XMlX9z20hDK3LXDatbrK+ZGrU3mTnff+itr9vhLAB3kZIA
	u3YqbLEkgaKhOCWsSJgVWjBArTx+js0K+sQro9fAQIvHhkSdJ6aLXXO1F3kwjm6m5nff
	BU1rd5kN/Jk+rFqAh7iNafTZuFTe/nX6GRnVaO3LgSMJIsmMYdwTePrzlvBkSzdb1zaA
	MGCCoeIi6gUse0nzfTc8OBLQFwsuWGyw9hHjqR4BVIyQ6IxngUB0wwDOBpFri6pjVfkn
	zj90GUlagnv6wj7L56/Mnc4xAV5772gqTFYQEgSb/nCPHQqW4u4A6gNLPrwCndgNx24D
	2fOw==
X-Gm-Message-State: APjAAAX6deGnhQ1XmNsSyWKdlAKQEsJGhQwgJfCad0YegPBsHyALk5HN
	O5LT08TVQQT2pRD3AVsgzwB96Q==
X-Google-Smtp-Source: APXvYqyiGO2EZ0dJliCouWpOlgF68bJv5huplexvuqAC1FX7Q19mnMVmD3jyekunlUR1jonmlmEy9A==
X-Received: by 2002:a5d:5108:: with SMTP id s8mr9729992wrt.99.1557332971349;
	Wed, 08 May 2019 09:29:31 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id u9sm3342131wmd.14.2019.05.08.09.29.30
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 09:29:30 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190508145611.107133-1-ysato@users.sourceforge.jp>
	<20190508145611.107133-2-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a6e0032c-883f-1b00-f15b-3cb2dc8120c5@redhat.com>
Date: Wed, 8 May 2019 18:29:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508145611.107133-2-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v10 01/13] target/rx: TCG translation
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/19 4:55 PM, Yoshinori Sato wrote:
> This part only supported RXv1 instructions.
> Instruction manual.
> https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01us0032ej0120_rxsm.pdf
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  target/rx/translate.c  | 2432 ++++++++++++++++++++++++++++++++++++++++++++++++
>  target/rx/insns.decode |  617 ++++++++++++
>  2 files changed, 3049 insertions(+)
>  create mode 100644 target/rx/translate.c
>  create mode 100644 target/rx/insns.decode

I got this error (haven't look at it):

qemu/target/rx/translate.c: In function 'trans_XCHG_mr':
qemu/target/rx/translate.c:744:5: error: 'addr' may be used
uninitialized in this function [-Werror=maybe-uninitialized]
     tcg_gen_atomic_xchg_i32(cpu_regs[a->rd], addr, cpu_regs[a->rd],
     ^
cc1: all warnings being treated as errors
qemu/rules.mak:69: recipe for target 'target/rx/translate.o' failed


