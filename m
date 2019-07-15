Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A05C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B77820665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B77820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmyEy-0006kd-5B
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 06:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36484)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hmyEn-0006KF-7O
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hmyEm-0003JZ-2n
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:29:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hmyEl-0003J4-TU
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:29:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 08C548535D;
 Mon, 15 Jul 2019 10:29:39 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15B4A6012C;
 Mon, 15 Jul 2019 10:29:29 +0000 (UTC)
Date: Mon, 15 Jul 2019 11:29:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190715102927.GG30298@redhat.com>
References: <20190713143311.17620-1-marcandre.lureau@redhat.com>
 <20190713143311.17620-7-marcandre.lureau@redhat.com>
 <20190715094026.GC30298@redhat.com>
 <CAMxuvawZ6nCt-6KtnzPUnX4PWbvEs1tycufZK4c4tMr1s2T0ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvawZ6nCt-6KtnzPUnX4PWbvEs1tycufZK4c4tMr1s2T0ag@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 15 Jul 2019 10:29:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 6/6] test: skip tests if
 socket_check_protocol_support() failed
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
Cc: Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Bonzini, Paolo" <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 15, 2019 at 02:25:03PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Jul 15, 2019 at 1:40 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >
> > On Sat, Jul 13, 2019 at 06:33:11PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > Skip the tests if socket_check_protocol_support() failed, but do ru=
n
> > > g_test_run() to keep TAP harness happy.
> >
> > Did you actually find a scenario in which it failed, or is this just
> > doing the change for the sake of strict correctness ?
>=20
> It fails under podman atm (https://github.com/containers/libpod/issues/=
3535)

Oh i see. I wonder if a better strategy is to simply set

  has_ipv4 =3D has_ipv6 =3D false

if getaddrinfo() returns an error and make socket_check_protocol_support
return void.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

