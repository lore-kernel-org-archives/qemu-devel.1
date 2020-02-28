Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A61C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B11246A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXMSU0I7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B11246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ccQ-0005u1-2W
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7cZz-0002eS-QL
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7cZx-0003Q4-GZ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:09:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24301
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7cZx-0003Pn-DZ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582884549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/lxDNqU9f6szodAoL+eKVqU16LD68L11FLyfkgqa0zY=;
 b=KXMSU0I7PO+P9Q0bn6Lu+bPopr4SeHvjKcYuO1IdWZm+DQpzgwRMpjz7ekL/1ZGo5z1JWr
 NuGqnVHl4ttcOnjYHJbgTyPi8nXPL1V418iMHbloMD5TUot3/GnXQJsswzF6XF5nJAx53Q
 S3PqaayP7sHGqtXq/IhIgHL+bGDaw8o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-vcR858cjP8C_WxyO2xPO5w-1; Fri, 28 Feb 2020 05:09:05 -0500
X-MC-Unique: vcR858cjP8C_WxyO2xPO5w-1
Received: by mail-wm1-f70.google.com with SMTP id r19so962792wmh.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 02:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EHcn7Uig0EtUCcWo1FHf3SEWp5/ZmpM7wVWxnrh0SL0=;
 b=C8Z2DvqDOrCIYg/dF789geBpVZeyOgSj5wfPdKlU3dCLVfIWFTFDRxM8JVVBU4vx/I
 7xFa6aJce/3R7RXTJ4JJo6KlOh4dcMBo7cYCbd7VV6BmxzSJ3WszTh6W+ABHcoCayhKn
 ttNoiPInA+pZiLb6LtwLw9O6ZDpefpChdAsw1kx1pXsievKA2+zTzV5PoVGYuel6Hmey
 sAAzNt5m1DTgeNqNM+JnzKZNOcAfk5Q6N9vQ6S+yV+Rrs5cIR4xG0SussbHo22nOo7kc
 xFbZtls+8W2wgUjS0DO5fRVIb4r7JIr7qBewn79e3EFSFhhFTRWF1SGskz1anmTZ60Fg
 iZZA==
X-Gm-Message-State: APjAAAUoPtxd3WEe7mHnkX+L9fPvZoCf81RdkzorvyR9JjE0JztldPhm
 DUD6jeANrnZseLAxpLZj1Ud2gDUeGktLBIHI90Q6DjGqEDTbJyveOArVyRCxaI5/g6SuR2Sa68H
 BenNZdwPT6IBfBZc=
X-Received: by 2002:a7b:c958:: with SMTP id i24mr4148711wml.180.1582884544532; 
 Fri, 28 Feb 2020 02:09:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqy+pCCIHZwu6JHxntWdbDcTvUVhAoEUlr5QaD/4tDZ0JAZkFkXZQslpiZEofZ0jQMLVORU4kA==
X-Received: by 2002:a7b:c958:: with SMTP id i24mr4148684wml.180.1582884544312; 
 Fri, 28 Feb 2020 02:09:04 -0800 (PST)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id y185sm1558864wmg.2.2020.02.28.02.09.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 02:09:03 -0800 (PST)
Subject: Re: [PATCH] qom/object: Comment to use g_slist_free on
 object_class_get_list result
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200227190942.8834-1-philmd@redhat.com>
 <20200228094652.GB1657361@redhat.com>
 <CAJ+F1CL-fbX=dXpopMMT1o-WH1JhrqrzpM55J9cGoGDNpDq=AQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cc93fc81-3e4d-b8d0-afa7-2c35ac502785@redhat.com>
Date: Fri, 28 Feb 2020 11:08:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL-fbX=dXpopMMT1o-WH1JhrqrzpM55J9cGoGDNpDq=AQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 qemu trival <qemu-trivial@nongnu.org>, Pan Nengyuan <pannengyuan@huawei.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/28/20 11:06 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Feb 28, 2020 at 10:47 AM Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
>>
>> On Thu, Feb 27, 2020 at 08:09:42PM +0100, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> Document the list returned by object_class_get_list() must be
>>> released with g_slist_free() to avoid memory leaks.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>   include/qom/object.h | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/include/qom/object.h b/include/qom/object.h
>>> index 29546496c1..5517b56508 100644
>>> --- a/include/qom/object.h
>>> +++ b/include/qom/object.h
>>> @@ -984,6 +984,9 @@ void object_class_foreach(void (*fn)(ObjectClass *k=
lass, void *opaque),
>>>    * @include_abstract: Whether to include abstract classes.
>>>    *
>>>    * Returns: A singly-linked list of the classes in reverse hashtable =
order.
>>> + *
>>> + * The returned list must be released with g_slist_free()
>>> + * when no longer required.
>>
>> I'd suggest
>>
>>    "The returned list, but not its elements, must be released with
>>     g_slist_free() or g_autoptr when no longer required"
>=20
> As gobject-introspection annotations: "Returns: (transfer container)
> (element-type ObjectClass): A list of #ObjectClass"

Are you suggesting to replace "Returns: A singly-linked list of the=20
classes in reverse hashtable order." by the line you quoted?

>=20
>>
>>>    */
>>>   GSList *object_class_get_list(const char *implements_type,
>>>                                 bool include_abstract);
>>> @@ -995,6 +998,9 @@ GSList *object_class_get_list(const char *implement=
s_type,
>>>    *
>>>    * Returns: A singly-linked list of the classes in alphabetical
>>>    * case-insensitive order.
>>> + *
>>> + * The returned list must be released with g_slist_free()
>>> + * when no longer required.
>>>    */
>>>   GSList *object_class_get_list_sorted(const char *implements_type,
>>>                                 bool include_abstract);
>>> --
>>> 2.21.1
>>>
>>>
>>
>> Regards,
>> Daniel
>> --
>> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberra=
nge :|
>> |: https://libvirt.org         -o-            https://fstop138.berrange.=
com :|
>> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberra=
nge :|
>>
>>
>=20
>=20


