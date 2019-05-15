Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A4CC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F02C2084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IY0S9XQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F02C2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40414 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQxvt-00045z-67
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 13:43:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQxtl-0002ON-9l
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQxhY-0003vA-9p
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:28:26 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQxhW-0003nf-Nt
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:28:24 -0400
Received: by mail-pg1-x544.google.com with SMTP id i21so101279pgi.12
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 10:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=LNUFner0cgMCagOe9Y0n8QtTSyevgLhqV3YyFHotP9k=;
	b=IY0S9XQO63g9KMhzK+V58EZ9R6K7MPGefzmB8anFWBfryyE7NKXRjpiI8VsbwFClSZ
	4h6IaPdlHRH4Efzj6AKbNKUcCq2GNxrMxMHZ+vkDatEKceSkISu91WaWFMilsRR5cqFU
	Z9pgc50uSZwE3uB3XcXSJuruYiI7XwpgruHAj1RnVyvGFd9Er56rRJQxY1nBiId/jE9B
	D7HwM8dp9nCLUa3o0sH4uFk0X9Ocwk3laQrKZaVzWaNywV1FUtTf7mWtoYYU/s4JVQEd
	ZYgEopTV/rC8Mqzup0N58nk06kLLUAEBvNUzE4gqA6wqAyrB3SyqYLF0aKfDEdGlOx4j
	SeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=LNUFner0cgMCagOe9Y0n8QtTSyevgLhqV3YyFHotP9k=;
	b=XVjn10o+aGTDFpTP9GhyWPCSWTCKTXU+DDRmaCGKz8H37f1/u0cl/iKJxiCCRTllz0
	NbpydY56PYj9vYcUVz3md6PUnlXWMQU+7QkaHaEHTCxdoADbSdpnhvC32IrNG4uwIRf5
	Br/+C/ihsvDdv8xtuxBD3eQvZTPj35rXpCND7f39gaTBIb/HPwFgC/ZdTGXyvydze0ZJ
	KJljY8QX64q1T2bmTosmGDfTZ5M49Ckzh9CS9X+Lxuk/Mx4TRt+j/7KyCle+PN0X3dNw
	Vt52eBdXUd+rENqHdZEQPZOuAahzfbaqxtLv4SgCS7m4+5zZP5xpGD9u1+SYYIZUO56Z
	9HGA==
X-Gm-Message-State: APjAAAWQN4WWLPAhxHt+Rfrn5a659rQ6PW5F4Luktu2GXKHJRyffUVO4
	nG9zK91AY3zVcTnLts0OqvL/mw==
X-Google-Smtp-Source: APXvYqyQiYn0l9hH/g+92hEah1dSgOD6qTDKG7vslO9SJVbjnyAfWyqmkoBYoR0aAEoWS8uNx5/7XQ==
X-Received: by 2002:a62:520b:: with SMTP id g11mr46888194pfb.215.1557941300652;
	Wed, 15 May 2019 10:28:20 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	s77sm7123930pfa.63.2019.05.15.10.28.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 May 2019 10:28:19 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-2-armbru@redhat.com>
	<2679829b-cc1d-83ce-9949-2b80d970ddec@redhat.com>
	<875zqe7b10.fsf@dusky.pond.sub.org>
	<CAFEAcA-vqnucYKuV3QKf4wBsfuXMZiC1kqrnaVcA+BEaud__Bw@mail.gmail.com>
	<877eat6xgm.fsf@dusky.pond.sub.org>
	<e562c5f5-9d01-59b0-5a4c-d040fa8b8962@redhat.com>
	<87lfz88bva.fsf@dusky.pond.sub.org> <20190515102615.GB4751@redhat.com>
	<87a7fn6a5v.fsf@dusky.pond.sub.org> <87zhnn1wtg.fsf@dusky.pond.sub.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b0909f1e-64ad-7595-a922-f83f01e9332c@linaro.org>
Date: Wed, 15 May 2019 10:28:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87zhnn1wtg.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-bridge-helper: Fix misuse of
 isspace()
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/19 9:55 AM, Markus Armbruster wrote:
> Proposal:
> 
> 1. Add qemu-bridge-helper.c to Jason's "Network device backends"
> 
> 2. Deprecate -netdev tap parameter "helper"
> 
> 3. Improve documentation of -netdev bridge
> 
> 4. Create a manual page for qemu-bridge-helper that also covers
>    /etc/qemu/bridge.conf.
> 
> 5. Fix the nutty error handling in parse_acl_file()

LGTM.  Thanks!


r~

