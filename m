Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED278C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5272083B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYFyHUIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5272083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ7x2-0005V0-7C
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 07:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ7wT-00054l-JG
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:49:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ7wQ-0000fT-QH
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602071344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jwm8F//vPudYNIz/dSPQtOMUZi/YLJ5ywHTpi1C6owE=;
 b=RYFyHUIElNHn5mFMqpUvIDdgp5D85z/wPGab5hVQJ9iiQ+j8fyi/OPqBI1ntzqe0zizhzy
 AE+y2QKg+BFzU+uXpMCr24GYnMj/AkKXfvFHQdgYPSKpezQ+v/RI/j6pq6AqFkKU4ETB89
 suLYkc00RnSQFTwJqmVW0fw6Ga9NITc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-JVc0uieKN_ufeVjzbovhjw-1; Wed, 07 Oct 2020 07:49:03 -0400
X-MC-Unique: JVc0uieKN_ufeVjzbovhjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56B381007B00
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 11:49:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2100319C4F;
 Wed,  7 Oct 2020 11:49:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 764EA11329C1; Wed,  7 Oct 2020 13:49:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 19/36] qapi/events.py: add type hint annotations
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-20-jsnow@redhat.com>
 <87zh4ye0fh.fsf@dusky.pond.sub.org>
Date: Wed, 07 Oct 2020 13:49:00 +0200
In-Reply-To: <87zh4ye0fh.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Wed, 07 Oct 2020 13:32:34 +0200")
Message-ID: <87pn5ucl3n.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> John Snow <jsnow@redhat.com> writes:
>
>> Annotations do not change runtime behavior.
>> This commit *only* adds annotations.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  scripts/qapi/events.py | 46 ++++++++++++++++++++++++++++++++----------
>>  scripts/qapi/mypy.ini  |  5 -----
>>  2 files changed, 35 insertions(+), 16 deletions(-)
>>
>> diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
>> index f840a62ed92..57e0939e963 100644
>> --- a/scripts/qapi/events.py
>> +++ b/scripts/qapi/events.py
>> @@ -12,19 +12,31 @@
[...]
>> @@ -137,15 +153,15 @@ def gen_event_send(name, arg_type, boxed, event_enum_name, event_emit):
>>  
>>  class QAPISchemaGenEventVisitor(QAPISchemaModularCVisitor):
>>  
>> -    def __init__(self, prefix):
>> +    def __init__(self, prefix: str):
>>          super().__init__(
>>              prefix, 'qapi-events',
>>              ' * Schema-defined QAPI/QMP events', None, __doc__)
>>          self._event_enum_name = c_name(prefix + 'QAPIEvent', protect=False)
>> -        self._event_enum_members = []
>> +        self._event_enum_members: List[QAPISchemaEnumMember] = []
>>          self._event_emit_name = c_name(prefix + 'qapi_event_emit')
>>  
>> -    def _begin_user_module(self, name):
>> +    def _begin_user_module(self, name: str) -> None:
>>          events = self._module_basename('qapi-events', name)
>>          types = self._module_basename('qapi-types', name)
>>          visit = self._module_basename('qapi-visit', name)
>> @@ -168,7 +184,7 @@ def _begin_user_module(self, name):
>>  ''',
>>                               types=types))
>>  
>> -    def visit_end(self):
>> +    def visit_end(self) -> None:
>
> Ignorant question: what's the difference between -> None (like here) and
> nothing (like __init__() above?

Looks like commit message of PATCH 24 has an answer.

Copy to all the commits that omit -> None similarly?

>>          self._add_system_module('emit', ' * QAPI Events emission')
>>          self._genc.preamble_add(mcgen('''
>>  #include "qemu/osdep.h"
> [...]


