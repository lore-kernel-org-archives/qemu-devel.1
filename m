Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DD0C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 16:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5773A20B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 16:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5773A20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39656 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIbXI-00082u-9M
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 12:11:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIbWE-0007NP-Ka
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIbWD-0001kC-Jh
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:10:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIbW8-0001df-51
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:10:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so15029146wmd.0
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 09:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=3THODaa0vWmcdw/YPeQUnakH1+YNAMsfYa7pPE2zNN8=;
	b=iZRC69D3vePsAaEzV0sSLl2oXi+Dq+d8wbH47rdXXp8uOzVnyVATKAR+Bql+5S3yN6
	WffrmgVK3/IhWEm2EfQyVha/ZaNi2+Gr0cgQdPXNUrJmyezOf0+UfjlIU6BWyGSzp2Ma
	oFmwaGBjD8wK7/T2qFDeG1sKZVq6bjGbmEk87PxBzqF//4OHc1Rp1XXOmKgoVwSi0vlE
	vq7sAGM2rzlVUnEdK4SNON+oL9nZ62a4wpsaW4Tz9GDVKTeEiKgF01AVeJVC2TzS7ztZ
	egmV2iH0dt/Fdz1oRaSMT9o8mG5GJepIB1N0Bt943O+7iR1D4mMKNqecFlNl9lIwpUeV
	rMFA==
X-Gm-Message-State: APjAAAXCvoSnOzMjJNLY/+rXYX/w2eTvek9Asi8GZdtIjs0VebXREQoZ
	CPuZcIaFcex3K5mxwJTxdZrU7ZhiGsFZMA==
X-Google-Smtp-Source: APXvYqzZc/nqFRN8dS9bik62sP3vLWPwDVz6RFpm3DB5Z4ex00Az5cICFEK2SP/x8JppgWTTqLzk3g==
X-Received: by 2002:a1c:14:: with SMTP id 20mr13492931wma.66.1555949396698;
	Mon, 22 Apr 2019 09:09:56 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	z10sm11198908wmi.15.2019.04.22.09.09.55
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 Apr 2019 09:09:56 -0700 (PDT)
To: Chen Zhang <tgfbeta@me.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
References: <087F1D9C-109D-41D1-BE2C-CE5D840C981B@me.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8a9008f1-34f7-ecb8-9ccb-c129f56236ec@redhat.com>
Date: Mon, 22 Apr 2019 18:09:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <087F1D9C-109D-41D1-BE2C-CE5D840C981B@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] hvf: Add missing break statement
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422160955.gIOThUjYGKpE_4LF7o2zUUnnwVclN5Xl_dj1i-aOdqs@z>

On 4/22/19 5:42 AM, Chen Zhang via Qemu-devel wrote:
> In target/i386/hvf/hvf.c, a break statement was probably missing in `hvf_vcpu_exec()`, in handling EXIT_REASON_HLT.
> 
> These lines seemed to be equivalent to `kvm_handle_halt()`.
> 

Fixes: c97d6d2cdf97

> Signed-off-by: Chen Zhang <tgfbeta@me.com>
> ---
>  target/i386/hvf/hvf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 42f9447303..2751c8125c 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -708,6 +708,7 @@ int hvf_vcpu_exec(CPUState *cpu)
>                  !(idtvec_info & VMCS_IDT_VEC_VALID)) {
>                  cpu->halted = 1;
>                  ret = EXCP_HLT;
> +                break;

Oops... I'm surprised no compiler warned about this yet...

This probably mean:
- This code is not covered by Continuous Integration
- Upstream maintainers are not building this code
- Upstream is not running this code

Please tell me I'm wrong!

Meanwhile:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>              }
>              ret = EXCP_INTERRUPT;
>              break;
> 

