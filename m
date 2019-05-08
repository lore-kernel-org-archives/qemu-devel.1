Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EB7C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 03:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E8C214C6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 03:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+bHp8Zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E8C214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58422 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hODjQ-0001Dt-7L
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 23:59:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hODif-0000su-Ol
	for qemu-devel@nongnu.org; Tue, 07 May 2019 23:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hODie-0004XH-TX
	for qemu-devel@nongnu.org; Tue, 07 May 2019 23:58:13 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hODie-0004Wd-Mf
	for qemu-devel@nongnu.org; Tue, 07 May 2019 23:58:12 -0400
Received: by mail-pl1-x641.google.com with SMTP id bi2so9216833plb.13
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 20:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=uvkZYiAJP5QCt+vecVviDJRgVB9vAcGGQjycS9edO/w=;
	b=s+bHp8ZxRVWLdZz5lEQvUtdf3W0Rsirqp7XNT7Yoz/IBZ7qcdRjbnq78Je4uD0bnDs
	JaTwvbJnxM/TJd2dRpquHhzaV51cQFPzYhf4wYHaFMGGK/4Z5OuqD2Ml3rTGp4mDOrgT
	eh0BUe1YqlaaLMNST1DmxZfk0Zx9Nz60Yb71oH4JhJ9Hd856XWRykZEgrSpuereUbitA
	bKXHFkpngtqFnG3uX9Y/07FufBF0gq8IszdX4AqLH2m6+B7yaYXBnpheObegKADlzOmB
	/oHy0hJC8YlZUFEwY93I6Fb/Uf6XcBWRMhRwgkYV/WU5TKwF9bhbT64IpnSOyUGaIq1d
	NvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=uvkZYiAJP5QCt+vecVviDJRgVB9vAcGGQjycS9edO/w=;
	b=L0jbI/fCcsI/DVD9krekxpRsy39E6lddXpydKPNH/rtO/kOksrIGqNmbzTEjar302v
	ak0AGCV1O8bdkk/WrbP/29BOJzsLhqu+lGniXFWGYzBrTMqC9MF/N/OaAuVDkyeCsoG0
	YFFUmMdU3CjoWiMXJQU10chqtKZjPGiwFYGH7vTbjpi+m7iHFIROq6riW2nfEymQedFn
	42mGP9qEXGfOvEyhESoo7HNaHUkyZDee6scy2zFIPyfoWSyBtV6uLXEGWwozynts3MLN
	lPf8ql/PGxhoo40P1AwYrgsBxrrEErf+HkpMljBXvKbyP0FZnsKZ7miZAQWKunX8i/xn
	qFxA==
X-Gm-Message-State: APjAAAWtkrRzMSomHm629JnhxiNaMqwuVm4ft7vri1UgAlpfHyyYizKb
	5SXiKaXrw1ee8PaTz//DZCvNhYfIzkk=
X-Google-Smtp-Source: APXvYqzTc5/Hb/ULL5AwzsGh1V8Hed2vMl9Sc+x9s9ellBCbXUDnWucS8oXVIITY4VMQn/8bFmREuQ==
X-Received: by 2002:a17:902:364:: with SMTP id
	91mr43657470pld.72.1557287889815; 
	Tue, 07 May 2019 20:58:09 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	s21sm19278552pfm.3.2019.05.07.20.58.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 20:58:08 -0700 (PDT)
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20190506173353.32206-1-richard.henderson@linaro.org>
	<20190506173353.32206-3-richard.henderson@linaro.org>
	<5f6eaa15-4a36-37c2-3199-0084178e9cfb@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c692a451-15a0-43b5-4255-37f4bce5cfe3@linaro.org>
Date: Tue, 7 May 2019 20:58:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5f6eaa15-4a36-37c2-3199-0084178e9cfb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v4 02/24] crypto: Merge crypto-obj-y into
 libqemuutil.a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/19 2:03 AM, Laurent Vivier wrote:
> This patch breaks linux-user statically linked build on Fedora.
> 
> Fedora doesn't provide static version of nettle and gcrypt, so the configure
> fails.
> 
> You should update the configure for them like you did for gnutls in PATCH 1.

Which fedora?  I just tried fedora30 and it worked for me...


r~

