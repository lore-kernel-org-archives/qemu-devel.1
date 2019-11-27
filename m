Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB488C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 16:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943392073F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 16:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYcmxtV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943392073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia0NY-0003xS-Ml
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 11:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ia0Az-0004ng-2x
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:28:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iZzvT-0000I6-D4
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:12:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58345
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iZzvP-0000AS-VQ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574871137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8l5AQE7j46IIAJYbDBwD2XYRqlQkvglcZ4JV+xYke0I=;
 b=BYcmxtV5guMwqCJDfFi15Y0RqlEo5TaX1wyf8g7z7zhasJSnxCiJbdNM9gZ5edxciUoUtg
 fplZwoUbk0dc9BLccEuhG3pOuAoK/9qvEE1XxSm8dyqZ90fl3wZtUh9FI9eLUXykI+RIZo
 tyNIz56mzy9P+lS2TrR9u2C11EYRslg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-rcJaVvFTMkSRgIEN8GB88A-1; Wed, 27 Nov 2019 11:12:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50DDF911EB;
 Wed, 27 Nov 2019 16:12:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2761C600C8;
 Wed, 27 Nov 2019 16:12:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 028A616E18; Wed, 27 Nov 2019 17:12:11 +0100 (CET)
Date: Wed, 27 Nov 2019 17:12:10 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [RFC 00/10] R300 QEMU device V2
Message-ID: <20191127161210.ractqwwymzkpbu6n@sirius.home.kraxel.org>
References: <20191126124433.860-1-aaron.zakhrov@gmail.com>
 <20191126141924.GQ556568@redhat.com>
 <09273ecd-be76-ab61-304f-7ea0f1f0b107@redhat.com>
 <20191127150520.GG2131806@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191127150520.GG2131806@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: rcJaVvFTMkSRgIEN8GB88A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Aaron Dominick <aaron.zakhrov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> It does become a slight usability issue, as any users need to go and find
> the suitable BIOS in order to use the device. No downstream OS vendors ar=
e
> going to be able to distribute this BIOS either
>=20
> I don't know if we have hit this problem before & if we have any
> general policies about it ?

Booting from lsi scsi adapter used to work with a vendor bios only
loooooong ago.  Fixed by adding an lsi driver to seabios.

Building a r300 vgabios shouldn't be too hard, we already have
support in seavgabios for the other ati variants emulated by qemu.

cheers,
  Gerd


