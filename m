Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6416C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 812ED20717
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHH16sz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812ED20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrVB-0005WH-QK
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxrTK-00021B-7u
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:34:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53026
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxrTI-0003ev-Fw
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595334851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A7Ryvjv3xEvF9/klKCTlXAGL2fjXw8HK3H/Tzo92Fuk=;
 b=OHH16sz1Am9RQXp5cd+Z7uxWs6PZ7pUfqrW8Tbj2e517ll/d6U1kJ8pKhXULGM0/OFJ4mo
 zqy+FbmOBIiDCa+31oKgxCFIeX3XnaQuW4U45qID2+kw2pp876H9HrMh+6yPXOar4ZOBqp
 lULhwMxYOEjb95Jmp0rRjMHz1ounmCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-VivQxb0wN7y1jrYkSam_0A-1; Tue, 21 Jul 2020 08:34:09 -0400
X-MC-Unique: VivQxb0wN7y1jrYkSam_0A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C1B7800474;
 Tue, 21 Jul 2020 12:34:08 +0000 (UTC)
Received: from localhost (ovpn-114-133.ams2.redhat.com [10.36.114.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A9E12B5B6;
 Tue, 21 Jul 2020 12:34:02 +0000 (UTC)
Date: Tue, 21 Jul 2020 13:34:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH v2 2/4] scripts/tracetool: Use void pointer for vcpu
Message-ID: <20200721123401.GC183198@stefanha-x1.localdomain>
References: <20200717093517.73397-1-r.bolshakov@yadro.com>
 <20200717093517.73397-3-r.bolshakov@yadro.com>
MIME-Version: 1.0
In-Reply-To: <20200717093517.73397-3-r.bolshakov@yadro.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:30:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 12:35:15PM +0300, Roman Bolshakov wrote:
> dtrace on macOS complains that CPUState * is used for a few probes:
>=20
>   dtrace: failed to compile script trace-dtrace-root.dtrace: line 130: sy=
ntax error near "CPUState"
>=20
> A comment in scripts/tracetool/__init__.py mentions that:
>=20
>   We only want to allow standard C types or fixed sized
>   integer types. We don't want QEMU specific types
>   as we can't assume trace backends can resolve all the
>   typedefs
>=20
> Fixes: 3d211d9f4dbee ("trace: Add 'vcpu' event property to trace guest vC=
PU")
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Cc: Cameron Esfahani <dirty@apple.com>
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  scripts/tracetool/vcpu.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8W4LkACgkQnKSrs4Gr
c8gYNwgAuE1XeWzRApMYqehMTBVFiN4UhejCbgynjgTFq7aoAdRnyMn23ph5uHce
6agGp8wsCrFmCbd70aCRZwfiA0TqywqGN2jPSBXB0dgPbZsc6uC+LBVAwFc4DB6e
j69XC01MLKuNc0XUos1vmfuailnY+m5CoI1dwrnJ54QBiuzhqPPuY1H1RXBwXXQm
H84qAXknJo4fkVgornryHY5PXKfYSGwWKLywsgDLUllYdN33kR2b51bySYbVt+Dj
u6VLrcsWj2Gi9VTSK2BUXQD6IdEcs2qCErqHh4nscn9nIsySDzzAzRYiwgOpNPMz
qpZg/nEnm0aqZ2JtvBDLRn1qAOEllw==
=sXzO
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--


