Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722DDC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38559216F4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTGOWj01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38559216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaMym-00028E-AM
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 11:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iaMNS-0004BD-Ia
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iaMNK-0004Bq-3w
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:10:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58064
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iaMNG-00047w-Nq
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574957432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWsAnGzK/KjP2NhxOk9t02jQu8u51kxY8wVPVpUdhZs=;
 b=HTGOWj01+XvTFVJh4zcVM+R4FqsCuXqadjvjmIg7EnYVk7SjHrn9+pXsYZQvBXz+slxJ3J
 QykXVC1xM5ek+olAodJJUKvDAg2hlTA4lA/t9hhlE8Q2ADtCYyynVcogKdHermkZVSKhxx
 fyCV9MbZDUEBZOy49SsdxWCKZD8Lnyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-7slqANk0PkCifb0Ge0LMDA-1; Thu, 28 Nov 2019 11:10:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DAD264A9E;
 Thu, 28 Nov 2019 16:10:28 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C07A600C8;
 Thu, 28 Nov 2019 16:10:22 +0000 (UTC)
Date: Thu, 28 Nov 2019 13:10:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
Message-ID: <20191128161021.GA14595@habkost.net>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191128141518.628245-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 7slqANk0PkCifb0Ge0LMDA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 28, 2019 at 06:15:16PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi,
>=20
> Setting up shared memory for vhost-user is a bit complicated from
> command line, as it requires NUMA setup such as: m 4G -object
> memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=3Don -nu=
ma
> node,memdev=3Dmem.
>=20
> Instead, I suggest to add a -mem-shared option for non-numa setups,
> that will make the -mem-path or anonymouse memory shareable.

Can we make this be a "-m" option?

Or, even better: can we make "-m" options be automatically
translated to memory-backend-* options somehow?

--=20
Eduardo


