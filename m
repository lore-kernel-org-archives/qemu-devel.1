Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DAAC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13972070B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13972070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46432 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdvEA-0001LC-VJ
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 07:27:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53212)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hdv4p-0004Vi-EX
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hduuF-0000hw-UB
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:07:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53329)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hduuF-0000he-M9
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:07:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so2625677wmj.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 04:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YABrXEXZO3C9cB7/mqalXZp2qaaiB3Poqy028OZIz9g=;
 b=IYUPOwrDpxFgYHYWhcrGNJfDS88Q1iR6LNYGXCz/ugMbJJDXjEVcQZ03Qwt1F7z8pO
 SrqIT5KSpbu51MQCnUzzuFSmBhZsdF3iAeqSZKnfi5Dqg8LTNd7BOlETOgNgmAlTKTwt
 eHagmZHkO1KCM+b2WAmGzC5XZH6hu+DKsaASLr7ZyzkSKUabXbeDN+JNjNXiFZ6fVcrs
 7i8OWYmuGNKT+cLX3B1ua6XLe/6ajvzbZ1NLGPuDswnLhgL5JtU5IGayxckGOlVxlSkA
 mLe1O4XjrcnG5Ct+R7MyMBqDBd/FeEshf/7TsCOiJ2ZFewrp48lmQsh66OVUuwVIVuzi
 fUkg==
X-Gm-Message-State: APjAAAUiH7nITPyJzJMftrjdohQ4xsRz0iV428gehQU8OOYu+6vQlowx
 ljdXsK5pZXDBNSIsH/gHqE1NuQ==
X-Google-Smtp-Source: APXvYqxNoYCM5921XwmtMb5uYYhzqnFvi1SSzqdpqHHYtY8mOQ+iuUvKV5L/lozBHnoQYBF6IRAQag==
X-Received: by 2002:a1c:c145:: with SMTP id r66mr2424679wmf.139.1561028822603; 
 Thu, 20 Jun 2019 04:07:02 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id t7sm14762270wrn.52.2019.06.20.04.07.01
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 04:07:02 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190619194021.8240-1-alex.bennee@linaro.org>
 <20190619194021.8240-3-alex.bennee@linaro.org>
 <f07129f7-2813-e7e9-79ae-94a026495ab9@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a88bb77f-717d-fb90-989f-3f4d760c6251@redhat.com>
Date: Thu, 20 Jun 2019 13:07:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f07129f7-2813-e7e9-79ae-94a026495ab9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v1 02/17] tests/vm: avoid image presence
 check and removal
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
Cc: Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/19 12:29 PM, Philippe Mathieu-Daudé wrote:
> On 6/19/19 9:40 PM, Alex Bennée wrote:
>> From: Cleber Rosa <crosa@redhat.com>
>>
>> Python's os.rename() will silently replace an existing file,
>> so there's no need for the extra check and removal.
>>
>> Reference: https://docs.python.org/3/library/os.html#os.rename
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

And now:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
>> Message-Id: <20190613130718.3763-3-crosa@redhat.com>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---

