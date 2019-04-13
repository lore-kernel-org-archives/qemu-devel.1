Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4F3C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 06:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19B920869
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 06:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wo0vc7Ai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19B920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47344 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFBtm-0005ZN-2f
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 02:12:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBt1-0005FU-3j
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBt0-0007FC-8b
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:11:35 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:38439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFBsz-0007ER-HA
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:11:34 -0400
Received: by mail-pl1-x635.google.com with SMTP id f36so6129093plb.5
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 23:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=bcTmFJljReKk4c1mUhl+PO72ibEFcvhuflHM/dP9ee8=;
	b=Wo0vc7Ai0cvI1fYncEW2x2MMhj/nHhA3z7H09kwf/Xj56x+FkSp4c4b252DnkMj5uy
	XXLaQgnzs3odinR4qpAZQqtZvCzZkl17sXwENIfGin7I7zC9SFwi1js6eFBqWfmwHPV1
	Jf7xdlQ3LmC4lJT/IfrKQW+sLgrPBNtF4HOIvPiW2GnwoUh9rz7HGe2EU9Cu9jD+vv6E
	JdHRLhGqmzBzFr7kv1eCY15Gn60F1gnzzaopuOei8TiXF8I2+aKZHy2vtNRFAfTz4MTN
	XnpXFFOKRy9WCG/77Xo4mhU84y9TjIYxDCcZnYfp/P3UiMy2En5g/NIYXkTtiR155UMj
	EYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=bcTmFJljReKk4c1mUhl+PO72ibEFcvhuflHM/dP9ee8=;
	b=FzwgEhGMX3se+g2CIrMNhLhWqoCc9j5pX95/9R52o7YwXT93PmYWBzRC0jxCVW3bOD
	XB+tOqJNlvU3YbPQW01bHu4T3nsxSWhyvbBGAjzU4j9SQwjyhkQ7YRXi1P0PSvn/avmX
	cAmw2B7cIubiZUhiS3eyNKN1K3GX2eDNDqECgEDMPKhm1Ai/xbyrNpaEcsCbM3wGmgg/
	GS/293lnYbpHkWEMMdaOT2hKHBXpd1S88YT7ODw0kG5WF8PV0ruJU+kZCmlCoXk/cxdU
	8o+7i8UGMOaAi7eU61mXSs6WXiUS/uSce9DD8S57m9oeV81DEQ2Y4Q7SGwEmIpJww0KJ
	dIow==
X-Gm-Message-State: APjAAAUsYkeU2E4IvRdPbUQy4eENc6iqhOW0BeKDLwOzFoq93/FMeUsE
	NRXZw4+VfKo1aXQNM5zVK0r7lw==
X-Google-Smtp-Source: APXvYqwCshkpYfCt8eoNMvEuC+WwzHSXq92dxxS7A3aWjgHoNlgvAewLU0OQUevqD2ENCANxO9+yTw==
X-Received: by 2002:a17:902:b948:: with SMTP id
	h8mr61484049pls.39.1555135892333; 
	Fri, 12 Apr 2019 23:11:32 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	h16sm22393162pgj.85.2019.04.12.23.11.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 23:11:31 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-38-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9ecb39e2-99e3-4d48-2582-8962005ed940@linaro.org>
Date: Fri, 12 Apr 2019 20:11:27 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-38-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::635
Subject: Re: [Qemu-devel] [PATCH v1 37/41] s390x/tcg: Implement VECTOR
 SUBTRACT WITH BORROW COMPUTE BORROW INDICATION
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
Message-ID: <20190413061127.ZtyhqC1Xvnqsd3KL95F2RQ1ehk8p39YBTKw-nqFtumc@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> +static DisasJumpType op_vsbcbi(DisasContext *s, DisasOps *o)
> +{
> +    if (get_field(s->fields, m5) != ES_128) {
> +        gen_program_exception(s, PGM_SPECIFICATION);
> +        return DISAS_NORETURN;
> +    }
> +
> +    gen_gvec_4_ool(get_field(s->fields, v1), get_field(s->fields, v2),
> +                   get_field(s->fields, v3), get_field(s->fields, v4), 0,
> +                   gen_helper_gvec_vsbcbi128);
> +    return DISAS_NEXT;
> +}


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I'm sure this can be done similarly to add with carry compute carry, but it's
harder to reason with sub2.  Something like

	tcg_gen_andi_i64(tl, cl, 1);
	tcg_gen_sub2_i64(tl, th, al, zero, tl, zero);
	tcg_gen_sub2_i64(tl, th, tl, th, bl, zero);
	tcg_gen_andi_i64(tl, th, 1);
	tcg_gen_sub2_i64(tl, th, ah, zero, tl, zero);
	tcg_gen_sub2_i64(tl, th, tl, th, bh, zero);
	tcg_gen_andi_i64(tl, th, 1);
	/* result in tl */


r~

