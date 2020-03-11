Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1248BC10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43762192A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bo6WdbJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43762192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBuz5-0002ja-3p
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuyW-0002Bm-7w
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuyV-0001U8-9S
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:36:16 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBuyV-0001Ts-2P
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:36:15 -0400
Received: by mail-pf1-x442.google.com with SMTP id p14so735774pfn.4
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DV30OW99uQZ2EGZoE1K0zlZaZVIcax8ibg4rClaECrQ=;
 b=bo6WdbJUKFQ1rBgzcZRUk7Ft5R8isnh14QmKHRODrvCKcAmqJFQ9VnBwP2n6ydfgWD
 NNKtoQCzGNIKwvnncNmo4hl4Pwd5enNYkeQyFCX5KXkQ86jHjcRC0PNQ+FQoHpWJUJwq
 2HNomZWzVUJ+tO2GQBBL4tGY3qzxNLFI+hfiwENT1A+HGqmxmPNT4FriCMiiwz9bY24O
 kPYnWPk9jdUq21EKpWlWPI2/glFuQbvn4DUtEDXbegPOvrcOyeFecf+k1dOUuOx6cxu4
 poUoUANFzB9rbFD7afK4on5vI4qExAFZ77hmmu4Vaf3h85eMhmTXJZ8Rudh95L1VLnLe
 X8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DV30OW99uQZ2EGZoE1K0zlZaZVIcax8ibg4rClaECrQ=;
 b=odpRgE6vzrehX0oxx2iX3maIvtSOXOaIB1vGzU8Dyp3rYtGEmoioerL4xqJa+m+S7J
 /hBumRaHagPZm3odazihNUS1ht2NN4u5ElTFaim44SESt1P+RsLHxQh05Pw55tmkVp7S
 1aG8brAP4URNBQo5vjiZIMRvIiZA/+0FjtBYsVr0zT43dDhbLUHCbxjPKP92QlrHsc6/
 T6WSRtbUe6zEC66UZrYxEYVtxxPeobVJSv+Yxrr/lZlu0DqeUalj4jUeiSV2WFe/l09n
 Y2vKbvanfdLHqbAOkPCEBC6jsrglAGdWIQYibEkCYaQBA4KVsdxEnPt+y0OrUtbosiRN
 NV3A==
X-Gm-Message-State: ANhLgQ3R67Pr6YHT3HUp/dQVNfbHjJSqhNjzyKYagX53al6nzMVa8nmC
 pNNYOt4gCRjldktBya19I/VdfA==
X-Google-Smtp-Source: ADFU+vtjtvt46Kx1I/VPbyUEP30mw37ZOkopG7O7LdREsdfwkJQapHyCdjWf93dQ/B/rsLyQXf97VQ==
X-Received: by 2002:a62:4ec4:: with SMTP id c187mr1418494pfb.223.1583908573350; 
 Tue, 10 Mar 2020 23:36:13 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 a71sm11512230pfa.162.2020.03.10.23.36.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 23:36:12 -0700 (PDT)
Subject: Re: [PATCH 1/5] Makefile: Allow for subdirectories in Sphinx manual
 dependencies
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200309215818.2021-1-peter.maydell@linaro.org>
 <20200309215818.2021-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a2de498d-65c0-6394-a241-1f36badcff22@linaro.org>
Date: Tue, 10 Mar 2020 23:36:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309215818.2021-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 2:58 PM, Peter Maydell wrote:
> Currently we put 'docs/foo/*.rst' in the Make list of dependencies
> for the Sphinx 'foo' manual, which means all the files must be
> in the top level of that manual's directory. We'd like to be
> able to have subdirectories inside some of the manuals, so add
> 'docs/foo/*/*.rst' to the dependencies too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

