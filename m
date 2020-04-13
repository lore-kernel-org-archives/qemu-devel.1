Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66FFC2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 21:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6983F206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 21:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hq3mTJh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6983F206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO6rl-0002bS-Et
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 17:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jO6r8-000204-1O
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 17:43:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jO6r6-0003ph-Db
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 17:43:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29589
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jO6r6-0003pa-AP
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 17:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586814179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6MZrXoNEQ7P2KkLRW9gmiVdE/YryKPAaJMzH1bLmrUI=;
 b=Hq3mTJh8I6m23Um0Uz9zXUeZhIQLl+W7EDkI9W0FLYvbLwxcBH24cDPr71N1yXh2c4J1tW
 XWaQ03IBnlsLw6VYfoPrRTfYsiWdjntjg7nHHBWgxeGdwOB5oz+0lQFdXdYpGvbX1pqGC/
 wfJG+qfdwRqHs6/hY/b9sXcuHFblGW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-XNoe7I5INguOSRN3g82AVQ-1; Mon, 13 Apr 2020 17:42:55 -0400
X-MC-Unique: XNoe7I5INguOSRN3g82AVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 654E21926DA7;
 Mon, 13 Apr 2020 21:42:54 +0000 (UTC)
Received: from [10.3.115.59] (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D7E41001B2C;
 Mon, 13 Apr 2020 21:42:54 +0000 (UTC)
Subject: Re: [PATCH] .gitignore: include common build sub-directories
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200413162902.7985-1-alex.bennee@linaro.org>
 <2c489489-f459-f029-029e-74bfbfc70e49@redhat.com> <87imi38433.fsf@linaro.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d97c8034-2a9f-fe26-c70b-49b4d19f800d@redhat.com>
Date: Mon, 13 Apr 2020 16:42:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87imi38433.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/13/20 4:32 PM, Alex Benn=C3=A9e wrote:
>=20
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 4/13/20 11:29 AM, Alex Benn=C3=A9e wrote:
>>> As out-of-tree builds become more common (or rather building in a
>>> subdir) we can add a lot of load to "git ls-files" as it hunts down
>>> sub-directories that are irrelevant to the source tree. This is
>>> especially annoying if you have a prompt that attempts to summarise
>>> the current git status on command completion.
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>    .gitignore | 2 ++
>>>    1 file changed, 2 insertions(+)
>>> diff --git a/.gitignore b/.gitignore
>>> index 0c5af83aa74..7757dc08a08 100644
>>> --- a/.gitignore
>>> +++ b/.gitignore
>>> @@ -141,6 +141,8 @@ cscope.*
>>>    tags
>>>    TAGS
>>>    docker-src.*
>>> +build
>>> +builds
>>
>> Would 'build-*' be worth adding as well?
>=20
> Sure - I'll add it to v2.

Or even consolidate it into a single pattern: build* (which would allow=20
'build', 'builds', 'build1', 'build23', 'build-fedora', 'build-bug1234',=20
...)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


