Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433C0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1829422CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1829422CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i18KU-00069H-4M
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 08:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i18Ij-0004ho-Ee
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i18Ih-0003Er-7H
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:04:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54716)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i18If-0003Db-8n
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:04:13 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7E1A14E919
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 12:04:12 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id v15so4745009wrg.13
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 05:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ppUWLxQTz2wI3gbWeMKsPw13Ln5jF4j9kUtdzGvEY94=;
 b=LE/VJCtf275+IqTOHdt5aChrjB5svB/z1ls/lhaOznCLP7AdseRyoNmhpT5D5sGLW0
 TIM8hLB9G2x5Z5hRx1sNTEoA4yrKWL+CQF2F3eMqSfpJRnv2L0xcyU8VTZ3xeGNX8Hh9
 YCQpjkRbrj1KkzMARJ4PjU3qo6PKp9W0wOWlYlYDI1J95LAeP+csR/RFmWOpDKQ1Jfj0
 Lj4RrwzTGk/Xsb57D7t2kbi5W+Pgtj03ZshdsuT6j9vsHskdP7jDkd67r8m61C3Wld6Q
 deR9vCr2fLpMCVu4Hf/Qiop3cPUuYjuHqD9J/CcVaP214hlgEYn/5s1BYrPmHJqlJ9pf
 LOjw==
X-Gm-Message-State: APjAAAVAuVxPQXWJSM8fmBnjh6zJPuXusSElBtbNMUazSAjoJmhLmN1S
 A7fTS4cU96n3bPqwgLBWhM4GKHniyfTkw9a2Qkuv9nYMGWz3mA7exDLZOJ+X48tpArb4p7hM7TD
 C8WhVUgMfcTZIjVU=
X-Received: by 2002:a7b:c118:: with SMTP id w24mr4969360wmi.100.1566561851194; 
 Fri, 23 Aug 2019 05:04:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxinFsEo3WUuKsjTa2ZA47lDwPCH5mOlSM9AVbSQVYIcvXZ3UIoTzCiJohRoJxHmjT3RUBwnQ==
X-Received: by 2002:a7b:c118:: with SMTP id w24mr4969334wmi.100.1566561850901; 
 Fri, 23 Aug 2019 05:04:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4566:f1b0:32e7:463f?
 ([2001:b07:6468:f312:4566:f1b0:32e7:463f])
 by smtp.gmail.com with ESMTPSA id e14sm2109407wme.35.2019.08.23.05.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2019 05:04:10 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <1566495734-23297-1-git-send-email-pbonzini@redhat.com>
 <9492af41-2125-9543-203a-312f0cd9087c@redhat.com>
 <CAFEAcA__BNnW4oSyv4iTAd7rsMUfcjyNJgk0nOwbkRQtmLj9jQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <dd473e9b-716d-cd9f-47bd-433d2b17687d@redhat.com>
Date: Fri, 23 Aug 2019 14:04:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA__BNnW4oSyv4iTAd7rsMUfcjyNJgk0nOwbkRQtmLj9jQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] modules-test: fix const cast
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/08/19 11:11, Peter Maydell wrote:
> On Fri, 23 Aug 2019 at 10:06, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 8/22/19 7:42 PM, Paolo Bonzini wrote:
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  tests/modules-test.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/modules-test.c b/tests/modules-test.c
>>> index 3aef0e5..a8118e9 100644
>>> --- a/tests/modules-test.c
>>> +++ b/tests/modules-test.c
>>> @@ -4,7 +4,7 @@
>>>  static void test_modules_load(const void *data)
>>>  {
>>>      QTestState *qts;
>>> -    const char **args = data;
>>> +    const char **args = (const char **)data;
>>>
>>>      qts = qtest_init(NULL);
>>>      qtest_module_load(qts, args[0], args[1]);
>>
>> Why did nobody notice this before? ... some additional words in the
>> patch description would be fine.
> 
> It got into the tree because I don't have an --enable-modules
> config in my set of things I run before merging. It's in
> the Travis build set, but that only runs after the fact.

Are you going to apply this and "[PATCH] modules-test: ui-spice-app is
not built as module" to qemu.git directly?

Thanks in advance,

Paolo

