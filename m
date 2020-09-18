Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153C3C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 11:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3944320874
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 11:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0oGFSQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3944320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJEDs-0001Gc-7J
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 07:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kJEBP-0008QQ-8W
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 07:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kJEBM-0000wL-Td
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 07:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600427039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OshyfBJP2APoMnPtMHzpxPWlqGUQCcLYJOgcgY+6JOE=;
 b=K0oGFSQxAr7grGkTw8FHrNLW7iBYpJvbOUFoug+nuOAEMHUVSBH4TcTjOA5dpz1ldMeANY
 MiC122qIQNOwzVmGNtEXhWScRtC7W8WtdXLg/pFtNzMQndwmucCb0QG2jZ8ynMTDVvuyjw
 3WrxUTYZSkPJL6LfhKQ06fFUTPYYRiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-sQLWMeHyMmy8ekpmvauKHA-1; Fri, 18 Sep 2020 07:03:55 -0400
X-MC-Unique: sQLWMeHyMmy8ekpmvauKHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C93B9186843C;
 Fri, 18 Sep 2020 11:03:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9695173664;
 Fri, 18 Sep 2020 11:03:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2B5BD113864A; Fri, 18 Sep 2020 13:03:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 10/37] qapi/common.py: delint with pylint
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-11-jsnow@redhat.com>
 <87r1r0pjza.fsf@dusky.pond.sub.org>
 <eba468c3-91c3-10cb-9ef6-662468e676f7@redhat.com>
Date: Fri, 18 Sep 2020 13:03:53 +0200
In-Reply-To: <eba468c3-91c3-10cb-9ef6-662468e676f7@redhat.com> (John Snow's
 message of "Thu, 17 Sep 2020 13:48:18 -0400")
Message-ID: <87y2l7ibxi.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 9/17/20 10:15 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>   scripts/qapi/common.py | 16 +++++++---------
>>>   scripts/qapi/schema.py | 14 +++++++-------
>>>   2 files changed, 14 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>>> index 87d87b95e5..c665e67495 100644
>>> --- a/scripts/qapi/common.py
>>> +++ b/scripts/qapi/common.py
>>> @@ -14,6 +14,11 @@
>>>   import re
>>>     
>>> +EATSPACE = '\033EATSPACE.'
>>> +POINTER_SUFFIX = ' *' + EATSPACE
>>> +c_name_trans = str.maketrans('.-', '__')
>>> +
>>> +
>> You rename and move.  pylint gripes about the names, but it doesn't
>> actually ask for the move, as far as I can tell.  Can you explain why
>> you move?
>> 
>
> Preference. I like constants and globals at the top so you can audit
> any code that runs at import time in one place.

I can buy this argument.

>                                                 Since they are
> externally visible objects, having them near other "header" style
> information makes sense to me.

This one I find unconvincing.  Functions and classes are just as
visible.

Mention the move in the commit message, along with the (convincing part
of the) rationale.

Aside: EATSPACE and c_name_trans are actually local to common.py.
EATSPACE sort of leaks out only via the contract of mcgen().  The
contract could be rephrased in terms of POINTER_SUFFIX.  Not sure it's
worthwhile.

>>>   # ENUMName -> ENUM_NAME, EnumName1 -> ENUM_NAME1
>>>   # ENUM_NAME -> ENUM_NAME, ENUM_NAME1 -> ENUM_NAME1, ENUM_Name2 -> ENUM_NAME2
>>>   # ENUM24_Name -> ENUM24_NAME
>>> @@ -42,9 +47,6 @@ def c_enum_const(type_name, const_name, prefix=None):
>>>       return camel_to_upper(type_name) + '_' + c_name(const_name, False).upper()
>>>     
>>> -c_name_trans = str.maketrans('.-', '__')
>
> (This one winds up being a constant, so I renamed it in my v2.)
>
>>> -
>>> -
>>>   # Map @name to a valid C identifier.
>>>   # If @protect, avoid returning certain ticklish identifiers (like
>>>   # C keywords) by prepending 'q_'.
>>> @@ -89,10 +91,6 @@ def c_name(name, protect=True):
>>>       return name
>>>     
>>> -eatspace = '\033EATSPACE.'
>>> -pointer_suffix = ' *' + eatspace
>>> -
>>> -
>>>   class Indent:
>>>       """
>>>       Indent-level management.
>>> @@ -135,12 +133,12 @@ def pop(self, amount: int = 4) -> int:
>>>     
>>>   # Generate @code with @kwds interpolated.
>>> -# Obey indent_level, and strip eatspace.
>>> +# Obey INDENT level, and strip EATSPACE.
>> Is the change to INDENT intentional?
>> 
>
> Kind of, but it's either late (should have been with the indent
> manager patch) or early (Should be with the patch that moves comments
> into docstrings.)
>
> When this comment becomes a docstring, I use `INDENT` to indicate it
> as a proper object. This in and of itself is prescient, as we are not
> using sphinx/apidoc to generate any documentation about the QAPI
> package yet.
>
> (The pending v2 uses `indent` after you pointed out that it was not a
> constant.)
>
>>>   def cgen(code, **kwds):
>>>       raw = code % kwds
>>>       if INDENT:
>>>           raw, _ = re.subn(r'^(?!(#|$))', str(INDENT), raw, flags=re.MULTILINE)
>>> -    return re.sub(re.escape(eatspace) + r' *', '', raw)
>>> +    return re.sub(re.escape(EATSPACE) + r' *', '', raw)
>>>     
>>>   def mcgen(code, **kwds):
>> [...]
>> 


