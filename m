Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCC5C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658BB206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hF1yhJVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658BB206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVHBQ-0003yS-IZ
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 10:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iVGuP-0001Tk-NH
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:19:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iVGuO-0002ZK-Gp
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:19:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23870
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iVGuO-0002YL-Di
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573744783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyUPHaTJDjj7Ag4PJhQWkAdvKDcqO1RvgP62SUyqcOk=;
 b=hF1yhJVHhAqbIy0n+HtNIN0h/FCzNEO7DkSofSLpk/JhJQimjiituUf3lxqrXypFrkO+vX
 iU7hYlokXhKKYNMAqY7HPubpabU4eJBrYwyNWmaeHJM+03kK+llX/KHwnbEfwL7YpMlvve
 YVPWgfGwYtGV7+82ez9ot5ErOgV40oo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-d_l3zHejPvKAPXhW5rBX6A-1; Thu, 14 Nov 2019 10:19:40 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AABAF8034E2;
 Thu, 14 Nov 2019 15:19:39 +0000 (UTC)
Received: from [10.3.116.242] (ovpn-116-242.phx2.redhat.com [10.3.116.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63C2F10013A1;
 Thu, 14 Nov 2019 15:19:39 +0000 (UTC)
Subject: Re: [PATCH] MAINTAINERS: add more bitmap-related to Dirty Bitmaps
 section
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191026165655.14112-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e0382af1-1da0-3e70-ccd8-d965fcbd8eb6@redhat.com>
Date: Thu, 14 Nov 2019 09:19:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191026165655.14112-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: d_l3zHejPvKAPXhW5rBX6A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/19 11:56 AM, Vladimir Sementsov-Ogievskiy wrote:
> Let's add bitmaps persistence qcow2 feature and postcopy bitmaps
> migration to Dirty Bitmaps section.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
>=20

I see no reason why this can't go in -rc2, so I'll queue it through my=20
NBD tree.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 556ce0bfe3..51f31b4011 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1829,6 +1829,8 @@ F: util/hbitmap.c
>   F: block/dirty-bitmap.c
>   F: include/qemu/hbitmap.h
>   F: include/block/dirty-bitmap.h
> +F: qcow2-bitmap.c
> +F: migration/block-dirty-bitmap.c
>   F: tests/test-hbitmap.c
>   F: docs/interop/bitmaps.rst
>   T: git https://github.com/jnsnow/qemu.git bitmaps
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


