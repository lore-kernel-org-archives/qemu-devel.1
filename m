Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48ADC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B9442087E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGD+ybvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9442087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0uI-0004EG-Kp
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iT0tA-0003lB-EG
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iT0t9-0003tq-A8
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:49:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37050
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iT0t9-0003tC-6G
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573206546;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1I0Kgd4bB9kjYjrAFoOLr5qvU2iqC6OF5fAsjacz4e0=;
 b=JGD+ybvPUbCr1DINV16C58awa3M2yHmlgtHf69aj34idCu7t0pemRVvnCn5/pZ3SpVjsVe
 HwiVCtV8Z/yVk3Nuv2r0YbMineO9/xXRZUiD+eiWaknQRR56OK4g2vOtc85Z+2/Yy9mWYG
 1+PFmIUtYu1ikkQJgQgKLk2IBq4KqPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-c2AcN4fXOEOrJj9lQTCORg-1; Fri, 08 Nov 2019 04:49:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20A6D107ACC3
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 09:49:03 +0000 (UTC)
Received: from redhat.com (ovpn-112-63.ams2.redhat.com [10.36.112.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0794A5D6AE;
 Fri,  8 Nov 2019 09:48:58 +0000 (UTC)
Date: Fri, 8 Nov 2019 09:48:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: Should QEMU's configure script check for bzip2 ?
Message-ID: <20191108094856.GD182396@redhat.com>
References: <da6cfaeb-420e-6e84-ca14-a75d900d65c0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <da6cfaeb-420e-6e84-ca14-a75d900d65c0@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: c2AcN4fXOEOrJj9lQTCORg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 08:43:27PM +0100, Thomas Huth wrote:
>=20
>  Hi,
>=20
> I just tried to compile QEMU on a freshly installed system. "configure"
> finished without problems, but during "make" I hit this error:
>=20
>   BUNZIP2 pc-bios/edk2-i386-secure-code.fd.bz2
> /bin/sh: bzip2: command not found
> make: *** [Makefile:305: pc-bios/edk2-i386-secure-code.fd] Error 127
> make: *** Deleting file 'pc-bios/edk2-i386-secure-code.fd'
> make: *** Waiting for unfinished jobs....
>=20
> Sure, it's easy to fix, but maybe "configure" should already check for th=
e
> availablity of "bzip2", so that we then either skip the installation of t=
he
> edk2 images if "bzip2" is not available, or bail out during "configure"
> already?

The general rule is that if we run a binary we should check for it upfront
so users immediately see any missing pre-requisites, rather than wasting
30 minutes waiting for QEMU to build & then fail.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


