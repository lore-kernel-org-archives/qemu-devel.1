Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E475C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08793214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d01O615s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08793214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irL06-0007Ez-FF
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 07:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1irKsd-0006YX-5n
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:01:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1irKsY-0002cD-22
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:01:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26791
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1irKsW-0002aQ-9V
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579003257;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aDpKOCrjDY09QLx/VvVb5OYHq4W736t8eUjwdlanjoQ=;
 b=d01O615sjFYScnbhDcJ8i+ohwRY9GlTJLZPtagl/q2gmQAyhuN1UpKPsBUJYDxLJ+n4XNQ
 3l5TQt6khMprneqt3z0nuK4lnXes4QcfArmALUvWMjO9BUgmZJuLkUc4ivbPNsdjeh+m0m
 41XBE8Uy0Vmre0T9M77/8QS12X8VH4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-1ScPgCFkNrGSmyTywmu6BQ-1; Tue, 14 Jan 2020 07:00:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33CF018552A0;
 Tue, 14 Jan 2020 12:00:47 +0000 (UTC)
Received: from redhat.com (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C35ED60BF4;
 Tue, 14 Jan 2020 12:00:34 +0000 (UTC)
Date: Tue, 14 Jan 2020 12:00:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PULL 01/30] multifd: Initialize local variable
Message-ID: <20200114120031.GL4071034@redhat.com>
References: <20200114113926.3556-1-quintela@redhat.com>
 <20200114113926.3556-2-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200114113926.3556-2-quintela@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 1ScPgCFkNrGSmyTywmu6BQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <cminyard@mvista.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Jason Wang <jasowang@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 12:38:57PM +0100, Juan Quintela wrote:
> Fill everything with zero, so the padding fields are also initialized.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

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


