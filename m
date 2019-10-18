Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0953ACA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F8E20663
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F8E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVEl-0002lt-V5
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iLVDO-0001dF-TM
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iLVDN-0002bd-OV
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:34:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iLVDJ-0002Yc-TL; Fri, 18 Oct 2019 12:34:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DD4B61017C0D;
 Fri, 18 Oct 2019 16:34:52 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 765495C21A;
 Fri, 18 Oct 2019 16:34:49 +0000 (UTC)
Subject: Re: [PATCH 08/10] nbd/server: introduce NBDExtentArray
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190930151502.7829-1-vsementsov@virtuozzo.com>
 <20190930151502.7829-9-vsementsov@virtuozzo.com>
 <c56a7e0c-50df-1ad7-6c6e-d4c3fe52132f@redhat.com>
 <ffee3ef7-d931-bcac-be82-2ae3533aa981@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <39449490-8cea-0387-6840-96bc06af55b2@redhat.com>
Date: Fri, 18 Oct 2019 11:34:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <ffee3ef7-d931-bcac-be82-2ae3533aa981@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 18 Oct 2019 16:34:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 11:07 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>  =C2=A0 static int nbd_co_send_extents(NBDClient *client, uint64_t ha=
ndle,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDExtent *extents, unsigned int nb_=
extents,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t length, bool last,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t context_id, Error **errp)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDExtentArray *ea,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool last, uint32_t context_id, Erro=
r **errp)
>>>  =C2=A0 {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDStructuredMeta chunk;
>>> -
>>> +=C2=A0=C2=A0=C2=A0 size_t len =3D ea->count * sizeof(ea->extents[0])=
;
>>> +=C2=A0=C2=A0=C2=A0 g_autofree NBDExtent *extents =3D g_memdup(ea->ex=
tents, len);
>>
>> Why do we need memdup here?=C2=A0 What's wrong with modifying ea->exte=
nts in place?...
>=20
> To not make ea to be IN-OUT parameter.. I don't like functions with sid=
e effects.
> It will break the code if at some point we call nbd_co_send_extents twi=
ce on same
> ea object.
>=20
> What is the true way? To not memdup, nbd_co_send_extents should consume=
 the whole
> ea object..
>=20
> Seems, g_autoptr attribute can't be used for function parameter, gcc co=
mplains:
> nbd/server.c:1983:32: error: =E2=80=98cleanup=E2=80=99 attribute ignore=
d [-Werror=3Dattributes]
>    1983 |                                g_autoptr(NBDExtentArray) ea,
>         |                                ^~~~~~~~~
>=20
> so, is it better
> to call nbd_co_send_external(... g_steal_pointer(&ea) ...)
>=20
> and than in nbd_co_send_external do
>=20
> g_autoptr(NBDExtentArray) local_ea =3D ea;
> NBDExtent *extents =3D local_ea->extents;
>=20
> ?
>=20

No, that makes it worse.  It's that much more confusing to track who is=20
allocating what and where it gets cleaned up.

I personally don't see the need to avoid jumping through hoops to avoid=20
an in-out parameter (if we're going to rework code later, we'll notice=20
that we documented how things are supposed to be used), but if in-out=20
parameters bother you, then the approach you used, even with an extra=20
memdup(), is the simplest way to maintain, even if it is not the most=20
efficient.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

