Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2C5C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 15:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF8B22527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 15:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHWGsqDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF8B22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifQjB-0003C8-1C
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 10:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1ifQib-0002n5-1S
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 10:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1ifQiY-0004WK-4I
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 10:49:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54052
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1ifQiX-0004U6-VI
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 10:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576165769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4XMZ1PmByAjWzqX5hXVCb1U/YIEnDkDFBkHYS7rQQ/c=;
 b=WHWGsqDDGINmoOtsBaDc0XH6Jv3z3Ch5VDpyFJfJEIe4dRakFporJL/CHl8Cid7HnvheKf
 HC1NVrriqn8ik6VOVDpFphp82QfhUDe8SvYGxZzr113CPLF2sm82ejZArC5tdWKRTPIaYM
 /hwqcw9ujOneR8XZiX+Z2SGxPJM51DY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-fdao-39ZN2GU2wxtGVXkQA-1; Thu, 12 Dec 2019 10:49:27 -0500
X-MC-Unique: fdao-39ZN2GU2wxtGVXkQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E02A218B9FCD
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 15:49:26 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9F1160BF3;
 Thu, 12 Dec 2019 15:49:23 +0000 (UTC)
References: <1576161021-5359-1-git-send-email-pbonzini@redhat.com>
 <1576161021-5359-3-git-send-email-pbonzini@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/5] fw_cfg: allow building without other devices
In-reply-to: <1576161021-5359-3-git-send-email-pbonzini@redhat.com>
Date: Thu, 12 Dec 2019 16:49:20 +0100
Message-ID: <87zhfxbl33.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Paolo Bonzini <pbonzini@redhat.com> writes:

> The microvm machine type uses fw_cfg but lacks SMBIOS and ACPI.  Do not include
> the files if the symbol is not present in QEMU and remove dependencies on
> machine-specific files.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i386/fw_cfg.c | 7 +++++++
>  hw/i386/pc.c     | 2 --
>  2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl3yYYAACgkQ9GknjS8M
AjWCsw/+KDweH0igv7qSxqQv9OJ1kNj1y6oADbL85D1dXhUGZC8VLhkXWLAg4d/p
xACrtGTd0YoOQWoFy7yjvrd5Pz45I/EOXISq+CVOsnLcx9VPkCNJccNbcX9+UscA
h/I/u4BIXe4r0zuLqnXId+k8NCtwKb/R8E4FgPtm5qy+A/v8FDG52vTDvbW5uORi
1XshiusCVhIVqScOiToGYcEmugNVw6NgpTzBa4V0AVm+NQFAsqB2rQUOmXF6ZUP6
t8RW7F27OPCnKj0guDvCM0aZPHDUtgN6Ww8M+SyBPbv4S7qi+A0PZ2NBLe/Khs/B
Emicd1edGwcKHnup4ZgBDbFGPPve2dHeC2Zp65Ww55k799cCL8ImPaXKH+oGfNYy
IkWhXpGqIMXS8aAo01pRx1SiLLS2nbNlCfv3quZGufcy9ErUPJy2gvjJdtBpA83B
2d65bmdxWytvWRO7lJADndj50/Fc4hSEPu551RFcclvVKyAqI6w5umbdgi62SmjA
5D4KC/xhvo+Ay8eR9xDLxu1sGRRbUwEqwTA17QilL/pldlSooY4yOtRefhiLdhLw
IgU1xdGwzG96nFEiG55nsKqV0qEAqGMZx77u8bT/Vt4u+EGrQJrYewuI+aLDJex6
PFUpfF9zoW6ei9rqea/bl70nSYA95UZy+kGanzWwFugAGQtQJqA=
=uiAY
-----END PGP SIGNATURE-----
--=-=-=--


