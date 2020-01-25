Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F57C35241
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 07:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F422071E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 07:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKbIDYKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F422071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivGEY-0004Qn-Tt
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 02:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ivGDr-00041s-Pj
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 02:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ivGDq-0002KD-Ex
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 02:51:15 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ivGDn-0002F7-35
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 02:51:14 -0500
Received: by mail-pj1-x1041.google.com with SMTP id gv17so871817pjb.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 23:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dzptgcfQ0CuThPvcgLQ0jAJhL9wNJy/6Osrlj9jpdkg=;
 b=aKbIDYKRUs7T4NhZNNE51WPM8uVESe8za4LU8l/CrBizAa9TuUFqAFfYUw+r2nQVhe
 7ebB6OHzleszYArPDNWbh0rikAEVAPo6w6H8vRDHk7c6rJieuwI+3VKDxF4J+bOdoxsV
 paAGrxoeXs4PJdCmNWMru/fgR8awuQE9cGkerj3dFWKeewdiGFM4G+jM+MaEHhy2gBe0
 k1lMFpF16d/GTewc2oOMQJzWlj/UOCCqUaDBJ4XtFoDVIZPbCIVh6QGajIWnxDa1hRJ8
 dbpO8fcaTOlCFPVMe5qZwaCyY+ZdI6yQ7iPGXn7TSZvsXJEqAdgPub/Ct8miyjAXOr8s
 o72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dzptgcfQ0CuThPvcgLQ0jAJhL9wNJy/6Osrlj9jpdkg=;
 b=SqJUW4iAZY+3d4ynG33JbrxmBuO0w38DwEuwPeWWA7cOsE34wLqNa88DcC0Evdgyxp
 zvHzXZlE5aprPb8nrNV+aBgh/8orzlSud5+Bdq3w/NDO+3VaTpL3JA0JCnvu++PWn0GQ
 FW9HcQAwKCcfNGomRMcFzvtNn0stqCMD4mBaBcht+8lZWFATR8HerSmPJJEJyAnf7gXE
 8qpGmN05FI8OnZqOk5aozabM41C02Ud5Y6AKBCDk10dK/+IICQ5AYURG/oVtAGgxfxp6
 QutcxmLDiI/PelJT/jteTakDZdBlHLheWdZqafUIwHqONJxmB8I9Xz3fi/Bm+edXQYQO
 IxUg==
X-Gm-Message-State: APjAAAXQyyYIpC0/T8NPX09Cbac4rBGbDlMjelZoYsH24OXJPmTLUKr+
 kFSJ8cMa0do+bhmzegGLKMttfg==
X-Google-Smtp-Source: APXvYqzlpNzE1gq2P7wvHt19jVx9pFtop3pnOdP8hSGc+wFU/VK4Q7ddrN/21fL3+hrtOwo8+wFHMQ==
X-Received: by 2002:a17:902:567:: with SMTP id
 94mr7590768plf.174.1579938669574; 
 Fri, 24 Jan 2020 23:51:09 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id u23sm8506642pfm.29.2020.01.24.23.51.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 23:51:08 -0800 (PST)
Subject: Re: [PATCH v4 6/7] disas: mips: Add micromips R6 disassembler -
 infrastructure and 16-bit instructions
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1579883929-1517-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579883929-1517-7-git-send-email-aleksandar.markovic@rt-rk.com>
 <779b7b35-16a8-0538-ad87-fac218c93e82@linaro.org>
 <CAL1e-=hqgWesfm9f8fsSQ8JS54LybNMMGygbCNi0O+VyfSAJvg@mail.gmail.com>
 <c3c80f0a-e348-4c7c-e8c4-579b16ec22a4@linaro.org>
 <CAL1e-=g89vC8gw6xNiGcNAhDixX2xZgnDjKgvDsChkvHHpduQA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0d2d0fff-302b-b8e6-cbc6-5c2bb66f1f8e@linaro.org>
Date: Fri, 24 Jan 2020 21:51:02 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=g89vC8gw6xNiGcNAhDixX2xZgnDjKgvDsChkvHHpduQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 1:38 PM, Aleksandar Markovic wrote:
> On Friday, January 24, 2020, Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
>     The thing I'm concerned about here is any future maintenance of this file.  One
>     would surely prefer to edit the original decodetree input than this output.
> 
> 
> Here is the deal: This dissasembler is meant to reflect the  documentation of a
> particular ISA, and as the documentation largely stays constant (except adding
> some insignificant errata), the disassembler will stay virtually constant, we
> wouldn't like even to touch it, and we like it this way.

No, this is neither right nor proper.

To review the code in this form is significantly harder than in its decodetree
form.  That is in fact the whole point of the decodetree form: otherwise we'd
still be writing these sorts of parsers by hand.

While there's no license on this new file (another problem), if as assumed this
is GPL 2+, then you are in violation of the GPL.  From section 3:

  # The source code for a work means the preferred form of
  # the work for making modifications to it.

You cannot with a straight face claim that the generated c is the preferred
form for making modifications.

Finally, suppose we improve decodetree.py, so that it produces code with which
the compiler produces better code, for some metric of better.  We would want
this disassembler to benefit as well.


r~

