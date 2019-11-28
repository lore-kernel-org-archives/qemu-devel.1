Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEAAC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 22:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016AE21787
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 22:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvfLpEdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016AE21787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaSG2-0002Av-BC
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 17:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iaQYd-0001QC-EZ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:38:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iaQYV-0006v0-Ch
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:38:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40168
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iaQYU-0006l6-2X
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574973502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/WXqlSKhe1dlq4dboKqKSvWLUhdzXcF5VWE+Eh2jbI=;
 b=RvfLpEdrtC6f3BhkjL6BQlrV/Jq5S1uLOllCxc5ixHwDd3p06bhGF+UTG9PZackDC9c8Ct
 mO6feEK+3qMQ7qriDQkXQj5rlZJSF70ivro3LCe7fMRXBDuHySVkNU88VlviCAdi4GX4To
 UrN4FD5NTjkWK+wvyLe2D4rHwzki3y4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-AtKd-sOGOBa5c19mp4i1DQ-1; Thu, 28 Nov 2019 15:38:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E45D110054E3;
 Thu, 28 Nov 2019 20:38:16 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50822600C8;
 Thu, 28 Nov 2019 20:38:13 +0000 (UTC)
Date: Thu, 28 Nov 2019 17:38:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] hw: add compat machines for 5.0
Message-ID: <20191128203811.GD14595@habkost.net>
References: <20191112104811.30323-1-cohuck@redhat.com>
 <20191128183706.21b1fe0e.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191128183706.21b1fe0e.cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: AtKd-sOGOBa5c19mp4i1DQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 28, 2019 at 06:37:06PM +0100, Cornelia Huck wrote:
> On Tue, 12 Nov 2019 11:48:11 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
> > Add 5.0 machine types for arm/i440fx/q35/s390x/spapr.
> >=20
> > For i440fx and q35, unversioned cpu models are still translated
> > to -v1; I'll leave changing this (if desired) to the respective
> > maintainers.
> >=20
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >=20
> > also pushed out to https://github.com/cohuck/qemu machine-5.0
> >=20
> > x86 folks: if you want to change the cpu model versioning, I
> > can do it in this patch, or just do it on top yourselves
>=20
> So, do we have a final verdict yet (keep it at v1)?
>=20
> If yes, I'll queue this via the s390 tree, unless someone else beats me
> to it.

We won't change default_cpu_version in 5.0, so:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo


