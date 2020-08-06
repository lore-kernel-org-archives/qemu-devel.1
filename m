Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6E1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D0722D74
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQZZNSlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D0722D74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3g8p-0007Yv-Kb
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1k3g7k-0005qX-Dv
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:40:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54577
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1k3g7h-00031V-ES
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596721195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lZ2xO/r9/lY7GLup8/HvCICtkmbVo2XLDZC5dlGcfGY=;
 b=QQZZNSlNgRCLwefyW/wepUq0PCQd89raw8+rmwNc5fEtOlOQxuEm71ggxaRXcZtzBtJhtK
 SCQIc4lKVafkvTtXbBKIIJ3Qm7YCzDF/SFGDVjUX2Dc8oeMoaziS6QGzTuQru5fm1vmf0l
 WlDYn71pKyfTbHyOlJ+yAjC2dSfMZmE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-vM8LUwXPPoW2RjFNdA4LYQ-1; Thu, 06 Aug 2020 09:38:49 -0400
X-MC-Unique: vM8LUwXPPoW2RjFNdA4LYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A25CE10932E0;
 Thu,  6 Aug 2020 13:38:47 +0000 (UTC)
Received: from localhost (ovpn-112-129.rdu2.redhat.com [10.10.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 124DF6931B;
 Thu,  6 Aug 2020 13:38:46 +0000 (UTC)
Date: Thu, 6 Aug 2020 15:38:45 +0200
From: Sergio Lopez <slp@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: Why QEMU should move from C to Rust (clickbait alert ;))
Message-ID: <20200806133845.maouiwnazkjtpklr@mhamilton>
References: <CAJSP0QWF8g7r5VqU_PRbskWZU3ahCq+eobR8GexUcPrAiYoCPQ@mail.gmail.com>
 <20200806115148.7lz32dro645a3wv6@mhamilton>
 <20200806120130.GK4159383@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200806120130.GK4159383@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=slp@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eucklqdevqpgjtwc"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, "Oleinik, Alexander" <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dave Gilbert <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--eucklqdevqpgjtwc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2020 at 01:01:30PM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Aug 06, 2020 at 01:51:48PM +0200, Sergio Lopez wrote:
> > On Thu, Aug 06, 2020 at 11:24:13AM +0100, Stefan Hajnoczi wrote:
> > <snip>
> > > Conclusion
> > > ---------------
> > > Most security bugs in QEMU today are C programming bugs. Switching to
> > > a safer programming language will significantly reduce security bugs
> > > in QEMU. Rust is now mature and proven enough to use as the language
> > > for device emulation code. Thanks to vhost-user and vfio-user using
> > > Rust for device emulation does not require a big conversion of QEMU
> > > code, it can simply be done in a separate program. This way attack
> > > surfaces can be written in Rust to make them less susceptible to
> > > security bugs going forward.
> > >=20
> >=20
> > Having worked on Rust implementations for vhost-user-fs and
> > vhost-user-blk, I'm 100% sold on this idea.
> >=20
> > That said, there are a couple things that I think may help getting
> > more people into implementing vhost-user devices in Rust.
> >=20
> >  1. Having a reference implementation for a simple device somewhere
> >  close or inside the QEMU source tree. I'd say vhost-user-blk is a
> >  clear candidate, given that a naive implementation for raw files
> >  without any I/O optimization is quite easy to read and understand.
> >=20
> >  2. Integrating the ability to start-up vhost-user daemons from QEMU,
> >  in an easy and portable way. I know we can always rely on daemons
> >  like libvirt to do this for us, but I think it'd be nicer to be able
> >  to define a vhost-user device from the command line and have QEMU
> >  execute it with the proper parameters (BTW, Cloud-Hypervisor already
> >  does that). This would probably require some kind of configuration
> >  file, to be able to define which binary provides each vhost-user
> >  device personality, but could also be a way for "sanctioning"
> >  daemons (through the configuration defaults), and to have them adhere
> >  to a standardized command line format.
>=20
> This second point is such a good idea that we already have defined
> how todo this in QEMU - see the docs/interop/vhost-user.json file.
> This specifies metadata files that should be installed into a
> defined location such that QEMU/libvirt/other mgmt app can locate
> vhost-user impls for each type of device, and priortize between
> different impls.

Nice, but AFAIK QEMU still lacks the ability to process those files
and run the vhost-user device providers by itself. Or perhaps I just
can't find it (?).

Sergio.

--eucklqdevqpgjtwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl8sB+UACgkQ9GknjS8M
AjV20hAAo9fiFrmnv8ajYRY11F8Y4O7CmFJzf/FCOzJtON8UHSpKNOeNqyDXzkN7
jo8eE4aFfzqOUn2cxQe9yAjWi3eSHG/AKHNREMM8Ne2J4ZBdXuQZhaSv/7sLwltN
H8ozV6NNaY2200Zy9GO/vgOhaHfhBMsEjR3zzmHlsT9SKQP1ioXDTdgyX2bs6WuN
NU9aV3o7vo2sQe/hqPFyE+Nb8A3d5te5n2M4RyrpYFu7WLN0loyoIonzjxKmDcSe
cyCEOJtZTC8IV5QAjsi2Oub0Fd4G6dMfzXh4/U2R+2y+4IGdwVDnFxyJjrKRrhow
ZQfzgYhkCf94dZw0vUD3LYA+eFJI6+Dzd3I2OgDUf4E1erWJ+y2uHYO5TPIEl/du
JfM4e5Zi+91dDatDGPcWIwl/femhrHga8yltDFdMSIVWt6FG/PoCB44P90vDZdcb
0BWYBYvj4fM5gFdd+gIRruqu6fh7qJGRTi+LXOYxm/RODVOihMnTrWhyBgB3/w7N
NiRutgTWrVeWT6ODxqVRvwC+3ZftYuE3mDZZzde+s+eqt1JOFkuZcfoFLe2KpEw4
PQxZM+DhqF1x7JGUKyFddCNhcvk02sB16gejXlRw7MP5YyShT9WOwtJTbYvzvlGT
QMMFzr54HkKwII6yKhFbXYPbS7jjuuBVYzXtMYxVkPGNfkG41ks=
=eeCG
-----END PGP SIGNATURE-----

--eucklqdevqpgjtwc--


