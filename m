Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DCFC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 10:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E4920656
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 10:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCfXtlfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E4920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic5pF-0002IP-2P
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 05:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ic5kM-0000TZ-Bc
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ic5kH-0008BL-E4
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:49:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30576
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ic5kH-00086S-8i
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575370167;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VAUDkRtpv/DO3dWe+257rO/IOkjpO1FAZpSLrAc9cAU=;
 b=fCfXtlfQ7sv2+hAU3whpLimFs/Q8fALCQRGj3kj2hjhUrmJvX1I2UvcxXtf3ZsQ0C1gCyR
 p1L/jzBQFTEOX8SA5TSJ9BY1dHQfZxX0B7hGWalZyX2B28d1fxs0fo3TKYYwbYaOqdmSg1
 VFEF+sw+E6Wzlo1uyYL2GsJQxt34Bi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-vfKHZJ6VMHOpfuZ_33q3dg-1; Tue, 03 Dec 2019 05:49:23 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B3C1800D4E;
 Tue,  3 Dec 2019 10:49:22 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 145335D6A7;
 Tue,  3 Dec 2019 10:49:16 +0000 (UTC)
Date: Tue, 3 Dec 2019 10:49:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 00/15] s390x: Protected Virtualization support
Message-ID: <20191203104914.GA267814@redhat.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191129110820.GF2260471@redhat.com>
 <699bb3bc-f42a-2fcf-acb3-b91d783e7ce4@linux.ibm.com>
 <20191129123524.GI2260471@redhat.com>
 <c2c4b71b-d42e-3487-01d8-ae4f5751748b@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <c2c4b71b-d42e-3487-01d8-ae4f5751748b@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: vfKHZJ6VMHOpfuZ_33q3dg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: thuth@redhat.com, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 29, 2019 at 03:02:41PM +0100, Janosch Frank wrote:
> On 11/29/19 1:35 PM, Daniel P. Berrang=C3=A9 wrote:

> > Is there any way to prevent a guest from using protected mode even
> > if QEMU supports it ?  eg the mgmt app may want to be able to
> > guarantee that all VMs are migratable, so don't want a guest OS
> > secretly activating protected mode which blocks migration.
>=20
> Not enabling facility 161 is enough.

Is this facility enabled by default in any scenario ?

What happens if the feature is enabled & QEMU is also
coinfigured to use huge pages or does not have memory
pinned into RAM, given that those features are said to
be incompatible ?

>=20
> >=20
> >> Such VMs are started like any other VM and run a short "normal" stub
> >> that will prepare some things and then requests to be protected.
> >>
> >> Most of the restrictions are memory related and might be lifted in the
> >> future:
> >> * No paging
> >> * No migration
> >=20
> > Presumably QEMU is going to set a migration blocker when a guest
> > activates protected mode ?
>=20
> Well, that's stuff I still need to figure out :)
>=20
> >=20
> >> * No huge page backings
> >> * No collaborative memory management

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


