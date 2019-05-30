Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED748C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7BF2582F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UL/g6YNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7BF2582F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52331 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWJAK-0004hs-Q6
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 07:24:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWJ9I-000429-Ec
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWJ9H-0001UA-IK
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:23:08 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:45713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWJ9H-0001Q7-AF
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:23:07 -0400
Received: by mail-oi1-x22a.google.com with SMTP id b20so1045567oie.12
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 04:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ujXUUi8WpjgeIt0fPgHFQYqdSCyjru6MCtoRNwzFiE8=;
	b=UL/g6YNipxG7t6VVSpPplS2PyrzmN4kMfSw6YxazHv7gDZiko7iWW2DNt7+V+sZt09
	J/hPwflzoF+0KnQPcUswTdnLnatjyooewtr7fKZgczXdEFhqmhEk6j6CGrLsgyENxMDV
	7DPJqUQDOc9uUSDRQw+/HLgC55ivtezg475esbzyQ17bHDDE4wzb5XCBB9gVnaJUz4A5
	CayAp3pkyq0vK8Obnm5DPgfwadjZZdG/SMnualM9hvz7PRLh/tBdvsPAi1ZsJl/yq0XR
	mWh4V1BZDdbpf0eQhV5HE2cIGay1VNbMO7LpSIWII9wgazlew0HUZxcevDkgn9bvB5gO
	YBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ujXUUi8WpjgeIt0fPgHFQYqdSCyjru6MCtoRNwzFiE8=;
	b=fG9ucj+kcAlrZn4i84cAqAJss6o6I/+h1Hc/IqtvnA9R6Myz6wih7t2/Nhjd2qSq4I
	RzaiMVr9tBnpdYDagQKjBeiP4YQ4+OcKvu4lnOdtYcXNOAeAGP/ADfLO1VLWJ9WuCYVk
	ZTdRobd9pRaZSW0c01AOHJWwCcWfYpBfGD9LKXGWN2QOzJEI9EOL9AQbFkUb8bUvE8ER
	xs6DvN1X2QAPK4BGnJMkjXu5R3OSfH1G5kc7zMaH4Y5/nQDDQ1vscpq/YFH7Gh1q26cQ
	iEVnwdewmBfvl1jvnzClaHCIf/db+crmjhd4NCmIZsHcrjW9lVWRX9jlxfT2q/jX8wHp
	Mgbg==
X-Gm-Message-State: APjAAAUpYQy3nj0iDMzDMmmQjCwx0uOu9ZeiN3s9Y4LNk9rsALrdvqJl
	AQ2kvRwTt4fuLFHt2KWVoY3/bAAPLp1xx2vQ6s3Uzg==
X-Google-Smtp-Source: APXvYqz9nJSxVGqcSGjmEX6RGXd79O3aXeg3jeiq5nh0TsDEmmQvjSfg8QDW0fdXxphYjslSUP3Vfi4KoJoZ9tAZ5iM=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr2213829oib.170.1559215386027; 
	Thu, 30 May 2019 04:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190520170302.13643-1-cohuck@redhat.com>
	<20190520170302.13643-20-cohuck@redhat.com>
In-Reply-To: <20190520170302.13643-20-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2019 12:22:54 +0100
Message-ID: <CAFEAcA-NBnfATjAcCdvMBtzuPcEArz4Z_TJnZdnfjdPhKFcaDQ@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22a
Subject: Re: [Qemu-devel] [PULL 19/54] s390x/tcg: Implement VECTOR GALOIS
 FIELD MULTIPLY SUM (AND ACCUMULATE)
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 May 2019 at 18:06, Cornelia Huck <cohuck@redhat.com> wrote:
>
> From: David Hildenbrand <david@redhat.com>
>
> A galois field multiplication in field 2 is like binary multiplication,
> however instead of doing ordinary binary additions, xor's are performed.
> So no carries are considered.
>
> Implement all variants via helpers. s390_vec_sar() and s390_vec_shr()
> will be reused later on.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Hi -- Coverity (CID 1401703) complains that a lot of this
function is dead code:

> +static S390Vector galois_multiply64(uint64_t a, uint64_t b)
> +{
> +    S390Vector res = {};
> +    S390Vector va = {
> +        .doubleword[1] = a,
> +    };
> +    S390Vector vb = {
> +        .doubleword[1] = b,
> +    };
> +
> +    while (!s390_vec_is_zero(&vb)) {
> +        if (vb.doubleword[1] & 0x1) {
> +            s390_vec_xor(&res, &res, &va);
> +        }
> +        s390_vec_shl(&va, &va, 1);
> +        s390_vec_shr(&vb, &vb, 1);
> +    }
> +    return res;
> +}

but I can't make any sense of its annotations or why it
thinks this is true. Would somebody like to have a look at the
issue? If it's just Coverity getting confused we can mark it
as a false positive.

thanks
-- PMM

