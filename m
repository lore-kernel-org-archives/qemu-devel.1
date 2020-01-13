Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0D7C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D13206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OH+O0aP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D13206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir3WP-0000U6-9g
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 12:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ir3VX-00089K-K4
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ir3VW-00078K-1U
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:28:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46134
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ir3VV-00076p-UH
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578936485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omJdc+kRH7tYTH71npeaK2HFeumr9RwLWuSbMlb9x94=;
 b=OH+O0aP5t2hyPTmM874bl7tgBEPKf6QjULz5d6zcKI4sf2WEi+i9Iz9hcI5dzRiOiuTtDY
 rRs79TiMCbofWCv9Rl94FGGGxDbL5x3qY1TEfRjQ5JpuO7jYHYc4/GuS6eevlQCop4nJB8
 eHISFpgz30mznY6CaP1RuUWAGNbL+TY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-Xx54yrBqOA6Yj8iVxNvbgw-1; Mon, 13 Jan 2020 12:28:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 064E691222;
 Mon, 13 Jan 2020 17:28:01 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 350C864435;
 Mon, 13 Jan 2020 17:27:59 +0000 (UTC)
Subject: Re: [PATCH 2/2] qcow2: dump QCOW2 metadata
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <1577447039-400109-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1577447039-400109-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <d87d183d-cd69-1994-11d0-5767ec72589e@redhat.com>
 <be0bf681-5551-c5ec-e7b3-3589fb230176@virtuozzo.com>
 <cedf0e08-8994-a892-85dc-bf0dea221163@redhat.com>
 <da049f97-9eac-9c07-cf4b-a390d8c24000@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a2394db7-589a-a8e4-2945-8de8d7f97589@redhat.com>
Date: Mon, 13 Jan 2020 11:27:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <da049f97-9eac-9c07-cf4b-a390d8c24000@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Xx54yrBqOA6Yj8iVxNvbgw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/13/20 11:02 AM, Andrey Shinkevich wrote:

>>>>> +++ b/qemu-img.texi
>>>>> @@ -230,7 +230,7 @@ specified as well.
>>>>>  =A0=A0 For write tests, by default a buffer filled with zeros is wri=
tten.
>>>>> This can be
>>>>>  =A0=A0 overridden with a pattern byte specified by @var{pattern}.
>>>>> -@item check [--object @var{objectdef}] [--image-opts] [-q] [-f
>>>>> @var{fmt}] [--output=3D@var{ofmt}] [-r [leaks | all]] [-T
>>>>> @var{src_cache}] [-U] @var{filename}
>>>>> +@item check [--object @var{objectdef}] [--image-opts] [-M] [-q] [-f
>>>>> @var{fmt}] [--output=3D@var{ofmt}] [-r [leaks | all]] [-T
>>>>> @var{src_cache}] [-U] @var{filename}
>>>>
>>>> This mentions that -M is valid, but has no further documentation on wh=
at
>>>> -M means.=A0 Without that, it's anyone's guess.
>>>>
>>>
>>> Thank you Eric, I really missed to supply a comment for the new option
>>> here and am going to put it below. Should I mention that option in
>>> qapi/block-core.json file also with this patch of the series?
>>
>> Mentioning that the qapi type exists to facilitate a qemu-img option
>> might not hurt. But more important is that the qemu-img documentation
>> mentions what -M does; that documentation can point to the qapi docs for
>> how the output will be structured when --output=3Djson is in effect.
>>
>=20
> Would you please specify the qemu-img and qapi documentation files to
> modify? Thank you.

I'm thinking that qemu-img.texi can simply mention something like "see=20
type XYZ in the QAPI docs for how the JSON output will be formatted",=20
and then your QAPI documentation already added in patch 1/2 is then=20
sufficient to cover the details of what -M exposes here.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


