Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD6AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 12:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B367206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 12:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0dMI7AF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B367206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsmLq-0002Tg-IY
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 08:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsmKI-0001Bd-PZ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 08:03:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39130
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsmKH-0004Mn-1L
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 08:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594123432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FmfhiMJtahQ7Hi+R/Z4QNLj/V+gjSLRy4LCXx2Z8lgs=;
 b=A0dMI7AFjqqKK3Rzqcn6o2bMnFBebzdy49r9KtQHvqenaHyzqUM6Vlfe7o0qHXRL01oW1i
 5MKSFUJyJelzJ4skPAT4lv5ecIgWhQLqeGQpH2aDvqNQB48uzWmYUZSp+B+jL7CXd+Vb/b
 iTy6njqP0Y1qpuvs520fqwmLZPtUMFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-781L0jVHNWuQ-peHXeDbnw-1; Tue, 07 Jul 2020 08:03:50 -0400
X-MC-Unique: 781L0jVHNWuQ-peHXeDbnw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F92E107B0E1;
 Tue,  7 Jul 2020 12:03:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3F2760BF3;
 Tue,  7 Jul 2020 12:03:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 566D71132FD2; Tue,  7 Jul 2020 14:03:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] util/qemu-option: Document the get_opt_value() function
References: <20200629070858.19850-1-philmd@redhat.com>
 <87imezan9b.fsf@dusky.pond.sub.org>
 <e3a29383-ee77-e9be-c6a0-f795cdfc53cb@redhat.com>
Date: Tue, 07 Jul 2020 14:03:47 +0200
In-Reply-To: <e3a29383-ee77-e9be-c6a0-f795cdfc53cb@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 7 Jul 2020 08:11:20
 +0200")
Message-ID: <87pn977crg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, Kevin Wolf <kwolf@redhat.com>,
 Daniel =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/7/20 7:48 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>=20
>>> Coverity noticed commit 950c4e6c94 introduced a dereference before
>>> null check in get_opt_value (CID1391003):
>>>
>>>   In get_opt_value: All paths that lead to this null pointer
>>>   comparison already dereference the pointer earlier (CWE-476)
>>>
>>> We fixed this in commit 6e3ad3f0e31, but relaxed the check in commit
>>> 0c2f6e7ee99 because "No callers of get_opt_value() pass in a NULL
>>> for the 'value' parameter".
>>>
>>> Since this function is publicly exposed, it risks new users to do
>>> the same error again. Avoid that documenting the 'value' argument
>>> must not be NULL.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>> v2: Drop confuse comment (Damien Hedde)
>>> ---
>>>  include/qemu/option.h | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/include/qemu/option.h b/include/qemu/option.h
>>> index eb4097889d..ac50d25774 100644
>>> --- a/include/qemu/option.h
>>> +++ b/include/qemu/option.h
>>> @@ -28,6 +28,19 @@
>>> =20
>>>  #include "qemu/queue.h"
>>> =20
>>> +/**
>>> + * get_opt_value
>>> + * @p: a pointer to the option name, delimited by commas
>>> + * @value: a non-NULL pointer that will received the delimited options
>>=20
>> s/received/receive/
>>=20
>>> + *
>>> + * The @value char pointer will be allocated and filled with
>>> + * the delimited options.
>>> + *
>>> + * Returns the position of the comma delimiter/zero byte after the
>>> + * option name in @p.
>>> + * The memory pointer in @value must be released with a call to g_free=
()
>>> + * when no longer required.
>>> + */
>>>  const char *get_opt_value(const char *p, char **value);
>>> =20
>>>  void parse_option_size(const char *name, const char *value,
>>=20
>> You are adding a *second* doc comment: the definition already has one.
>> It's clearer than yours on some things, and less explicit on others.
>> Feel free to improve or replace it.  But do put it next to the
>> definition.
>
> Hmm I haven't noticed it, because my reflex is to look at the usage
> description in the prototype declaration, not in the implementation.
>
> I know, 2 different schools.
>
> Maybe we can make both schools less unhappy by simply duplicating the
> function description in both the header and the source files...

Worst of both worlds :)

[...]


