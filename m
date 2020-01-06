Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FE2C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9312075A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYQKl5FV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9312075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUQk-0002U3-Ek
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ioTvR-0008S4-2C
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:04:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ioTvP-0007Sm-Nh
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:04:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52115
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ioTvP-0007SO-JD
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578323051;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ybVt+zx2DoEx/I1zd5WnrIugZJhr3feg27Euqqcb8AQ=;
 b=bYQKl5FVQiC5R1N6hDEogCkMP+yDeNECbS7tNIbKaAyEO+9/AnIizTArz30ugFMLzqrhb5
 b3ZG5zRcvpDyolrjZm2jZzlFF0VEVqR+EbvFigS29m2k49cJ4cCTo6WNJv1jSs7wnR0C5z
 qH+eD537V1cJgdF4z69KaEZcV2QuJio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-8XYIb-zEMHmfCQotbWBcMQ-1; Mon, 06 Jan 2020 10:03:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ED88107ACE3
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 15:03:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7D4F77FFD;
 Mon,  6 Jan 2020 15:03:51 +0000 (UTC)
Date: Mon, 6 Jan 2020 15:03:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 056/104] virtiofsd: add security guide document
Message-ID: <20200106150351.GT2930416@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-57-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-57-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 8XYIb-zEMHmfCQotbWBcMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:38:16PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Many people want to know: what's up with virtiofsd and security?  This
> document provides the answers!
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/security.rst | 118 +++++++++++++++++++++++++++++++++++

Do we need to link this into the rest of QEMU's docs in some
index page ?

>  1 file changed, 118 insertions(+)
>  create mode 100644 tools/virtiofsd/security.rst

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


