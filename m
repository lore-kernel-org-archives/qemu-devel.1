Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1C2C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8ABB206EC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vk/6iIZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8ABB206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJ7V-0001IK-Eu
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:19:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iiIy7-0004xc-UU
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iiIy6-0000qk-2O
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:09:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38680
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iiIy5-0000mX-Rp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576850964;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CTb2DL53DScyibjIHRHXoUlEkQW8La3mqKglWerTTy8=;
 b=Vk/6iIZpuzYec6BwWaLTR0g8IOsSgu7xz1oOsQF67UA8fHUXPfp8IekeaYK98vv617WsED
 jrX/Up4A/J0AS2P8Z6sD/5uCpqfJJtmvuz3CrfW6nfGOI5bo7w2X/UDJpiE71G8HCVaGKm
 yXygbuj0VkTEmBlrRA4vaGyvRxV8rvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-72UtSiKJNA2ILm0jYP7Imw-1; Fri, 20 Dec 2019 09:09:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA41810120A3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 14:09:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8BB719C68;
 Fri, 20 Dec 2019 14:09:15 +0000 (UTC)
Date: Fri, 20 Dec 2019 14:09:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v7 5/9] Add dbus-vmstate object
Message-ID: <20191220140914.GN1699760@redhat.com>
References: <20191219123029.200788-1-marcandre.lureau@redhat.com>
 <20191219123029.200788-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191219123029.200788-6-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 72UtSiKJNA2ILm0jYP7Imw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: mprivozn@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 04:30:25PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> When instantiated, this object will connect to the given D-Bus bus
> "addr". During migration, it will take/restore the data from
> org.qemu.VMState1 instances. See documentation for details.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  MAINTAINERS                   |   2 +
>  Makefile.objs                 |   1 +
>  backends/Makefile.objs        |   4 +
>  backends/dbus-vmstate.c       | 510 ++++++++++++++++++++++++++++++++++
>  backends/trace-events         |   7 +
>  docs/interop/dbus-vmstate.rst |  74 +++++
>  docs/interop/dbus.rst         |   5 +
>  docs/interop/index.rst        |   1 +
>  8 files changed, 604 insertions(+)
>  create mode 100644 backends/dbus-vmstate.c
>  create mode 100644 backends/trace-events
>  create mode 100644 docs/interop/dbus-vmstate.rst

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


