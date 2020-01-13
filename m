Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB576C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B822080D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBs7I6+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B822080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir2Pf-0005qI-8Z
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ir2O7-0004Ud-HD
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:16:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ir2O6-0006II-9b
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:16:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40788
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ir2O6-0006Hu-5U
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578932181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDhmRhuHSjR4XtIp/pjF91sCXnqbXFLjZvhBGAcYOZg=;
 b=MBs7I6+2insvZGIrgd00ydnu4z14F1EAarOP8tyXNtpSlmp11Jh6MsUrFmbqZh2uaK8QQg
 B/R3PwpbUJhr2JitVxhIAz3h0OKv7igSEQ3KccZQw8Tt8iNzlenu2/4M3IQNMpnFd1+w0i
 8KZ4b+agayQKGCbTvdKmQ8vOEasthH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-3tTUtMlhOwuP0L9yXFj__g-1; Mon, 13 Jan 2020 11:16:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6C2264A7E;
 Mon, 13 Jan 2020 16:16:15 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5CEE77E8E;
 Mon, 13 Jan 2020 16:16:14 +0000 (UTC)
Subject: Re: [PATCH 2/2] qcow2: dump QCOW2 metadata
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <1577447039-400109-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1577447039-400109-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <d87d183d-cd69-1994-11d0-5767ec72589e@redhat.com>
 <be0bf681-5551-c5ec-e7b3-3589fb230176@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cedf0e08-8994-a892-85dc-bf0dea221163@redhat.com>
Date: Mon, 13 Jan 2020 10:16:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <be0bf681-5551-c5ec-e7b3-3589fb230176@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3tTUtMlhOwuP0L9yXFj__g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/13/20 4:30 AM, Andrey Shinkevich wrote:

>>> -=A0=A0=A0=A0=A0=A0=A0 c =3D getopt_long(argc, argv, ":hf:r:T:qU",
>>> +=A0=A0=A0=A0=A0=A0=A0 c =3D getopt_long(argc, argv, ":hf:r:T:qU:M",
>>
>> We are already inconsistent, but I tend to add options in alphabetical
>> order, both here...
>>
>=20
> If I merely move 'M' forward like ':hf:M:r:T:qU', will it be OK?
>=20

If you don't mind writing a pre-requisite patch that sorts the existing=20
options, then the patch adding your option in sorted order is easy. But=20
that's asking you to do extra work, which I'm not going to insist on, so=20
I can also live with your patch being in any order as it is no worse=20
than existing code and anyone that wants to do a cleanup patch to sort=20
things has roughly the same level of effort whether or not your patch=20
without sorting lands in the meantime.


>>> +=A0=A0=A0 if ((fix & BDRV_DUMP_META) && output_format !=3D OFORMAT_JSO=
N) {
>>> +=A0=A0=A0=A0=A0=A0=A0 error_report("Metadata output in JSON format onl=
y");
>>> +=A0=A0=A0=A0=A0=A0=A0 return 1;
>>
>> Why this restriction?
>>
>=20
> This is to remind a user that '-M' can be effective with the option
> '--output=3Djson' only. Do you think that a comment in the qemu-img.texi
> would be enough and the restriction should be omitted here?

Rather, why can't we come up with some sort of sane human output, so=20
that we don't have to limit the flag to just --output=3Djson?

>>> +++ b/qemu-img.texi
>>> @@ -230,7 +230,7 @@ specified as well.
>>>  =A0 For write tests, by default a buffer filled with zeros is written.
>>> This can be
>>>  =A0 overridden with a pattern byte specified by @var{pattern}.
>>> -@item check [--object @var{objectdef}] [--image-opts] [-q] [-f
>>> @var{fmt}] [--output=3D@var{ofmt}] [-r [leaks | all]] [-T
>>> @var{src_cache}] [-U] @var{filename}
>>> +@item check [--object @var{objectdef}] [--image-opts] [-M] [-q] [-f
>>> @var{fmt}] [--output=3D@var{ofmt}] [-r [leaks | all]] [-T
>>> @var{src_cache}] [-U] @var{filename}
>>
>> This mentions that -M is valid, but has no further documentation on what
>> -M means.=A0 Without that, it's anyone's guess.
>>
>=20
> Thank you Eric, I really missed to supply a comment for the new option
> here and am going to put it below. Should I mention that option in
> qapi/block-core.json file also with this patch of the series?

Mentioning that the qapi type exists to facilitate a qemu-img option=20
might not hurt. But more important is that the qemu-img documentation=20
mentions what -M does; that documentation can point to the qapi docs for=20
how the output will be structured when --output=3Djson is in effect.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


