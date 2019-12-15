Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B52C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 06:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760D921D7E
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 06:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VKc7UHAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760D921D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igNak-00044F-8S
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 01:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Aijaz.Baig@protonmail.com>) id 1igNa2-0003es-Ro
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 01:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Aijaz.Baig@protonmail.com>) id 1igNa1-0001gO-8Q
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 01:40:38 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:25450)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Aijaz.Baig@protonmail.com>)
 id 1igNa0-0001cu-NI
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 01:40:37 -0500
Date: Sun, 15 Dec 2019 06:40:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=default; t=1576392032;
 bh=GoqlNpx1oCDAb1IiSQh5bntgDskQgZRIi4GBWN7EUvk=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
 Feedback-ID:From;
 b=VKc7UHASoKZPMVaYFQ5rqRUbbgG+6uQK1jdrl1bdM7+1LdJ2UJPfbpsJBzfERnAqA
 1MsOjVEEBOgBk/spN/AqgJywISO/DRmU3aR3jSRNqVSGZFDsU2p00MEXscf6ZB71jY
 4/fmjF7yCYHkhxjPRvFe7ng/VjUOOfilUu8qp3fY=
To: Aijaz.Baig@protonmail.com,
 =?UTF-8?Q?=27Daniel_P=2E_Berrang=C3=A9=27?= <berrange@redhat.com>
From: Aijaz.Baig@protonmail.com
Cc: qemu-devel@nongnu.org
Subject: RE: Error compiling Qemu-4.1 on Linux
Message-ID: <000001d5b312$8927d550$9b777ff0$@protonmail.com>
In-Reply-To: <000001d5acc2$e7e07ee0$b7a17ca0$@protonmail.com>
References: <003101d5ab71$8424dc40$8c6e94c0$@protonmail.com>
 <20191205143622.GB3080934@redhat.com>
 <000101d5ac55$f8422620$e8c67260$@protonmail.com>
 <20191206170747.GD3291374@redhat.com>
 <000001d5acc2$e7e07ee0$b7a17ca0$@protonmail.com>
Feedback-ID: uV088Vx4DnI5bE9OhCrN2z9v4XaPDWRvhVd_wxvMCaCwdybi5HTK8G-X2_UlIAM_J1SHtE1ybSTtLXuQ3x_qHQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.70.40.22
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
Reply-To: Aijaz.Baig@protonmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello

Anything suspicious that anyone can spot in here?? Still cannot get qemu to=
 compile

Keen to hear

-----Original Message-----
From: Aijaz.Baig@protonmail.com <Aijaz.Baig@protonmail.com>=20
Sent: Saturday, December 7, 2019 11:25 AM
To: 'Daniel P. Berrang=C3=A9' <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: RE: Error compiling Qemu-4.1 on Linux


That file IS present and its contents are:

prefix=3D/usr
exec_prefix=3D${prefix}
libdir=3D${prefix}/lib/x86_64-linux-gnu
includedir=3D${prefix}/include

Name: GThread
Description: Thread support for GLib
Requires: glib-2.0
Version: 2.50.3
Libs: -L${libdir} -lgthread-2.0 -pthread
Cflags: -pthread

Let me know what is falling short here

Regards

-----Original Message-----
From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>=20
Sent: Friday, December 6, 2019 10:38 PM
To: Aijaz.Baig@protonmail.com
Cc: qemu-devel@nongnu.org
Subject: Re: Error compiling Qemu-4.1 on Linux


On Fri, Dec 06, 2019 at 04:55:37PM +0000, Aijaz.Baig@protonmail.com wrote:
> Here is the content of config.log: https://pastebin.com/6zrSXWAG
>
> I am configuring it for 'arm-softmmu'  as can be seen from the above=20
> paste

Looks like it is failing on

  $ pkg-config  --atleast-version=3D2.40 gthread-2.0

returning non-zero exit status.


This suggests the file:

  /usr/lib/x86_64-linux-gnu/pkgconfig/gthread-2.0.pc

is missing on your install.

Or do you have some PKG_CONFIG_LIBDIR env variable set that is mistakenly p=
ointing to a different directory.


Regards,
Daniel
--
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|





