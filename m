Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29E2C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 22:35:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851512086D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 22:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cg5oOrGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851512086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43476 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF4lQ-0003Ud-Iz
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 18:35:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF4ka-0003AN-LJ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 18:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF4kZ-0000pQ-Ok
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 18:34:24 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF4kZ-0000oa-6Y
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 18:34:23 -0400
Received: by mail-pf1-x441.google.com with SMTP id y13so5778093pfm.11
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 15:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=bP1w3rW6gOEd4LanDoRqZrYFmmhE6U4LzsDN5zk5nWU=;
	b=Cg5oOrGysm1nfRtCojwUXk2+8e0GJSFnwWUB9sguHiCm+vgm58iKEsYmI2aqyqJi0M
	YKkfQAZKbyPSYF5osVtddlWbGgYzQIhmxlk0Ym4haQKek4B+URnZIKW1JmbEHsN9sz2C
	Vk6KR8dhXv+g6hrSQHC8eTviPyIFPuWlj7B8Btaaba2adAsmdp7XPT0sgzonm9B50dqt
	t9ffmU0ZdujVOC/7DIB1pHaWE3ziKBxFXbnCvqbiIlHZ+NmEDIvzFV+dn8qabiRS/53F
	seHrlWqJsxT0c73xQnA3m3lRlCLgE93C+UiMgJUh/HrOizAoqu4iq3/SAx9ODYNl5knZ
	7kXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=bP1w3rW6gOEd4LanDoRqZrYFmmhE6U4LzsDN5zk5nWU=;
	b=finppZiUi+83TsiiDe46qyYAFCBTVh0i+nMMetbHZfgED5PfO8t9kAyQ/s07gHpeKJ
	hRUy15TOZHA3/3MliQP+bY1dWoFmF/y0cMgP3TGEJDg6vEsZ0Vig/0kOhOk14RNna8q1
	UHiyUAPFWPy8xTs+dA9ZKIr/bSQch37av/tz81Mr8E0zWZZooTqr8Ny0ot1Y4hKTUFIh
	6jT3T2bJevBnS1GmtF0fu9AXYSHvOnM4WQvsnRgAok0D8O8bszYaxibyvDfQQUhVCXyE
	BHeIU/05kthck6FDf3XzJrpBCWtOItEZeTtCm57HSIcNowT3eOQdE512hrOTP/ooDnvb
	b2GQ==
X-Gm-Message-State: APjAAAWJGqAa8koyGedxcgVu3lKz/WkpgqyW6YTF7QM4nhy1fQkWkDQy
	EJz7vhC76hwViW0isSTYCh+FCw==
X-Google-Smtp-Source: APXvYqwwcpwZgazvQMdVuC5yCJZc3B+utfd8x09thZaGg+9Fc6zEx02llv1LMQ9BIaCnPVoSmUiFQA==
X-Received: by 2002:a62:47d0:: with SMTP id p77mr59662572pfi.95.1555108461181; 
	Fri, 12 Apr 2019 15:34:21 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	13sm53234766pfi.172.2019.04.12.15.34.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 15:34:20 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-8-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0c0c45f1-0721-78a8-fb46-f32e7701da0e@linaro.org>
Date: Fri, 12 Apr 2019 12:34:11 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-8-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v1 07/41] s390x/tcg: Implement VECTOR
 AVERAGE
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
Message-ID: <20190412223411.hmoI9z-8sdWUXvX8qkdbnadMGVgGlyvroEZACYeyKpI@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> +}
> +static DisasJumpType op_vavg(DisasContext *s, DisasOps *o)
> +{

Watch your spacing.


> +    static const GVecGen3 g[4] = {
> +        { .fno = gen_helper_gvec_vavg8, },
> +        { .fno = gen_helper_gvec_vavg16, },
> +        { .fni4 = gen_avg_i32, },
> +        { .fni8 = gen_avg_i64, },
> +    };

Pondering possible vector expansions.  I think one possibility is

  t1 = (a >> 1) + (b >> 1);

We still have the two "0.5 bits" to add back in, plus we round up by adding
another 0.5.  This means if either lsb is set, then we have carry in to the 1's
bit.  So:

  t1 = t1 + ((a | b) & 1);

Which leads to

  tcg_gen_sari_vec(vece, t0, a, 1);
  tcg_gen_sari_vec(vece, t1, b, 1);
  tcg_gen_or_vec(vece, t2, a, b);
  tcg_gen_add_vec(vece, t0, t0, t1);
  tcg_gen_dupi_vec(vece, t1, 1);
  tcg_gen_and_vec(vece, t2, t2, t1);
  tcg_gen_add_vec(vece, t0, t0, t2);

  { .fnv = gen_avg_vec,
    .fno = gen_helper_gvec_vavg8,
    .opc = INDEX_op_sari_vec },

But what you have here is correct and the above is mere optimization so,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

