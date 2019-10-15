Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D2DECE58C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 19:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312902054F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 19:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpREdcoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312902054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKSgk-0003yk-5D
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 15:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKSdO-0008PC-Sf
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 15:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKSdN-00079I-Iv
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 15:37:30 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKSdN-00078v-Cu
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 15:37:29 -0400
Received: by mail-pg1-x543.google.com with SMTP id p12so3414937pgn.6
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hiPPd3LEc/XLjd4HSUjTaDD4yp8TkzzEhOVfMtjD5PY=;
 b=bpREdcojtocv26nF0QQHwizzSeLyfsqYsVpRgrZq7onYM19wFsRyfabl2ZWWax9FfQ
 BPk81PQgGZoHnaz1MBwPwTUO+NChKp2wAX+JyFmTX4384kkCwEsOQq+CDTQnMvcmMmW1
 DdG/t03L6v+0z2RH0LstUY09cKU6QKdqoZEocaaJIOTm7N8r8F2qXYzoPf7hTtMCiwBN
 G/93YsmzeRjCL/MRXo72SKviPr25hZcu6pSbrH8WAiJbt+umvnlB7teyVtT8d13X3HiM
 6Sp2+5Oj+TKp4Kw/4qFmbY0S8NLhnu6U7OVMRZZJpRUZC1KXkluQaMOFYc9A6rZFyWWS
 nwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hiPPd3LEc/XLjd4HSUjTaDD4yp8TkzzEhOVfMtjD5PY=;
 b=giSDOFHWv5wJ7ZbtjDd/oYNcpDyfd1A2mAWcpXM03f5UyHmp2Gj+hCtJAn4gry2A+7
 tMyoRh8gytqeOlvEjKIqyCDwHoYt5keMTuLTxB2QVuXL9W41l7xPRgf6VLjkkagaLbV6
 YCdcPsQfGJapR49R8DlhRajoXVTNMEQ+1++LlBe4PBmvrpPXST2MxwWJmo33j5yaVTSj
 tcp309uE5xD9LFkBMsLZ5zAND3WrahFJum28YNURIxK5cXnU8g8snJcSwXmHCkgwpMEo
 ghogsCigqwkzyfcSLKJWaqHJSMYmzM4nrsz2Rn5NgygMtlONx58aq9mJ8T0snt8xZT6K
 tJsw==
X-Gm-Message-State: APjAAAXPplYmrZSoWWb72T9Yopk+E5DHRdWfgrioD3ziC9zbYby2JK8+
 GwEuxpHx9A/AeZY//kh2R0YqLw==
X-Google-Smtp-Source: APXvYqw4OszVj/9MqqffuXeIFAjNpDNz3h+VRVeqEfGAz/bsaebkkapzeLNaLsmfnV2PaVleFvoLBA==
X-Received: by 2002:a17:90a:cf97:: with SMTP id
 i23mr218160pju.77.1571168247616; 
 Tue, 15 Oct 2019 12:37:27 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s36sm23192324pgk.84.2019.10.15.12.37.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Oct 2019 12:37:26 -0700 (PDT)
Subject: Re: [PATCH v5 53/55] plugins: add sparc64 instruction classification
 table
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-54-alex.bennee@linaro.org>
 <3ce497fe-9dc1-5fa3-acf6-155ae16e0793@linaro.org> <87wod5ltai.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <70201b9b-54ee-c116-9e09-6b6d66a2cb94@linaro.org>
Date: Tue, 15 Oct 2019 12:37:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87wod5ltai.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: aaron@os.amperecomputing.com, cota@braap.org, qemu-devel@nongnu.org,
 peter.puhov@futurewei.com, robert.foley@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/19 12:09 PM, Alex Bennée wrote:
> How similar are the sparc and sparc64 decodes? Is there a canonical
> table you can point to?

sparc64 is a superset of sparc32.

Appendix A of https://community.oracle.com/docs/DOC-1005258


r~

