Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD51C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D83A20838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzimdG6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D83A20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04X2-00035A-Mt
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:22:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j04WB-00017z-Pn
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j04WA-0005fo-HF
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:22:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20883
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j04WA-0005fZ-Dj
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581085322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eQfAzTwlVM2OYnutHJNomAK7rGHwnqHEPD+pu1p48mI=;
 b=ZzimdG6eiumghKgE0RznfkjVWOQJU54ovwGi90jOFqzi9cYUIF8VTgzfY7wTMjaCez7vc+
 r4rHjnyZ0srHVA8F8mu21fiDr4QFaau4hyIbefykZZpyEQiju/5mus5zAThs5/8n8MsRxO
 WeaQbcDgRdCMypiTVMOaPcsOA90AGFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-3LUA86Q-MheKNEpMSscnHw-1; Fri, 07 Feb 2020 09:21:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18D2D8C02BE;
 Fri,  7 Feb 2020 14:21:57 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-156.ams2.redhat.com [10.36.116.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E35E360BEC;
 Fri,  7 Feb 2020 14:21:47 +0000 (UTC)
Date: Fri, 7 Feb 2020 15:21:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/3] MAINTAINERS: Cover qapi/block{-core}.json in 'Block
 layer core' section
Message-ID: <20200207142146.GF6031@linux.fritz.box>
References: <20200207103012.27049-1-philmd@redhat.com>
 <20200207103012.27049-3-philmd@redhat.com>
 <87blqaqyxi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87blqaqyxi.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 3LUA86Q-MheKNEpMSscnHw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.02.2020 um 15:01 hat Markus Armbruster geschrieben:
> Philippe Mathieu-Daud=E9 <philmd@redhat.com> writes:
>=20
> > List this file in the proper section, so maintainers get
> > notified when it is modified.
> >
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: Max Reitz <mreitz@redhat.com>
> > Cc: qemu-block@nongnu.org
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 903831e0a4..e269e9092c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1842,6 +1842,8 @@ S: Supported
>    Block layer core
>    M: Kevin Wolf <kwolf@redhat.com>
>    M: Max Reitz <mreitz@redhat.com>
>    L: qemu-block@nongnu.org
>    S: Supported
> >  F: block*
> >  F: block/
> >  F: hw/block/
> > +F: qapi/block.json
> > +F: qapi/block-core.json
> >  F: include/block/
> >  F: qemu-img*
> >  F: docs/interop/qemu-img.rst
>=20
> This is in addition to
>=20
>     Block QAPI, monitor, command line
>     M: Markus Armbruster <armbru@redhat.com>
>     S: Supported
>     F: blockdev.c
>     F: block/qapi.c
>     F: qapi/block*.json
>     F: qapi/transaction.json
>     T: git https://repo.or.cz/qemu/armbru.git block-next
>=20
> I'm not sure this section makes much sense anymore.

This is probably for you to decide.

Though the block-next branch from the T: line doesn't even exist any
more...

> Should qapi/transaction.json also be added to "Block layer core"?  Or
> should it go into John's section "Block Jobs"?

I think at the moment it only supports actions that are more related to
block jobs, so moving it there would make sense to me.

Kevin


