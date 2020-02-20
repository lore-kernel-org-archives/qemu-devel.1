Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D37CC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A56B20658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aX5XdCZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A56B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oIi-0004GC-7X
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j4oHa-0002Ub-PI
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j4oHZ-0001VT-Nt
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:02:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37102
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j4oHZ-0001VI-JS
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582214553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJpezD2KNFbbDvsoaGK8DPS+dV5Ahk9Qu4SROwnM09s=;
 b=aX5XdCZjVkN4sFAgQm3W815rAeFG3hh0rOZimNSw9+EHPqtI2BhLZ3mS8eNIpa0JfJubA6
 oarSWVCJacmpXBgAkZ+oFlzl9MKR6z2OCwhLT8dMIhxRi7icg04dFW5FIFmEYVfpwBkjWM
 yj4esyPUElQDy2ljcZrlS+qo8Putys4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-gQstA_RvMXKKrWkDIKjioQ-1; Thu, 20 Feb 2020 11:02:25 -0500
X-MC-Unique: gQstA_RvMXKKrWkDIKjioQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22B818010FD;
 Thu, 20 Feb 2020 16:02:24 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5965F10027A7;
 Thu, 20 Feb 2020 16:02:23 +0000 (UTC)
Subject: Re: [RFC PATCH v3 05/27] qcow2: Document the Extended L2 Entries
 feature
To: Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
 <0b884ddcd0ac3a3c0b8cdd9d09c74566ac107c9a.1577014346.git.berto@igalia.com>
 <7ff19f65-5148-a40a-9b7a-6a330cf7272e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <fcaace04-17be-66b2-e0aa-6b1c68b11989@redhat.com>
Date: Thu, 20 Feb 2020 10:02:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7ff19f65-5148-a40a-9b7a-6a330cf7272e@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/20/20 9:54 AM, Max Reitz wrote:

>> +Subcluster Allocation Bitmap (for standard clusters):
>> +
>> +    Bit  0 -  31:   Allocation status (one bit per subcluster)
>> +
>> +                    1: the subcluster is allocated. In this case the
>> +                       host cluster offset field must contain a valid
>> +                       offset.
>> +                    0: the subcluster is not allocated. In this case
>> +                       read requests shall go to the backing file or
>> +                       return zeros if there is no backing file data.
>> +
>> +                    Bits are assigned starting from the most significan=
t one.
>> +                    (i.e. bit x is used for subcluster 31 - x)
>=20
> I still prefer it the other way round, both personally (e.g. it=E2=80=99s=
 the C
> ordering), and because other places in qcow2 use LSb for bit ordering
> (the refcount order).

Internal consistency with refcount order using LSb ordering is the=20
strongest reason to flip things, and have bit x be subcluster x.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


