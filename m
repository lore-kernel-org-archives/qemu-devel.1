Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB909C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A78926CDD
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1L+qJSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A78926CDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46729 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWl3T-0003kv-O4
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:10:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWl2f-0003MF-QM
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWl2e-0002ib-UB
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:10:09 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWl2e-0002hp-Mu
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:10:08 -0400
Received: by mail-oi1-x244.google.com with SMTP id v2so8262121oie.6
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=luU9u2+zWmcnUfdm/FM1l8+T6AzyW06ATuLh2AVj5fg=;
	b=V1L+qJSRvtEvJJpBOwkSc/MZiA+cK2+LebYa0tGQiw+EMVririzod/TbO3rp8ZKXCs
	OOv2MMdnEWqWjof81AeyuJb4qIXvcVYgYgl7Fl1f9mIMab/a6F+tQxjxkLSEbyg8jXuj
	Fzvu+kDCz7Zvp2EFbebJmksSqOMN1GfAGWBd2fw11KACTv4bxRtXX2OWRUGFvWfPTrOv
	fMkpC7NgSsysKq9+FZKeyQewSrK6pJuoeU1VGyNbwz/aLs6g4iTK4kVEp6d5DQvSOuIn
	L7Tz85hKlrcZ0DCjxNQlLi7l95CgVXffvr8sqlTibwtv5ZqOU6u60Ws8Jo5JWjw1zJ84
	PoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=luU9u2+zWmcnUfdm/FM1l8+T6AzyW06ATuLh2AVj5fg=;
	b=c+BBeVFF3c9CglRzjIU/PiJyISGoiPRX009EVXh8YjU4h4PON5xNyziYJ57lDyxeEm
	gYGCXOF322/wuTBVZEkTKz8qWFIRT5kAEY0m2eSCkaR7RGYv/Iwtx0vUz6wwpFy7b0pw
	LQuPuMJYLM1fGqWhR0Qh3FK/QBRAGI1UACVU5IO+oWe6KIvgVho4bLUus58zyUXIt0J/
	LnIrldzGHMv1hVPIDZzCS/kgluyZfXH0lTLfKtD54dvkpF5e4hu56qTtVsaLw7ia6kHO
	GDNPaK5REHC54B9QVXOv3faIrOakWofrcu8UVTOkUTENMeLDFUfvKujUqh+2Kv80V2Ca
	6VYw==
X-Gm-Message-State: APjAAAXJrty2+Ckdg0ylCUF2H6wsZLy3Dy8t5T7iza4PG1l98RId1WR/
	jihyoqFiJV0ZlJM33Fu0hroJnA==
X-Google-Smtp-Source: APXvYqw9Up6PaEuZt0ZvG0kMc7DvGlsZ5O6PvpbolbSbflfhnuZK8kWdBPKQbSUx7NfOE7BnybpFFw==
X-Received: by 2002:aca:342:: with SMTP id 63mr6543699oid.10.1559322607587;
	Fri, 31 May 2019 10:10:07 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id o3sm2065493otl.76.2019.05.31.10.10.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 10:10:07 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-8-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f984c5d3-2a30-2bb9-468c-5c8bb94b6ebf@linaro.org>
Date: Fri, 31 May 2019 12:10:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531104432.29379-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v1 07/23] s390x/tcg: Implement VECTOR FP
 CONVERT FROM FIXED 64-BIT
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Denys Vlasenko <dvlasenk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 5:44 AM, David Hildenbrand wrote:
> +static DisasJumpType op_vcdg(DisasContext *s, DisasOps *o)
> +{
> +    const uint8_t fpf = get_field(s->fields, m3);
> +    const uint8_t m4 = get_field(s->fields, m4);
> +    const uint8_t erm = get_field(s->fields, m5);
> +    const bool se = extract32(m4, 3, 1);
> +    gen_helper_gvec_2_ptr *fn;
> +
> +    if (fpf != FPF_LONG || extract32(m4, 0, 2) || erm > 7 || erm == 2) {

Please split out the erm validity check.
We have fpinst_extract_m34 doing some of this now;
it would be a shame to replicate it more.


r~

