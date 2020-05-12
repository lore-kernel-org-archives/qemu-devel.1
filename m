Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A104DC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAE3206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKPGXqJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAE3206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYSM7-0000b0-J3
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 06:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYSDi-0006yF-Ns; Tue, 12 May 2020 06:33:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYSDh-0007Vt-MH; Tue, 12 May 2020 06:33:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id 50so14173671wrc.11;
 Tue, 12 May 2020 03:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=I9MIi/SSxbmvKk9tcXCh0+NovZpXmWa3BB8CHjlS/vs=;
 b=sKPGXqJRaPkw9CNk9Ywt0H82tPegBC0Jy3Pca+xE6AF2ZEfQ3M1AsF17+pFYnrYytm
 1IZbNH+fOS+chl3gIQcDKGhrF9uV38Nx8QmwMGEFxguFLQo+XdhHa1Hol76opF7XiW/a
 QOlKDbwK8wre5aXDMXaNUmGyUhdfRSfK5iFLD5Wz6z2N/+oZY9698pI6DeDGQkWzM1qD
 2U189hP2tYpqpKtw6VK4YuPaOeX/bPTXQEOj7KDBoA8qV5x224JxnCSzUhw6opirDw6W
 3LwOi0aNrn1Nj/HIbqBo0BZUHANGAvFKZgAYGf+/rp6dZwZx3ZVuUpSJnz7HHGGJVkNB
 fjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I9MIi/SSxbmvKk9tcXCh0+NovZpXmWa3BB8CHjlS/vs=;
 b=seBh9OjJMsJN2Hp5rLM7WD7ppk7qL/WVgpBUVEwFuIJ52xnHXqXkc3o2qJUuQzUhu0
 XL882xTJQtn8yPmtMrFTcWLQ/HyDze8BChXpXFd/vvRL+PHUxsSVJF+uI96ItaXlcNH5
 amyXLeNvk6kczN0NHs7194biII2WlCTTa9KJCe48Fl34g16uJnzTuTtYhFa+aQkdW6/V
 EssEC1L9eghgoujuLE2AmLv5vHXzOwU0cXhzFwkzi4+wB5hMLiKFocqkYtLso3aksKyL
 h1m9LFaO3cZPxk18Ax9TpC6vZnbMC91lO8xrKvqXObPAA8Gs6GJ8N1pBF5FTrJzvFBXw
 dmsA==
X-Gm-Message-State: AGi0Pub/PJT5UZOb3mA3nyFOPMAWbSnhm/5Mfkq07fQehlZHb6NKmzNY
 e0uyJlzDIigCVsEug4RFvCE=
X-Google-Smtp-Source: APiQypILKMXYsTq02tCEMY+x7yA69429kDh86bFKTzz/sSXwEe60wW7K5CIno5EoxeSrr8Mh+NAdqQ==
X-Received: by 2002:a5d:43d1:: with SMTP id v17mr23604247wrr.282.1589279583373; 
 Tue, 12 May 2020 03:33:03 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id u127sm31128671wme.8.2020.05.12.03.33.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 03:33:02 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] scripts/qemugdb: Remove shebang header
To: Kevin Wolf <kwolf@redhat.com>
References: <20200512070642.23986-1-f4bug@amsat.org>
 <20200512070642.23986-2-f4bug@amsat.org>
 <20200512085536.GA5951@linux.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <74080e65-8dbc-a3fa-c17e-dcbcb338ced6@amsat.org>
Date: Tue, 12 May 2020 12:33:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200512085536.GA5951@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 10:55 AM, Kevin Wolf wrote:
> Am 12.05.2020 um 09:06 hat Philippe Mathieu-DaudÃ© geschrieben:
>> These scripts are loaded as plugin by GDB (and they don't
>> have any __main__ entry point). Remove the shebang header.
>>
>> Acked-by: Alex BennÃ©e <alex.bennee@linaro.org>
>> Signed-off-by: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
>> ---
>>   scripts/qemugdb/__init__.py  | 3 +--
>>   scripts/qemugdb/aio.py       | 3 +--
>>   scripts/qemugdb/coroutine.py | 3 +--
>>   scripts/qemugdb/mtree.py     | 4 +---
>>   scripts/qemugdb/tcg.py       | 1 -
> 
> There is still a shebang line left in scripts/qemugdb/timers.py.

Oops, thanks for catching this.

> 
> Kevin
> 

