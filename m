Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCC8C46470
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 22:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F78A26D60
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 22:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kge2Akw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F78A26D60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41447 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXv0b-00052I-5t
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 18:00:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXuzd-0004gO-QK
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 17:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXuzb-0004pU-L9
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 17:59:49 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hXuzZ-0004eO-MU
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 17:59:46 -0400
Received: by mail-ot1-x341.google.com with SMTP id t24so3871649otl.12
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ZZ7Uj/Uo12xKaZsHQt7/fEcDKNv1tT6oHKaiVCbI2v0=;
	b=Kge2Akw3C85N6dZnqVNlTjV0r+o+C5/9AGePyJ89mSdcnyf/286oDDe6ART+A42qHH
	lh27kEgLJFP2NwVNsJ3BBbyJvcnMjH5sV8loQbkdM7DNsZoqnu3gLOLV/M0rjE51KMOH
	zw6jSVErldC80L8qCrZ0JBwK2XpBCHGuKR7+/JpaXldhAdw2QzgjKmxGbQ3qlWDjESJ0
	BlGcVYapU+hWItjlvZ3hvkgauDwm3KvDngMGUISzfpeLJZc9IfdFrElFygTfW3soQGRo
	DU7SEWe+Hl6i5Zpn2dh1/6DVlH8h/RuGXMBv4JBieFHDMSS81M58hHJtEe5UCW9HCuXx
	XR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ZZ7Uj/Uo12xKaZsHQt7/fEcDKNv1tT6oHKaiVCbI2v0=;
	b=IBtx4d+4VMOJaVXjdBpvLh7FMPgfMrjN6pY7qNbkDOQIDecPtZ41Z+wJvHldKuGIEI
	Ys4Qr1YKZxrrKUe3DPU99nX8URQEUoeKMbzj3JRUQI/MRz776BHLdPLCTygilmrIykNf
	CDVtkJKNrnUhDezCEI7ghukazNkVRcMVeZw3cb7WUDcvffTHqGuHvUyRRT+RBaqO21YM
	8Fbz1lRkZaehc537wMNbozWLjMqrwRfHv34A/IOaWRu0Hcua8gnZlPpV2eTc/p398dLz
	w46u0f2bQ3iEYH9xlMRdSCia3QitCC1q81ii8NyQsguOrxbtgjavq23bm1yoWMxjDcn5
	Nnug==
X-Gm-Message-State: APjAAAW/8gISupoFXk/MDtqp+mU8+7BqL5eRmM6vlpDaa/Q6SUV8e014
	59na/Uy5eLsILPHP7MimQ2Zlgg==
X-Google-Smtp-Source: APXvYqzV0gJnU64e2mQXaS94YfoPuBjbAvuCQ3sNwu/ik0CWp1v+hhbk9oUPwDm5fxQOyyR+lIl2/Q==
X-Received: by 2002:a9d:14a:: with SMTP id 68mr2714054otu.96.1559599182971;
	Mon, 03 Jun 2019 14:59:42 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id x204sm753005oig.9.2019.06.03.14.59.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 14:59:41 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190603165735.8934-1-richard.henderson@linaro.org>
	<c001abca-9de5-91eb-de00-fd8fb8249f59@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a3b3cf27-0ba0-57ee-dd1b-fad753093742@linaro.org>
Date: Mon, 3 Jun 2019 16:59:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c001abca-9de5-91eb-de00-fd8fb8249f59@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] target/s390x: Use tcg_gen_gvec_bitsel
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
Cc: cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/19 2:41 PM, David Hildenbrand wrote:
>> -static void gen_sel_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b,
>> -                        TCGv_vec c)
>> -{
>> -    TCGv_vec t = tcg_temp_new_vec_matching(d);
>> -
>> -    tcg_gen_andc_vec(vece, t, b, c);
>> -    tcg_gen_and_vec(vece, d, a, c);
>> -    tcg_gen_or_vec(vece, d, d, t);
>> -    tcg_temp_free_vec(t);
>> -}
>> -
> 
> Comparing against tcg_gen_bitsel_i64()
> 
> 1. a and c are switched
> 2. b is _not_ switched (and() and andc() are switched)

Not quite.  {a,b,c} from your s390 implementation becomes {c,a,b} for tcg.

Running tests would show for sure; I guess you have those later in your vx
patch set?

> Should I send this patch with the next s390x/tcg pull request?

Yes please.


r~

