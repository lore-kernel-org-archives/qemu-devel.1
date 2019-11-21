Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB47AC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FED62071C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dty+M/YU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FED62071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXiLi-0007Ww-2R
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 04:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iXiKc-0006op-Sl
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iXiKY-0002ok-0q
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:00:54 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iXiKX-0002oC-PA
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:00:49 -0500
Received: by mail-wm1-x342.google.com with SMTP id n188so816893wme.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 01:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ief5qaf59IK4l/RsxmY4LaFV/OVnvf4u2DluHLngnQE=;
 b=dty+M/YUVpCmWoGY7eLg8xLrxy6VDSL147OwibyCdpyKb9zkJf1SKtXZt63zpRp950
 PLzhxRTBMsykXYAiBEEEWb3pzhagFlJpl7MBJ8U1CuHz4Y5B+IbosOuHPECprOD3WBYS
 dIW4tFqml+SXTqUXbK6dnRAyRZoMcbhPnee5ZtghwmUr/qvtkrXrK8mVzf3m8RjJGvE8
 j/BpFN23vSjFcx1wFoyo5fJN7YCwr3hLpXh6TPhGanbKsMv6TfwEVA67W08orVyXeRm+
 DtmCDK4n7nXBphEEGq6GC3yS1SbkudjPxip0gZVh81qBHiHZo08/Xy7Lj8IA38flZLjX
 uusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ief5qaf59IK4l/RsxmY4LaFV/OVnvf4u2DluHLngnQE=;
 b=NYCTCU02rFAI/pWDIKB5o8jlNkjtwSt9ws7xXwD+F6NDjQT8bvD1V9UH6uQC8D1xwu
 yVZ34f22pC/om6f/op9FY94UDTgYV3QDBeow3uJlaFBx1n0O7wviSgQoMRDObTqYVNZ3
 uo1fVhm16bcAcJchw0GyMuKOAa2GqGntfCs3FXPLCQQjnqRLRx0F23niRYGLUEQu4/tx
 5XKMujQpe71F1SuABAHKt0JhepjTJvFfOeNMKaaDEFjtIRAJcqkmDEr4TE1SZXpKCgg3
 Xm32/IAzto8+9w7R8L/uItdUWDOo6J7oZ5OLtB3Yqjk+SYBDhmvTkCpZuwHqgLxBvBjE
 TCKA==
X-Gm-Message-State: APjAAAVufBWgxw0h2DfenCrn16KMRyKT6BVRMMuuM/IWtRSh720tSycx
 ayZa6YHZA4UR4zMo6Z3eMkli8JHi6lKsRw==
X-Google-Smtp-Source: APXvYqya4vv1T90slaXvUSTsO7ghSCkBVv9ed4F/kvdYkQ7kb9iZYfDTPSEfZ821x1BWnC2cR4f+3g==
X-Received: by 2002:a05:600c:a:: with SMTP id g10mr8645535wmc.69.1574326847994; 
 Thu, 21 Nov 2019 01:00:47 -0800 (PST)
Received: from [172.16.205.140] ([195.235.52.108])
 by smtp.gmail.com with ESMTPSA id g138sm2289589wmg.11.2019.11.21.01.00.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Nov 2019 01:00:46 -0800 (PST)
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
To: Taylor Simpson <tsimpson@quicinc.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <41e0e646-f595-be14-fc31-12a5ec090dcb@linaro.org>
 <BYAPR02MB4886DFE6DB0E6400B9409154DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <4b0ce6f3-f9a2-68a6-910c-f9830c34585c@linaro.org>
 <BYAPR02MB48867B036ADC1111CF04B023DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <2bdd3e40-1530-90f6-f179-8bf12e223ec1@linaro.org>
 <BYAPR02MB488654BC0532F7B8D667A704DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <bd96b924-8234-6dcc-fe46-6c34482d6707@linaro.org>
Date: Thu, 21 Nov 2019 10:00:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB488654BC0532F7B8D667A704DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

On 11/20/19 4:17 PM, Taylor Simpson wrote:
> Are you saying there's a way to tell qemu to put the stack at a certain location?  Or are you suggesting we do something on the hardware side?

There's obviously nothing to be done on the hardware side.  Presumably this is
all about the kernel, running on the hardware, and the default memory map that
it creates for the application.

There's certainly a way to influence where the stack gets put, via
ELF_START_MMAP.  We could even add another define to force the stack to a given
location if required.  I don't know enough about the kernel's default memory
map, and what's different here, to answer that question.


r~

