Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A614EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6974120721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnsgbvpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6974120721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcYv-0000Og-HW
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVcWI-0004IL-Cp
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:56:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42646
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVcWH-0002Wu-Ee
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588604192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJAiAsvoGCHz9xCOtRIS3F1MysjDE4O427NaTIwdIw8=;
 b=bnsgbvpBSTCP42mm/g4NIwjfkJPE50grxkwsnrDOM5mPSXXKvZNg5W5F1yNZTsOuZLpWQ3
 wCtIqvl/vJuvvl2qjdsf61BZwpXsUx4B/7CJ7gyRytLQWS586QPnEuGPpRP5gjCKSnGADP
 NRHn7qOqInFPt0FoaeQV5hnpcWaLEE8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-nBqhBjMdP_qUnyYPd_qS9g-1; Mon, 04 May 2020 10:56:30 -0400
X-MC-Unique: nBqhBjMdP_qUnyYPd_qS9g-1
Received: by mail-wr1-f72.google.com with SMTP id f2so10936744wrm.9
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qI4QuUX9YolojNCMjfbELEyRtoJnZzLw5njjpjDvl0s=;
 b=Cw3kXVHuO5FxwvJPB3aBwFJzzLz2Nmu6RarmApEjzujjWGVYQrwzkccCEm7xXEpng+
 7xi1Fbta1g7u/NlSEbzJVxNQ65K27zAW1SPTNa+fqg+8gbVReh7u4O3h0u9vDge4QEEc
 P8jQBq60/7oeqAi+f4Ato1Ls9BEe16KjuNOlUMuBYQFGH6lEtvLRKK7gWvtE4UF2fFWI
 hInV1mq8UMBB9Myv6TEvi1NplVjLTUWkWhSHMic8OX3MVA7TvQLpJS3ouKTujolgL+5U
 Evh6V7fGhVBKKgwW0HlDAR4WUCsErk7YK3YMDvehD2DKaHR5SHgRGCAf5i36cnvBb8GU
 Hvug==
X-Gm-Message-State: AGi0PubxFqEhW2LFAU0RORkkPAMcjmjOA+dbL8tlW52QJa4F1Za5yZM4
 aNb1gPRpRgRkfySJB4eRZPQV7fRnpoJqbxHpaaK0iul8IMva7ivXzgacbYQGP0448ILrQv+DmmL
 IPcS53Xzm2mQkW1o=
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr14900817wmd.67.1588604188908; 
 Mon, 04 May 2020 07:56:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypIZdKtGsd9OR1NIJ0fjdRZC91Oz5bH9yaCk3SH3mVCHMoHo/CcSGhGcaf2h0bKwyRACrOmAmw==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr14900807wmd.67.1588604188766; 
 Mon, 04 May 2020 07:56:28 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id a9sm13279613wmm.38.2020.05.04.07.56.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 07:56:28 -0700 (PDT)
Subject: Re: [PATCH 2/4] coroutine: Add check for SafeStack in sigalstack
To: Daniele Buono <dbuono@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
 <20200429194420.21147-3-dbuono@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0e65715a-127f-7a4f-ce32-aed5599ef6b5@redhat.com>
Date: Mon, 4 May 2020 16:56:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429194420.21147-3-dbuono@linux.vnet.ibm.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tobin Feldman-Fitzthum <tobin@ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 9:44 PM, Daniele Buono wrote:
> LLVM's SafeStack instrumentation cannot be used inside signal handlers
> that make use of sigaltstack().
> Since coroutine-sigaltstack relies on sigaltstack(), it is not
> compatible with SafeStack. The resulting binary is incorrect, with
> different coroutines sharing the same unsafe stack and producing
> undefined behavior at runtime.
> To avoid this, we add a check in coroutine-sigaltstack that throws a
> preprocessor #error and interrupt the compilation if SafeStack is
> enabled.
>=20
> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
> ---
>   util/coroutine-sigaltstack.c | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/util/coroutine-sigaltstack.c b/util/coroutine-sigaltstack.c
> index f6fc49a0e5..b7cdc959f8 100644
> --- a/util/coroutine-sigaltstack.c
> +++ b/util/coroutine-sigaltstack.c
> @@ -30,6 +30,10 @@
>   #include "qemu-common.h"
>   #include "qemu/coroutine_int.h"
>  =20
> +#ifdef CONFIG_SAFESTACK
> +#error "SafeStack does not work with sigaltstack's implementation"
> +#endif
> +
>   typedef struct {
>       Coroutine base;
>       void *stack;
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


