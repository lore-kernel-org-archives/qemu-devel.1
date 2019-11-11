Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A367FC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 20:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9DB20659
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 20:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IA5G0bEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9DB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUGcC-0005HW-JV
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 15:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iUGao-0004ZB-RK
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 15:47:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iUGam-0006pn-Pb
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 15:47:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42414
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iUGam-0006pU-Ip
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 15:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573505239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PtAv/PLlz8h252abMPpdqc9K6uEitM8uzRIV1C9sGck=;
 b=IA5G0bEGT1Ul5H5OuAFURgTRe61ZmNw7xi+eOnrmEWlPFSRsTBTyqtM1qyKu0cbi2c09oP
 FJIBXjRwWK5y4RKOg2sB9mSShhJlOqYJGSTz4HGsSSvjt9skeY/mVyDo7BRHRRC4Hi6GrH
 gJkzP5jDZRclL7WGZ5W7JPtW7OLJEgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-YqRv0YMTP3WuLEmZxI40pg-1; Mon, 11 Nov 2019 15:47:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54D878017E0;
 Mon, 11 Nov 2019 20:47:15 +0000 (UTC)
Received: from [10.3.116.242] (ovpn-116-242.phx2.redhat.com [10.3.116.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C65F5C1B5;
 Mon, 11 Nov 2019 20:47:14 +0000 (UTC)
Subject: Re: [PATCH v6 1/3] block: introduce compress filter driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1573488277-794975-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1573488277-794975-2-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <78fde14e-b573-f7e0-d211-f066c3767b7d@redhat.com>
Date: Mon, 11 Nov 2019 14:47:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1573488277-794975-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: YqRv0YMTP3WuLEmZxI40pg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/11/19 10:04 AM, Andrey Shinkevich wrote:
> Allow writing all the data compressed through the filter driver.
> The written data will be aligned by the cluster size.
> Based on the QEMU current implementation, that data can be written to
> unallocated clusters only. May be used for a backup job.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/Makefile.objs     |   1 +
>   block/filter-compress.c | 212 +++++++++++++++++++++++++++++++++++++++++=
+++++++
>   qapi/block-core.json    |  10 ++-
>   3 files changed, 219 insertions(+), 4 deletions(-)
>   create mode 100644 block/filter-compress.c

> +++ b/qapi/block-core.json
> @@ -2884,15 +2884,16 @@
>   # @copy-on-read: Since 3.0
>   # @blklogwrites: Since 3.0
>   # @blkreplay: Since 4.2
> +# @compress: Since 4.2

Are we still trying to get this in 4.2, even though soft freeze is past?=20
  Or are we going to have to defer it to 5.0 as a new feature?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


