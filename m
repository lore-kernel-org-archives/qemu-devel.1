Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C13BC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6818520659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqgkvhyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6818520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGP5-0002YJ-7b
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1idEyt-0000EZ-Ag
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1idEyr-0005ef-WA
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:53:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58087
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1idEyr-0005dl-Re
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643997;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FkGMdrif3Udb3R3UjvtIPo+bXTEG3UgL8G0h6TAWLHs=;
 b=cqgkvhyTu1MyzyYXaej3FjrbD+PdW/sTNeu7Jm3ErRjeAjJrWYHIYYt5x8GGQiqFOuCuZx
 QETqcWGSwj4loPdSqNC9JWJl7CpR/jSts+prnL92t9dpyekBIRHAHlP/r90gkEaQJ8Y37Q
 FAciGCp/DpgOI0S0vvXKf+xH0oscKh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-jeeXet6hMNipKSbTXhnq9A-1; Fri, 06 Dec 2019 09:53:13 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2325F8024CA;
 Fri,  6 Dec 2019 14:53:12 +0000 (UTC)
Received: from redhat.com (ovpn-112-49.ams2.redhat.com [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA9BA1CB;
 Fri,  6 Dec 2019 14:53:07 +0000 (UTC)
Date: Fri, 6 Dec 2019 14:53:04 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] qapi: better document NVMe blockdev @device parameter
Message-ID: <20191206145304.GC3291374@redhat.com>
References: <20191206143811.3777524-1-berrange@redhat.com>
 <fa41baea-5b86-192d-97ed-6f13caf2fdfa@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fa41baea-5b86-192d-97ed-6f13caf2fdfa@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: jeeXet6hMNipKSbTXhnq9A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-stable <qemu-stable@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 06, 2019 at 08:51:15AM -0600, Eric Blake wrote:
> On 12/6/19 8:38 AM, Daniel P. Berrang=C3=A9 wrote:
> > Mention that this is a PCI device address & give the format it is
> > expected it. Also mention that it must be first unbound from any
>=20
> maybe s/expected it/expecting/

It was supposed to be "in" rather than "it", but your suggestion
is fine too.

>=20
> > host kernel driver.
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >   qapi/block-core.json | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 0cf68fea14..fcb52ec24f 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -2963,9 +2963,13 @@
> >   #
> >   # Driver specific block device options for the NVMe backend.
> >   #
> > -# @device:    controller address of the NVMe device.
> > +# @device:    PCI controller address of the NVMe device in
> > +#             format hhhh:bb:ss.f (host:bus:slot.function)
> >   # @namespace: namespace number of the device, starting from 1.
> >   #
> > +# Note that the PCI @device must have been unbound from any host
> > +# kernel driver before instructing QEMU to add the blockdev.
> > +#
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Doesn't affect code, but similarly no reason to hurry this into 4.2. 5.0 =
and
> qemu-stable (cc'd) is good enough.
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


