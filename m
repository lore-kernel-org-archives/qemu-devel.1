Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07F8C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD5F206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjnSp6im"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD5F206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJCu-000281-Eh
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iiJ3V-00052E-MH
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iiJ3U-0008LU-3w
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:15:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46511
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iiJ3T-0008GA-Qy
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576851298;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9jxY4miomDHkY4F0FFdrif+0ChwGYNeHA+/kgneSacg=;
 b=WjnSp6imOnLG+B6GmHi32rPF7dN+oCTWjC1N4j7mdcDCcGTB78fUxcaUlLahVzIiRNyKBI
 ENlvk3/AMB7gQVM+DMD1bhgDmQ/OfHdDoVvPZgfczegLBIUouMN9KPKsmc/KXdE4wl+XFK
 Lc1in7v7GJUqMUgpVv6H14sZsO0Cuy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-8pMd4ZJrMvyZQndvrZuotQ-1; Fri, 20 Dec 2019 09:14:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1B41DB60
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 14:14:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D91D6FDCE;
 Fri, 20 Dec 2019 14:14:53 +0000 (UTC)
Date: Fri, 20 Dec 2019 14:14:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v7 9/9] tests: add dbus-vmstate-test
Message-ID: <20191220141452.GP1699760@redhat.com>
References: <20191219123029.200788-1-marcandre.lureau@redhat.com>
 <20191219123029.200788-10-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191219123029.200788-10-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 8pMd4ZJrMvyZQndvrZuotQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: mprivozn@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 04:30:29PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  MAINTAINERS                  |   1 +
>  roms/SLOF                    |   2 +-
>  tests/Makefile.include       |  22 +-
>  tests/dbus-vmstate-daemon.sh |  95 +++++++++
>  tests/dbus-vmstate-test.c    | 382 +++++++++++++++++++++++++++++++++++
>  tests/dbus-vmstate1.xml      |  12 ++
>  6 files changed, 512 insertions(+), 2 deletions(-)
>  create mode 100755 tests/dbus-vmstate-daemon.sh
>  create mode 100644 tests/dbus-vmstate-test.c
>  create mode 100644 tests/dbus-vmstate1.xml


> diff --git a/roms/SLOF b/roms/SLOF
> index 9546892a80..8ebf2f55e1 160000
> --- a/roms/SLOF
> +++ b/roms/SLOF
> @@ -1 +1 @@
> -Subproject commit 9546892a80d5a4c73deea6719de46372f007f4a6
> +Subproject commit 8ebf2f55e1ba1492b942ba4b682160e644fc0f98

Accidental change. With that removed

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


