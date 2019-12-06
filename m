Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B73CC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298E52173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPrSmIT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298E52173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIKG-0002Ce-9g
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1idH5H-0006gE-Hc
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1idH5E-0003yv-5d
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:08:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47616
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1idH5B-0003vF-O6
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575652076;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p5Dv4GFUOmdHnLB1hh/4DNoFT8nFVXHrpvrwfU+xUc0=;
 b=NPrSmIT2m1fMm0MLw5HjPeM0b5s1YffPHc+uqMU+35AlLbab4ncBTOeGv3//smIMaeSB9A
 tD07DWjeiQH0/0ZDpbrivPMc34dWocGYI9tKwbzX8g8ZC5SXEYzC/h0+wWF7LOEB7kuPgX
 YIuA8PI/fqjoMUkw7AVn6W0XvP6QZYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-mwtoZjKzNSuQQKtLEtaGBg-1; Fri, 06 Dec 2019 12:07:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E234A801E76;
 Fri,  6 Dec 2019 17:07:51 +0000 (UTC)
Received: from redhat.com (ovpn-112-49.ams2.redhat.com [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0210119C4F;
 Fri,  6 Dec 2019 17:07:50 +0000 (UTC)
Date: Fri, 6 Dec 2019 17:07:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Aijaz.Baig@protonmail.com
Subject: Re: Error compiling Qemu-4.1 on Linux
Message-ID: <20191206170747.GD3291374@redhat.com>
References: <003101d5ab71$8424dc40$8c6e94c0$@protonmail.com>
 <20191205143622.GB3080934@redhat.com>
 <000101d5ac55$f8422620$e8c67260$@protonmail.com>
MIME-Version: 1.0
In-Reply-To: <000101d5ac55$f8422620$e8c67260$@protonmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: mwtoZjKzNSuQQKtLEtaGBg-1
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

On Fri, Dec 06, 2019 at 04:55:37PM +0000, Aijaz.Baig@protonmail.com wrote:
> Here is the content of config.log: https://pastebin.com/6zrSXWAG
>=20
> I am configuring it for 'arm-softmmu'  as can be seen from the above past=
e

Looks like it is failing on

  $ pkg-config  --atleast-version=3D2.40 gthread-2.0

returning non-zero exit status.


This suggests the file:

  /usr/lib/x86_64-linux-gnu/pkgconfig/gthread-2.0.pc

is missing on your install.

Or do you have some PKG_CONFIG_LIBDIR env variable set that
is mistakenly pointing to a different directory.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


