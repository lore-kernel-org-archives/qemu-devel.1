Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD66C7619D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CCD2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuCKrT/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CCD2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3byh-00009P-UW
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 03:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j3by5-00081Z-EL
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j3by3-0000z8-Ki
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:41:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35997
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j3by3-0000y7-GW
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581928886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cWdsNhtfVcEYyLR9L5LbYmHHP8zWNXxuLy+uVBOTSx0=;
 b=RuCKrT/znj6zoewpnE8sRshu9qnd6Lghj26XuEdfmxg/8uarUVBAJSbGPcdZNQ83G8uVvA
 9ZuUbSF8n730F2F4NwbA9BhSZbJGCRgUtsSUBf4CEdmLoGaqpogn/1WB85xdrr4x7pCTSi
 0t6DsV+rrVZNYKCg5tg65DrzqmqnseI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-bdeAEd8LM12LGhR77rCX6w-1; Mon, 17 Feb 2020 03:41:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44B5F100551A;
 Mon, 17 Feb 2020 08:41:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C52E910021B2;
 Mon, 17 Feb 2020 08:41:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BACFF16E16; Mon, 17 Feb 2020 09:41:15 +0100 (CET)
Date: Mon, 17 Feb 2020 09:41:15 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: BIOS updates
Message-ID: <20200217084115.kx6n2gys55xppfmy@sirius.home.kraxel.org>
References: <8cfc7c64-4d65-a84b-e1ec-9bc766429425@ozlabs.ru>
 <e6f68d95-16b9-ccaf-681f-18ac1ad1ca32@ozlabs.ru>
MIME-Version: 1.0
In-Reply-To: <e6f68d95-16b9-ccaf-681f-18ac1ad1ca32@ozlabs.ru>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: bdeAEd8LM12LGhR77rCX6w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 17, 2020 at 12:47:54PM +1100, Alexey Kardashevskiy wrote:
>=20
> On 17/02/2020 12:27, Alexey Kardashevskiy wrote:
> > Hi!
> >=20
> > We have a SLOF repo mirrored at git.qemu.org. Once I push an update to
> > my github repo, it gets mirrored soon, it works fine.
> >=20
> > Now to the problems :)
> >=20
> > 1. by accident I pushed a branch with a lot of debug stuff on top. When
> > I noticed, I force-pushed the correct one but it was too late - the
> > incorrect branch got mirrored. Is there a way to fix this on
> > https://git.qemu.org/git/SLOF.git? This is the correct one:
> >=20
> > 42228d763f1f (tag: qemu-slof-20200217, github/master) version: update t=
o
> > 20200217
> >=20
> > https://github.com/aik/SLOF/commits/qemu-slof-20200217
>=20
> Huh, this one got resolved, was it a script or a person? :)

The repo is in "git clone --mirror" mode I guess ...

cheers,
  Gerd


