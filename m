Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7B1C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7826206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alrdEaHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7826206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iojp8-0006uS-Ms
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iojPa-0005XV-LK
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iojPZ-0007qk-D9
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43027
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iojPZ-0007nx-96
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shyCrJ7mc+8ijfqmuQtCT2FsjnjNS2swSA7mCSxpXkI=;
 b=alrdEaHyFiaXpRPzCsJxkH6JFm6RI762yf5CzzR5PonNLmRxgKAuBYnVxmm6z4tOX155YE
 Ek7DPoICZmXl87yJWKbidAnvU//TFnND+DSv0cFkKMC8Bx32fOvq4PJlsRIPs2f29DJwzE
 5RDhbTxsQVTNsnC9QrpfI0K5zHvDrtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-0sOURVAqMWy4AECFkpTOAA-1; Tue, 07 Jan 2020 02:36:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE2BC801E76
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 07:36:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20651858AF;
 Tue,  7 Jan 2020 07:36:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 510B59DA3; Tue,  7 Jan 2020 08:36:07 +0100 (CET)
Date: Tue, 7 Jan 2020 08:36:07 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] hw/usb: Introduce Kconfig switches for the CCID card
 devices
Message-ID: <20200107073607.zaeag7giehjm7t52@sirius.home.kraxel.org>
References: <20191211102029.1772-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191211102029.1772-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 0sOURVAqMWy4AECFkpTOAA-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 11, 2019 at 11:20:29AM +0100, Thomas Huth wrote:
> In our downstream distribution of QEMU, we need more fine-grained
> control on the set of CCID card devices that we want to include.
> So let's introduce some proper Kconfig switches that it is easier
> to disable them without modifying the corresponding Makefile.objs.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Added to usb queue.

thanks,
  Gerd


