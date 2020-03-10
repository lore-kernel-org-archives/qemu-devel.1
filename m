Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03D5C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE21C227BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvYcyEuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE21C227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBfqx-00064V-AN
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 10:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jBfpx-0004zS-Eb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jBfpw-0004w2-4O
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:26:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56371
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jBfpw-0004t4-0O
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583850382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fUZDLqvneGWKJ8CIVbMKBmTsOXTVU5yYM1ftKRO0XA=;
 b=EvYcyEuByKWyQllHOiW+NbICNFtmAz2tlSiHzHNGSejHdNeFSv699JHb/hk62snVKbGsEr
 F6UbOWp7TNhIY0LPU5dieZeozjl9RhmronOGkBEUUzvhumLOQyXrkzq6e4hpTy0icXLOS5
 vHx1vAoFb/YNlBTurDSRmi6bD9pomi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-RqgAFTPTPpC-Yyz-HGakYg-1; Tue, 10 Mar 2020 10:26:20 -0400
X-MC-Unique: RqgAFTPTPpC-Yyz-HGakYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0926B18C8C25;
 Tue, 10 Mar 2020 14:26:19 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.104])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A9D019C6A;
 Tue, 10 Mar 2020 14:26:15 +0000 (UTC)
Date: Tue, 10 Mar 2020 15:26:14 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Chen Qun <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH v3 02/12] block/iscsi:Remove redundant statement in
 iscsi_open()
Message-ID: <20200310142614.GF6926@linux.fritz.box>
References: <20200302130715.29440-1-kuhn.chenqun@huawei.com>
 <20200302130715.29440-4-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200302130715.29440-4-kuhn.chenqun@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 qemu-trivial@nongnu.org, Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.03.2020 um 14:07 hat Chen Qun geschrieben:
> Clang static code analyzer show warning:
>   block/iscsi.c:1920:9: warning: Value stored to 'flags' is never read
>         flags &=3D ~BDRV_O_RDWR;
>         ^        ~~~~~~~~~~~~
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Lieven <pl@kamp.de>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
>=20
> v1->v2:
>  Keep the 'flags' then use it(Base on Kevin's comments).

I think this patch wants a different subject line now.

> diff --git a/block/iscsi.c b/block/iscsi.c
> index 682abd8e09..50bae51700 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -2002,7 +2002,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *=
options, int flags,
>          iscsilun->cluster_size =3D iscsilun->bl.opt_unmap_gran *
>              iscsilun->block_size;
>          if (iscsilun->lbprz) {
> -            ret =3D iscsi_allocmap_init(iscsilun, bs->open_flags);
> +            ret =3D iscsi_allocmap_init(iscsilun, flags);
>          }
>      }

The code looks good.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


