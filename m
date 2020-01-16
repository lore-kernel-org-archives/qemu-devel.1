Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535E1C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 10:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA85206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 10:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5IaO3zJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA85206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is2DG-0005uc-5p
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 05:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1is2CR-0005UY-AD
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1is2CL-0001VJ-Sl
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:16:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50470
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1is2CL-0001UH-1L
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579169780;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F3sRMwJLhUC3dshgwgIFchqLFuj2Q+Ez1Mp+Vrg/CE4=;
 b=A5IaO3zJwjKC1S0poF2jSlpvicPFkG71yaK3WTWmX+M5HzjczhQrueZZe6mGE9+WrQHI4s
 rLe6urX5pnwAd2kBJQ30wdBTVSyALEOg+PwQmtMURfyJLyMCxp+XFIhMs3vM4PQmoZuENi
 Kd+Akbgf1hrKXSD7uErCEie/2Eda+q0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-_y0tNz99No2T0IdYCFrWHQ-1; Thu, 16 Jan 2020 05:16:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A19D6190D34B;
 Thu, 16 Jan 2020 10:16:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 702C584338;
 Thu, 16 Jan 2020 10:16:08 +0000 (UTC)
Date: Thu, 16 Jan 2020 10:16:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] ui/gtk: Get display refresh rate with GDK version 3.22
 or later
Message-ID: <20200116101606.GA533908@redhat.com>
References: <20200116011217.2144-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200116011217.2144-1-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: _y0tNz99No2T0IdYCFrWHQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nikola Pavlica <pavlica.nikola@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 16, 2020 at 02:12:17AM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> The GdkMonitor was introduced in GTK+ 3.22:
> https://developer.gnome.org/gdk3/stable/api-index-3-22.html#api-index-3.2=
2
>=20
> If we build with older GTK+, the build fails:

Presumably the problem here is Ubuntu Xenial 16.04 which
only has 3.18.9 ?

We should put in a sanity check for this against our min version

 #define  GDK_VERSION_MIN_REQUIRED GDK_VERSION_3_14
 #define  GDK_VERSION_MAX_ALLOWED GDK_VERSION_3_14

into glib-compat.h

For that matter we can update our min version to 3.18 I believe
since that looks like the oldest version any supported build
platform has.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


