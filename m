Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBB2C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 195C420672
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNYL5jZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195C420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXqqD-0008Fn-05
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 13:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iXqpJ-0007dJ-U3
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iXqpH-0001Uf-LJ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:05:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41862
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iXqpG-0001Tn-To
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574359505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jlFK5Yy+zkY0w/kMZJ8nP/nLBvbCZQn/gPw7+sEmQs=;
 b=KNYL5jZHEqpsLQssxYGNhQy6SRM+qE7e07yhAmizfCtTDphlDzGSwl+/daENO9EVMhQhz0
 o2wqfFeDJGqit2GSusmn302GBfhsYQDvbRjirsu/1rVUFKfsNLGNBD+YQ5/gWkDbGh1FTp
 h1oVqIyKqp+idPG2o4JPrOAsNaai0aE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-CpugOwuEPPGaEasKmRuOEA-1; Thu, 21 Nov 2019 13:05:02 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C62B8024C9;
 Thu, 21 Nov 2019 18:05:01 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7743B2AAAF;
 Thu, 21 Nov 2019 18:04:59 +0000 (UTC)
Subject: Re: [PATCH 1/4] block/quorum.c: stable children names
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
References: <cover.1574356137.git.lukasstraub2@web.de>
 <ce10f8cf2bb9ae8a1505b59bbc2199f7b4966990.1574356137.git.lukasstraub2@web.de>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2ce1be55-010b-d3c3-9df4-e8e02eb522f9@redhat.com>
Date: Thu, 21 Nov 2019 12:04:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ce10f8cf2bb9ae8a1505b59bbc2199f7b4966990.1574356137.git.lukasstraub2@web.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: CpugOwuEPPGaEasKmRuOEA-1
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 11:49 AM, Lukas Straub wrote:
> If we remove the child with the highest index from the quorum,
> decrement s->next_child_index. This way we get stable children
> names as long as we only remove the last child.
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>   block/quorum.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>=20
> diff --git a/block/quorum.c b/block/quorum.c
> index df68adcfaa..6100d4108a 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -1054,6 +1054,12 @@ static void quorum_del_child(BlockDriverState *bs,=
 BdrvChild *child,
>       /* We know now that num_children > threshold, so blkverify must be =
false */
>       assert(!s->is_blkverify);
>=20
> +    unsigned child_id;
> +    sscanf(child->name, "children.%u", &child_id);

sscanf() cannot detect overflow. Do we trust our input enough to ignore=20
this shortfall in the interface, or should we be using saner interfaces=20
like qemu_strtoul()?  For that matter, why do we have to reparse=20
something; is it not already available somewhere in numerical form?

> +    if (child_id =3D=3D s->next_child_index - 1) {
> +        s->next_child_index--;
> +    }
> +
>       bdrv_drained_begin(bs);
>=20
>       /* We can safely remove this child now */
> --
> 2.20.1
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


