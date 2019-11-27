Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F5DC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25018206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUlmrXrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25018206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZzfa-0005hG-Tk
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 10:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iZzeH-00040n-Ls
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iZzeG-0004eF-BH
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:54:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59612
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iZzeG-0004e7-7G
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574870075;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ALF4jJwO5q4RkITvrx4plX8f8cUyIdPesOtnzRHHy+Y=;
 b=BUlmrXrsM7g2ikbk7KMoER4uLu7DonsPrBlZQuNcUmfZQWd7D9KPvH0krQ2YtTxA9EKsfS
 yswe9TvICXdTm10BuvUlkMRPSrumA9MstBantaKZ04fNS8kKKrJ+3KZX8BCFB7TM7SQDh0
 a5UN/1xWLM06kyutqkgucxpQQXkJll0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-RyiNKD_nN3CPoGW-Y__3MA-1; Wed, 27 Nov 2019 10:54:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40E46A0372;
 Wed, 27 Nov 2019 15:54:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E727C5D9D6;
 Wed, 27 Nov 2019 15:54:25 +0000 (UTC)
Date: Wed, 27 Nov 2019 15:54:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC 00/10] R300 QEMU device V2
Message-ID: <20191127155423.GH2131806@redhat.com>
References: <20191126124433.860-1-aaron.zakhrov@gmail.com>
 <20191126141924.GQ556568@redhat.com>
 <09273ecd-be76-ab61-304f-7ea0f1f0b107@redhat.com>
 <20191127150520.GG2131806@redhat.com>
 <19e8e458-04dc-874d-d372-04a0e2d5246b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <19e8e458-04dc-874d-d372-04a0e2d5246b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: RyiNKD_nN3CPoGW-Y__3MA-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, Aaron Dominick <aaron.zakhrov@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 27, 2019 at 04:13:18PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> Cc'ing more.
>=20
> On 11/27/19 4:05 PM, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Nov 27, 2019 at 04:00:01PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > > Hi Daniel, Aaron.
> > >=20
> > > On 11/26/19 3:19 PM, Daniel P. Berrang=C3=A9 wrote:
> > > > On Tue, Nov 26, 2019 at 06:14:27PM +0530, aaron.zakhrov@gmail.com w=
rote:
> > > > > From: Aaron Dominick <aaron.zakhrov@gmail.com>
> > > > >=20
> > > > > I have removed the botched patches and have got the code working =
upto the GART initialization.
> > > > > I am not sure how to implement the GART. I am guessing it should =
be an IOMMU device but I think that is a bit much for an emulated card.
> > > > > The earlier problem of display probing seems to be resolved by us=
ing an R300 bios I got from TechPowerUP's GPU database:
> > > > >=20
> > > > > =09https://www.techpowerup.com/vgabios/14509/14509
> > > > > I am NOT sure if we can distribute it in the QEMU source tree. If=
 it
> > > > > does cause problems I can send a patch to remove it.
> > > >=20
> > > > That site seems to be a repository of BIOS uploaded by arbitrary us=
ers,
> > > > with no information on what license terms might apply to the upload=
s.
> > > >=20
> > > > We have to therefore assume the worst and treat the BIOS images on =
that
> > > > site as proprietary and not re-distributable, despite the fact that=
 the
> > > > site itself is acting as a 3rd party distributor.
> > >=20
> > > We can not redistribute this BIOS.
> > >=20
> > > > IOW, we can't have this in QEMU git I'm afraid, unless someone can =
find
> > > > a trustworthy vendor source for the original image with accompanyin=
g
> > > > license information.
> > >=20
> > > Daniel, I think there is no problem if Aaron contributes a model of t=
he R300
> > > device to QEMU, right? This doesn't involve redistributing any BIOS.
> >=20
> > Having just the device impl doesn't cause any legal problems.
> >=20
> > It does become a slight usability issue, as any users need to go and fi=
nd
> > the suitable BIOS in order to use the device. No downstream OS vendors =
are
> > going to be able to distribute this BIOS either
> >=20
> > I don't know if we have hit this problem before & if we have any
> > general policies about it ?
>=20
> This appears to me the same case as a user downloading a proprietary
> driver/firmware at some vendor website, accepting the EULA, then using th=
e
> driver within a QEMU VM.
>=20
> No close source blob are redistributed, but users can still run them, and
> both party (the QEMU project, and the users) are legally correct, right? =
But
> IANAL.

Well in this case the user wouldn't be reading or accepting any EULA,
because this 3rd party site doesn't provide any such things with the
firmware it is re-distributing.

IOW, the only way the user can use this device is to download the
firmware from this 3rd site & ignore the lack of legal information
they provide about license/distribution rules.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


