Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93634C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0C720652
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0C720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52296 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfQpF-0007TK-Ds
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 11:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42146)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hfQoi-0006ws-QX
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hfQoh-00010E-IA
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:23:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1hfQoe-0000oR-Ej; Mon, 24 Jun 2019 11:23:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A948FC1EB201;
 Mon, 24 Jun 2019 15:23:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 125B35D9D3;
 Mon, 24 Jun 2019 15:23:22 +0000 (UTC)
Date: Mon, 24 Jun 2019 16:23:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Message-ID: <20190624152320.GK17698@redhat.com>
References: <20190620122132.10075-1-philmd@redhat.com>
 <20190620122132.10075-2-philmd@redhat.com>
 <6a0086e7-79ea-fc5e-6359-c1d4d256bf6e@redhat.com>
 <ebe04ce2-0e0a-c764-e235-3aabd420439e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ebe04ce2-0e0a-c764-e235-3aabd420439e@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 24 Jun 2019 15:23:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 1/3] hw/firmware: Add Edk2Crypto and
 edk2_add_host_crypto_policy()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 05:14:23PM +0200, Laszlo Ersek wrote:
> On 06/24/19 16:53, Laszlo Ersek wrote:
> > (+Daniel)
> >=20
> > On 06/20/19 14:21, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
> >>   $ qemu-system-x86_64 \
> >>       --object edk2_crypto,id=3Dhttps,\
> >>               ciphers=3D/etc/crypto-policies/back-ends/openssl.confi=
g,\
> >>               cacerts=3D/etc/pki/ca-trust/extracted/edk2/cacerts.bin
>=20
> (12) Regarding the command line. It just occurs to me that Daniel
> suggested [*] that libvirt should not be taught about this feature
> specifically.

Oh yes, thank you for reminding me of this point.

Essentially this is the same use case as with the GNUTLS default crypto
policy in QEMU.

The tls-creds-x409 object type in QEMU has a "priority" property which
lets you set a GNUTLS priority string eg

    --object tls-creds-x509,id=3Dtls0,priority=3D@SYSTEM

In practice, however, libvirt never uses this because the QEMU configure
script has a --tls-priority arg and distros will use that arg to set the
desired priority at build time. eg Fedora/RHEL build QEMU with the
"--tls-priority=3D@QEMU,SYSTEM" string and libvirt hasn't bothered to
make use of the 'priority' arg for tls-creds-x509 as a result.

I'd expect similar to be done with EDK2 priority where Fedora/RHEL sets
a compile time ciphers/cacerts list in RPM build.

Contrary to what we did with GNUTLS though, libvirt might still allow
this to be overridden at runtime, since the handling of the ciphers
is not as smart as we get with GNUTLS priority setting.

> Thus, I think we need properties that are "smarter" than plain
> user-specified strings:
>=20
> - they should have default values (the ones your example includes above=
)
>=20
> - for each of the properties: if the default pathname fails to identify
> a file, then treat it as a normal situation (leave the corresponding
> fields NULL)
>=20
> - if the user overrides the default, and the pathname resolution fails,
> then that should generate an error
>=20
> - the user should be permitted to override the default such that the
> corresponding setting is disabled (i.e. no error, but also no loading)
>=20
>=20
> It's too bad that I'm not sure about the right way to implement this. I=
t
> reminds me of On/Off/Auto, but only vaguely.
>=20
> In fact, if we never want to teach libvirt about this feature, then we
> essentially expect QEMU to auto-load these files, whenever they exist -=
-
> even if the guest ends up booting something other than edk2 firmware!
>=20
> [*] https://bugzilla.redhat.com/show_bug.cgi?id=3D1536624#c11 --
> unfortunately, this is a private RHBZ :(
>=20
> Thanks
> Laszlo

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

