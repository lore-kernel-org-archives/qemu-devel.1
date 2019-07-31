Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2844AC41514
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 13:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00503206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 13:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00503206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsoGT-0001fa-87
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 09:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41240)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hsoG1-0001CJ-2c
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 09:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hsoG0-0000iE-6u
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 09:03:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36100)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hsoG0-0000ht-0r
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 09:03:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so69672740wrs.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 06:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6tuOZnHqaG3S/kW7Gc2GJzSdvEDHwY1ehrhqvfGBrTA=;
 b=Z1RQi4zUJSq2mS/9wp24leL7PjHoYQUXt6Z/AxNRhWZjDKzfiAvKbSjEekiYfIIjrj
 3i4SETMQAWNCPW939Yq9sTmZ3WLcutqnFyKEpvhFndhYh9UiRDxJRnNHCgGAWojeIV/c
 jO84CPTV2YeXdXFdSx9EDwnjBNOi99vvuMHhvvDR6mYtuS6uDwYfq1zHVrFlAyz4+PNk
 elExkMbHps1W/pyTKnK9mOM05jwiYEgAqKkJOu8Khd+wsF5xlhaDJWreJpWNCz7PoaTv
 utaCF+ft34mA8htdVNyINlLYOkZSM7FkCz7p/E3rUVLOLAP9gAAgmumB2OU5oS1C18Eq
 IfsQ==
X-Gm-Message-State: APjAAAXuva53Da7v3jmrifIkC6tXdvM/eHvq4Jnp8ycPzKG90kB0lAJa
 fqXU3QM3S/h/4pGzW+O0C8pIFw==
X-Google-Smtp-Source: APXvYqxvj2NnCMXj09R1SeZlYJ9gWJtaTck7xRuR/yQ+wJh0fkCYe9eoa9Hzi5kavRfZMIfrLo53SQ==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr125860239wrm.68.1564578182860; 
 Wed, 31 Jul 2019 06:03:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91e7:65e:d8cd:fdb3?
 ([2001:b07:6468:f312:91e7:65e:d8cd:fdb3])
 by smtp.gmail.com with ESMTPSA id b8sm88518509wmh.46.2019.07.31.06.03.01
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 06:03:02 -0700 (PDT)
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <1564502498-805893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1564502498-805893-4-git-send-email-andrey.shinkevich@virtuozzo.com>
 <14b60c5b-6ed4-0f4d-17a8-6ec861115c1e@redhat.com>
 <30f40221-d2d2-780b-3375-910e9f755edd@de.ibm.com>
 <08958a7e-1952-caf7-ab45-2fd503db418c@virtuozzo.com>
 <bdbee2e0-62a7-8906-8076-408922511146@de.ibm.com>
 <f9346216-a4e9-4882-4a36-33580529b75e@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <72f0fe91-3ced-ea7c-b675-1f219586213c@redhat.com>
Date: Wed, 31 Jul 2019 15:03:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f9346216-a4e9-4882-4a36-33580529b75e@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 3/3] i386/kvm: initialize struct at full
 before ioctl call
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berto@igalia.com" <berto@igalia.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Denis Lunev <den@virtuozzo.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/07/19 14:43, Christian Borntraeger wrote:
>>>>>>       if (has_xsave) {
>>>>>>           env->xsave_buf = qemu_memalign(4096, sizeof(struct kvm_xsave));
>>>>>> +        memset(env->xsave_buf, 0, sizeof(struct kvm_xsave));
> This is memsetting 4k? 
> Yet another variant would be to use the RUNNING_ON_VALGRIND macro from
> valgrind/valgrind.h to only memset for valgrind. But just using MAKE_MEM_DEFINED
> from memcheck.h is simpler. 
> 

Yes, it's 4k but only at initialization time and I actually prefer not
to have potentially uninitialized host data in there.

Paolo

