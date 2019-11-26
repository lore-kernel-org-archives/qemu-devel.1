Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BE7C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F82F2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOlMozNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F82F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZbiQ-0004kg-5I
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 09:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iZbgo-0003ky-I9
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iZbgm-00014g-6J
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:19:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51071
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iZbgm-00014b-2X
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574777975;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zkwhKhSCYKzug9HMRyyNdArhrQ11Aq9gdIl5Euo+plM=;
 b=GOlMozNGCgyMmlQxL4X3w3uCXKsf32eW90tan8gw87RdENwzemuCMleYc+rjuNH8gES4l/
 adY7I+/Bk4xJhpF0a1FDQgz/EM9PfYS5E7ZYlVp4Cxfej2iBzHRIjlqQeQwmFmN3OSy0G9
 yByKdSCuBSVu2EBeURuLjIjAG4EDW/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-M2WV_PCzO-2uj64qD36jzQ-1; Tue, 26 Nov 2019 09:19:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8943F8CDFDF;
 Tue, 26 Nov 2019 14:19:31 +0000 (UTC)
Received: from redhat.com (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C53255D9CA;
 Tue, 26 Nov 2019 14:19:27 +0000 (UTC)
Date: Tue, 26 Nov 2019 14:19:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: aaron.zakhrov@gmail.com
Subject: Re: [RFC 00/10] R300 QEMU device V2
Message-ID: <20191126141924.GQ556568@redhat.com>
References: <20191126124433.860-1-aaron.zakhrov@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191126124433.860-1-aaron.zakhrov@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: M2WV_PCzO-2uj64qD36jzQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 26, 2019 at 06:14:27PM +0530, aaron.zakhrov@gmail.com wrote:
> From: Aaron Dominick <aaron.zakhrov@gmail.com>
>=20
> I have removed the botched patches and have got the code working upto the=
 GART initialization.
> I am not sure how to implement the GART. I am guessing it should be an IO=
MMU device but I think that is a bit much for an emulated card.=20
> The earlier problem of display probing seems to be resolved by using an R=
300 bios I got from TechPowerUP's GPU database:
>=20
> =09https://www.techpowerup.com/vgabios/14509/14509
> I am NOT sure if we can distribute it in the QEMU source tree. If it
> does cause problems I can send a patch to remove it.

That site seems to be a repository of BIOS uploaded by arbitrary users,
with no information on what license terms might apply to the uploads.

We have to therefore assume the worst and treat the BIOS images on that
site as proprietary and not re-distributable, despite the fact that the
site itself is acting as a 3rd party distributor.

IOW, we can't have this in QEMU git I'm afraid, unless someone can find
a trustworthy vendor source for the original image with accompanying
license information.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


