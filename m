Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33352C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD6B2070D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pp+2YiGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD6B2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42667 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF3QF-0002NZ-5W
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 17:09:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF3OK-00017K-R7
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF3OI-0005UV-U4
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:07:20 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF3OI-0005Tb-7V
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:07:18 -0400
Received: by mail-pf1-x442.google.com with SMTP id b3so5721606pfd.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 14:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=/fpdNSrmAlv56hbSOunonEnKPski+/RXwm7yB/Vi4b8=;
	b=Pp+2YiGvpmkS73x/Ou0a/6hZssS5PsieH0VUkzTVULZIQCttGPUcFcsTYxFv5+Y2Pa
	sMVv/IBeAkRnE3lNAOeHPrmL9F7l53bwLNBuj57ZNOqps3TQTccrnkjlhTX9iDxO+ioT
	haGPE5u/tRPxZJbBH0N2R+Yl4L2Tza8tnIN3AGxUMybQCboL1m5VbxfooORYcPzQdxIM
	uRW2ZCmHagmlJMJxT+quLHa5TMHArwRtBReELl1T4o9um/J+hZF9HdfKfhkz+hTVF1hq
	3vyXmW5JER6yONurrvlj1DZr2jK/73LphoI0XFZU/RLQbh4dn6lC3qMxcWi1MsONHuN6
	9yhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=/fpdNSrmAlv56hbSOunonEnKPski+/RXwm7yB/Vi4b8=;
	b=dgMrv+Lls020ueaIWA+N+9lTUdc7Ajzi/s7dgzLo8R83kwktFdX4hTpIVw9kZbKNA/
	VDUjK3FdV3gIU3uwK3QQAGEYmaw1Tl9u8nSrcvzSxOH9wBPxJuzGXD+nm/DFitNPQXXs
	vFmSKQPpBsn0ICyPdCf9yWAhI7KrA5HUErrXb8eOnv/kkvd4HzCsJRzo8HWw2wYNxwRi
	Hcli/+vqP9FaXeCl2UIW2QR6yHOS7O1+K12CfJBLGgPc9WwnO0kC+kIdkqnXDroI3zM1
	zjBVbwkoX4EcFnsP4QhVDP2ER5Qkh9/Ejn8cGjsPaCOeTrM6krnAplVqfCnhTh0Lgvj8
	YBAw==
X-Gm-Message-State: APjAAAXjx+Deacl8B2oWiATTz6HOSw5Xsf6tUDooN5ykSxwJXIy0Y7Jk
	H4yFWwLrrKN3sUphb6mZmFSofQ==
X-Google-Smtp-Source: APXvYqz+JPpyfoAs8VBABEaZ8LXJbRn6rCCFU2ZO77GGnQWG7d5mi5iOg0/DciqgrDlG7QaP6H23qg==
X-Received: by 2002:a63:7943:: with SMTP id u64mr55117260pgc.91.1555103233996; 
	Fri, 12 Apr 2019 14:07:13 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	129sm40462316pgc.24.2019.04.12.14.07.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 14:07:12 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <50db1745-397d-03e0-626a-12d1b2a2a554@linaro.org>
Date: Fri, 12 Apr 2019 11:05:42 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-4-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v1 03/41] s390x/tcg: Implement VECTOR ADD
 COMPUTE CARRY
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
	Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412210542.hy8dRUKy1pFr8GTE0EZ93A6Lu7j-6AJYaQLBy4LuHvI@z>

On 4/11/19 12:07 AM, David Hildenbrand wrote:
> +    static const GVecGen3 g[5] = {
> +        { .fni8 = gen_acc8_i64, },
> +        { .fni8 = gen_acc16_i64, },
> +        { .fni8 = gen_acc32_i64, },
> +        { .fni8 = gen_acc_i64, },
> +        { .fno = gen_helper_gvec_vacc128, },
> +    };

Vector versions of the first four are fairly simple too.

static void gen_acc_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
{
    tcgv_vec t = tcg_temp_new_vec_matching(d);

    tcg_gen_add_vec(vece, t, a, b);
    tcg_gen_cmp_vec(TCG_COND_LTU, vece, d, r, a);  /* produces -1 for carry */
    tcg_gen_neg_vec(vece, d, d);                 /* convert to +1 for carry */
}

  { .fni8 = gen_acc8_i64,
    .fniv = gen_acc_vec,
    .opc = INDEX_op_cmp_vec,
    .vece = MO_8 },
  ...


I'm surprised that you're expanding the 128-bit addition out-of-line.
One possible expansion is

  tcg_gen_add2_i64(tl, th, al, zero, bl, zero);
  tcg_gen_add2_i64(tl, th, th, zero, ah, zero);
  tcg_gen_add2_i64(tl, th, tl, th, bl, zero);
  /* carry out in th */


r~

