Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4F3C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB73721835
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlEnBLDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB73721835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icsHM-0005wq-TF
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1icsGa-0005Vt-Jk
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1icsGZ-0004Dr-8t
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:38:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43383
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1icsGZ-00048q-2O
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575556681;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J6zJyKUECL/9vBDMo8qEFs8VI6khHT4GNmFZaVL5B9s=;
 b=FlEnBLDtWAF0ZiH3wOX7xl6HmtmkZK1dld4Y+8/C0Tz+vN+TlflMo3M8dlSAOvuRB6FMMx
 +J1EMSdfNsRYM2qRGpJd+pX7eHLCD3mqSlTxHYQFHZCZ7plsIC6z9tzufKf1Mxsq+pw8PG
 /Mwr0NU0Bi1ce1/vMTz413SrPVhQoTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-Xy5xX9h2OVu6XnnrYWtS1w-1; Thu, 05 Dec 2019 09:36:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DE60107ACC4;
 Thu,  5 Dec 2019 14:36:27 +0000 (UTC)
Received: from redhat.com (ovpn-112-49.ams2.redhat.com [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 438B960135;
 Thu,  5 Dec 2019 14:36:25 +0000 (UTC)
Date: Thu, 5 Dec 2019 14:36:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Aijaz.Baig@protonmail.com
Subject: Re: Error compiling Qemu-4.1 on Linux
Message-ID: <20191205143622.GB3080934@redhat.com>
References: <003101d5ab71$8424dc40$8c6e94c0$@protonmail.com>
MIME-Version: 1.0
In-Reply-To: <003101d5ab71$8424dc40$8c6e94c0$@protonmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Xy5xX9h2OVu6XnnrYWtS1w-1
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 05, 2019 at 01:40:11PM +0000, Aijaz.Baig@protonmail.com wrote:
> Hello
>=20
> I=E2=80=99m trying to compile Qemu from sources and as such face the well=
 known errors of requiring Glib-2.4 and gthread-2.0
>=20
> ERROR: glib-2.40 gthread-2.0 is required to compile QEMU
>=20
> I=E2=80=99m on Linux Mint and I=E2=80=99ve installed libglib-2.0 from the=
 repo
>=20
> AB1@piper11:~$ dpkg -l | grep -i libglib
>=20
> ii  libglib2.0-dev                        2.50.3-2+deb9u1                =
   amd64        Development files for the GLib library

This is the important one & looks fine.

> I am wondering what is it that I am missing. Kindly guide

Please paste the 'config.log' file after a failed configure, it often
has more debug info.

Also, what env/args (if any) are you passing to configure

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


