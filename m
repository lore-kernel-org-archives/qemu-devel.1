Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF94CC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EDF120C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDF120C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw1II-00043v-QB
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50412)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hw1Hk-0002yW-RQ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hw1Hj-0004xg-M7
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:34:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hw1Hj-0004xC-Gh
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:34:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so5026390wms.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4QVJ9H9zVaDcWtrMiHwRJtBZ03QKXMRDUOrCR/nxNdw=;
 b=Lo/ehtM+ofl4KyR0nLr0ENFkhZ2w59TZa5iGAWC1u7xBpvtN7wrf8ByRPvjx9SFrn+
 lbQ2QIKzbSns/ZCu7+EFQCnC6cyfStFJ/uvDUrvZ0xMVvTtTeOVUVRyhlmHWOnS+HXOf
 G+xO3+ncamGkn3zgicw7hIlJJw/ehGI5NuSA4RFXuHeJUSqMnKIlvDctqIXrEhi+ghO9
 lPJ8ONbYs1o5/J+1mDFmmq3t21vYy5KJb9Dpp0uWwFS3nTuLEHEk6oiLYlhhiTWaQMMg
 boD90tCxNldA5Yl6B3ydz5RU2md8oyf9GMkAcw3VgCAA+6XoRJNaQ9d6SseleK/p9QA0
 G85A==
X-Gm-Message-State: APjAAAUVFswoeP3usqIK4RWDBEVkVD3XwDCAqgo+ahj8g4nHRpSaqKmR
 PI20gN/DN7XosjX9Z+lIuHeFXw==
X-Google-Smtp-Source: APXvYqwyAfaXumhlaT39jkAyOKkx8RP11hsCQOloEu54OdRl+1PuuD8a7pD1rJTPlKN2W1p0uuFMMQ==
X-Received: by 2002:a05:600c:1007:: with SMTP id
 c7mr9320070wmc.161.1565343245833; 
 Fri, 09 Aug 2019 02:34:05 -0700 (PDT)
Received: from [192.168.50.36] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id b136sm5644040wme.18.2019.08.09.02.34.04
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 02:34:05 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190809091940.1223-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bf98b3c6-a50a-812d-e26f-f55cae85f48a@redhat.com>
Date: Fri, 9 Aug 2019 11:34:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190809091940.1223-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v2 0/7] softfloat includes cleanup
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 11:19 AM, Alex Bennée wrote:
> Hi Markus,
> 
> Here is v2 of the softfloat headers cleanup which addresses Richards
> comments from yesterday.
> 
> The following patches need review
>    01 - fpu move LIT64 helper to softfloat types (1 ack)
>    03 - fpu make softfloat macros self contained (1 ack)
>    05 - target mips rationalise softfloat includes
> 
> Alex Bennée (7):
>   fpu: move LIT64 helper to softfloat-types
>   fpu: move inline helpers into a separate header
>   fpu: make softfloat-macros "self-contained"
>   fpu: rename softfloat-specialize.h -> .inc.c
>   target/mips: rationalise softfloat includes
>   target/riscv: rationalise softfloat includes
>   targets (various): use softfloat-helpers.h where we can

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

