Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2F9C31E43
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 17:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6DEC2082E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 17:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DEC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48614 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haOIN-0003oj-8H
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 13:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57726)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1haOHg-0003Fq-3v
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 13:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1haOHe-000297-Sc
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 13:40:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1haOHe-00026s-Lf
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 13:40:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CDDBA75726;
 Mon, 10 Jun 2019 17:40:22 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 632CA1001B30;
 Mon, 10 Jun 2019 17:40:21 +0000 (UTC)
Date: Mon, 10 Jun 2019 18:40:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190610174018.GM7809@redhat.com>
References: <20190607211544.7964-1-ehabkost@redhat.com>
 <CAFEAcA-wCqppsi+gcrTqGjR3bSDOHs5btKKE8oHYxbAUDtu7Fw@mail.gmail.com>
 <20190610131105.GJ22416@habkost.net>
 <CAFEAcA_fBBN_854PznqJUniks0uemEite8Hxcw6cwTbUSr+aVg@mail.gmail.com>
 <20190610171213.GK7809@redhat.com>
 <CAFEAcA8L7dFfwi84_wLwEV1xYyyAbf31WxiqCf_z_m8p0SAhhg@mail.gmail.com>
 <20190610173000.GL7809@redhat.com>
 <CAFEAcA-L_OfUyP9NMOZbpaKst+3Q2PBCc8=+3ErMRVLNaTASfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-L_OfUyP9NMOZbpaKst+3Q2PBCc8=+3ErMRVLNaTASfg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 10 Jun 2019 17:40:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/8] Python queue, 2019-06-07
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
Cc: Cleber Rosa <crosa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 10, 2019 at 06:38:05PM +0100, Peter Maydell wrote:
> On Mon, 10 Jun 2019 at 18:30, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > Do you have access to any machine in the compile farm or is access
> > granted on a per-machine basis ?   If i'm reading this page right:
> >
> >   https://cfarm.tetaneutral.net/machines/list/
> >
> > there is now one aarch64 machine (gcc117) that is running
> > Debian 9 / Stretch and another (gcc118) with OpenSUSE Leap 15.
> > In terms of OS version at least, either of those could be viable
> > for QEMU, if it is possible for you to access them.
>=20
> They're all available, but those machines have less RAM and
> fewer CPUs; I think the A1100 is also not as powerful as the X-Gene.
> I'm pretty sure Linaro has access to something better than that,
> but it will take me a bit to find out and set up to use it.
> (I do actually have a Mustang board myself but it's running
> the aarch32 builds and I'd prefer not to make it also do the
> aarch64 builds at the same time.)

Ok, thanks for the explanation.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

