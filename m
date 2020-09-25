Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01527C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1012087D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRQagoKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1012087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqX8-0008F8-Gd
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLqAx-0006et-PM
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:02:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLqAv-00035S-CQ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:02:23 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601049740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TflUz2C3b3d8+QETEO1qMe39kPsukcXkUxktC5PSDtY=;
 b=bRQagoKvgV92izs7RWyY5kj8Q/QfOFlJB6UlfmMtatBmuI2LjgZkxjPXhTkc2+yUcELPuk
 I/LHLQiORq8DihEVlS70Iz0Tk3OGNGVUJJwlLsg4Lr3t4u0a9LsjNFldLifAFO5U53pnXB
 Jzu+N3cjLcdX1A7Zk/f43DHnQau6Ykg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-V5W_By2INWCKPcRbtDVtvw-1; Fri, 25 Sep 2020 12:02:10 -0400
X-MC-Unique: V5W_By2INWCKPcRbtDVtvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47E5C2FD09;
 Fri, 25 Sep 2020 16:02:09 +0000 (UTC)
Received: from localhost (ovpn-115-66.ams2.redhat.com [10.36.115.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B088D60C15;
 Fri, 25 Sep 2020 16:02:08 +0000 (UTC)
Date: Fri, 25 Sep 2020 17:02:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v9 0/7] coroutines: generate wrapper code
Message-ID: <20200925160202.GD343759@stefanha-x1.localdomain>
References: <20200924185414.28642-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200924185414.28642-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 09:54:07PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> The aim of the series is to reduce code-duplication and writing
> parameters structure-packing by hand around coroutine function wrappers.
>=20
> Benefits:
>  - no code duplication
>  - less indirection
>=20
> v9: Thanks to Eric, I used commit message tweaks and rebase-conflict solv=
ing from his git.

Thanks, applied to my block tree with the encoding=3D'utf-8' and
spelling/grammar fixes:
https://github.com/stefanha/qemu/commits/block

Stefan

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9uFHoACgkQnKSrs4Gr
c8jYAgf9EMxPQJaQZZ1AgWjieQMDW5zSTYBtP2vljGx4EQ76dP0bbN7977Bb8NWr
vtEONxQUJgPH0JqrFL+QTBOIoAb/vhXKQzchhZP70vOT+ZTuWAQOpGaR3xfNWpr1
1cTRAE+qWmmNS3FJvbiKlAgChsoH/9D+bTtxe5bQvBmKtHNQLiss1Wi1mG7mDVXb
XBHfrh5746fLW8B1SpXKYSOfp6eWSV9Vd2KFkTWtc+OnHdE/WZpNMTd3ayTBgp1T
2bvuh9EHh80qPkl9DPS5IZPYMCQUiyjJIlLJoXEAZHhOCdjst6WbhMEdzBgYi1ua
Dk45NtAohgBDLBJDRdLDMQJSCVnvnw==
=PVR0
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--


