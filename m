Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB86C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 16:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E7220658
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 16:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhbJbDgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E7220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jExf8-0006bo-HK
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 12:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jExdU-0004kP-U1
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jExdT-0002XW-1q
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:03:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jExdS-0002W5-S5
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584633785;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IbS7SLjD7Faf6qt6eGitAyBeqI++CSyOi3O6bGrZ2cg=;
 b=PhbJbDgoimTadIO8osYV8IgZr5WQyIimfVq+y4o/fglmNRt5k/T7zcJclpCZGqyCXDojBC
 NcqQu8a9tLtxcZhSV2sVIIJvb21Wl0egzM9UDzd4QdnM+vLwsIAJRbAHZkkWhrBr94ebiu
 t59N1cXELfb5aGx2DdyGYmsOuuDAcvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-TJSl3VydMr23DlDqISh4eQ-1; Thu, 19 Mar 2020 12:02:30 -0400
X-MC-Unique: TJSl3VydMr23DlDqISh4eQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ACAF1922961;
 Thu, 19 Mar 2020 16:02:29 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2658310016EB;
 Thu, 19 Mar 2020 16:02:24 +0000 (UTC)
Date: Thu, 19 Mar 2020 16:02:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 1/1] conf: qemu 9pfs: add 'multidevs' option
Message-ID: <20200319160221.GF2322997@redhat.com>
References: <E1jEFpH-00028X-1c@lizzy.crudebyte.com>
 <E1jEFpL-00028n-Qj@lizzy.crudebyte.com>
 <20200319131026.GA2150275@lpt> <1876644.SqPMx7qSmg@silver>
MIME-Version: 1.0
In-Reply-To: <1876644.SqPMx7qSmg@silver>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: libvir-list@redhat.com, =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 19, 2020 at 04:57:41PM +0100, Christian Schoenebeck wrote:
> On Donnerstag, 19. M=C3=A4rz 2020 14:10:26 CET J=C3=A1n Tomko wrote:
> > On a Tuesday in 2020, Christian Schoenebeck wrote:
> > >Introduce new 'multidevs' option for filesystem.
> > >
> > >  <filesystem type=3D'mount' accessmode=3D'mapped' multidevs=3D'remap'=
>
> >=20
> > I don't like the 'multidevs' name, but cannot think of anything
> > beter.
> >=20
> > 'collisions' maybe?
>=20
> Not sure if 'collisions' is better, e.g. collisions=3D'remap' sounds scar=
y. :)
> And which collision would that be? At least IMO 'multidevs' is less ambig=
ious.
> I have no problem though to change it to whatever name you might come up =
with.=20
> Just keep the resulting key-value pair set in mind:
>=20
> multidevs=3D'default'
> multidevs=3D'remap'
> multidevs=3D'forbid'
> multidevs=3D'warn'
>=20
> vs.
>=20
> collisions=3D'default'
> collisions=3D'remap' <- probably misleading what 'remap' means in this ca=
se
> collisions=3D'forbid'
> collisions=3D'warn' <- wrong, it warns about multiple devices, not about =
file ID=20
> collisions.
>=20
> So different key-name might also require different value-names.
>=20
> Another option would be the long form 'multi-devices=3D...'

I tried to come up with names when this was posted to QEMU, but didn't
think of much better than multidevs, so I think that's acceptable for
libvirt usage.

"collisions" isn't better enough to justify different naming from QEMU


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


