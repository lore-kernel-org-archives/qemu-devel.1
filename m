Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C11CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA915222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA915222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSUF-0003QJ-Qw
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iLSTH-0002Y5-KC
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iLSTG-0000lT-En
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:39:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iLSTD-0000kB-Pw; Fri, 18 Oct 2019 09:39:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CA32D307C65B;
 Fri, 18 Oct 2019 13:39:06 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D7D5194BE;
 Fri, 18 Oct 2019 13:39:05 +0000 (UTC)
Subject: Re: [PATCH v7 1/2] docs: improve qcow2 spec about extending image
 header
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191007160451.27334-1-vsementsov@virtuozzo.com>
 <20191007160451.27334-2-vsementsov@virtuozzo.com>
 <7afa803e-3efd-1186-2b37-7056d9a983f0@redhat.com>
 <90102485-ccbb-018c-c90d-b85a7b2f0392@virtuozzo.com>
 <2d60f7aa-7f3a-18f2-434f-0ab176924be2@virtuozzo.com>
 <b157b428-4f30-ddad-2eb6-78bd9ca3bc21@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <37a0d4f3-6967-1115-fbea-43d5ce5c6973@redhat.com>
Date: Fri, 18 Oct 2019 08:39:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <b157b428-4f30-ddad-2eb6-78bd9ca3bc21@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 18 Oct 2019 13:39:07 +0000 (UTC)
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 4:27 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>> I would suggest a stronger requirement:
>>>>
>>>> header_length must be a multiple of 4, and must not land in the midd=
le of any optional 8-byte field.
>>>>
>>>> Or maybe even add our compression type extension with 4 bytes of pad=
ding, so that we could go even stronger:
>>>>
>>>> header_length must be a multiple of 8.
>>>
>>> Hmm, if we imply that software will have to add some padding, than re=
quirement above about zero =3D=3D=3D feature-absence
>>> becomes necessary. [*]
>>>
>>> Still I have two questions:
>>> 1. Do we really need all fields to be 4 or 8 bytes? Why not use 1 byt=
e for compression?

No, fields can be smaller if that makes sense; but I still think it's=20
important that fields don't straddle natural alignment boundaries. When=20
adding just one field at a time, it's easier to add a wide field and=20
less padding than a narrow field and lots of padding, if we're still=20
striving for alignment.

>>> 2. What is the benefit of padding, which you propose?

The biggest benefit to keeping large fields from straddling alignment=20
boundaries is that you can mmap() a qcow2 file and do naturally-aligned=20
reads of those large fields, rather than byte-by-byte reads, without=20
risking SIGBUS on some architectures.  (You still have to worry about=20
endianness, but that's true regardless of alignment)


>> So, it looks inconsistent, if we pad all header extensions to=C2=A0 8 =
bytes except for the start of the first extension.
>>
>> I'll resend with padding soon.
>=20
>=20
> Still, we have to make an exception at least for header_length =3D 104,=
 which is not a multiply of 8.

Huh?  104 =3D=3D 8 * 13, so our current v3 header size is 8-byte aligned.=
=20
Likewise for 72 =3D=3D 8 * 9 for v2 header size.

>=20
> Also, is requiring alignment is an incompatible change of specification=
?

No. I think it is just clarifying what was implicitly already  the case.=20
  Remember, immediately after the header comes header extensions, and=20
THOSE are explicitly required to be multiple-of-8 in size.  That=20
requirement makes no sense unless the header itself ends on an 8-byte=20
alignment (which it does for all existing v2 and v3 images prior to our=20
first official v3 header extension).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

