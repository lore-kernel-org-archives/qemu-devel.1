Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A64C04EBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 08:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9363D204EC
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 08:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkOwpET6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9363D204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQRYR-0001Rf-Au
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 04:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQRXl-0000yC-Nv
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 04:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQRXk-0008BD-45
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 04:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602146694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/aKfJ7A1Ikq3mJt/RW4eCly8Ud04QkreKOKcMZQ++qI=;
 b=CkOwpET6KOQjPaMBPj9yrwm497vSej9RGZC4QnvjfugbI4ZtcGDtexMjMZhBAoUdbvH30c
 lhlShyDJN8M+/HF3K0fu+5qr4VMs5PxWMB+ai+5WiOs6UpvH8XHKxCfiVhFrKK4TMl6fdV
 fuSGigZ4NdbroBbSUNIXBynTpH7001o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-BfcsCuVZOs-BwhjMfgcq0Q-1; Thu, 08 Oct 2020 04:44:52 -0400
X-MC-Unique: BfcsCuVZOs-BwhjMfgcq0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23EFA107B46F
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2020 08:44:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E996A76649;
 Thu,  8 Oct 2020 08:44:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 907EA11329C1; Thu,  8 Oct 2020 10:44:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 27/36] qapi/gen.py: add type hint annotations
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-28-jsnow@redhat.com>
 <87tuv68952.fsf@dusky.pond.sub.org>
 <5979141d-1d54-94fe-1afb-a976739f0956@redhat.com>
Date: Thu, 08 Oct 2020 10:44:49 +0200
In-Reply-To: <5979141d-1d54-94fe-1afb-a976739f0956@redhat.com> (John Snow's
 message of "Wed, 7 Oct 2020 12:50:33 -0400")
Message-ID: <878sch2jjy.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 10/7/20 9:20 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> Annotations do not change runtime behavior.
>>> This commit *only* adds annotations.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>   scripts/qapi/gen.py | 104 ++++++++++++++++++++++++--------------------
>>>   1 file changed, 57 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
>>> index 1bad37fc06b..d0391cd8718 100644
>>> --- a/scripts/qapi/gen.py
>>> +++ b/scripts/qapi/gen.py
>>> @@ -17,7 +17,13 @@
>>>   import errno
>>>   import os
>>>   import re
>>> -from typing import Optional
>>> +from typing import (
>>> +    Dict,
>>> +    Iterator,
>>> +    List,
>>> +    Optional,
>>> +    Tuple,
>>> +)
>>>     from .common import (
>>>       c_fname,
>>> @@ -29,31 +35,31 @@
>>>       mcgen,
>>>   )
>>>   from .schema import QAPISchemaObjectType, QAPISchemaVisitor
>>> +from .source import QAPISourceInfo
>> PATCH 03 has a similar cleanup.  Are there more?  Perhaps a separate
>> patch doing just this kind of cleanup would make sense.  Up to you.
>> [...]
>> 
>
> This isn't a cleanup, I am just importing QAPISourceInfo to use for an
> annotation. It's relevant and required for this patch, and doesn't
> make sense on its own.

I was mistaken.  A case of patch-review-eye...

> Patch 03 ... Oh, you mean identifying the correct location of
> QAPIError. Uh... nah? I think that was the only case of that one
> changing. Not worth pulling out or naming, I think.

Agree.


