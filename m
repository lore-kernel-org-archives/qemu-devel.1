Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26572C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23652075A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnrGKK8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23652075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iojDR-0001J2-4L
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 02:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ioj8z-000126-M3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ioj8y-0000xk-2L
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:19:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29180
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ioj8x-0000ws-VJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578381550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GYjjFtwIKTcGecQ0qh4LpPRaAqQVoCaX4veFaxQlCMk=;
 b=UnrGKK8FFTfUjObIYZ6Jff9XYy7SlrAupY3FJhuFwb7hZB13WZQnjkAKBWzemGP7P2clrn
 7kdmwbmb4oNcXoYKOUYCqxA024nUDef6f5rMlQ+li7Bo7h4jVtbph4pY7cUSNOitO9l9Uz
 4IC25zZLuhYBPyy3sdtc3P7+OdgqNOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-xwTjXij-Nbi8C1nXRuoH-Q-1; Tue, 07 Jan 2020 02:19:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CD64801E77;
 Tue,  7 Jan 2020 07:19:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43F5A5D9CA;
 Tue,  7 Jan 2020 07:19:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 759D79DA3; Tue,  7 Jan 2020 08:19:04 +0100 (CET)
Date: Tue, 7 Jan 2020 08:19:04 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Nikola Pavlica <pavlica.nikola@gmail.com>
Subject: Re: [PATCH v3] display/gtk: get proper refreshrate
Message-ID: <20200107071904.vk27shvujw7cnk6b@sirius.home.kraxel.org>
References: <df077a591cc6d4cd20178ba0829c1f37f891ae4e.camel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <df077a591cc6d4cd20178ba0829c1f37f891ae4e.camel@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: xwTjXij-Nbi8C1nXRuoH-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: philmd@redhat.com, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

>  {
>      bool zoom_to_fit =3D false;
> =20
> +    int refresh_rate_millihz =3D 0;

Please drop the blank line between the variable declarations.
Also there is no need to zero-initialize the variable ...

> +    refresh_rate_millihz =3D gdk_monitor_get_refresh_rate(monitor);

... as it is set unconditionally here.

> +    if (refresh_rate_millihz) {
> +        vc->gfx.dcl.update_interval =3D MILLISEC_PER_SEC /
> refresh_rate_millihz;

Patch is corrupted here, your mailer wrapped the line.
Best way to avoid this is to send patches using "git send-email".

cheers,
  Gerd


