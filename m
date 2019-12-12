Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7267DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FA32173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQZWW5Rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FA32173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33471 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifQue-0006hg-DJ
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1ifQts-0006BJ-2k
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:01:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1ifQtp-0007KT-Vg
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:01:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57421
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1ifQtp-0007IU-Qg
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576166468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3tKhTIZFfiq+LBGjcN2GnLR4iyUPiEb36Lx3/5+raZ0=;
 b=EQZWW5RlEHAy498+w7b0DU3q2GIgGzuJPhYpHFLz7sYtKsk5o1scxKxje9StZwGrmegajm
 RJEdvOLXJ6KcK5S7V7V2tmHxRKOZ2MLHIF+B1KLck16+s8YKLlHeMztVvaIgOBg/bGZiDS
 j92L8LcU7PiD8vfSSRsv6gNLCgIzlBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-c-BBsGw6Ms2TFDf40IsFgg-1; Thu, 12 Dec 2019 11:01:06 -0500
X-MC-Unique: c-BBsGw6Ms2TFDf40IsFgg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 483D3DBAA
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:01:05 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DCB76609A;
 Thu, 12 Dec 2019 16:01:01 +0000 (UTC)
References: <1576161021-5359-1-git-send-email-pbonzini@redhat.com>
 <1576161021-5359-5-git-send-email-pbonzini@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/5] pci-stub: add more MSI functions
In-reply-to: <1576161021-5359-5-git-send-email-pbonzini@redhat.com>
Date: Thu, 12 Dec 2019 17:00:58 +0100
Message-ID: <87wob1bkjp.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Paolo Bonzini <pbonzini@redhat.com> writes:

> On x86, KVM needs some function from the PCI subsystem in order to set
> up interrupt routes.  Provide some stubs to support x86 machines that
> lack PCI.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/pci/pci-stub.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl3yZDsACgkQ9GknjS8M
AjXP6w//dvMV5+q4x+cctgq7lNwEUJAkNxRPjPEDexyASc8oaMg2b0XGr8eJ4lsJ
SqrR8jLTnth0YnJH7GDv391Oqn82bAO/dNSsOiZXMD2K+tT1YLTt/D3KJkZZRsvp
XJiChMce/ix9dUm5Ww2sgIw8/StEMIjaltXITF3VZuQeWNUYnksfgX/k/nUN8B9p
e3BROUpxHSqZv56DdQrxq1laTv6Rz7djp9Ybr4KnM2Ta5Mt2Qrpwe52iQMZ6gXCQ
BINaTsVHVKm36jBvhxVsJH3oOzXe7be0UKonwZwIUzgDm5lCjMJEJ9noY3yJSzDW
5Jo/qtF6Z9XTz/0gpKZ7p1t+xZ/VX86+78FjdoGI+d40tiNo+uOMBESAqwvF6uF+
3y3zgWLF78f1I2AFIpHNiP34nZ/YAIo68svbRQ2NxmiBNS/vmZNqERE2Ji4bIeG/
hBMxEGTZrSdX3KJPBoIl2zZJoP+WAXRqbfo5D+NaaFcVrFD1Bk25wVEnA9Wev/aX
P9WuSljfJkWG2eKC2Vfb2golw94GUGA3JbStxoe2MM0wb8/XDW/njB79RtgIKBUL
Be7a88wHOpcT3rk30T00ILCfaprmI1KQyTiYj0OW46MC+jBjkeNGWQxMmjCzsYMY
3TAShn5ThUSzNU5eu1aaFu4Wso54UesmrHZrQ1yFF+14rDH6mFA=
=3WF3
-----END PGP SIGNATURE-----
--=-=-=--


