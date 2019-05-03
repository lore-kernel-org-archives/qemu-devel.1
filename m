Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A88C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F942081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gdx1QRUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F942081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34720 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMQiU-00073X-Tc
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 01:26:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMQhd-0006fF-2E
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMQhc-0007B0-7x
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:25:45 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMQhc-0007AT-2P
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:25:44 -0400
Received: by mail-pl1-x643.google.com with SMTP id e92so2146602plb.6
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 22:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=cMWf48gKOnpuygEjClebHSb2yIIM6RBJy8edpkAGOfg=;
	b=Gdx1QRUvlYlNvnSCm8aObJaFBkF/q2b6nfQlXgLN95Ig5Yyl0YqYsblBJwxVayPYe7
	TYZr5AywcgvaZHTyTVar/W/4oHLbr4LM6l75Id3diwWfADIOUROmMZ82xCu+mCXJTTZ6
	JxyneMEKEsz2YoqEYutV1HNVwCGhrZwH0CfNfaUhETweEPzLY2HBQ4giZWdYe5XCMwZL
	HyIUwEth7wQ6CsH0BX+E2eDmyIqfnBijxeOeXh8hogykXEDF1pr6UXlx2u84F//g1f5g
	Tupv1IPybAF0a565PfKV38odQn8rxBMou1i4i1BrxoOHhwf55Ut2Hu04K+m3z5kqGQzK
	hWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=cMWf48gKOnpuygEjClebHSb2yIIM6RBJy8edpkAGOfg=;
	b=X79NNU0wHtuM6c3Afm/ghvqXl8Kf1i7rshF1nSLjBytwNLdTax/cQzmKQLINpX0Cu/
	tBnrSUcu2LLBPazBfrA/73o1jwA83qiegGewaohXtTfoPRHPZek0sy+fFnLpYJE3JgXe
	i8rn5cvIgrkwCLNDGTaYzfZ2iB6Wo9kont5TSbi68OqmgMzz7pdpx8QwqNfo4mnsgWGJ
	QVColyOIQtTomjK8Hm8pjnpDioz680aY5wdITGGnZw1nahOUC+5ZZKVwlnD2S50vfIJ7
	6P+u/LMvMRkWbvcVpjPD3Hb3jFr4Kh7FCFTc900xrVDiiPHcjsedcPrj2u7TYAuq/qrW
	W1rA==
X-Gm-Message-State: APjAAAUiF9LHR8GGG9MH/xPOlJLiOm2aHSC3HrUtFsDFZ5pGs559s2oT
	qEeRlPRbfX9EeMNQOW2iK7XOvQ==
X-Google-Smtp-Source: APXvYqyDa0YmilrWZ1k8tKNoYyfg07X+WQiMaOM85O/8hynxuJKefiqbAJKINhDKM0ifZBVuCYQohQ==
X-Received: by 2002:a17:902:7c90:: with SMTP id
	y16mr8086846pll.309.1556861142842; 
	Thu, 02 May 2019 22:25:42 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	j22sm1101218pfi.139.2019.05.02.22.25.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 02 May 2019 22:25:41 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190502141019.6385-1-david@redhat.com>
	<20190502141019.6385-28-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9161ba93-fad8-c74b-3f49-71659f9f6017@linaro.org>
Date: Thu, 2 May 2019 22:25:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502141019.6385-28-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v3 27/40] s390x/tcg: Implement VECTOR
 ELEMENT ROTATE AND INSERT UNDER MASK
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503052539.3eaNI2ph79p-PBeRhLmI0-sEKTOYkJvCG3mA3zpNRUY@z>

On 5/2/19 7:10 AM, David Hildenbrand wrote:
> Use the new vector expansion for GVecGen3i.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 51 +++++++++++++++++++++++++++++++++
>  target/s390x/vec_int_helper.c   | 20 +++++++++++++
>  4 files changed, 75 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


