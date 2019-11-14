Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7776BC43141
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4728120675
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CT2LBYQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4728120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVCRS-0006oh-DL
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 05:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iVCQK-00068c-1Z
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:32:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iVCQH-00040R-Q5
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:32:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46938
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iVCQH-0003zT-Hk
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573727540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=JdeCRICYAytjHNBaajV54M+eq1HpNXAdbvQQvVmphu4=;
 b=CT2LBYQcFUcaGqMTQLuzgCHfpJ8R4VC7aij/iclFL61SGbqpaRPfUkLe/VypJ/pIzrY5zq
 gZgXnjE257VE7XSlc1BnRPw94jRc/ZaMGZWxieftre/BQH5DjOqb2X67EskJ2l2GcT2Zx8
 DRsdkBwiIFyvFoFhllhhH6dd3/GFWxU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-IwJTaLJgOieUJc7llbGK-A-1; Thu, 14 Nov 2019 05:32:19 -0500
Received: by mail-wm1-f69.google.com with SMTP id z3so3120939wmk.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 02:32:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uW3cEj6mgyWenmN3DRcbtYLRhxZwu1ixo9QdUR2cgY0=;
 b=byuLViTP7k2eJ8zHcbMKnWnemMqSovPcbaVvwsmzhPty0YvgNpozQb506q2X3RxrbE
 PAqFmMhFdQmPewzwrGz84Is0oAa+kiqvztOFa/c8WUsn1cSIxpiGa8AsJhBnVlEE1z3f
 talyln0gJNlVyrDJwNNYtnUO/+cPbkW6NIcDz2Jd3QaPINAsFet5aoC7DAzXdMwE7YlS
 e0BWuA8WTTMLVz/LZSLFLQ0fZZ/hg22vZPrLjIoRxoBKOcBomnQrvNEJFZxleCDVP6jp
 vKq1m4kEMggixE3Cud7DdOjjwH+ra+1vRnJmJWeRpNM549R/Tu5oqp4M7KGyt6SclAzM
 zjcg==
X-Gm-Message-State: APjAAAXkPOLPpPK00BUG3UpTrmYFyNr2cHQ54eFhYLk2SwHNjDSQozqY
 9qyPFICteTpDf7yx/E//NWLEFUZdXLoM+BmQiEIGnZFbZ+Bqf89UpX6djmuGc1MZramtVccdoE/
 iyo7qKpuhLLmFUP8=
X-Received: by 2002:a1c:2b82:: with SMTP id r124mr7297037wmr.112.1573727538191; 
 Thu, 14 Nov 2019 02:32:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqz3nMQ1iA8uY8CgJcuwhFQyRMXRO03928a1YRsoKr1rYGvWxSqBBnJM2IGgJZlZix3JaMO1ng==
X-Received: by 2002:a1c:2b82:: with SMTP id r124mr7297005wmr.112.1573727537928; 
 Thu, 14 Nov 2019 02:32:17 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc?
 ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
 by smtp.gmail.com with ESMTPSA id a186sm5195563wmc.48.2019.11.14.02.32.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2019 02:32:17 -0800 (PST)
Subject: Re: [PATCH 01/16] memory: do not look at current_machine->accel
To: Peter Maydell <peter.maydell@linaro.org>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-2-git-send-email-pbonzini@redhat.com>
 <2db4f901-65ad-4b80-d309-b8b63330492f@redhat.com>
 <4783e606-19b8-c3c0-08ab-ac84b02af6f4@redhat.com>
 <CAFEAcA_FnfJx=oae5e_KGcmqwyUtM01KeywjpSSa09fu9++sMw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <07c6a4ea-1d5b-da75-9fed-3b9e7bb1d193@redhat.com>
Date: Thu, 14 Nov 2019 11:32:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_FnfJx=oae5e_KGcmqwyUtM01KeywjpSSa09fu9++sMw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: IwJTaLJgOieUJc7llbGK-A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/11/19 11:21, Peter Maydell wrote:
>> FlatView #1
>>  AS "memory", root: system
>>  AS "cpu-memory-0", root: system
>>  Root memory region: system
>>   0000000000000000-00000000000effff (prio 0, ram): microvm.ram kvm:tcg
>>   00000000000f0000-00000000000fffff (prio 0, ram): pc.bios kvm:tcg
>>   0000000000100000-0000000007ffffff (prio 0, ram): microvm.ram @00000000=
00100000 kvm:tcg
> Why do we need to print the accelerator name for every
> memory region? Isn't it just a global property, or at
> least a property of the CPU ?

Not all regions are registered with the accelerator, in particular not
for devices.  So we print it next to regions that are registered.

Paolo


