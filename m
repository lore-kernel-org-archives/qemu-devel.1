Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BF6C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0675206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkM41rzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0675206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jClrH-0002Bg-0Y
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 11:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jClox-0007SH-Dh
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jClow-0007gZ-Gz
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:01:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36625
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jClow-0007gQ-Co
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584111713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SruuZ+zAXVFBpoI1MK/kAdmkTRcaUcW83DVBY2R4c0M=;
 b=OkM41rzAR9rZNnCPj2BQS/6a0VcIjTNLnVezNNU7d2WsVkL3J9Yaaf5rrfxEhjzlmdpeVJ
 cCZiiavUp950d3SC18TEMhFhEHwt7jWzlWfYt8YdaQpoSY2VP3/GzUQcE+T3xRCpuqIk/x
 xcbePL3OuMnIdMk0h9a3BN2Wd04yoAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-40k3kKnANCCSo40Cq5k_LQ-1; Fri, 13 Mar 2020 11:01:49 -0400
X-MC-Unique: 40k3kKnANCCSo40Cq5k_LQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE6ADDB63;
 Fri, 13 Mar 2020 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-127-103.rdu2.redhat.com
 [10.10.127.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09D2373896;
 Fri, 13 Mar 2020 15:01:43 +0000 (UTC)
Date: Fri, 13 Mar 2020 11:01:42 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/5] GitLab Gating CI: introduce pipeline-status contrib
 script
Message-ID: <20200313150142.GC492336@localhost.localdomain>
References: <20200312193616.438922-1-crosa@redhat.com>
 <20200312193616.438922-5-crosa@redhat.com>
 <CAFEAcA-=3-AFUec1tMTFgXyHGscC-PF_+XEBTbujCsLB043MEw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-=3-AFUec1tMTFgXyHGscC-PF_+XEBTbujCsLB043MEw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2020 at 01:56:51PM +0000, Peter Maydell wrote:
>=20
> All new files, and particularly new scripts and source
> files, should have the usual copyright-and-license
> comment at the top, please.
>=20
> thanks
> -- PMM
>=20

My bad.  I'll wait for further comments and included that in a v2.

Cheers,
- Cleber.

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl5roFUACgkQZX6NM6Xy
CfNV/A/9Edx+uxsG/pm28l7ERcCunuW/7kIb6FhZFxItiEfUHdE4NF7cHbg8LRIC
1hUsKqIhgikD297gJQ0DQL4OI2biRk8bXxsoQWkr5YQYxL9LndKRp147tuTUtk1N
FYtTs49ZvLuMs88igbqmgrT7nRr9G5S481yfM5FcQ7oYuW3LAInXQOWEkkuutd6Z
g5n0Mh83nt6nRKrRhhcq+uDUp5SUaPBXPn9uzS71sGP77KnbFd/d4WqTqtabg/Nh
tA+hG0PZyCpVTVL8Nk13udddhHMqSj8kh86qDVvkMN56Jqu2iWrHr4xKD0atCr49
AUouHYGswSvVLUEEEQYpY3Ail6/0wM2HATBioEKeZHV98YKD3BABRdIat/wt35Rz
mfsGiKp6Wr70R/zfeMhsGF+LJO2JW2DZa4JfFaIxNm5m5xUxNnBZFOP2SvYuOz8S
fgwWkN/24yF/7UMVlZlsrpIaBMfoF2WrUFUeFko2ExFgwHBwwGdR4PsTqJXMO/CC
X0F+rCLkA+A5AgPadAlbAGlcExpqKEZKM5PPPB9gs06NLtgHWHRy/FxDukG1SzWU
Ip9N/r7OJiV45b9h46PtAj97YZrg9J6gKdd9+xSBm8O5sFjeMOR4+qFcVx4DiI/n
XoTFW9VQRtieQBEBCsp5ibSAydYqH7h/qoZC7pxsTzTYON2SotQ=
=BAnT
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--


