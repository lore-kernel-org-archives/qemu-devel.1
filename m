Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73445C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFEF206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWT98oqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFEF206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipXl9-0000rO-9G
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ipXkO-0000Gk-RK
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:21:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ipXkN-0002u3-Qy
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:21:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52101
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ipXkN-0002pl-KL
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578576070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rGgkUROH+ur96ZK2BhGI/kmW1n7j/WUZtF/ETt48/ZM=;
 b=JWT98oqMPIip2ckStH1ACVufUE2RdlNbB6LB63eN9eAo6WJOe2dryqldd1Wnm9P+A0CQas
 s+Rh3PzOzw0yPybb28nf6mu2lzJt8rwDXAVnvXQQgeSk1wU2o44GINMFeWhKd1Pdxv5nHw
 TG8c4rg0H5UF5VtW7muYMG6dnHUDdYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-cL24P6gIM6mdhD_XBS26BQ-1; Thu, 09 Jan 2020 08:21:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E9A1477;
 Thu,  9 Jan 2020 13:21:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 257DC5DE52;
 Thu,  9 Jan 2020 13:21:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 57B1831F29; Thu,  9 Jan 2020 14:21:07 +0100 (CET)
Date: Thu, 9 Jan 2020 14:21:07 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: pavlica.nikola@gmail.com
Subject: Re: [PATCH v5] display/gtk: get proper refreshrate
Message-ID: <20200109132107.hskyyyypu3tym5jt@sirius.home.kraxel.org>
References: <20200108121342.29597-1-pavlica.nikola@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200108121342.29597-1-pavlica.nikola@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: cL24P6gIM6mdhD_XBS26BQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 08, 2020 at 01:13:42PM +0100, pavlica.nikola@gmail.com wrote:
> From: Nikola Pavlica <pavlica.nikola@gmail.com>
>=20
> Because some VMs in QEMU can get GPU virtualization (using technologies
> such as iGVT-g, as mentioned previously), they could produce a video
> output that had a higher display refresh rate than of what the GTK
> display was displaying. (fxp. Playing a video game inside of a Windows
> VM at 60 Hz, while the output stood locked at 33 Hz because of defaults
> set in include/ui/console.h)
>=20
> Since QEMU does indeed have internal systems for determining frame
> times as defined in ui/console.c.
> The code checks for a variable called update_interval that it later
> uses for time calculation. This variable, however, isn't defined
> anywhere in ui/gtk.c and instead ui/console.c just sets it to
> GUI_REFRESH_INTERVAL_DEFAULT which is 30
>=20
> update_interval represents the number of milliseconds per display
> refresh, and by doing some math we get that 1000/30 =3D 33.33... Hz
>=20
> This creates the mentioned problem and what this patch does is that it
> checks for the display refresh rate reported by GTK itself (we can take
> this as a safe value) and just converts it back to a number of
> milliseconds per display refresh.
>=20
> Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com>

Added to ui queue.

thanks,
  Gerd


