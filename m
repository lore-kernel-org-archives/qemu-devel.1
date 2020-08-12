Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A40C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E625F20774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4dk77jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E625F20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5wS6-0007uy-3p
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5wQv-0006CM-UQ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 15:29:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24543
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5wQu-0001Cc-2A
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 15:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597260547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+OowUtLjp4BXTb25GV3Ealht4n362/cCFCPwtbPEXKM=;
 b=F4dk77jjxlHiTdWWWf0tHHgCDbQv92K+xiK5r1BaRgmNMKOR2Huf1ZUdMsvOneddjwgyfq
 UHu9fwKUJFNPSB6fTXcKBPXIKLR4qfQgqrFN9ttbnqIs9jQ8AHqNeCSeoCphBPZ+tzahgB
 68Yk4JCMe6hY1GioCYN92dJH6q50hmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-uoN8dEdOO7aCiYIufyZmcA-1; Wed, 12 Aug 2020 15:29:04 -0400
X-MC-Unique: uoN8dEdOO7aCiYIufyZmcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B2878017F4
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 19:29:03 +0000 (UTC)
Received: from localhost (ovpn-114-96.ams2.redhat.com [10.36.114.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E553619D71;
 Wed, 12 Aug 2020 19:29:02 +0000 (UTC)
Date: Wed, 12 Aug 2020 20:29:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/4] trace-events: Clean up
Message-ID: <20200812192901.GE112330@stefanha-x1.localdomain>
References: <20200806141334.3646302-1-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200806141334.3646302-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 06:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2020 at 04:13:30PM +0200, Markus Armbruster wrote:
> Philippe's "[PATCH] softmmu: Add missing trace-events file" made me
> look for more.  Enjoy!
>=20
> Based-on: <20200805130221.24487-1-philmd@redhat.com>
>=20
> Markus Armbruster (4):
>   scripts/cleanup-trace-events: Fix for vcpu property
>   scripts/cleanup-trace-events: Emit files in alphabetical order
>   trace-events: Delete unused trace points
>   trace-events: Fix attribution of trace points to source
>=20
>  audio/trace-events              |  3 ---
>  block/trace-events              |  8 ++-----
>  hw/block/trace-events           |  2 +-
>  hw/char/trace-events            |  2 +-
>  hw/display/trace-events         |  4 +++-
>  hw/hyperv/trace-events          |  2 +-
>  hw/mips/trace-events            |  2 +-
>  hw/misc/trace-events            |  9 ++++----
>  hw/ppc/trace-events             | 10 ++-------
>  hw/riscv/trace-events           |  2 +-
>  hw/rtc/trace-events             |  2 +-
>  hw/timer/trace-events           |  1 -
>  hw/tpm/trace-events             |  2 +-
>  hw/usb/trace-events             |  4 +++-
>  hw/vfio/trace-events            | 10 +++++----
>  hw/virtio/trace-events          |  2 +-
>  migration/trace-events          | 37 +++++++++++++++++----------------
>  scripts/cleanup-trace-events.pl | 23 ++++++++++++--------
>  target/ppc/trace-events         |  1 -
>  target/riscv/trace-events       |  2 +-
>  trace-events                    |  5 +++--
>  ui/trace-events                 |  6 +++---
>  util/trace-events               |  4 +++-
>  23 files changed, 72 insertions(+), 71 deletions(-)
>=20
> --=20
> 2.26.2
>=20

Thanks, applied to my tracing-next tree:
https://github.com/stefanha/qemu/commits/tracing-next

Stefan

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl80Qv0ACgkQnKSrs4Gr
c8ikKQf/QY+vttKlPkjEg6//Uhl8xafacEqP26CtoOU+gp02hsNUj87n+FGdhPle
ZB1rXADwznoDW8iLgR3o9RgKNMzH0YWZoE9FXzmug56oDsE/IH4evMy85H63MM7m
tL/BGrz1EcarxnPknaIqsKhbqCMGPnBiEqhrIpgLyVPk0TBL3eAIOZiS5DESKifS
Yc98GOsQOkl/r27LUnwd+R18Brs2foAqKaGJnCHmdB/6txXoCEMz5Kwq7c1skszs
6D0a9We2qFGjh8iz5Fptk2QnLnN4Xr5mRpovWn6ooLkiFu9DuUtUihtn/6Ucu8Vm
bBW/j3DAJdLi1Xn/gI5QBmSJSqBXUw==
=H8Pr
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--


