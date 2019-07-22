Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C4FC76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 20:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5558F218B8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 20:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5558F218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpeVA-0004CX-8m
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 16:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39182)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hpeUy-0003o7-55
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 16:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hpeUx-0000O3-7c
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 16:01:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54568)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hpeUx-0000NF-0u
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 16:01:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so36341766wme.4
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 13:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wg0BWHvH5vTR+QBMPEzQnz4zc1Ou+dSzoYyUXEQCkXw=;
 b=NhBJr9F//j1vCmRMwKpKLCvPnV9Ie+t+hIt/e9Y28MCLkqN/evGbZQs08GpbVF2n1S
 BwvMbgangZFuX/65LNGcIQpdoA7vY8u96/Q1xMZqdegnE2Mji9sbP6/DQPUajGcqjhk1
 QetA0m7cI0/o3rDJNXw66YGcUgLw0dUyX15Z1tmLgr+v+OtNWLbix1eyN19i6gQz/+go
 4MeTyOHr5ZH0y4sBKIb650LJDdLkNQeZg6dmnaNvVP/VK4MM04Q8uXVHTdb6/InoJxY3
 deRmdW/dwEk8JJ/dTntLUp+i4SHGQb6MIHRbSEQTBrv/6FbkFxSYSitQm6nY0fIBZcqb
 n7Ng==
X-Gm-Message-State: APjAAAV9OqQTKfm0JVp1C7Z6lcMRvqDMyinvOfmK1HEMp3F5nJVn+B1W
 QtGhqx/tWt6t0PFZQnMkZqJUyQ==
X-Google-Smtp-Source: APXvYqzYAnYXer9MHSP7AQytsg1IwbkFYt0lKiGplxGtWFHqPewiH069bdWj3JIUriQ4QPzzFD0zxg==
X-Received: by 2002:a05:600c:2189:: with SMTP id
 e9mr61704233wme.56.1563825685479; 
 Mon, 22 Jul 2019 13:01:25 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id p18sm39511470wrm.16.2019.07.22.13.01.24
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 13:01:24 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190717134335.15351-1-alex.bennee@linaro.org>
 <20190717134335.15351-19-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0f74a6b5-e3d7-bb2c-c7b8-091f654a46cf@redhat.com>
Date: Mon, 22 Jul 2019 22:01:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190717134335.15351-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2 18/23] travis: enable travis_retry for
 check phase
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
Cc: Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On 7/17/19 3:43 PM, Alex Bennée wrote:
> We have some flaky tests and usually the test passes on a retry.
> Enable travis_retry for the test phase and see if that helps keep
> things green.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 5d3d6ee1d32..caf0a1f8faf 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -75,7 +75,7 @@ before_script:
>    - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>    - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
>  script:
> -  - make -j3 && ${TEST_CMD}
> +  - make -j3 && travis_retry ${TEST_CMD}
>  
>  
>  matrix:
> 

Does it help?

IIRC if TEST_CMD takes >20min the job will likely fails, anyway at best
it succeeds :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

