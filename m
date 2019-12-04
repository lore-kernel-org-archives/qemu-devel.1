Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8D0C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB44520674
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwF8UoeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB44520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icUFY-0005wy-QC
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icUEb-0005TH-1V
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:58:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icUEY-0003Qh-4h
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:58:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20092
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icUEX-0003QH-HY
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575464300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3OVME42t3BnSHHn8jvVQ3zJiieN9RxyuIWN6S6xZr+k=;
 b=iwF8UoeYi/7wz4U29DDlOd7h/k+k6vLFB457kPgHBhYAMUk5K1CMkEKgrTAe5i/xmQhde2
 o5y/dhG7G60lemdLdppcSgGt5/4ocoxg7achs+C2kkASqmNJ6aHcPocjQyo4zRV/o/Dc3S
 WnVStyMN2Z6Z4awxZq6jBf/vIx00sqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-3M4yZXdSMZiTuZDAZeNUCQ-1; Wed, 04 Dec 2019 07:58:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25885802C98;
 Wed,  4 Dec 2019 12:58:17 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3F6F5D6BB;
 Wed,  4 Dec 2019 12:58:16 +0000 (UTC)
Subject: Re: [PATCH 7/6] Makefile: Make Makefile depend on generated qga
 files, too
To: Markus Armbruster <armbru@redhat.com>
References: <20191120182551.23795-1-armbru@redhat.com>
 <20191129095927.17382-1-armbru@redhat.com>
 <45cff400-7e88-cefe-560e-7642d2ea1d00@redhat.com>
 <8736e0h93m.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <42dbda81-f1a0-bb15-cee6-3040f41f38ef@redhat.com>
Date: Wed, 4 Dec 2019 06:58:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8736e0h93m.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3M4yZXdSMZiTuZDAZeNUCQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/4/19 12:56 AM, Markus Armbruster wrote:

>>> +++ b/Makefile
>>> @@ -130,6 +130,15 @@ GENERATED_QAPI_FILES += qapi/qapi-doc.texi
>>>      generated-files-y += $(GENERATED_QAPI_FILES)
>>>    +GENERATED_QGA_FILES := qga-qapi-types.c qga-qapi-types.h
>>> +GENERATED_QGA_FILES += qga-qapi-visit.c qga-qapi-visit.h
>>> +GENERATED_QGA_FILES += qga-qapi-commands.h qga-qapi-commands.c
>>> +GENERATED_QGA_FILES += qga-qapi-init-commands.h qga-qapi-init-commands.c
>>> +GENERATED_QGA_FILES += qga-qapi-doc.texi
>>> +GENERATED_QGA_FILES := $(addprefix qga/qapi-generated/, $(GENERATED_QGA_FILES))
>>
>> Would it be worth using two separate variable names (maybe
>> GENERATED_QGA_BASEFILES for the first list) rather than exploiting the
>> arcane knowledge that consecutive use of := causes GNU make to rewrite
>> an existing variable with new contents?
> 
> Our rules.mak relies on this already.  It's full of magic, which
> admittedly diminishes its suitability to serve as a good example.
> 
> Your worry might be rooted in old "=" burns.  "=" makes the variable
> recursively expanded, and
> 
>      GENERATED_QGA_FILES = $(addprefix qga/qapi-generated/, $(GENERATED_QGA_FILES))

Indeed, but I have to refer to the manual to remind myself of whether = 
or := is what I want in a given situation.

> 
> would be an infinite loop.  ":=" makes it simply expanded; there's not
> even a loop, let alone an infinite one.  The GNU Make manual explains
> this clearly at
> https://www.gnu.org/software/make/manual/html_node/Flavors.html
> 
> Aside: there's a reason one of the two flavors is called "simple".  It
> could additionally be called "not as slow".  One of my pet makefile
> peeves: unthinking use of recursively expanded variables, complicating
> semantics and slowing down builds.
> 
> Back to this patch.  I had started to write the thing in longhand, but
> got tired of repeating qga/qapi-generated/, so I factored that out.
> Would longhand be easier to understand?

It's more verbose.  My suggestion was more:

GENERATED_QGA_BASENAMES := qga-qapi-types.c qga-qapi-types.h
GENERATED_QGA_BASENAMES += qga-qapi-visit.c qga-qapi-visit.h
...
GENERATED_QGA_FILES := $(addprefix qga/qapi-generated/, 
$(GENERATED_QGA_BASENAMES))

to avoid the reassignment-to-self issue altogether, while still 
remaining concise compared to longhand.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


