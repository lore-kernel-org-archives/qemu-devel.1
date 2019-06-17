Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D583C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 23:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C7B2089E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 23:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMPf7IHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C7B2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52510 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd0li-0006Zp-2B
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 19:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43316)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0kj-00068M-Ip
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 19:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0kh-0003ym-OV
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 19:09:29 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hd0ke-0003rZ-NS
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 19:09:26 -0400
Received: by mail-pg1-x542.google.com with SMTP id s27so6594101pgl.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 16:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3E2T8rbrudliHoY6EaeLuOcC8ryYIRlYDLo3bFuyDFY=;
 b=ZMPf7IHt06cN3gpKU7PnlMXPWXILvPiESSAGoI/PHdnY3tmlyo2drBIEZ9cbR7rTO6
 m1UWqqJiZ+n0t6DauRdgKELzoFgLwFoeKpuDqJ7TxSxPqqSL4zmGX2cQtm5ldkYR8ALt
 8tp8tIR92Agq9Kjb3S/qJ7DC8dG5mnBQqeC2g2i3eDI09POlCbgGmYTQRO3l31Rlo2yK
 97a//vgxanAOUpOtpefZ4gyOi9DIIjy8b+ydBx0GGUTW6z7oNajoh0ta6ARxq88+Gr7D
 V5wgjfbGw7Y0ajdQifJ4ZvD2Gmqx/iQSbRhGA092vNhYPXLXIN2sR66O59uXJIrO1F4R
 ub/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3E2T8rbrudliHoY6EaeLuOcC8ryYIRlYDLo3bFuyDFY=;
 b=EkVwemtc+l658pZDScdQbnm4ka30+ADzrhrqvB3dya0VdH0kl0Lbf2upws9eB5y0G8
 fzX23SvOlkCz6J2lLo/X1kkJZwzoXy/ETV43ehIKa4t5S0g3wQnk8x4KDiV8aIXJQllx
 TBf8DxnADiy+mirU3eG1J3c8K5RammHe/pb3d02lx+kAe91YImx6Hz925HuhrRmpMotQ
 jIrwFly2MTzmHcJ5ANNL7Uvq+WmcZN9mw5OTCuocbBhTStQppGwsrU2apPhsJslu9jRn
 d5TlVLnvxTMLWajWs2ZyRbyrWBb6+A0RMAivLJp9UQfNMkkKxzMW2wcg8ERuRkgYS/P1
 Aw4A==
X-Gm-Message-State: APjAAAX7Jnni4KNE/STAC3aUJc0q4pqU/JtTqsfwrntxNhp3O7yydGA1
 a2PoRu8+4HOLMnEJnq7lPqUaEla0PV8=
X-Google-Smtp-Source: APXvYqwj5YVIEQeDRTaOtWzgie9YGMZtsndZWXLTNgvBb4XuJ0uFMAhbVF5iL1ajpWr4CjIMCyGPBA==
X-Received: by 2002:a17:90a:376f:: with SMTP id
 u102mr1705126pjb.5.1560812962929; 
 Mon, 17 Jun 2019 16:09:22 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id w187sm14230286pfb.4.2019.06.17.16.09.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 16:09:21 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-45-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <035fc23c-257b-23e7-f232-fc56c7737564@linaro.org>
Date: Mon, 17 Jun 2019 16:09:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-45-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v3 44/50] plugin: add
 qemu_plugin_insn_disas helper
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> Give the plugins access to the QEMU dissasembler so they don't have to
> re-invent the wheel.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  disas.c                      | 103 +++++++++++++++++++++++++++++++++++
>  include/disas/disas.h        |   2 +
>  include/qemu/qemu-plugin.h   |   9 +++
>  plugins/api.c                |   7 +++
>  plugins/qemu-plugins.symbols |   1 +
>  5 files changed, 122 insertions(+)

There are a couple of checkpatch errors, otherwise
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


