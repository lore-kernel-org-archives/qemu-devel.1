Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44855C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 13:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 193BC2133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 13:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193BC2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK0oN-0001LV-A0
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 09:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iK0nS-0000Sa-9d
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iK0nQ-0003kJ-Px
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:54:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iK0nH-0003W2-5k; Mon, 14 Oct 2019 09:53:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E2DCB10DCC8F;
 Mon, 14 Oct 2019 13:53:43 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ED185D6A7;
 Mon, 14 Oct 2019 13:53:43 +0000 (UTC)
Subject: Re: [PATCH v3 07/16] qcow2: Write v3-compliant snapshot list on
 upgrade
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191011152814.14791-1-mreitz@redhat.com>
 <20191011152814.14791-8-mreitz@redhat.com>
 <a9263c74-f958-5859-9db3-a67aefe73ff5@redhat.com>
 <085c7aec-edd7-79bd-136f-5a3785a5d430@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <582dc245-8a09-f88e-d67c-9435200c327d@redhat.com>
Date: Mon, 14 Oct 2019 08:53:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <085c7aec-edd7-79bd-136f-5a3785a5d430@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Mon, 14 Oct 2019 13:53:43 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 3:45 AM, Max Reitz wrote:

>>> +=C2=A0=C2=A0=C2=A0 need_snapshot_update =3D false;
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < s->nb_snapshots; i++) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->snapshots[i].extra=
_data_size <
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
izeof_field(QCowSnapshotExtraData, vm_state_size_large) +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
izeof_field(QCowSnapshotExtraData, disk_size))
>>
>> Shorter as:
>> if (s->snapshots[i].extra_data_size < sizeof(QCowSnapshotExtraData))
>>
>> but that's stylistic, so R-b still stands.
>=20
> Yes, but if we ever add fields to QCowSnapshotExtraData, we shouldn=E2=80=
=99t
> count them here.  Therefore, I think we need to count exactly the field=
s
> that the standard says are mandatory in v3.

If we ever add more fields, I'd prefer that we did something like:

struct QCowSnapshotExtraV3Minimum {
     uint64_t vm_state_size_large;
     uint64_t disk_size;
};
struct QCow3SnapshotExtraFull {
     struct QCowSnapshotExtraV3Minimum base;
     new fields...;
};

and use sane naming to get at extra members based on the expected types,=20
rather than trying to piecemeal portions of a type based on size.

Until we actually DO add more fields, why do we have to complicate the=20
current code?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

