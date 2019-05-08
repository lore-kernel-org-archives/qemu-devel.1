Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3255C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9643820989
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9643820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60385 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOGCt-0004PU-T9
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 02:37:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOG3w-0005BQ-Ns
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOG3u-0005uD-TW
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:28:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOG3t-0005si-1F
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:28:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id v11so5412854wru.5
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 23:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=FZ/YcSmceG5eupg6mz8E9DdxhsG64yMRDq5Hqx7nnDc=;
	b=h01M6561sM3kPQg5oiy7sqcQBgDgIX8YfvBPWjQeZIzPUawN6qbGhx61uwhg+zSi+T
	fsOwg3yl9mColLsrNNOopzrflhLZcVDGKS/MzDFuzTCc3younx8fzbYzt4h36RSMfQQ8
	Ar9+f5Wrt0iWnzKSLUlW+23yw6f68iKbUxetbKf3/tKJOiHyDvfHs1SNOigo/49vdd7s
	AsO9h97aaWW2+1FhOY5sQZngvHbDSjad0lNjRGc27RHOjZZOJkZ1WncGZ9aKztsLhLwS
	kAnyengXMBU1IBWx2O+/A1TJcE4MnIWv6nUH3fLyTN0R7TLgfSe1S2d5AfwEBCufRI9b
	RuiA==
X-Gm-Message-State: APjAAAU/0d8Ec+89n+wxji63sUgfr53Vsgb2QNS+hzCC7nHulXfPED1m
	ZodVvjpdAiqnDkcdEAAjsIeH/EtelhA=
X-Google-Smtp-Source: APXvYqz6ay5AeXUp0qLlGpKUe0Tr5zK9N1njFa/2RQa068aUMM6I+GA0EntErNB947EJhGwqc81V4Q==
X-Received: by 2002:adf:9221:: with SMTP id 30mr1536632wrj.110.1557296895248; 
	Tue, 07 May 2019 23:28:15 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id c6sm1547812wmb.21.2019.05.07.23.28.14
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 23:28:14 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <704c26cd-0412-bb23-9a75-74c285e677d1@redhat.com>
Date: Wed, 8 May 2019 08:28:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508000641.19090-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v3 11/39] target/cris: Reindent op_helper.c
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

On 5/8/19 2:06 AM, Richard Henderson wrote:
> Fix all of the coding style errors in this file at once.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/cris/op_helper.c | 817 +++++++++++++++++++---------------------
>  1 file changed, 398 insertions(+), 419 deletions(-)

Reviewed using 'git diff --ignore-all-space --word-diff=color'.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

