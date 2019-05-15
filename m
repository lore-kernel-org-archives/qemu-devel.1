Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0091BC04AA7
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 06:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA6D2084E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 06:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA6D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60522 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQnkH-0002on-3H
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 02:50:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQniI-0001Dk-Ob
	for qemu-devel@nongnu.org; Wed, 15 May 2019 02:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQng1-0002lM-NZ
	for qemu-devel@nongnu.org; Wed, 15 May 2019 02:46:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQng1-0002j7-Hf
	for qemu-devel@nongnu.org; Wed, 15 May 2019 02:46:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so1341894wml.4
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 23:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=hO9hy0hk2KtmErCifJJO9cqw0c8hz6D7TCf4zsvJgdI=;
	b=X7xsa76cs9tTq7A2lfuyi/NwXMpoVItsGb//mPSYX0H4W6onHUe+VVIOzr8IN+5wsG
	zuo4PDn5oV/tT1a6tzQaqZ5mKq2qQwMuUdNnXphCQAVcxELd/Jv7goeXS76SkSPtpzS3
	3hWRxVgGbtLPkXBBM1Najqs5U/202f62+vFPnZ5Do48vC/nu+ppPzw11PPNVByWxW/KW
	fEp6qULOp81vDkgeZktH8O6iKVFaScnycWH/ClEHhuxCpjesmS0zyJBELDUxbLzzcWVD
	6v/C4jhZRsL2h+3zq2ygFqy541BrB3Ask2nZmXIdibiiY1YpPhA6vmPO1gGJ/YiJxh2M
	RnIQ==
X-Gm-Message-State: APjAAAWcUKCL1be/uL1wLOrx44j9Iz2aUuQnhx3GaqAWq/sX4E9cuyv1
	Fs6jQrLjlli0UdyuILhXlMEjDBS0jag=
X-Google-Smtp-Source: APXvYqwiGevrr3Ja2yuLnY9t7vMsKpWSDwLETuGwU+cE6yInFouy4yudB2ZaMUQAy+aNIvaO2xMpRw==
X-Received: by 2002:a1c:ed12:: with SMTP id l18mr23390382wmh.13.1557902768347; 
	Tue, 14 May 2019 23:46:08 -0700 (PDT)
Received: from [192.168.1.43] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	u125sm2198739wme.15.2019.05.14.23.46.07
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 23:46:07 -0700 (PDT)
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20190514204447.17486-1-jcmvbkbc@gmail.com>
	<20190514204447.17486-8-jcmvbkbc@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8293f332-446d-1ff7-7c69-8043568e96de@redhat.com>
Date: Wed, 15 May 2019 08:46:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514204447.17486-8-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 7/9] target/xtensa: implement block
 prefetch option opcodes
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

On 5/14/19 10:44 PM, Max Filippov wrote:
> Block prefetch option adds a bunch of non-privileged opcodes that may be
> implemented as nops since QEMU doesn't model caches.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/translate.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
> index 24eb70d619d5..356eb9948701 100644
> --- a/target/xtensa/translate.c
> +++ b/target/xtensa/translate.c
> @@ -3078,6 +3078,9 @@ static const XtensaOpcodeOps core_ops[] = {
>          .translate = translate_dcache,
>          .op_flags = XTENSA_OP_PRIVILEGED,
>      }, {
> +        .name = "dhi.b",
> +        .translate = translate_nop,
> +    }, {
>          .name = "dhu",
>          .translate = translate_dcache,
>          .op_flags = XTENSA_OP_PRIVILEGED,
> @@ -3085,9 +3088,15 @@ static const XtensaOpcodeOps core_ops[] = {
>          .name = "dhwb",
>          .translate = translate_dcache,
>      }, {
> +        .name = "dhwb.b",
> +        .translate = translate_nop,
> +    }, {
>          .name = "dhwbi",
>          .translate = translate_dcache,
>      }, {
> +        .name = "dhwbi.b",
> +        .translate = translate_nop,
> +    }, {
>          .name = "dii",
>          .translate = translate_nop,
>          .op_flags = XTENSA_OP_PRIVILEGED,
> @@ -3112,15 +3121,33 @@ static const XtensaOpcodeOps core_ops[] = {
>          .translate = translate_dcache,
>          .op_flags = XTENSA_OP_PRIVILEGED,
>      }, {
> +        .name = "dpfm.b",
> +        .translate = translate_nop,
> +    }, {
> +        .name = "dpfm.bf",
> +        .translate = translate_nop,
> +    }, {
>          .name = "dpfr",
>          .translate = translate_nop,
>      }, {
> +        .name = "dpfr.b",
> +        .translate = translate_nop,
> +    }, {
> +        .name = "dpfr.bf",
> +        .translate = translate_nop,
> +    }, {
>          .name = "dpfro",
>          .translate = translate_nop,
>      }, {
>          .name = "dpfw",
>          .translate = translate_nop,
>      }, {
> +        .name = "dpfw.b",
> +        .translate = translate_nop,
> +    }, {
> +        .name = "dpfw.bf",
> +        .translate = translate_nop,
> +    }, {
>          .name = "dpfwo",
>          .translate = translate_nop,
>      }, {
> @@ -3628,6 +3655,21 @@ static const XtensaOpcodeOps core_ops[] = {
>          .par = (const uint32_t[]){true},
>          .op_flags = XTENSA_OP_PRIVILEGED,
>      }, {
> +        .name = "pfend.a",
> +        .translate = translate_nop,
> +    }, {
> +        .name = "pfend.o",
> +        .translate = translate_nop,
> +    }, {
> +        .name = "pfnxt.f",
> +        .translate = translate_nop,
> +    }, {
> +        .name = "pfwait.a",
> +        .translate = translate_nop,
> +    }, {
> +        .name = "pfwait.o",
> +        .translate = translate_nop,
> +    }, {
>          .name = "pitlb",
>          .translate = translate_ptlb,
>          .par = (const uint32_t[]){false},
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

