Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0D3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85872221E2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GukC09O7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85872221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k420J-0004H2-OI
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 09:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k41ze-0003qE-1y
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:01:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37797
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k41zb-00036D-VC
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596805262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K+rDJw4j+pDtsgZvrDoNfKW9XxfZbdOco9pDrv4bwrk=;
 b=GukC09O7oWeFI9EqoSqjRlln+9qMQMZF4kYkXEyL4q0YQQ/7Nsg5powEGFdgBlsftiYOFE
 25j9FJAg2IhfSCJp+pjbcINQ1NJ5mcNHZu5uJMylUpx+7VIB5PQgMIj4oPtosDKTGxgn2J
 Anzozx53BYMgBQ6wzV/eov4fxtXQlDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-94SzP0o4Ph2TqViiQ9qyYQ-1; Fri, 07 Aug 2020 09:00:56 -0400
X-MC-Unique: 94SzP0o4Ph2TqViiQ9qyYQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17496800468;
 Fri,  7 Aug 2020 13:00:55 +0000 (UTC)
Received: from localhost (ovpn-114-16.ams2.redhat.com [10.36.114.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 996BB6111F;
 Fri,  7 Aug 2020 13:00:54 +0000 (UTC)
Date: Fri, 7 Aug 2020 14:00:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH v2 0/4] Add dtrace support on macOS
Message-ID: <20200807130053.GB609387@stefanha-x1.localdomain>
References: <20200717093517.73397-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
In-Reply-To: <20200717093517.73397-1-r.bolshakov@yadro.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:11:35
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 12:35:13PM +0300, Roman Bolshakov wrote:
> Hi,
>=20
> This is a small series that enables dtrace tracing backend on macOS.
> Whether or not it should go to 5.1 is up to discretion of tracing
> maintainers.
>=20
> Thanks,
> Roman
>=20
> Changes since v1:
>  - Fixed a typo ANSI C to C99, wrt to _Bool in the first patch.
>  - Prevented a few [-Wpointer-sign] warnings by converting int8_t * to
>    signed char * in static probe definitions.
>  - Moved COLO packet dump under #ifdef DEBUG_COLO_PACKETS (Daniel).
>  - Separated tracepoints in net/filter-rewriter.c to use matching
>    is-enabled probe (Daniel).
>=20
> Roman Bolshakov (4):
>   scripts/tracetool: Fix dtrace generation for macOS
>   scripts/tracetool: Use void pointer for vcpu
>   build: Don't make object files for dtrace on macOS
>   net/colo: Match is-enabled probe to tracepoint
>=20
>  Makefile.objs                 |  2 ++
>  net/colo-compare.c            | 42 ++++++++++++++++++-----------------
>  net/filter-rewriter.c         | 10 +++++++--
>  net/trace-events              |  2 --
>  scripts/tracetool/format/d.py | 15 ++++++++++++-
>  scripts/tracetool/vcpu.py     |  2 +-
>  6 files changed, 47 insertions(+), 26 deletions(-)
>=20
> --=20
> 2.26.1
>=20

Thanks, applied to my tracing-next tree:
https://github.com/stefanha/qemu/commits/tracing-next

Stefan

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8tUIUACgkQnKSrs4Gr
c8jMXAf+Kgu+pkwCV3qJ0AELdhUrnDLTKQ870li7E2cywce/dfygJcFMmwHM1ndR
1XUb1zHX2BXVr/kCicl11Gl0uEZKvE6FtXkeXNRSUVJpIlFwLaHZkA2nh2NZCOJY
AqD+0dCr4mncVS9DPZAzzoIZhS8B7mSbCOAHa7dZ2EcjrPeNjPqjqOtFnNH8TczF
yINJQjYdKK48J/uC2bnH5Pq4whwypKL6IbSfyz1UFq/6PHZzTCKcKvY3HogcsuP2
BEJlv1vGnZ8pUFYf0OfDmSjIWsLlUtV7MY0lUbLHJX7qD0C/99MsPDTakn3BE7i3
6+u3d5Clbszvoseii157LVAS+mzY3A==
=aLfq
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--


