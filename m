Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0B4C4CEC4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904C22053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904C22053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAxRM-0000D6-RH
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iAxPP-000701-Vz
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iAxPO-00007M-Sd
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:27:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iAxPO-000060-Mw
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:27:46 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E063211A07
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:27:45 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id t11so1145883wro.10
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 07:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lKzcvFrFvsuwnxzjekpKEEzUuyIDEDYX7lbIC2J4SSc=;
 b=YEwM9EkoGZFFBF7Gr0EqTpTo7LB3+SxGup8an+FjTHc3byNfWNbC4NDQ6blcZgGqgM
 zoDQ6t9DDM453UAr9YeqERU9EGRVC0REnYds5/vmkrrzCn0Vw6pH7I8P91wPCpPQZuvF
 bEC7i3qmSRqktAaqBBrtNTBqM0uScoInhywmIU1cXuE65R8TN42TMX+GrMUJ+7ggzw3m
 aqk6wEPhrP9Yb8E9DrdqZf5jtmtEtmMj80FF4I4Yun23KkvcTAP+/2SfE7WRcl33Mp1V
 EyFfd7AVHpEQ9cG9wVLaZHQLs55HbW5swq++gKxl/g4pJ5MayGBhR4uSc5Z9apyQB2FF
 qiSg==
X-Gm-Message-State: APjAAAWAtP+fQLDf7yx5h/7QWjNKbl3qCkFiX2BD5fb2Db1MQrejRfjt
 EQUiOq+Xp8yaSc8ggN5R2x4SPQ0/jWa93vyKdU8GRcUYfozbsixWwJfoCfIaeUAVRqt8ZsJqX6x
 1Cmr91GltIvXaauo=
X-Received: by 2002:a1c:49d4:: with SMTP id w203mr2963695wma.132.1568903264611; 
 Thu, 19 Sep 2019 07:27:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwWHpid1hKmrP9o9mnI8qIsygxO0YvM00EZKuMQe4PeOB9ufNP3dV/JP7ovlKx3DrL8Qj4aFw==
X-Received: by 2002:a1c:49d4:: with SMTP id w203mr2963668wma.132.1568903264364; 
 Thu, 19 Sep 2019 07:27:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8?
 ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
 by smtp.gmail.com with ESMTPSA id s9sm8060432wme.36.2019.09.19.07.27.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 07:27:43 -0700 (PDT)
Subject: Re: [PATCH v3 05/22] libqtest: Add a layer of abstraciton to send/recv
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-6-alxndr@bu.edu>
 <a2ac1b44-8a93-8b81-c44d-133f7eefe944@redhat.com>
 <60437a730d3df6a3248cd944eacd4555b40d00bc.camel@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d07eebbd-2c4d-3f0a-790e-72d1965f6ca0@redhat.com>
Date: Thu, 19 Sep 2019 16:27:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <60437a730d3df6a3248cd944eacd4555b40d00bc.camel@bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/09/19 15:27, Oleinik, Alexander wrote:
> On Thu, 2019-09-19 at 13:18 +0200, Paolo Bonzini wrote:
>> I think you can pass "s" to the tx handler as well, and remove the
>> send_opaque and recv_opaque fields?
> 
> Qtest also uses this function to communicate over qmp  (different fd).
> I can probably make the tx handler a wrapper which accepts "s", and
> passes s->fd to the real socket_send.

Yes, exactly.

Thanks,

Paolo


