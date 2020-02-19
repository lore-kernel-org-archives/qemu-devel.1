Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DFAC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C086624654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5y7UMjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C086624654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4PTH-0002ap-UP
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 08:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j4PRj-0001Df-EE
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j4PRh-0006aX-In
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:31:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23471
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j4PRh-0006ZT-An
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582119080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ILmUHEW6soqnqSDSbCXN9T5GP/0M4VgjRZchziPQ3nM=;
 b=E5y7UMjy071lvWBgZdetly9PgdOUyB3THQj6L4edfFFko3ieqdd3Dak0qurrJ0Pz6gX2Qd
 szJeNrJDQxdHV4JHb3bj4m1V7+LGcR9EXTsxO+Jz4rBjEoN4iEg57OHwKhGzJFS3bQxnHF
 bGDHpPC+w5b3fjBamDOhB8edHFEMvrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-A0F-WgKyMyG43vwQ_qtzpQ-1; Wed, 19 Feb 2020 08:31:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 674D518A8C91;
 Wed, 19 Feb 2020 13:31:11 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 02335171D6;
 Wed, 19 Feb 2020 13:31:08 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] finish qemu-nbd --partition deprecation
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200123164650.1741798-1-eblake@redhat.com>
 <b3fe3a5b-0692-fb35-55ec-281fc2699e98@redhat.com>
 <2bc36642-3ba6-b44b-c89d-959e04795d20@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e6eab244-bc56-051b-20bf-24e217903805@redhat.com>
Date: Wed, 19 Feb 2020 07:31:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2bc36642-3ba6-b44b-c89d-959e04795d20@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: A0F-WgKyMyG43vwQ_qtzpQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org,
 "libvirt-list@redhat.com" <libvirt-list@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/19/20 4:53 AM, Max Reitz wrote:
> On 31.01.20 18:11, Eric Blake wrote:
>> ping
>=20
> Do you want further review or is J=C3=A1n=E2=80=99s sufficient for you?

Commit 0bc16997 has already landed, so no further review will show in=20
git history. But you're always welcome to raise issues that might result=20
in follow-up patches.

>=20
> Also, I wonder whether it would make a good GSoC/Outreachy/... project
> to add partition reading support to the raw block driver, or whether
> that=E2=80=99s a bad idea. O:-)

Personally, I think that since nbdkit already provides a good partition=20
filter [1], any other implementation of a partition filter is duplicated=20
effort.  The only reason to teach qemu how to access an arbitrary=20
partition is if it makes serving that arbitrary partition to a guest=20
more efficient than what is currently possible by pointing qemu at an=20
NBD server run by nbdkit with its partition filter.  But in general, you=20
are more likely to want qemu to serve an entire disk image file to the=20
guest (and let the guest interpret partitions embedded within that file)=20
than to have qemu serve a single partition to a guest (and have the=20
guest treat that partition as a bare disk), so I don't see it as=20
something that would be frequently used or needed in qemu.

[1] http://libguestfs.org/nbdkit-partition-filter.1.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


