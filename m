Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E022C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD81F20CC7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3DtOnOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD81F20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydp5-0000CJ-0V
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iydoS-00086a-6Z
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:39:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iydoR-0005z4-A9
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:39:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34349
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iydoR-0005yY-6B
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580744338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=3/5tSFoSXGY1O20yBO3A0oHEhFBq92j5f6chfEhaGjw=;
 b=F3DtOnOGYizxEgZcZRSzllGTG1U5ONZmam5hQyFmWay6H9vqSAfYZxt64lGkED7PT36CLI
 JEXflxQ9zM/1wA0N9xWkFRA9P7nE4rq0Tz5tnZjie3/zHB2vPP70l9FsdUOTtZKINybsIN
 ZUiq4dE+rZRhN+69ASaccS5p3B7SAgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-fzsjVqYsMpe5iWrx6Y5oYw-1; Mon, 03 Feb 2020 10:38:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 500F619082C5;
 Mon,  3 Feb 2020 15:38:46 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74F458EA0B;
 Mon,  3 Feb 2020 15:38:45 +0000 (UTC)
Subject: Re: [PULL 00/13] qtests, kconfig and misc patches
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200203123811.8651-1-thuth@redhat.com>
 <CAFEAcA_1KYRA=87k34zCRLqCf1tWHrULGZPcHeKwJZhDUx0=kw@mail.gmail.com>
 <2fd63018-b9f9-ab88-2d65-009c54bb6cf2@redhat.com>
 <CAFEAcA_XKAeT10p+XNRjQeOjoGYX1Q-D+kj9E0kFx2AxtktACg@mail.gmail.com>
 <fedbec35-51c7-cf1b-ef55-e2a582620781@redhat.com>
 <a40afb1e-0f36-e4c0-918c-9d3c88cd511d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2bbe8de3-9555-4111-c66a-671bdef635c0@redhat.com>
Date: Mon, 3 Feb 2020 16:38:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a40afb1e-0f36-e4c0-918c-9d3c88cd511d@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: fzsjVqYsMpe5iWrx6Y5oYw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/02/2020 16.29, Paolo Bonzini wrote:
> On 03/02/20 16:17, Paolo Bonzini wrote:
>> On 03/02/20 15:50, Peter Maydell wrote:
>>>
>>> An extremely cheesy workaround would be if the commit which
>>> removes the hw/bt/Kconfig also touches configure; then Make
>>> will know it needs to rerun configure, which will (among
>>> other things) blow away all the config-devices.mak.d and
>>> force rerunning of minikconf.
>>>
>>> I don't know what the correct additional makefile magic
>>> would be that would cause us to automatically get deletion
>>> of a Kconfig file right; maybe Paolo does?
>>
>> Nope, sorry. :(
> 
> Wait, hw/*/Kconfig should not have to be added to minikconf.py's
> arguments.  There are "source" lines in hw/Kconfig to do so.  It does
> not fail because minikconf skips multiple includes of the same file, but
> it should be possible to remove it.

Right, I came to the same conclusion. Patch is on the way...

 Thomas


