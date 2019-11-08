Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC56FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE397206A3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCCzuCLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE397206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT3zh-0007Xp-39
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 08:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iT3yg-0006em-PS
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iT3yf-0004qT-Mz
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:07:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54827
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iT3yf-0004pB-4u
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573218420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26Xl/h6sy4WcTAxha8V52LMJ0OaGDmet2gRx9XuF5Tc=;
 b=LCCzuCLOvKj4GiAoUlc5vw9Rg5NbmVHlZbk+5idjWlR14bgwPdA/cO3TZz1ooVzHjXwb37
 TOZdmgmEDs6LGyFw0F7GYujx2PGzA0Up2b3VZYXV4vg94nRpgp6Jd/89KPBGyfwbL2HQjL
 aIZpGMjIsvvrBSH/xoFrmev9AO6oSZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-AL62Mf_KNBq9I3AN4ggp-A-1; Fri, 08 Nov 2019 08:06:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A55F68017DE;
 Fri,  8 Nov 2019 13:06:55 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3E705DA7F;
 Fri,  8 Nov 2019 13:06:24 +0000 (UTC)
Message-ID: <60243f085cf2992c64ff0b025a3cf593523acc87.camel@redhat.com>
Subject: Re: [PATCH v2 0/2] Deprecate implicit filters
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, 
 qemu-block@nongnu.org
Date: Fri, 08 Nov 2019 15:06:23 +0200
In-Reply-To: <20191108101655.10611-1-vsementsov@virtuozzo.com>
References: <20191108101655.10611-1-vsementsov@virtuozzo.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: AL62Mf_KNBq9I3AN4ggp-A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, libvir-list@redhat.com,
 armbru@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 jsnow@redhat.com, dinechin@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-11-08 at 13:16 +0300, Vladimir Sementsov-Ogievskiy wrote:
> v2:
> Don't deprecate drive-backup, it is unrelated thing and will be resent
> in separate.
> Don't deprecate drive-mirror. Instead add filter-node-name to
> drive-mirror to behave like blockdev-mirror
> Fix all broken iotests.

I did a quick overview of these patches (I don't know the area well
to do a full review) and it looks fine to me, other than that FIXME you add=
ed,
which (at least looking at the explanation) I think should be investigated,
as it might point to a deeper problem somewhere.

Also *I think* that I would merge these two patches together,
but this is only my personal taste.

Best regards,
=09Maxim Levitsky


>=20
> Vladimir Sementsov-Ogievskiy (2):
>   qapi: add filter-node-name option to drive-mirror
>   qapi: deprecate implicit filters
>=20
>  qemu-deprecated.texi       |  6 ++++++
>  qapi/block-core.json       | 14 ++++++++++++--
>  include/block/block_int.h  | 10 +++++++++-
>  blockdev.c                 | 12 +++++++++++-
>  tests/qemu-iotests/094     |  1 +
>  tests/qemu-iotests/095     |  6 ++++--
>  tests/qemu-iotests/109     |  1 +
>  tests/qemu-iotests/127     |  1 +
>  tests/qemu-iotests/141     |  5 ++++-
>  tests/qemu-iotests/144     |  3 ++-
>  tests/qemu-iotests/156     |  1 +
>  tests/qemu-iotests/161     |  7 +++++++
>  tests/qemu-iotests/161.out |  1 +
>  tests/qemu-iotests/185     |  3 +++
>  tests/qemu-iotests/191     |  2 ++
>  tests/qemu-iotests/229     |  1 +
>  tests/qemu-iotests/247     |  8 +++++---
>  tests/qemu-iotests/249     |  5 +++--
>  tests/qemu-iotests/249.out |  2 +-
>  19 files changed, 75 insertions(+), 14 deletions(-)
>=20



