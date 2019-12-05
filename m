Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DCEC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978B024249
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KL+VybSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978B024249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvb6-0008Es-GC
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icvGL-00022t-Ai
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:50:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icvGJ-0003VX-Uu
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:50:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49437
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icvGJ-0003RX-Nu
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575568198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jWVoYb8x9VTh57thCyW8u9A7acacs8cnWBy2auzTy0k=;
 b=KL+VybSEktW35JmpUlCOchRO0m9fljtlhfvNqMcL5tUhs9ewbXlbdYk5bJbq+97L6ts1Y7
 UWi0jKfpxxo6iC+5ak/RYVaYDHec1G8Axw9SxhVN41gJsiHSbE7Ro+Auyo4FIsi3j/XLmJ
 g9FAkGNuu6SQUUAchfqc1zL9MmcEyqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-FZMVmSnsPeSWKfAq0JPJkg-1; Thu, 05 Dec 2019 12:49:57 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5408D800D5E;
 Thu,  5 Dec 2019 17:49:56 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95DD960136;
 Thu,  5 Dec 2019 17:49:55 +0000 (UTC)
Subject: Re: [PATCH v7 21/21] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191205152019.8454-1-vsementsov@virtuozzo.com>
 <20191205152019.8454-22-vsementsov@virtuozzo.com>
 <c4ff448d-e756-9d95-b07e-4ae5f2d5b9b0@redhat.com>
 <93046486-1580-14a1-520d-08abdf74da0e@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <443bfd26-08df-a421-fe88-71b2c068d8e4@redhat.com>
Date: Thu, 5 Dec 2019 11:49:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <93046486-1580-14a1-520d-08abdf74da0e@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: FZMVmSnsPeSWKfAq0JPJkg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 11:39 AM, Vladimir Sementsov-Ogievskiy wrote:
> 05.12.2019 20:14, Eric Blake wrote:
>> On 12/5/19 9:20 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> The local_err parameter is not here to return information about
>>> nbd_iter_channel_error failure. Instead it's assumed to be filled when
>>> passed to the function. This is already stressed by its name
>>> (local_err, instead of classic errp). Stress it additionally by
>>> assertion.
>>>

>>
>> Would it be better to assert(!local_err || *local_err)?=A0 The assertion=
 as written is too strict without ERRP_AUTO_PROPAGATE, but you get away wit=
h it because none of the grandparents pass NULL; but is appropriate as writ=
ten for after after the macro conversion so then we wonder if churn on the =
macro is worth it.
>=20
> We don't have any grandparents, this function is always called on local_e=
rr. And it's argument named local_err to stress it.

Then the commit message should state that. How about:

All callers of nbd_iter_channel_error() pass the address of a local_err=20
variable, and only call this function if an error has already occurred,=20
using this function to append details to that error.  This is already=20
implied by its name (local_err instead of the classic errp), but it is=20
worth additionally stressing this by adding an assertion to make it part=20
of the function contract.

> The function is an API to report error, and it wants filled local_err obj=
ect.
>=20
> It will crash anyway if local_err is NULL, as it dereferences it.
>=20
> I just want to place an assertion at start of functions like this,
> which will be easily recognizable by coccinelle.

With an improved commit message, the assertion makes sense, so

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> ---
>=20
> We can improve the API, to support local_err=3D=3DNULL, for the case when=
 original request was called with
> errp=3D=3DNULL, but for this we'll need more changes, like, pass errp to =
NBD_FOREACH_REPLY_CHUNK and save
> it into iter object...
>=20
> But how to detect it in code? Something like
>=20
>=20
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1059,8 +1059,10 @@ static int nbd_co_receive_blockstatus_reply(BDRVNB=
DState *s,
>            case NBD_REPLY_TYPE_BLOCK_STATUS:
>                if (received) {
>                    nbd_channel_error(s, -EINVAL);
> -                error_setg(&local_err, "Several BLOCK_STATUS chunks in r=
eply");
> -                nbd_iter_channel_error(&iter, -EINVAL, &local_err);
> +                if (errp) {
> +                    error_setg(&local_err, "Several BLOCK_STATUS chunks =
in reply");
> +                }
> +                nbd_iter_channel_error(&iter, -EINVAL, errp ? &local_err=
 : NULL);

No, that's not worth it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


