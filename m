Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB49DC10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8530E208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gv6SOq8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8530E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBumA-0000H7-O4
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBulT-0007zP-Gv
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBulS-00042g-Jw
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:22:47 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:50828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBulS-0003zr-DY
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:22:46 -0400
Received: by mail-pj1-x1042.google.com with SMTP id u10so455666pjy.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QDosoOA7LbdbFFpH59r0kpMLUcxkm5aOoy9uomL+7yw=;
 b=Gv6SOq8M2OjttM+9eTm6/XaWiCKP/PpHp2AClWr7RHNQOBFvAYFSq6Xl3JNl1HwSBJ
 C/tyDyZK0ESN05597csgJ5X8i8qLp1BLbKtZ+00w6oHX8gjeVzI8IASbVwHad14xJpOu
 G2d+IS41wTr0Bzjo73CoXt41M0eknbmzCMDi3T3XCJx4Io/CbGI0bkLxMl+c43+FZ1Tw
 8qoQALi7oJiWyVgY/7/U148jNezKeVcMBlcQNjizQI4mgjbKZMpmxrca0UrjkkWJ3Lqc
 MZ/Q7vdk9PpLThaTgemuDBbMIVnNgWG3mM42jY9NA24Ecxer9PVSQKAM0mOVcaSctb30
 VVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QDosoOA7LbdbFFpH59r0kpMLUcxkm5aOoy9uomL+7yw=;
 b=TjCN0OFHG2kvc9Zuau3gOK8vnnrrmfAJK3JI2uqLTLguIS/J73xI8jQBH2LEGJOb8E
 uam+mDGtmn2k+5hv3ZqDf6nN0xye/l+ONWdW+V2LMNXyD+YzHIYp3IqJWmzNcqDvDQBn
 oJwlDniC6EvQN9y4e+y/4jiagx+WhRZPfBWJ4el4oN92WSc6LwEn3Jvq0HxNdBWzNHEI
 GfR4ViU88jekWTAkgD6TAJEtp/8YnsTt9HfHMX/qEL3iVOJiNeUFESfasXzHLwnLLe21
 GgUQiIjATudN6/aTS3MLvX3hUeDsjpyuv0eiOaSKjROGB3v7VFmHcHCEqYwpK+u7hXoP
 R15Q==
X-Gm-Message-State: ANhLgQ2EFlgSiDiUeqQz3oendHJVFJG8RUfYUPIZBnrq7dCVkZG9gp1c
 GmPWMYTxLIf5szVAWGI8rzaDqw==
X-Google-Smtp-Source: ADFU+vtYtAkPWELuY+NZvL3i8LEiVg0AMC4CYMb0sNrFvBvU16+LP2g4iEqe085EsYvJrPADtw3i5g==
X-Received: by 2002:a17:90b:1a89:: with SMTP id
 ng9mr1740954pjb.102.1583907765208; 
 Tue, 10 Mar 2020 23:22:45 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 a197sm21525618pfa.171.2020.03.10.23.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 23:22:44 -0700 (PDT)
Subject: Re: [PATCH v4 11/18] qga/qapi-schema.json: Add some headings
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a660f61f-8c93-fec3-55a2-c4c397e05959@linaro.org>
Date: Tue, 10 Mar 2020 23:22:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309154405.13548-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 8:43 AM, Peter Maydell wrote:
> Add some section headings to the QGA json; this is purely so that we
> have some H1 headings, as otherwise each command ends up being
> visible in the interop/ manual's table of contents.  In an ideal
> world there might be a proper 'Introduction' section the way there is
> in qapi/qapi-schema.json.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qga/qapi-schema.json | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

