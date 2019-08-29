Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFBFC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 09:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1948B215EA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 09:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1948B215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3GsP-00083X-6j
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 05:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i3GrW-0007cA-LQ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i3GrS-0000HQ-QH
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:37:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47532)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i3GrS-0000Gs-Iy
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:36:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4EE7308429D;
 Thu, 29 Aug 2019 09:36:57 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 217275D9C9;
 Thu, 29 Aug 2019 09:36:50 +0000 (UTC)
Date: Thu, 29 Aug 2019 10:36:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: He Zhe <zhe.he@windriver.com>
Message-ID: <20190829093648.GC17141@redhat.com>
References: <1567068782-371028-1-git-send-email-zhe.he@windriver.com>
 <20190829091505.GB17141@redhat.com>
 <7d3d9777-725c-7e27-515d-fc003351704f@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d3d9777-725c-7e27-515d-fc003351704f@windriver.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 29 Aug 2019 09:36:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] configure: Add pkg-config handling for
 libgcrypt
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
Cc: pbonzini@redhat.com, thuth@redhat.com, philmd@redhat.com, laurent@vivier.eu,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 29, 2019 at 05:26:49PM +0800, He Zhe wrote:
>=20
>=20
> On 8/29/19 5:15 PM, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Aug 29, 2019 at 04:53:02PM +0800, zhe.he@windriver.com wrote:
> >> From: He Zhe <zhe.he@windriver.com>
> >>
> >> libgcrypt may also be controlled by pkg-config, this patch adds pkg-=
config
> >> handling for libgcrypt.
> > Where are you seeing pkg-config files for libgcrypt ?
> >
> > The upstream project has (frustratingly) been hostile to any proposal=
 to
> > add pkg-config support saying people should stick with their custom=20
> > libgcrypt-config tool
> >
> >    https://dev.gnupg.org/T2037
> >
> > Even if this is something added by some distro downstream, what is th=
e
> > benefit in using it, compared with libgcrypt-confg which should alrea=
dy
> > work & is portable.
>=20
> IMHO, it could be easy for people to use pkg-config as a center to cont=
rol
> configurations for many different packages.
>=20
> This is just an addition for qemu to be able to work in both cases. It =
does not
> remove libgcrypt-confg and can fall back to libgcrypt-confg when pkg-co=
nfig does
> not work.

The addition has a maint cost associated with it, since we have have two
different ways to achieve the same thing. When only one of the approaches
is provided by upstream, the other is not going to be widely tested. In
maintaining packages in Fedora which rely on pkg-config files that are
not upstream, we've seen frequent breakage when. So my preference is
stick with what we have that is supported by upstream gcrypt.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

