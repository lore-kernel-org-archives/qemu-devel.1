Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1AFC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 22:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E1320637
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 22:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5HN+E0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E1320637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieR8V-00082F-MM
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 17:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ieR7q-0007XE-JJ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 17:03:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ieR7p-0006In-EW
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 17:03:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46435
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ieR7p-0006FK-BV
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 17:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575929008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xe/5HCmd2rUcG7e6Lslz90H4wg9/YoajpdPrAoDnwkA=;
 b=C5HN+E0M8hbaNnaX3tGNd1Bw/AQpy8giiMP43cFqH69Lo3nZ1D0pVIzN+G6UZ+3HgGiw4m
 kOgO+QUWa2C+NTD994iALiv/4wDMHkWQKggBFgVEagC2ArZGEx3+e55QP+FvXZ00rUwref
 QxyTK7De+yRlLznsXx/Mjfkpbu7cAto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-G0ORfQboPd-J7ElE4Ky-dQ-1; Mon, 09 Dec 2019 17:03:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50AA08017DF;
 Mon,  9 Dec 2019 22:03:24 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06B6760BE0;
 Mon,  9 Dec 2019 22:03:19 +0000 (UTC)
Subject: Re: [bugfix ping2] Re: [PATCH v2 0/2] fix
 qcow2_can_store_new_dirty_bitmap
To: Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191014115126.15360-1-vsementsov@virtuozzo.com>
 <e89b8844-26c7-0768-f6dd-6faa814551e2@virtuozzo.com>
 <0db82122-ee0d-a346-cb49-d902d5d66b77@virtuozzo.com>
 <cbba2b12-da7d-eed8-1f6b-fc2412f82ff8@redhat.com>
 <a67b4a16-773c-52c8-288a-0e9e032b4589@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <466a95d3-e808-02d1-94df-27bf1e4e13ee@redhat.com>
Date: Mon, 9 Dec 2019 16:03:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a67b4a16-773c-52c8-288a-0e9e032b4589@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: G0ORfQboPd-J7ElE4Ky-dQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 11:58 AM, Max Reitz wrote:
> On 09.12.19 17:30, Max Reitz wrote:
>> On 02.12.19 15:09, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi again!
>>>
>>> Still forgotten bug-fix :(
>>>
>>> Is it too late for 4.2?
>>
>> Sorry. :-/
>>
>> Yes, I think I just forgot it.  I don=E2=80=99t think it=E2=80=99s too i=
mportant for
>> 4.2, so, well, it isn=E2=80=99t too bad, but...  Sorry.
>>
>>> I can't imagine better test, and it tests exactly what written in
>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1712636
>>>
>>> (Hmm, actually, I doubt that it is real use-case, more probably it's a =
bug in management layer)
>>>
>>> So, take this with test or without test, to 4.2 or 5.0.
>>
>> I was thinking of seeing whether I could write a quicker test, but of
>> course we should take the patch either way.
>=20
> OK, I give up.  It=E2=80=99s very much possible to create an image with 6=
5535
> bitmaps very quickly (like, under a second) outside of qemu, but just
> opening it takes 2:30 min (because of the quadratic complexity of
> checking whether a bitmap of the same name already exists).

Can we fix that to use a hash table for amortized O(1) lookup rather=20
than the current O(n) lookup?

But such a fix is 5.0 material.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


