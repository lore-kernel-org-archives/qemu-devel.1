Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2F0C04AA7
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 05:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA1A20862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 05:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA1A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59980 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQmjA-0007OY-W3
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 01:45:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQmiP-0006u3-6k
	for qemu-devel@nongnu.org; Wed, 15 May 2019 01:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQmiN-0005S8-6M
	for qemu-devel@nongnu.org; Wed, 15 May 2019 01:44:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQmiM-0005Mf-VR
	for qemu-devel@nongnu.org; Wed, 15 May 2019 01:44:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id h11so1104506wmb.5
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 22:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ufWX82v8bZFc3Q9l5cvg7f2gG6sa/mwWv/p2Vf2bwU0=;
	b=AmpIUvVbWsTZdOq2TADtSrCZJKnPzb5nOpcu6v+/Qvuz+fST1PNNMKTmQlQchiNn3W
	JgXXMJioXb6mvOlR6pmb7VAJ9M1GvjXSumSP0KoUk2ZytF+RJrJGzSDY7SwFYQfvihYh
	tmcfESghrC0Ej3lhFqeYYWanp3PthyguqMehXYxONqPTSnOzJQN5l26od9Iqi9SEHGoC
	Hf++PfJwXY7zP0NvVepu3TORDniCsVmReWMlN78tG0glUOLSnlvkMNgjwql1eQZ8di8v
	4gtglwPsCmKmfQd66yNkGAmC8g3b6L3mgIUQa2IAnTxtl9eFlGhP3qo/e7VPyMPDrOq6
	x2bg==
X-Gm-Message-State: APjAAAUPvd4qk7HSvMS77YO+GGnUGKe5DbLZFHxWZ3HOvcCjvUv4mPR6
	anZFqIxsV4t0jmp8j7ppAxDHzw==
X-Google-Smtp-Source: APXvYqxfEhQWO8CUNGYTY8q9X4GXbpsd9nC9GYVWSe9AO3YAjiqCbWqv2ZTMp/IW2Rs+Qex01+WtDw==
X-Received: by 2002:a1c:4909:: with SMTP id w9mr22600268wma.17.1557899068985; 
	Tue, 14 May 2019 22:44:28 -0700 (PDT)
Received: from [192.168.1.43] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id e8sm2322191wrc.34.2019.05.14.22.44.28
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 22:44:28 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190510032710.23910-1-richard.henderson@linaro.org>
	<20190510032710.23910-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <492ec7a8-b5bf-b873-8ed2-2a1faf0968b4@redhat.com>
Date: Wed, 15 May 2019 07:44:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510032710.23910-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 3/8] target/sparc: Define an enumeration
 for accessing env->regwptr
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

On 5/10/19 5:27 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/sparc/cpu.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 85b9665ccc..08f7d1a3c6 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -31,6 +31,39 @@
>  
>  /*#define EXCP_INTERRUPT 0x100*/
>  
> +/* Windowed register indexes.  */
> +enum {
> +    WREG_O0,
> +    WREG_O1,
> +    WREG_O2,
> +    WREG_O3,
> +    WREG_O4,
> +    WREG_O5,
> +    WREG_O6,
> +    WREG_O7,
> +
> +    WREG_L0,
> +    WREG_L1,
> +    WREG_L2,
> +    WREG_L3,
> +    WREG_L4,
> +    WREG_L5,
> +    WREG_L6,
> +    WREG_L7,
> +
> +    WREG_I0,
> +    WREG_I1,
> +    WREG_I2,
> +    WREG_I3,
> +    WREG_I4,
> +    WREG_I5,
> +    WREG_I6,
> +    WREG_I7,

I'd feel safer if you initialize those enums (better safe than sorry!).

> +
> +    WREG_SP = WREG_O6,
> +    WREG_FP = WREG_I6,
> +};
> +
>  /* trap definitions */
>  #ifndef TARGET_SPARC64
>  #define TT_TFAULT   0x01
> 

