Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E21AC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5682054F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VV3V/F+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5682054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHSg-0005hO-Qy
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Aijaz.Baig@protonmail.com>) id 1idGtX-00020r-ID
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:55:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Aijaz.Baig@protonmail.com>) id 1idGtV-0001wj-Vt
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:55:55 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:37135)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Aijaz.Baig@protonmail.com>)
 id 1idGtV-0001pi-NP
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:55:53 -0500
Date: Fri, 06 Dec 2019 16:55:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=default; t=1575651344;
 bh=iby5YWj6OLLkV5vQh5dReGxCJWT0cWX8vR1No6fOyXE=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
 Feedback-ID:From;
 b=VV3V/F+dDWIBpQT8A/VyV4Y4ZC3t1XZzebY8goCMpWFV4q7WAHwTPJ6x7IgAw3yQt
 fRxn1ZuyUCB9lPS6XH4bG9kNEdh0dPnPXcLQ7bGzglGAE580JiVS5pXj+j8ANYN3QU
 AXAywCOZzUtJhWkMKAlBvC01hYs+mr4vR6LIBx50=
To: =?UTF-8?Q?=27Daniel_P=2E_Berrang=C3=A9=27?= <berrange@redhat.com>
From: Aijaz.Baig@protonmail.com
Cc: qemu-devel@nongnu.org
Subject: RE: Error compiling Qemu-4.1 on Linux
Message-ID: <000101d5ac55$f8422620$e8c67260$@protonmail.com>
In-Reply-To: <20191205143622.GB3080934@redhat.com>
References: <003101d5ab71$8424dc40$8c6e94c0$@protonmail.com>
 <20191205143622.GB3080934@redhat.com>
Feedback-ID: uV088Vx4DnI5bE9OhCrN2z9v4XaPDWRvhVd_wxvMCaCwdybi5HTK8G-X2_UlIAM_J1SHtE1ybSTtLXuQ3x_qHQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.70.40.134
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

Here is the content of config.log: https://pastebin.com/6zrSXWAG

I am configuring it for 'arm-softmmu'  as can be seen from the above paste

Keen to know,
Aijaz Baig

-----Original Message-----
From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>=20
Sent: Thursday, December 5, 2019 8:06 PM
To: Aijaz.Baig@protonmail.com
Cc: qemu-devel@nongnu.org
Subject: Re: Error compiling Qemu-4.1 on Linux


On Thu, Dec 05, 2019 at 01:40:11PM +0000, Aijaz.Baig@protonmail.com wrote:
> Hello
>
> I=E2=80=99m trying to compile Qemu from sources and as such face the well=
=20
> known errors of requiring Glib-2.4 and gthread-2.0
>
> ERROR: glib-2.40 gthread-2.0 is required to compile QEMU
>
> I=E2=80=99m on Linux Mint and I=E2=80=99ve installed libglib-2.0 from the=
 repo
>
> AB1@piper11:~$ dpkg -l | grep -i libglib
>
> ii  libglib2.0-dev                        2.50.3-2+deb9u1                =
   amd64        Development files for the GLib library

This is the important one & looks fine.

> I am wondering what is it that I am missing. Kindly guide

Please paste the 'config.log' file after a failed configure, it often has m=
ore debug info.

Also, what env/args (if any) are you passing to configure

Regards,
Daniel
--
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|




