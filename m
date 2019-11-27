Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7933EC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 16:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FFA20684
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 16:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sx1O0HpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FFA20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia0Qq-0005nA-Ep
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 11:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ia0F6-0007ik-HF
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ia0F3-0002id-OQ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:32:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30374
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ia0F1-0002gg-Q2
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574872353;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I4J4wwBwJwwqLVVaqXlgDdm5hwzpaM914AuTAvqlMq8=;
 b=Sx1O0HpJ+Xv+xeWXbGcJqUxoAxy1p6aiP83nuJvR4B2suhwf21X2BKSzOgmidS27/HiErA
 R6MGkFxQUBwYiEnoopnXgETu9kd63b6E0vshC911J31hh5TxiIu6y7xJPuUnUDfz0MNzTz
 Y+52ihZyWSIPdc5Nk4KFDVeL8mK+GxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-GSIG2-eqPN-F3IhcBrUTSQ-1; Wed, 27 Nov 2019 11:32:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F0671023139;
 Wed, 27 Nov 2019 16:32:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57FCB60BEC;
 Wed, 27 Nov 2019 16:32:21 +0000 (UTC)
Date: Wed, 27 Nov 2019 16:32:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC 00/10] R300 QEMU device V2
Message-ID: <20191127163219.GI2131806@redhat.com>
References: <20191126124433.860-1-aaron.zakhrov@gmail.com>
 <20191126141924.GQ556568@redhat.com>
 <09273ecd-be76-ab61-304f-7ea0f1f0b107@redhat.com>
 <20191127150520.GG2131806@redhat.com>
 <20191127161210.ractqwwymzkpbu6n@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20191127161210.ractqwwymzkpbu6n@sirius.home.kraxel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: GSIG2-eqPN-F3IhcBrUTSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Aaron Dominick <aaron.zakhrov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 27, 2019 at 05:12:10PM +0100, Gerd Hoffmann wrote:
>   Hi,
>=20
> > It does become a slight usability issue, as any users need to go and fi=
nd
> > the suitable BIOS in order to use the device. No downstream OS vendors =
are
> > going to be able to distribute this BIOS either
> >=20
> > I don't know if we have hit this problem before & if we have any
> > general policies about it ?
>=20
> Booting from lsi scsi adapter used to work with a vendor bios only
> loooooong ago.  Fixed by adding an lsi driver to seabios.
>=20
> Building a r300 vgabios shouldn't be too hard, we already have
> support in seavgabios for the other ati variants emulated by qemu.

That sounds reasonable, so it is fine to add r300 to QEMU without the BIOS.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


